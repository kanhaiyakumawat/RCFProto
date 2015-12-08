
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

#ifndef INCLUDE_RCF_RCFPROTO_HPP
#define INCLUDE_RCF_RCFPROTO_HPP

#include <RCF/GoogleProtobufs.hpp>

#include <RCF/RCF.hpp>
#include <RCF/ClientStub.hpp>
#include <RCF/Exception.hpp>
#include <RCF/Export.hpp>
#include <RCF/RemoteCallContext.hpp>

#ifdef BOOST_WINDOWS
#include <RCF/Win32Certificate.hpp>
#endif

#if RCF_FEATURE_OPENSSL==1

#include <RCF/OpenSslEncryptionFilter.hpp>

#else

namespace RCF {
    class RCF_EXPORT PemCertificate : public Certificate
    {
    public:
        PemCertificate(const std::string & pathToCert, const std::string & password = "")
        {
            RCF_THROW(Exception(_RcfError_NotSupportedInThisBuild("PemCertificate")));
        }
    };

    class RCF_EXPORT X509Certificate : public Certificate
    {
    public:
        X509Certificate()
        {
            RCF_THROW(Exception(_RcfError_NotSupportedInThisBuild("X509Certificate")));
        }
        std::string getCertificateName()        { return "";}
        std::string getIssuerName()             { return ""; }

    };
} // namespace RCF

#endif

#if RCF_FEATURE_SSPI==1
#include <RCF/Schannel.hpp>
#endif

#if RCF_FEATURE_NAMEDPIPE==1
#include <RCF/Win32NamedPipeEndpoint.hpp>
#endif

#if RCF_FEATURE_LOCALSOCKET==1
#include <RCF/UnixLocalEndpoint.hpp>
#endif

#if RCF_FEATURE_LOCALSOCKET==0

namespace RCF {

    class RCF_EXPORT UnixLocalEndpoint : public Endpoint
    {
    public:
        UnixLocalEndpoint(const std::string & socketName)                       { RCF_THROW(Exception(_RcfError_NotSupportedInThisBuild("UnixLocalEndpoint"))); }

        virtual std::auto_ptr<ServerTransport>  createServerTransport() const   { return std::auto_ptr<ServerTransport>(); }
        virtual std::auto_ptr<ClientTransport>  createClientTransport() const   { return std::auto_ptr<ClientTransport>(); }
        virtual EndpointPtr                     clone() const                   { return EndpointPtr(); }
        virtual std::string                     asString() const                { return std::string(); }
    };

} // namespace RCF

#endif // RCF_FEATURE_LOCALSOCKET==0

#ifndef BOOST_WINDOWS

namespace RCF {

    class RCF_EXPORT LogToDebugWindow : public LogTarget
    {
    public:
        LogToDebugWindow()
        {
            Exception e(_RcfError_SupportedOnWindowsOnly("LogToDebugWindow"));
            RCF_THROW(e);
        }
        virtual LogTarget * clone() const { return NULL; }
        virtual void write(const RCF::ByteBuffer & output) {}
    };

    class RCF_EXPORT LogToEventLog : public LogTarget
    {
    public:
        LogToEventLog(const std::string & appName, int eventLogLevel)
        {
            Exception e(_RcfError_SupportedOnWindowsOnly("LogToEventLog"));
            RCF_THROW(e);
        }
        virtual LogTarget * clone() const { return NULL; }
        virtual void write(const RCF::ByteBuffer & output) {}
    };

    class RCF_EXPORT Win32Certificate : public Certificate
    {
    public:
        Win32Certificate()
        {
            Exception e(_RcfError_SupportedOnWindowsOnly("Win32Certificate"));
            RCF_THROW(e);
        }

        virtual CertificateImplementationType _getType()
        {
            return Cit_Win32;
        }

        tstring getCertificateName()                            { return tstring(); }
        tstring getIssuerName()                                 { return tstring(); }
        void exportToPfx(const std::string & pfxFilePath)       {}

