
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

using System;
using System.Collections.Generic;
using System.Text;

using Google.ProtocolBuffers;
using Google.ProtocolBuffers.Descriptors;

using System.Runtime.InteropServices;
using Microsoft.Win32;

namespace DeltaVSoft.RCFProto
{

    internal class Util
    {
        [DllImport("kernel32.dll", CharSet = CharSet.Auto, SetLastError = true)]
        private static extern IntPtr LoadLibraryEx(string libname, IntPtr hFile, Int32 dwFlags);

        [DllImport("kernel32.dll", CharSet = CharSet.Auto, SetLastError = true)]
        private static extern IntPtr GetModuleHandle(string libname);

        internal static string g_nativeDllPath = "";

        private static IntPtr g_nativeDll = new IntPtr();

        internal static void LoadRCFProtoNativeDll()
        {
            if (g_nativeDll == IntPtr.Zero)
            {
                string dllPath = "RCFProto_NET_impl.dll";
                if (g_nativeDllPath != null && g_nativeDllPath != "")
                {
                    dllPath = g_nativeDllPath;
                }

                g_nativeDll = LoadLibraryEx(dllPath, IntPtr.Zero, 8);
                if (g_nativeDll == IntPtr.Zero)
                {
                    int error = System.Runtime.InteropServices.Marshal.GetLastWin32Error();
                    System.ComponentModel.Win32Exception win32Err = new System.ComponentModel.Win32Exception(error);
                    string errorMsg = "Unable to load RCFProto native bindings for .NET. Attempted to load: " + dllPath + ".\n";
                    errorMsg += "LoadLibraryEx() error: " + win32Err.Message + "\n";

                    // Elaborate on Windows error 193 "%1 is not a valid Win32 application" .
                    if (error == 193)
                    {
                        errorMsg += "Note: This error most likely indicates an x86/x64 architecture mismatch.\n";
                    }

                    throw new System.Exception(errorMsg);
                }
            }
        }
    }

    public delegate bool CertificateValidationCallback(Certificate cert);

    // Client- or server-side  in-progress interface to a remote call.

    // DOCSTRING RcfProtoController
    /// <summary>
    /// RPC controller interface, for both server-side and client-side code. 
    /// </summary>
    public class RcfProtoController : Google.ProtocolBuffers.IRpcController
    {
        public RcfProtoController()
        {
            mChannel = null;
            mSession = null;
        }
        public RcfProtoController(RcfProtoChannel channel)
        {
            mChannel = channel;
        }

        public RcfProtoController(RcfProtoSession session)
        {
            mSession = session;
        }

        // DOCSTRING RcfProtoController.Reset()
        /// <summary>
        /// Resets the RcfProtoController to its initial state so that it may be reused in a new call.  Must not be called while an RPC is in progress. 
        /// </summary>
        public void Reset()
        {
            mChannel = null;
            mSession = null;
        }

        // Client side

        // DOCSTRING RcfProtoController.ErrorText()
        /// <summary>
        /// Client-side: If Failed() is true, returns a human-readable description of the error. 
        /// </summary>
        public string ErrorText
        {
            get
            {
                return mChannel.ErrorText();
            }
        }

        // DOCSTRING RcfProtoController.Failed()
        /// <summary>
        /// Client-side: After a call has finished, returns true if the call failed. Failed() must not be called before a call has finished.  If Failed() returns true, the contents of the response message are undefined. 
        /// </summary>
        public bool Failed
        {
            get
            {
                return mChannel.Failed();
            }
        }

        // DOCSTRING RcfProtoController.StartCancel()
        /// <summary>
        /// Client-side: Cancels an RPC that is in progress. Once canceled, the "done" callback will still be called and the RcfProtoController will indicate that the call failed at that time. 
        /// </summary>
        public void StartCancel()
        {
            mChannel.StartCancel();
        }

        // DOCSTRING RcfProtoController.Completed()
        /// <summary>
        /// Client-side: Returns false while a call is in progress, and true after the call has been completed and the completion handler run (if a completion handler was provided). 
        /// </summary>
        public bool Completed
        {
            get
            {
                return mChannel.Completed();
            }
        }

        // Server side

        // DOCSTRING RcfProtoController.IsCanceled()
        /// <summary>
        /// Server-side: If true, indicates that the client canceled the RPC, so the server may as well give up on replying to it.  The server should still call the final "done" callback. 
        /// </summary>
        public bool IsCanceled()
        {
            return mSession.IsCanceled();
        }

