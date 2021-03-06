/* ----------------------------------------------------------------------------
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 2.0.4
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
 * ----------------------------------------------------------------------------- */

package com.deltavsoft.rcfproto;

/**
 * Represents a UNIX local socket endpoint. Only available on UNIX platforms. 
 */
public class UnixLocalEndpoint extends Endpoint {
  private long swigCPtr;

  UnixLocalEndpoint(long cPtr, boolean cMemoryOwn) {
    super(RCFProtoJNI.UnixLocalEndpoint_SWIGUpcast(cPtr), cMemoryOwn);
    swigCPtr = cPtr;
  }

  static long getCPtr(UnixLocalEndpoint obj) {
    return (obj == null) ? 0 : obj.swigCPtr;
  }

  protected void finalize() {
    delete();
  }

  public synchronized void delete() {
    if (swigCPtr != 0) {
      if (swigCMemOwn) {
        swigCMemOwn = false;
        RCFProtoJNI.delete_UnixLocalEndpoint(swigCPtr);
      }
      swigCPtr = 0;
    }
    super.delete();
  }

  /**
   * Constructs a UNIX local socket endpoint with the given name. 
   */
  public UnixLocalEndpoint(String socketName) {
    this(RCFProtoJNI.new_UnixLocalEndpoint(socketName), true);
  }

}