        Win32CertificatePtr findRootCertificate(
            Win32CertificateLocation certStoreLocation, 
            Win32CertificateStore certStore)                    { return Win32CertificatePtr(); }

    };

    class RCF_EXPORT PfxCertificate : public Win32Certificate
    {
    public:

        PfxCertificate(
            const std::string & pathToCert, 
            const tstring & password,
            const tstring & certName)
        {
            Exception e(_RcfError_SupportedOnWindowsOnly("PfxCertificate"));
            RCF_THROW(e);
        }

        void addToStore(
            Win32CertificateLocation certStoreLocation, 
            Win32CertificateStore certStore)                    {}
    };

    class RCF_EXPORT StoreCertificate  : public Win32Certificate
    {
    public:

        StoreCertificate(
            Win32CertificateLocation certStoreLocation, 
            Win32CertificateStore certStore,
            const tstring & certName)
        {
            Exception e(_RcfError_SupportedOnWindowsOnly("StoreCertificate"));
            RCF_THROW(e);
        }

        void removeFromStore()                                  {}

    };

    class RCF_EXPORT StoreCertificateIterator
    {
    public:

        StoreCertificateIterator(
            Win32CertificateLocation certStoreLocation, 
            Win32CertificateStore certStore)
        {
            Exception e(_RcfError_SupportedOnWindowsOnly("StoreCertificateIterator"));
            RCF_THROW(e);
        }

        bool moveNext()                                         { return false; }
        void reset()                                            {}
        Win32CertificatePtr current()                           { return Win32CertificatePtr(); }
    };

} // namespace RCF

#endif

#if RCF_FEATURE_NAMEDPIPE==0

namespace RCF {

    class RCF_EXPORT Win32NamedPipeEndpoint : public Endpoint
    {
    public:
        Win32NamedPipeEndpoint(const tstring & pipeName)                        { RCF_THROW(Exception(_RcfError_SupportedOnWindowsOnly("Win32NamedPipeEndpoint"))); }

        virtual std::auto_ptr<ServerTransport>  createServerTransport() const   { return std::auto_ptr<ServerTransport>(); }
        virtual std::auto_ptr<ClientTransport>  createClientTransport() const   { return std::auto_ptr<ClientTransport>(); }
        virtual EndpointPtr                     clone() const                   { return EndpointPtr(); }
        virtual std::string                     asString() const                { return std::string(); }
    };

} // namespace RCF

#endif // RCF_FEATURE_NAMEDPIPE==0

#if RCF_FEATURE_SSPI==0

namespace RCF {

} // namespace RCF

#endif // RCF_FEATURE_SSPI==0

namespace RCF {

RCF_EXPORT bool isProBuild();

class RcfProtoChannel;
class RcfProtoSession;
class RcfProtoController;

typedef boost::shared_ptr<RcfProtoController> RcfProtoControllerPtr;

/// RPC controller interface, for both server-side and client-side code.
class RCF_EXPORT RcfProtoController : public google::protobuf::RpcController
{
public:

    /// Resets the RcfProtoController to its initial state so that it may be reused in
    /// a new call.  Must not be called while an RPC is in progress.
    virtual void Reset();

    /// Client-side: After a call has finished, returns true if the call failed.
    /// Failed() must not be called before a call has finished.  If Failed() 
    /// returns true, the contents of the response message are undefined.
    virtual bool Failed() const;

    /// Client-side: If Failed() is true, returns a human-readable description of the error.
    virtual std::string ErrorText() const;

    /// Client-side: Cancels an RPC that is in progress. Once canceled, the "done" 
    /// callback will still be called and the RcfProtoController will indicate that 
    /// the call failed at that time.
    virtual void StartCancel();

    /// Client-side: Returns false while a call is in progress, and true after the call
    /// has been completed and the completion handler run (if a completion handler was 
    /// provided).
    virtual bool Completed() const;

    // Server-side methods ---------------------------------------------

    // These calls may be made from the server side only.  Their results
    // are undefined on the client side (may crash).

