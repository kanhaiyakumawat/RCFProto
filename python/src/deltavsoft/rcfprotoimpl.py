
import traceback

import rcfproto
from rcfproto import *

import google.protobuf
import google.protobuf.service

# Client side

class SwigCallback_CallCompletion(rcfproto._SwigCallback) :
    def __init__(self, channel):
        super(SwigCallback_CallCompletion, self).__init__()
        self.channel = channel

    def Run(self):
        rcfproto.RcfProtoChannelImpl.OnCallCompleted(self.channel)

class SwigCallback_Certificate(rcfproto._SwigCallback) :
    def __init__(self, channel):
        super(SwigCallback_Certificate, self).__init__()
        self.channel = channel

    def ValidateCertificate(self, args):
        cert = args.mCertificatePtr

        # Downcast certificate to Schannel or OpenSSL.
        if cert._getType() == Cit_Win32:
            cert = cert._downcastToWin32Certificate(cert)
        elif cert._getType() == Cit_X509:
            cert = cert._downcastToX509Certificate(cert)

        ok = False
        if self.channel.mCertValidationCallback:
            ok = self.channel.mCertValidationCallback(cert)
        return ok

class RcfProtoChannelImpl :

    @staticmethod
    def CallMethod(self, methodDesc, controller, request, responsePrototype, done):

        self.response = None
        self.responseError = None

        self.done = done
        self.response = responsePrototype()

        # Serialize request
        if controller:
            controller.Reset()
            controller.channel = self

        svcName = methodDesc.containing_service.name
        methodId = methodDesc.index
        requestBytes = request.SerializeToString()

        # Hand off to RCF
        self.closure = SwigCallback_CallCompletion(self)
        self._CallMethodSwig_WithCopy(svcName, methodId, requestBytes, self.closure)

        syncRpc = not self.GetAsynchronousRpcMode()
        if syncRpc:
            if self.Failed():
                self.responseError = self.ErrorText()
                raise Exception(self.responseError)

    @staticmethod
    def GetResponse(self):
        return self.response;

    @staticmethod
    def OnCallCompleted(self):
        responseBuffer = self._GetResponseBuffer_WithCopy()
        if responseBuffer:
            self.response.ParseFromString(responseBuffer)
        else:
            self.response = None

        asyncRpc = self.GetAsynchronousRpcMode()
        if asyncRpc:
            self.done(self.response)


    @staticmethod
    def SetCertificateValidationCallback(self, certValidationCb):
        self.mCertValidationCallback = certValidationCb
        if certValidationCb:
            self.mSwigCallbackCertificate = SwigCallback_Certificate(self)
            self._setCertificateValidationCallback(self.mSwigCallbackCertificate)

# Server side

class SwigCallback_ServerRpc(rcfproto._SwigCallback):
    def __init__(self, server):
        super(SwigCallback_ServerRpc, self).__init__()
        self.server = server
        self.server._setCallbackTable(self)

    def ProtoRpcBegin(self, args, server, context, svcName, methodId):
        try:
            RcfProtoServerImpl.ProtoRpcBegin(self.server, context, svcName, methodId)
        except Exception:
            args.mErrorString = traceback.format_exc()

class RcfProtoServerImpl :

    @staticmethod
    def BindService(self, svc):
        svcName = svc.GetDescriptor().name
        # TODO
        #if not self.pbServices: self.pbServices = {}
        self.pbServices = {}
        self.pbServices[svcName] = svc

    @staticmethod
    def ProtoRpcBegin(self, session, svcName, methodId):

        requestBuffer = session._GetRequestBuffer_WithCopy()

        # Look up the service and method, and call it.
        if svcName in self.pbServices:
            svc = self.pbServices[svcName]
            svcDesc = svc.GetDescriptor()
            methodDesc = svcDesc.methods[methodId]
            request = svc.GetRequestClass(methodDesc)()
            request.ParseFromString(requestBuffer)
            controller = RcfProtoController(None, session)

            def doneClosure(response):
                RcfProtoServerImpl.ProtoRpcEndPy(self, session, response)

            svc.CallMethod(methodDesc, controller, request, doneClosure)

    @staticmethod
    def ProtoRpcEndPy(self, session, response):
        responseBuffer = response.SerializeToString()
        session._SetResponseBuffer_WithCopy(responseBuffer)
        session._Commit()
