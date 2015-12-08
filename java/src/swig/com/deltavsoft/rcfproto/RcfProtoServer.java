/* ----------------------------------------------------------------------------
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 2.0.4
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
 * ----------------------------------------------------------------------------- */

package com.deltavsoft.rcfproto;

/**
 * Serves up Protocol Buffer-based services to clients, over one or more server transports. 
 */
public class RcfProtoServer {

  // BEGIN INSERTED CODE

  java.util.Map<String, com.google.protobuf.Service> mPbServices 
    = new java.util.HashMap<String, com.google.protobuf.Service>();

  SwigCallback_ServerRpc mCallbackTable;

  public void bindService(com.google.protobuf.Service svc)
  {
    RcfProtoServerImpl.bindService(this, svc);
  }

  // END INSERTED CODE


  private long swigCPtr;
  boolean swigCMemOwn;

  RcfProtoServer(long cPtr, boolean cMemoryOwn) {
    swigCMemOwn = cMemoryOwn;
    swigCPtr = cPtr;
  }

  static long getCPtr(RcfProtoServer obj) {
    return (obj == null) ? 0 : obj.swigCPtr;
  }

  protected void finalize() {
    delete();
  }

  public synchronized void delete() {
    if (swigCPtr != 0) {
      if (swigCMemOwn) {
        swigCMemOwn = false;
        RCFProtoJNI.delete_RcfProtoServer(swigCPtr);
      }
      swigCPtr = 0;
    }
  }

  public RcfProtoServer() {
    this(RCFProtoJNI.new_RcfProtoServer__SWIG_0(), true);
  }

  public RcfProtoServer(Endpoint endpoint) {
    this(RCFProtoJNI.new_RcfProtoServer__SWIG_1(Endpoint.getCPtr(endpoint), endpoint), true);
  }

  /**
   * Starts the RCFProto server. 
   */
  public void start() {

    if (mCallbackTable == null) mCallbackTable = new SwigCallback_ServerRpc(this);

    RCFProtoJNI.RcfProtoServer_start(swigCPtr, this);
  }

  /**
   * Stops the RCFProto server. 
   */
  public void stop() {
    RCFProtoJNI.RcfProtoServer_stop(swigCPtr, this);
  }

  void _setCallbackTable(_SwigCallback pCallback) {
    RCFProtoJNI.RcfProtoServer__setCallbackTable(swigCPtr, this, _SwigCallback.getCPtr(pCallback), pCallback);
  }

  /**
   * Sets the thread pool the server will use. Thread pools can also be assigned to individual transports. 
   */
  public void setThreadPool(ThreadPool threadPoolPtr) {
    RCFProtoJNI.RcfProtoServer_setThreadPool(swigCPtr, this, ThreadPool.getCPtr(threadPoolPtr), threadPoolPtr);
  }

  /**
   * Returns the thread pool the server is using. 
   */
  public ThreadPool getThreadPool() {
    long cPtr = RCFProtoJNI.RcfProtoServer_getThreadPool(swigCPtr, this);
    return (cPtr == 0) ? null : new ThreadPool(cPtr, true);
  }

  /**
   * Adds a transport endpoint to the server. 
   */
  public ServerTransport addEndpoint(Endpoint endpoint) {
    return new ServerTransport(RCFProtoJNI.RcfProtoServer_addEndpoint(swigCPtr, this, Endpoint.getCPtr(endpoint), endpoint), false);
  }

  /**
   * Sets the list of supported protocols the server supports. Clients that connect without using one of the supported protocols are dropped. If the list of supported protocols is empty, all protocols are allowed. Note that supported protocols can also be specified on a server transport, in which case the server transport setting overrides the server setting. 
   */
  public void setSupportedTransportProtocols(TransportProtocolList protocols) {
    RCFProtoJNI.RcfProtoServer_setSupportedTransportProtocols(swigCPtr, this, TransportProtocolList.getCPtr(protocols), protocols);
  }

  /**
   * Returns the list of supported protocols for the server. 
   */
  public TransportProtocolList getSupportedTransportProtocols() {
    return new TransportProtocolList(RCFProtoJNI.RcfProtoServer_getSupportedTransportProtocols(swigCPtr, this), false);
  }