    /// Server-side: Causes Failed() to return true on the client-side.  "reason" will be
    /// incorporated into the message returned by ErrorText().  If you find
    /// you need to return machine-readable information about failures, you
    /// should incorporate it into your response protocol buffer and should
    /// NOT call SetFailed().
    virtual void SetFailed(const std::string& reason);

    /// Server-side: If true, indicates that the client canceled the RPC, so the server may
    /// as well give up on replying to it.  The server should still call the
    /// final "done" callback.
    virtual bool IsCanceled() const;

    /// Asks that the given callback be called when the RPC is canceled.  The
    /// callback will always be called exactly once.  If the RPC completes without
    /// being canceled, the callback will be called after completion.  If the RPC
    /// has already been canceled when NotifyOnCancel() is called, the callback
    /// will be called immediately.
    ///
    /// NotifyOnCancel() must be called no more than once per request.
    virtual void NotifyOnCancel(google::protobuf::Closure* callback);

    RcfProtoController();
    RcfProtoController(RcfProtoSession & session);

    RcfProtoSession * getSession();
    RcfProtoChannel * getChannel();

private:

    friend class RcfProtoChannel;
    friend class RcfProtoServer;

    RcfProtoChannel *            mpRcfChannel;
    RcfProtoSession *            mpRcfSession;
};


//------------------------------------------------------------------------------
// Client side implementation

class I_Pb;
template<typename T> class RcfClient;

class RcfProtoServer;
class RcfProtoSession;

class RCF_EXPORT _SwigCallbackArgs
{
public:

    // *** SWIG BEGIN ***

    std::string mErrorString;

    CertificatePtr mCertificatePtr;

    // *** SWIG END ***

};

class RCF_EXPORT _SwigCallback
{
public:

    // *** SWIG BEGIN ***

    _SwigCallback();
    virtual ~_SwigCallback();

    // Run client-side RPC completion handler.
    virtual void Run();

    // Run server-side RPC server implementation.
    virtual void ProtoRpcBegin(
        _SwigCallbackArgs * args,
        RcfProtoServer * server,
        RcfProtoSession * session, 
        const std::string & serviceName, 
        int methodId);

    // Certificate validation callback.
    virtual bool ValidateCertificate(
        _SwigCallbackArgs * args);

    // *** SWIG END ***

};

class _SwigCallbackCpp : public _SwigCallback
{
public:
    _SwigCallbackCpp(RcfProtoChannel & channel);
    virtual void Run();

private:
    RcfProtoChannel & mChannel;
};

/// Represents a single RPC connection to a server.
class RCF_EXPORT RcfProtoChannel : public google::protobuf::RpcChannel
{
public:

    // For C#.
    void _CallMethodSwig(
        const std::string&          serviceName, 
        int                         methodId, 
        unsigned char *             szBuffer, 
        int                         szBufferLen,
        _SwigCallback *              closure);

    int _GetResponseBufferLength() const;
    void _GetResponseBuffer(unsigned char * szBuffer, int bufferLen) const;

    // For Java.
    void _CallMethodSwig(
        const std::string&          serviceName, 
        int                         methodId, 
        char *                      szBuffer, 
        size_t                      szBufferLen,
        _SwigCallback *              closure);

    void _GetResponseBuffer(char * szBuffer, size_t bufferLen) const;


    // *** SWIG BEGIN ***

    /// Constructs a RPC channel from an endpoint.
    RcfProtoChannel(const RCF::Endpoint & endpoint);

    void _CallMethodSwig_WithCopy(
        const std::string&          serviceName, 
        int                         methodId, 
        const std::string&          strBuffer, 
        _SwigCallback *              closure);

    std::string _GetResponseBuffer_WithCopy() const;

    // Controller interface.

    /// After a call has finished, returns true if the call failed.  The possible
    /// reasons for failure depend on the RPC implementation.  Failed() must not
    /// be called before a call has finished.  If Failed() returns true, the
    /// contents of the response message are undefined.
    bool Failed();

    /// If Failed() is true, returns a human-readable description of the error.
    std::string ErrorText();

