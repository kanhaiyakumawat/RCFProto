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
/// Represents an IP address (IPv4 or IPv6). 
/// </summary>
public class IpAddress : IDisposable {
  private HandleRef swigCPtr;
  protected bool swigCMemOwn;

  internal IpAddress(IntPtr cPtr, bool cMemoryOwn) {
    swigCMemOwn = cMemoryOwn;
    swigCPtr = new HandleRef(this, cPtr);
  }

  internal static HandleRef getCPtr(IpAddress obj) {
    return (obj == null) ? new HandleRef(null, IntPtr.Zero) : obj.swigCPtr;
  }

  ~IpAddress() {
    Dispose();
  }

  public virtual void Dispose() {
    lock(this) {
      if (swigCPtr.Handle != IntPtr.Zero) {
        if (swigCMemOwn) {
          swigCMemOwn = false;
          RCFProtoPINVOKE.delete_IpAddress(swigCPtr);
        }
        swigCPtr = new HandleRef(null, IntPtr.Zero);
      }
      GC.SuppressFinalize(this);
    }
  }

  /// <summary>
  /// Construct an IP address from a host name 
  /// </summary>
  public IpAddress(string ip) : this(RCFProtoPINVOKE.new_IpAddress__SWIG_0(ip), true) {
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
  }

  /// <summary>
  /// Construct an IP address from a host name and port. 
  /// </summary>
  public IpAddress(string ip, int port) : this(RCFProtoPINVOKE.new_IpAddress__SWIG_1(ip, port), true) {
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
  }

}

}
