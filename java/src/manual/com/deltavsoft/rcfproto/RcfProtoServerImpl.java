
//******************************************************************************
// RCF - Remote Call Framework
//
// Copyright (c) 2005 - 2013, Delta V Software. All rights reserved.
// http://www.deltavsoft.com
//
// RCF is distributed under dual licenses - closed source or GPL.
// Consult your particular license for conditions of use.
//
// If you have not purchased a commercial license, you are using RCF 
// under GPL terms.
//
// Version: 2.0
// Contact: support <at> deltavsoft.com 
//
//******************************************************************************

package com.deltavsoft.rcfproto;

import java.io.File;

import com.google.protobuf.*;
import com.google.protobuf.Descriptors.MethodDescriptor;

class RcfProtoServerCallback implements RpcCallback<com.google.protobuf.Message>
{
    public RcfProtoServerCallback(RcfProtoServer server, RcfProtoSession context)
    {
        mServer = server;
        mContext = context;
    }

    public void run(com.google.protobuf.Message response)
    {
        RcfProtoServerImpl.ProtoRpcEndJava(mServer, mContext, response);
    }

    RcfProtoServer mServer;
    RcfProtoSession mContext;
}

class RcfProtoServerImpl
{

    public static void bindService(RcfProtoServer self, com.google.protobuf.Service svc)
    {
        String svcName = svc.getDescriptorForType().getName();
        self.mPbServices.put(svcName, svc);
    }

    public static void ProtoRpcBegin(
        RcfProtoServer self,
        RcfProtoSession context,
        String svcName,
        int methodId) throws InvalidProtocolBufferException
    {
        // Get request buffer.
        int requestBufferLen = context._GetRequestBufferLength();
        byte[] raBuffer = new byte[requestBufferLen];
        context._GetRequestBuffer(raBuffer);

        // Look up PB service.
        com.google.protobuf.Service svc = null;
        if (self.mPbServices.containsKey(svcName))
        {
            svc = self.mPbServices.get(svcName);
        }
        com.google.protobuf.Descriptors.ServiceDescriptor svcDesc = svc.getDescriptorForType();
        com.google.protobuf.Descriptors.MethodDescriptor methodDesc = svcDesc.getMethods().get(methodId);

        // Build the request message.
        com.google.protobuf.Message requestPrototype = svc.getRequestPrototype(methodDesc);
        com.google.protobuf.Message.Builder builder =  requestPrototype.toBuilder();
        builder.mergeFrom(raBuffer);
        com.google.protobuf.Message request = builder.build();

        RcfProtoController controller = new RcfProtoController(context);
        RpcCallback<com.google.protobuf.Message> done = new RcfProtoServerCallback(self, context);
        svc.callMethod(methodDesc, controller, request, done);
    }

    public static void ProtoRpcEndJava(RcfProtoServer self, RcfProtoSession context, com.google.protobuf.Message response)
    {
        // Serialize response and send back to client.
        byte[] raBytes = response.toByteArray();
        context._SetResponseBuffer(raBytes);
        context._Commit();
    }
}