    /// Advises the RPC system that the caller desires that the RPC call be
    /// canceled.  The RPC system may cancel it immediately, may wait awhile and
    /// then cancel it, or may not even cancel the call at all.  If the call is
    /// canceled, the "done" callback will still be called and the RpcController
    /// will indicate that the call failed at that time.
    void StartCancel();

    bool Completed();

    // RCF specific functionality.

    /// Connects to the server.
    void connect();

    /// Disconencts from the server.
    void disconnect();

    /// Sets the remote call timeout value, in milliseconds.
    void setRemoteCallTimeoutMs(unsigned int remoteCallTimeoutMs);

    /// Gets the remote call timeout value, in milliseconds.
    unsigned int getRemoteCallTimeoutMs() const;

    /// Sets the connect timeout value, in milliseconds.
    void setConnectTimeoutMs(unsigned int connectTimeoutMs);

    /// Gets the connect timeout value, in milliseconds.
    unsigned int getConnectTimeoutMs() const;

    /// Sets the transport protocol being used by the channel. 
    void setTransportProtocol(RCF::TransportProtocol protocol);

    /// Gets the transport protocol being used by the channel. 
    RCF::TransportProtocol getTransportProtocol();

    /// Sets the asynchronous RPC mode. By default the asynchronous RPC mode is false.
    void setAsynchronousRpcMode(bool enable);

    /// Gets the asynchronous RPC mode.
    bool getAsynchronousRpcMode();


    /// Sets the ping back interval of the connection, in milliseconds. Ping backs are sent
    /// from the server back to the client, while a remote call is in progress.
    void setPingBackIntervalMs(int pingBackIntervalMs);

    /// Returns the ping back interval of the connection.
    int getPingBackIntervalMs();

    /// Sets the network address of the HTTP proxy server, through which to route remote calls. Only valid when using a HTTP or HTTPS endpoint.
    void setHttpProxy(const std::string & httpProxy);

    /// Returns the network address of the HTTP proxy server.
    std::string getHttpProxy();

    /// Sets the port number of the HTTP proxy server, through which to route remote calls. Only valid when using a HTTP or HTTPS endpoint.
    void setHttpProxyPort(int httpProxyPort);

    /// Returns the port number of the HTTP proxy server.
    int getHttpProxyPort();

    /// Returns the transport type of the connection.
    TransportType getTransportType();

    /// Sets the Windows username to use when connecting. Only valid for NTLM and Kerberos transport protocols.
    void setUsername(const tstring & username);

    /// Returns the Windows username to use when connecting.
    tstring getUsername();      

    /// Sets the Windows password to use when connecting. Only valid for NTLM and Kerberos transport protocols.
    void setPassword(const tstring & password);

    /// Returns the Windows password to use when connecting.
    tstring getPassword();      

    /// Sets the Kerberos SPN to use when connecting. Only valid for Kerberos transport protocols. 
    void setKerberosSpn(const tstring & kerberosSpn);

    /// Returns the Kerberos SPN to use when connecting.
    tstring getKerberosSpn();   

    /// Sets the transport level compression setting for this connection.
    void setEnableCompression(bool enableCompression);

    /// Returns the transport level compression setting for this connection.
    bool getEnableCompression();

    /// Sets the SSL certificate for the channel.
    void setCertificate(CertificatePtr certificatePtr);

    /// Gets the SSL certificate for the channel.
    CertificatePtr getCertificate();

    /// Sets the certificate authority for the channel.
    void setCaCertificate(CertificatePtr certificatePtr);

    /// Gets the certificate authority for the channel.
    CertificatePtr getCaCertificate();

    /// Sets the OpenSSL cipher suite. Only applicable when using OpenSSL as the SSL implementation.
    void setOpenSslCipherSuite(const std::string & cipherSuite);

    /// Gets the OpenSSL cipher suite. 
    std::string getOpenSslCipherSuite() const;

