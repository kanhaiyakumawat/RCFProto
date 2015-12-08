/* ----------------------------------------------------------------------------
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 2.0.4
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
 * ----------------------------------------------------------------------------- */

package com.deltavsoft.rcfproto;

/**
 * Represents a HTTP endpoint. 
 */
public class HttpEndpoint extends TcpEndpoint {
  private long swigCPtr;

  HttpEndpoint(long cPtr, boolean cMemoryOwn) {
    super(RCFProtoJNI.HttpEndpoint_SWIGUpcast(cPtr), cMemoryOwn);
    swigCPtr = cPtr;
  }

  static long getCPtr(HttpEndpoint obj) {
    return (obj == null) ? 0 : obj.swigCPtr;
  }

  protected void finalize() {
    delete();
  }

  public synchronized void delete() {
    if (swigCPtr != 0) {
      if (swigCMemOwn) {
        swigCMemOwn = false;
        RCFProtoJNI.delete_HttpEndpoint(swigCPtr);
      }
      swigCPtr = 0;
    }
    super.delete();
  }

  /**
   * Constructs an HTTP endpoint on the given port number. 
   */
  public HttpEndpoint(int port) {
    this(RCFProtoJNI.new_HttpEndpoint__SWIG_0(port), true);
  }

  /**
   * Constructs an HTTP endpoint on the given IP address and port number. 
   */
  public HttpEndpoint(String ip, int port) {
    this(RCFProtoJNI.new_HttpEndpoint__SWIG_1(ip, port), true);
  }

}