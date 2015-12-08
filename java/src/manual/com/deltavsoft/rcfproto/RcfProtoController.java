
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

public class RcfProtoController implements com.google.protobuf.RpcController
{
    public RcfProtoController()
    {
        mChannel = null;
        mSession = null;
    }

    public RcfProtoController(RcfProtoChannel channel)
    {
        mChannel = channel;
        mSession = null;
    }

    public RcfProtoController(RcfProtoSession context)
    {
        mChannel = null;
        mSession = context;
    }

    @Override
    public String errorText() {
        return mChannel.errorText();
    }

    @Override
    public boolean failed() {
        return mChannel.failed();
    }

    @Override
    public boolean isCanceled() {
        return mSession.isCanceled();
    }

    @Override
    public void notifyOnCancel(RpcCallback<Object> callback) {
        // TODO
    }

    @Override
    public void reset() {
        mChannel = null;
        mSession = null;
    }

    @Override
    public void setFailed(String reason) {
        mSession.setFailed(reason);
    }

    @Override
    public void startCancel() {
        mChannel.startCancel();
    }
    
    public boolean completed() {
        return mChannel.completed();
    }
    
    public RcfProtoChannel getChannel()
    {
        return mChannel;
    }
    
    public RcfProtoSession getSession()
    {
        return mSession;
    }

    RcfProtoChannel mChannel;
    RcfProtoSession mSession;
}