    /// Sets the Schannel certificate validation setting. Only applicable when using Schannel as the SSL implementation.
    /// If this setting is non-empty, it will be used by Schannel to automatically validate peer certificates.
    void setEnableSchannelCertificateValidation(const tstring & peerName);

    /// Gets the Schannel certificate validation setting.
    tstring getEnableSchannelCertificateValidation() const;

    void _setCertificateValidationCallback(_SwigCallback * pcb);

    /// Sets the SSL implementation to be used by the channel.
    void setSslImplementation(SslImplementation sslImplementation);

    /// Gets the SSL implementation.
    SslImplementation getSslImplementation() const;


    // *** SWIG END ***

    /// Sets the certificate validation callback.
    typedef ClientStub::CertificateValidationCb CertificateValidationCb;
    void setCertificateValidationCallback(CertificateValidationCb certificateValidationCb);

    /// Gets the certificate validation callback.
    const CertificateValidationCb & getCertificateValidationCallback() const;


    // Entry point from C++.
    virtual void CallMethod(
        const google::protobuf::MethodDescriptor *      method,
        google::protobuf::RpcController *               controller,
        const google::protobuf::Message *               request,
        google::protobuf::Message *                     response,
        google::protobuf::Closure *                     done);

    // Common client calling code.
    void CallMethodInternal(
        const std::string &         serviceName, 
        int                         methodId, 
        RCF::ByteBuffer             requestBuffer,
        _SwigCallback *             closure);

private:

    friend  class _SwigCallbackCpp;
    _SwigCallbackCpp                        mSwigCallbackCpp;

    void onCompletionCpp();
    void onCompletion();

    boost::shared_ptr< RcfClient<I_Pb> >    mRcfClientPtr;
    
    const google::protobuf::Message *       mpRequest;
    google::protobuf::Message *             mpResponse;
    google::protobuf::Closure *             mpClosure;

    _SwigCallback *                         mpSwigCallback;

    boost::function<void()>                 mCompletionHandlerSwig;

    RCF::Future<RCF::ByteBuffer>            mFuture;
    RCF::Exception                          mError;
    RCF::ByteBuffer                         mResponseBuffer;

    std::string                             mRequestCopy;

    bool                                    mAsyncRpcMode;
};

//------------------------------------------------------------------------------
// Server side implementation

typedef RCF::RemoteCallContext<
    RCF::ByteBuffer, 
    const std::string &, 
    int, 
    RCF::ByteBuffer> RcfProtoContext;

class                                       RcfProtoSession;
typedef boost::shared_ptr<RcfProtoSession>  RcfProtoSessionPtr;

/// Represents the server-side session associated with a RPC connection.
class RCF_EXPORT RcfProtoSession
{
public:

    RcfProtoSession(RCF::RcfSession & session);
    ~RcfProtoSession();

    int _GetRequestBufferLength();

    // For C#.
    void _GetRequestBuffer(unsigned char * szBuffer, int szBufferLen);
    void _SetResponseBuffer(unsigned char * szBuffer, int szBufferLen);
    
    // For Java
    void _GetRequestBuffer(char * szBuffer, size_t szBufferLen);
    void _SetResponseBuffer(char * szBuffer, size_t szBufferLen);

    // *** SWIG BEGIN ***

    /// Causes Failed() to return true on the client side.  "reason" will be
    /// incorporated into the message returned by ErrorText().  If you find
    /// you need to return machine-readable information about failures, you
    /// should incorporate it into your response protocol buffer and should
    /// NOT call SetFailed().
    void SetFailed(const std::string& reason);

    /// If true, indicates that the client canceled the RPC, so the server may
    /// as well give up on replying to it.  The server should still call the
    /// final "done" callback.
    bool IsCanceled() const;

    void _Commit(const std::string& errorMsg);
    void _Commit();

    std::string _GetRequestBuffer_WithCopy();

    void _SetResponseBuffer_WithCopy(const std::string& buffer);

    /// Returns the Windows username of the client, if a NTLM or Kerberos transport protocol is being used.
    tstring getClientUsername();