  /**
   * Sets the session timeout value, in milliseconds. Client connections that are idle for this amount of time will be dropped by the server. 
   */
  public void setSessionTimeoutMs(long sessionTimeoutMs) {
    RCFProtoJNI.RcfProtoServer_setSessionTimeoutMs(swigCPtr, this, sessionTimeoutMs);
  }

  /**
   * Returns the session timeout value, in milliseconds. 
   */
  public long getSessionTimeoutMs() {
    return RCFProtoJNI.RcfProtoServer_getSessionTimeoutMs(swigCPtr, this);
  }

  /**
   * Sets the session harvesting interval, in milliseconds. This setting determines how often the server will scan for idle client connections. 
   */
  public void setSessionHarvestingIntervalMs(long sessionHarvestingIntervalMs) {
    RCFProtoJNI.RcfProtoServer_setSessionHarvestingIntervalMs(swigCPtr, this, sessionHarvestingIntervalMs);
  }

  /**
   * Returns the session harvesting interval, in milliseconds. 
   */
  public long getSessionHarvestingIntervalMs() {
    return RCFProtoJNI.RcfProtoServer_getSessionHarvestingIntervalMs(swigCPtr, this);
  }

  /**
   * Sets the SSL certificate of the server. 
   */
  public void setCertificate(Certificate certificatePtr) {
    RCFProtoJNI.RcfProtoServer_setCertificate(swigCPtr, this, Certificate.getCPtr(certificatePtr), certificatePtr);
  }

  /**
   * Gets the SSL certificate of the server. 
   */
  public Certificate getCertificate() {
    long cPtr = RCFProtoJNI.RcfProtoServer_getCertificate(swigCPtr, this);
    return (cPtr == 0) ? null : new Certificate(cPtr, true);
  }

  /**
   * Sets the OpenSSL cipher suite. Only applicable when OpenSSL is used as the SSL implementation. 
   */
  public void setOpenSslCipherSuite(String cipherSuite) {
    RCFProtoJNI.RcfProtoServer_setOpenSslCipherSuite(swigCPtr, this, cipherSuite);
  }

  /**
   * Gets the OpenSSL cipher suite. 
   */
  public String getOpenSslCipherSuite() {
    return RCFProtoJNI.RcfProtoServer_getOpenSslCipherSuite(swigCPtr, this);
  }

  /**
   * Sets the SSL certificate authority of the server. 
   */
  public void setCaCertificate(Certificate certificatePtr) {
    RCFProtoJNI.RcfProtoServer_setCaCertificate(swigCPtr, this, Certificate.getCPtr(certificatePtr), certificatePtr);
  }

  /**
   * Gets the SSL certificate authority of the server. 
   */
  public Certificate getCaCertificate() {
    long cPtr = RCFProtoJNI.RcfProtoServer_getCaCertificate(swigCPtr, this);
    return (cPtr == 0) ? null : new Certificate(cPtr, true);
  }

  /**
   * Sets the Schannel certificate validation setting. Only applicable when using Schannel as the SSL implementation. If this setting is non-empty, it will be used by Schannel to automatically validate peer certificates. 
   */
  public void setEnableSchannelCertificateValidation(String peerName) {
    RCFProtoJNI.RcfProtoServer_setEnableSchannelCertificateValidation(swigCPtr, this, peerName);
  }

  /**
   * Gets the Schannel certificate validation setting. 
   */
  public String getEnableSchannelCertificateValidation() {
    return RCFProtoJNI.RcfProtoServer_getEnableSchannelCertificateValidation(swigCPtr, this);
  }

  public void setSslImplementation(SslImplementation sslImplementation) {
    RCFProtoJNI.RcfProtoServer_setSslImplementation(swigCPtr, this, sslImplementation.swigValue());
  }

  /**
   * Gets the SSL implementation of the server. 
   */
  public SslImplementation getSslImplementation() {
    return SslImplementation.swigToEnum(RCFProtoJNI.RcfProtoServer_getSslImplementation(swigCPtr, this));
  }

}
