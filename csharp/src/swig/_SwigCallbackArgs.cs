/* ----------------------------------------------------------------------------
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 2.0.4
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
 * ----------------------------------------------------------------------------- */

namespace DeltaVSoft.RCFProto {

using System;
using System.Runtime.InteropServices;

internal class _SwigCallbackArgs : IDisposable {
  private HandleRef swigCPtr;
  protected bool swigCMemOwn;

  internal _SwigCallbackArgs(IntPtr cPtr, bool cMemoryOwn) {
    swigCMemOwn = cMemoryOwn;
    swigCPtr = new HandleRef(this, cPtr);
  }

  internal static HandleRef getCPtr(_SwigCallbackArgs obj) {
    return (obj == null) ? new HandleRef(null, IntPtr.Zero) : obj.swigCPtr;
  }

  ~_SwigCallbackArgs() {
    Dispose();
  }

  public virtual void Dispose() {
    lock(this) {
      if (swigCPtr.Handle != IntPtr.Zero) {
        if (swigCMemOwn) {
          swigCMemOwn = false;
          RCFProtoPINVOKE.delete__SwigCallbackArgs(swigCPtr);
        }
        swigCPtr = new HandleRef(null, IntPtr.Zero);
      }
      GC.SuppressFinalize(this);
    }
  }

  public string mErrorString {
    set {
      RCFProtoPINVOKE._SwigCallbackArgs_mErrorString_set(swigCPtr, value);
      if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
    } 
    get {
      string ret = RCFProtoPINVOKE._SwigCallbackArgs_mErrorString_get(swigCPtr);
      if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
      return ret;
    } 
  }

  public Certificate mCertificatePtr {
    set {
      RCFProtoPINVOKE._SwigCallbackArgs_mCertificatePtr_set(swigCPtr, Certificate.getCPtr(value));
      if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
    } 
    get {
      IntPtr cPtr = RCFProtoPINVOKE._SwigCallbackArgs_mCertificatePtr_get(swigCPtr);
      Certificate ret = (cPtr == IntPtr.Zero) ? null : new Certificate(cPtr, true);
      if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
      return ret;
    } 
  }

  public _SwigCallbackArgs() : this(RCFProtoPINVOKE.new__SwigCallbackArgs(), true) {
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
  }

}

}