    /// Returns the transport protocol in use on this server session.
    TransportProtocol getTransportProtocol();

    /// Returns the transport type of this server session.
    TransportType getTransportType();

    /// Returns true if compression is enabled for this server session, and false otherwise. Compression is enabled by the client.
    bool getEnableCompression();

    /// Returns the duration of the client connection, in milliseconds.
    std::size_t getConnectionDuration() const;

    /// Returns the number of remote calls executed on the server session so far.
    std::size_t getRemoteCallCount() const;

    /// Returns the total number of bytes received by the server session so far.
    boost::uint64_t getTotalBytesReceived() const;

    /// Returns the total number of bytes sent from the server session so far.
    boost::uint64_t getTotalBytesSent() const;


    // *** SWIG END ***

    // Returns the timestamp at which the client connected.
    //time_t getConnectedAtTime() const;


    /// Asks that the given callback be called when the RPC is canceled.  The
    /// callback will always be called exactly once.  If the RPC completes without
    /// being canceled, the callback will be called after completion.  If the RPC
    /// has already been canceled when NotifyOnCancel() is called, the callback
    /// will be called immediately.
    //
    /// NotifyOnCancel() must be called no more than once per request.
    void NotifyOnCancel(google::protobuf::Closure * callback);

    RcfSession& getRcfSession();

private:

    friend class RcfProtoServer;

    RcfSession &    mRcfSession;

    RcfProtoContext mServerContext;

    RCF::ByteBuffer mRequestBuffer;
    RCF::ByteBuffer mResponseBuffer;
};

typedef boost::shared_ptr<google::protobuf::Message> MessagePtr;

/// Serves up Protocol Buffer-based services to clients, over one or more server transports.
class RCF_EXPORT RcfProtoServer : public RCF::RcfServer
{
public:

    // *** SWIG BEGIN ***

    RcfProtoServer();
    RcfProtoServer(const RCF::Endpoint & endpoint);

    ~RcfProtoServer();
    
    /// Starts the RCFProto server.
    void start();

    /// Stops the RCFProto server.
    void stop();

    void _setCallbackTable(_SwigCallback * pCallback);

    /// Sets the thread pool the server will use. Thread pools can also be assigned to individual transports.
    void                    setThreadPool(ThreadPoolPtr threadPoolPtr)      { RcfServer::setThreadPool(threadPoolPtr); }

    /// Returns the thread pool the server is using.
    ThreadPoolPtr           getThreadPool()                                 { return RcfServer::getThreadPool(); }

    /// Adds a transport endpoint to the server.
    ServerTransport &       addEndpoint(const RCF::Endpoint & endpoint) { return RcfServer::addEndpoint(endpoint); }

    /// Sets the list of supported protocols the server supports. Clients
    /// that connect without using one of the supported protocols are dropped. If
    /// the list of supported protocols is empty, all protocols are allowed.
    ///
    /// Note that supported protocols can also be specified on a server transport, in
    /// which case the server transport setting overrides the server setting.

    void setSupportedTransportProtocols(
        const std::vector<TransportProtocol> & protocols)                   { RcfServer::setSupportedTransportProtocols(protocols); }

    /// Returns the list of supported protocols for the server.
    const std::vector<TransportProtocol> & 
        getSupportedTransportProtocols() const                              { return RcfServer::getSupportedTransportProtocols(); }

    /// Sets the session timeout value, in milliseconds. Client connections that are idle
    /// for this amount of time will be dropped by the server.
    void setSessionTimeoutMs(boost::uint32_t sessionTimeoutMs)              { return RcfServer::setSessionTimeoutMs(sessionTimeoutMs); }

    /// Returns the session timeout value, in milliseconds.
    boost::uint32_t getSessionTimeoutMs()                                   { return RcfServer::getSessionTimeoutMs(); }

    /// Sets the session harvesting interval, in milliseconds. This setting determines
    /// how often the server will scan for idle client connections.
    void setSessionHarvestingIntervalMs(boost::uint32_t sessionHarvestingIntervalMs) { RcfServer::setSessionHarvestingIntervalMs(sessionHarvestingIntervalMs); }

