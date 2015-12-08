
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

class RcfProtoChannelImpl
{

    public static void callMethod(
      RcfProtoChannel self, 
      MethodDescriptor method, 
      RpcController controller,
      Message request, 
      Message responsePrototype,
      RpcCallback<Message> done) {

        self.mDone = done;
        self.mResponsePrototype = responsePrototype;

        // Serialize the request.
        RcfProtoController rcfController = (RcfProtoController) controller;
        if ( rcfController != null )
        {
            rcfController.reset();
            rcfController.mChannel = self;
        }

        String serviceName = method.getService().getName();
        int methodId = method.getIndex();
        ByteString bytes = request.toByteString();
        byte[] raBytes = bytes.toByteArray();

        if (self.mSwigCallback == null)
        {
            self.mSwigCallback = new SwigCallback_CallCompletion(self);
        }
        self._CallMethodSwig(serviceName, methodId, raBytes, self.mSwigCallback);
        
        boolean syncRpc = !self.getAsynchronousRpcMode();
        if (syncRpc)
        {
            if (self.failed())
            {
                self.mResponseError = self.errorText();
                throw new RuntimeException(self.mResponseError);
            }
        }

    }
    
    public static Message getResponse(RcfProtoChannel self)
    {
        return self.mResponse;
    }


    public static void OnCallCompleted(RcfProtoChannel self)
    {
        try
        {
            
            int requestBufferLen = self._GetResponseBufferLength();
            if ( requestBufferLen == 0 )
            {
                // Can't pass null here, so go with default instance.
                self.mResponse = self.mResponsePrototype.getDefaultInstanceForType();
            }
            else
            {
                // Deserialize response.

                byte[] raBytes = new byte[requestBufferLen];
                self._GetResponseBuffer(raBytes);

                com.google.protobuf.Message.Builder builder = self.mResponsePrototype.newBuilderForType();
                builder.mergeFrom(raBytes);
                self.mResponse = builder.build();
            }
            
            boolean asyncRpc = self.getAsynchronousRpcMode();
            if (asyncRpc)
            {
                self.mDone.run(self.mResponse);
            }
        }
        catch(Exception e)
        {
            System.out.println("Caught client-side exception:");
            System.out.println(e.getMessage());
        }
    }
    
    public static boolean OnValidateCertificate(RcfProtoChannel channel, Certificate cert)
    {
        boolean ok = false;
        if (channel.mCertValidationCallback != null)
        {
            ok = channel.mCertValidationCallback.run(cert); 
        }
        return ok; 
    }
    
}
