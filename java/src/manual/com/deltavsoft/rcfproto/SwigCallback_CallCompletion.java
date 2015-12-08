
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

class SwigCallback_CallCompletion extends _SwigCallback
{
    SwigCallback_CallCompletion(RcfProtoChannel channel)
    {
        mChannel = channel;
    }

    public void Run()
    {
        RcfProtoChannelImpl.OnCallCompleted(mChannel);
    }

    RcfProtoChannel mChannel;
}