    /// Returns the session harvesting interval, in milliseconds.
    boost::uint32_t getSessionHarvestingIntervalMs()                        { return RcfServer::getSessionHarvestingIntervalMs(); }

    /// Sets the SSL certificate of the server.
    void setCertificate(CertificatePtr certificatePtr)                  { RcfServer::setCertificate(certificatePtr); }

    /// Gets the SSL certificate of the server.
    CertificatePtr getCertificate()                                     { return RcfServer::getCertificate(); }

    /// Sets the OpenSSL cipher suite. Only applicable when OpenSSL is used as the SSL implementation.
    void setOpenSslCipherSuite(const std::string & cipherSuite)             { RcfServer::setOpenSslCipherSuite(cipherSuite); }

    /// Gets the OpenSSL cipher suite.
    std::string getOpenSslCipherSuite() const                               { return RcfServer::getOpenSslCipherSuite(); }

    /// Sets the SSL certificate authority of the server.
    void setCaCertificate(CertificatePtr certificatePtr)                    { RcfServer::setCaCertificate(certificatePtr); }

    /// Gets the SSL certificate authority of the server.
    CertificatePtr getCaCertificate()                                   { return RcfServer::getCaCertificate(); }

    /// Sets the Schannel certificate validation setting. Only applicable when using Schannel as the SSL implementation.
    /// If this setting is non-empty, it will be used by Schannel to automatically validate peer certificates.
    void setEnableSchannelCertificateValidation(const tstring & peerName)   { RcfServer::setEnableSchannelCertificateValidation(peerName); }

    /// Gets the Schannel certificate validation setting.
    tstring getEnableSchannelCertificateValidation() const                  { return RcfServer::getEnableSchannelCertificateValidation(); }

    // Sets the SSL implementation of the server.
    void setSslImplementation(SslImplementation sslImplementation)          { RcfServer::setSslImplementation(sslImplementation); }

    /// Gets the SSL implementation of the server.
    SslImplementation getSslImplementation() const                          { return RcfServer::getSslImplementation(); }

    // *** SWIG END ***

    /// Sets the SSL certificate validation callback.
    void setCertificateValidationCallback(CertificateValidationCb certificateValidationCb)  { RcfServer::setCertificateValidationCallback(certificateValidationCb); }

    /// Gets the SSL certificate validation callback.
    const CertificateValidationCb & getCertificateValidationCallback() const                { return RcfServer::getCertificateValidationCallback(); }


    void bindService(google::protobuf::Service & service);

    RCF::ByteBuffer DoProtoRpc( 
        const std::string &     serviceName,
        int                     methodId,
        RCF::ByteBuffer         requestBuffer);

private:

    void ProtoRpcBeginCpp(
        RcfProtoSession &       session, 
        const std::string &     serviceName, 
        int                     methodId);

    void ProtoRpcEndCpp(
        std::pair<MessagePtr, MessagePtr>   requestResponsePair, 
        RcfProtoControllerPtr               controllerPtr);

    typedef std::map<std::string, google::protobuf::Service *> ProtobufServices;
    
    ProtobufServices mProtobufServices; 

    _SwigCallback * mpSwigCallback;
};

class BoostBindClosure : public google::protobuf::Closure
{
public:
    BoostBindClosure() :
        mFunc(), 
        mPermanent(true)
    {
    }

    BoostBindClosure(const boost::function<void()> & func, bool permanent = false) : 
        mFunc(func), 
        mPermanent(permanent)
    {
    }

    void assign(const boost::function<void()> & func, bool permanent = true)
    {
        mFunc = func;
        mPermanent = permanent;
    }

    void Run()
    {
        mFunc();
        if (!mPermanent)
        {
            delete this;
        }
    }

    boost::function<void()> mFunc;
    bool mPermanent;
};

} // namespace RCF

#endif // ! INCLUDE_RCF_RCFPROTO_HPP
