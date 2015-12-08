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
/// Base class for all client transports. 
/// </summary>
public class ClientTransport : IDisposable {
  private HandleRef swigCPtr;
  protected bool swigCMemOwn;

  internal ClientTransport(IntPtr cPtr, bool cMemoryOwn) {
    swigCMemOwn = cMemoryOwn;
    swigCPtr = new HandleRef(this, cPtr);
  }

  internal static HandleRef getCPtr(ClientTransport obj) {
    return (obj == null) ? new HandleRef(null, IntPtr.Zero) : obj.swigCPtr;
  }

  ~ClientTransport() {
    Dispose();
  }

  public virtual void Dispose() {
    lock(this) {
      if (swigCPtr.Handle != IntPtr.Zero) {
        if (swigCMemOwn) {
          swigCMemOwn = false;
          RCFProtoPINVOKE.delete_ClientTransport(swigCPtr);
        }
        swigCPtr = new HandleRef(null, IntPtr.Zero);
      }
      GC.SuppressFinalize(this);
    }
  }

  /// <summary>
  /// Returns the transport type of this client transport. 
  /// </summary>
  public virtual TransportType GetTransportType() {
    TransportType ret = (TransportType)RCFProtoPINVOKE.ClientTransport_getTransportType(swigCPtr);
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
    return ret;
  }

  /// <summary>
  /// Sets maximum incoming message length. Incoming messages that are larger than this size will be dropped. 
  /// </summary>
  public void SetMaxIncomingMessageLength(uint maxMessageLength) {
    RCFProtoPINVOKE.ClientTransport_setMaxIncomingMessageLength(swigCPtr, maxMessageLength);
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
  }

  /// <summary>
  /// Returns maximum incoming message length. 
  /// </summary>
  public uint GetMaxIncomingMessageLength() {
    uint ret = RCFProtoPINVOKE.ClientTransport_getMaxIncomingMessageLength(swigCPtr);
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
    return ret;
  }

  /// <summary>
  /// Returns the byte size of the last request sent on the client transport. 
  /// </summary>
  public uint GetLastRequestSize() {
    uint ret = RCFProtoPINVOKE.ClientTransport_getLastRequestSize(swigCPtr);
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
    return ret;
  }

  /// <summary>
  /// Returns the byte size of the last response received on the client transport. 
  /// </summary>
  public uint GetLastResponseSize() {
    uint ret = RCFProtoPINVOKE.ClientTransport_getLastResponseSize(swigCPtr);
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
    return ret;
  }

  /// <summary>
  /// Returns the running total of bytes sent on the client transport. 
  /// </summary>
  public ulong GetRunningTotalBytesSent() {
    ulong ret = RCFProtoPINVOKE.ClientTransport_getRunningTotalBytesSent(swigCPtr);
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
    return ret;
  }

  /// <summary>
  /// Returns the running total of bytes received on the client transport. 
  /// </summary>
  public ulong GetRunningTotalBytesReceived() {
    ulong ret = RCFProtoPINVOKE.ClientTransport_getRunningTotalBytesReceived(swigCPtr);
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
    return ret;
  }

  /// <summary>
  /// Resets the bytes-sent and bytes-received running totals to zero. 
  /// </summary>
  public void ResetRunningTotals() {
    RCFProtoPINVOKE.ClientTransport_resetRunningTotals(swigCPtr);
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
  }

}

}
