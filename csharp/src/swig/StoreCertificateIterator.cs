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

/// <summary>
/// Iterates over the certificates in a Windows certificate store. 
/// </summary>
public class StoreCertificateIterator : IDisposable {
  private HandleRef swigCPtr;
  protected bool swigCMemOwn;

  internal StoreCertificateIterator(IntPtr cPtr, bool cMemoryOwn) {
    swigCMemOwn = cMemoryOwn;
    swigCPtr = new HandleRef(this, cPtr);
  }

  internal static HandleRef getCPtr(StoreCertificateIterator obj) {
    return (obj == null) ? new HandleRef(null, IntPtr.Zero) : obj.swigCPtr;
  }

  ~StoreCertificateIterator() {
    Dispose();
  }

  public virtual void Dispose() {
    lock(this) {
      if (swigCPtr.Handle != IntPtr.Zero) {
        if (swigCMemOwn) {
          swigCMemOwn = false;
          RCFProtoPINVOKE.delete_StoreCertificateIterator(swigCPtr);
        }
        swigCPtr = new HandleRef(null, IntPtr.Zero);
      }
      GC.SuppressFinalize(this);
    }
  }

  /// <summary>
  /// Constructs a store iterator for the the given certificate location and store. 
  /// </summary>
  public StoreCertificateIterator(Win32CertificateLocation certStoreLocation, Win32CertificateStore certStore) : this(RCFProtoPINVOKE.new_StoreCertificateIterator((int)certStoreLocation, (int)certStore), true) {
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
  }

  /// <summary>
  /// Moves to the next certificate in the store. Returns false if there are no more certificates, and true otherwise. 
  /// </summary>
  public bool MoveNext() {
    bool ret = RCFProtoPINVOKE.StoreCertificateIterator_moveNext(swigCPtr);
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
    return ret;
  }

  /// <summary>
  /// Resets the iterator back to the beginning of the store. 
  /// </summary>
  public void Reset() {
    RCFProtoPINVOKE.StoreCertificateIterator_reset(swigCPtr);
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
  }

  /// <summary>
  /// Returns the current certificate. 
  /// </summary>
  public Win32Certificate Current() {
    IntPtr cPtr = RCFProtoPINVOKE.StoreCertificateIterator_current(swigCPtr);
    Win32Certificate ret = (cPtr == IntPtr.Zero) ? null : new Win32Certificate(cPtr, true);
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
    return ret;
  }

}

}