        // DOCSTRING RcfProtoController.NotifyOnCancel()
        /// <summary>
        /// Asks that the given callback be called when the RPC is canceled.  The callback will always be called exactly once.  If the RPC completes without being canceled, the callback will be called after completion.  If the RPC has already been canceled when NotifyOnCancel() is called, the callback will be called immediately. NotifyOnCancel() must be called no more than once per request. 
        /// </summary>
        public void NotifyOnCancel(Action<object> callback)
        {
            // TODO
        }

        // DOCSTRING RcfProtoController.SetFailed()
        /// <summary>
        /// Server-side: Causes Failed() to return true on the client-side.  "reason" will be incorporated into the message returned by ErrorText().  If you find you need to return machine-readable information about failures, you should incorporate it into your response protocol buffer and should NOT call SetFailed(). 
        /// </summary>
        public void SetFailed(string reason)
        {
            mSession.SetFailed(reason);
        }

        // DOCSTRING RcfProtoController.GetChannel()
        public RcfProtoChannel GetChannel()
        {
            return mChannel;
        }

        // DOCSTRING RcfProtoController.GetSession()
        public RcfProtoSession GetSession()
        {
            return mSession;
        }

        internal RcfProtoChannel mChannel;
        internal RcfProtoSession mSession;
    }

    internal class SwigCallback_CallCompletion : _SwigCallback
    {
        public SwigCallback_CallCompletion(RcfProtoChannel channel)
        {
            mChannel = channel;
        }

        public override void Run()
        {
            RcfProtoChannelImpl.OnCallCompleted(mChannel);
        }

        private RcfProtoChannel mChannel;
    }

    internal class SwigCallback_Certificate : _SwigCallback
    {
        internal SwigCallback_Certificate(CertificateValidationCallback certValidator)
        {
            mCertValidator = certValidator;
        }

        public override bool ValidateCertificate(_SwigCallbackArgs args)
        {
            try
            {
                // Downcast the certificate.
                Certificate cert = args.mCertificatePtr;
                HandleRef handle = Certificate.getCPtr(cert);
                IntPtr ptr = (IntPtr)handle;

                switch (cert._getType())
                {
                    case CertificateImplementationType.Win32:
                        cert = new Win32Certificate(ptr, false);
                        break;
                    case CertificateImplementationType.X509:
                        cert = new X509Certificate(ptr, false);
                        break;
                    default:
                        cert = new Certificate(ptr, false);
                        break;
                }
                return mCertValidator(cert);
            }
            catch (Exception e)
            {
                args.mErrorString = e.Message;
            }
            return false;
        }

        internal CertificateValidationCallback mCertValidator;
    }

    internal class RcfProtoChannelImpl
    {
        static internal void CallMethod(
            RcfProtoChannel self, 
            Google.ProtocolBuffers.Descriptors.MethodDescriptor method,
            Google.ProtocolBuffers.IRpcController controller,
            Google.ProtocolBuffers.IMessage request,
            Google.ProtocolBuffers.IMessage responsePrototype,
            Action<Google.ProtocolBuffers.IMessage> done)
        {
            self.mResponse = null;
            self.mResponseError = null;

            self.mDone = done;
            self.mResponsePrototype = responsePrototype;

            // Serialize the request.
            RcfProtoController rcfController = (RcfProtoController)controller;
            if (rcfController != null)
            {
                rcfController.Reset();
                rcfController.mChannel = self;
            }

            string serviceName = method.Service.Name;
            int methodId = method.Index;
            byte[] bytes = request.ToByteArray();

            // Hand off to RCF.
            if (self.mSwigCallback == null)
            {
                self.mSwigCallback = new SwigCallback_CallCompletion(self);
            }
            self._CallMethodSwig(serviceName, methodId, bytes, bytes.Length, self.mSwigCallback);

            bool syncRpc = !self.GetAsynchronousRpcMode();
            if (syncRpc)
            {
                if (self.Failed())
                {
                    self.mResponseError = self.ErrorText();
                    throw new System.Exception(self.mResponseError);
                }
            }
        }

        static internal Google.ProtocolBuffers.IMessage GetResponse(RcfProtoChannel self)
        {
            return self.mResponse;
        }

        static internal void OnCallCompleted(
            RcfProtoChannel self)
        {
            // Deserialize the response
            int requestBufferLen = self._GetResponseBufferLength();
            if (requestBufferLen == 0)
            {
                // Get crashes from Google.ProtocolBuffers.dll if we pass in null.
                //Google.ProtocolBuffers.IMessage response = null;
                self.mResponse = self.mResponsePrototype.WeakDefaultInstanceForType;
            }
            else
            {
                // Deserialize response.
                byte[] requestBuffer = new byte[requestBufferLen];
                self._GetResponseBuffer(requestBuffer, requestBufferLen);
                Google.ProtocolBuffers.IBuilder builder = self.mResponsePrototype.WeakCreateBuilderForType();
                Google.ProtocolBuffers.ByteString byteString = Google.ProtocolBuffers.ByteString.CopyFrom(requestBuffer);
                builder.WeakMergeFrom(byteString);
                self.mResponse = builder.WeakBuild();
            }

            bool asyncRpc = self.GetAsynchronousRpcMode();
            if (asyncRpc)
            {
                self.mDone(self.mResponse);
            }
        }

        public static void SetCertificateValidationCallback(
            RcfProtoChannel self,
            CertificateValidationCallback certificateValidator)
        {
            self.mSwigCallbackCertificate = new SwigCallback_Certificate(certificateValidator);
            self._setCertificateValidationCallback(self.mSwigCallbackCertificate);
        }
    }

    internal class SwigCallback_ServerRpc : _SwigCallback 
    {
        internal SwigCallback_ServerRpc(RcfProtoServer self)
        {
            mSelf = self;
            mSelf._setCallbackTable(this);
        }

        public override void ProtoRpcBegin(
            _SwigCallbackArgs args,
            RcfProtoServer self,
            RcfProtoSession session,
            string serviceName,
            int methodId)
        {
            try
            {
                RcfProtoServerImpl.ProtoRpcBegin(mSelf, session, serviceName, methodId);
            }
            catch (System.Exception e)
            {
                args.mErrorString = e.Message;
            }
        }

        public RcfProtoServer mSelf;
    }

    internal class RcfProtoServerImpl
    {
        static internal void BindService(
            RcfProtoServer self, 
            Google.ProtocolBuffers.IService svc)
        {
            self.mPbServices.Add(svc.DescriptorForType.Name, svc);
        }

        // Entry point from C++.
        static internal void ProtoRpcBegin(
            RcfProtoServer self,
            RcfProtoSession session,
            string serviceName,
            int methodId)
        {
            int requestBufferLen = session._GetRequestBufferLength();
            byte[] requestBuffer = new byte[requestBufferLen];
            session._GetRequestBuffer(requestBuffer, requestBuffer.Length);

            // Look up the service and method.
            Google.ProtocolBuffers.IService service = null;
            if (self.mPbServices.ContainsKey(serviceName))
            {
                service = self.mPbServices[serviceName];
            }
            
            if (service == null)
            {
                string errorMsg = "The requested service does not exist on this server. Service name: " + serviceName;
                throw new Exception(errorMsg);
            }

            ServiceDescriptor serviceDesc = service.DescriptorForType;
            MethodDescriptor methodDesc = serviceDesc.Methods[methodId];

            // Build the request object.
            IMessage requestPrototype = service.GetRequestPrototype(methodDesc);
            IBuilder builder = requestPrototype.WeakCreateBuilderForType();
            ByteString byteString = ByteString.CopyFrom(requestBuffer);
            builder.WeakMergeFrom(byteString);
            IMessage request = builder.WeakBuild();

            // Call the PB service
            // "=>" not supported in .NET 2.0.
            //Action<IMessage> done = (IMessage msg) => ProtoRpcEndCs(session, msg);           
            Action<IMessage> done = delegate(IMessage msg) { ProtoRpcEndCs(self, session, msg); };

            RcfProtoController controller = new RcfProtoController(session);
            service.CallMethod(methodDesc, controller, request, done);
        }

        static internal void ProtoRpcEndCs(
            RcfProtoServer self, 
            RcfProtoSession session, 
            IMessage response)
        {
            // Serialize response and send back to client.
            byte[] responseBuffer = response.ToByteArray();
            session._SetResponseBuffer(responseBuffer, responseBuffer.Length);
            session._Commit();
        }
    }

} // namespace RCFProto
