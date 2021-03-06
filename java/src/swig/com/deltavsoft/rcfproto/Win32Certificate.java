/* ----------------------------------------------------------------------------
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 2.0.4
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
 * ----------------------------------------------------------------------------- */

package com.deltavsoft.rcfproto;

/**
 * Represents an in-memory certificate, usually from a remote peer. Only applicable to Schannel. 
 */
public class Win32Certificate extends Certificate {
  private long swigCPtr;
  private boolean swigCMemOwnDerived;

  Win32Certificate(long cPtr, boolean cMemoryOwn) {
    super(RCFProtoJNI.Win32Certificate_SWIGSmartPtrUpcast(cPtr), true);
    swigCMemOwnDerived = cMemoryOwn;
    swigCPtr = cPtr;
  }

  protected static long getCPtr(Win32Certificate obj) {
    return (obj == null) ? 0 : obj.swigCPtr;
  }

  protected void finalize() {
    delete();
  }

  public synchronized void delete() {
    if (swigCPtr != 0) {
      if (swigCMemOwnDerived) {
        swigCMemOwnDerived = false;
        RCFProtoJNI.delete_Win32Certificate(swigCPtr);
      }
      swigCPtr = 0;
    }
    super.delete();
  }

  CertificateImplementationType _getType() {
    return CertificateImplementationType.swigToEnum(RCFProtoJNI.Win32Certificate__getType(swigCPtr, this));
  }

  /**
   * Gets the name of the certificate. 
   */
  public String getCertificateName() {
    return RCFProtoJNI.Win32Certificate_getCertificateName(swigCPtr, this);
  }

  /**
   * Gets the name of the issuer of the certificate. 
   */
  public String getIssuerName() {
    return RCFProtoJNI.Win32Certificate_getIssuerName(swigCPtr, this);
  }

  /**
   * Exports the certificate in PFX format, to the given file path. 
   */
  public void exportToPfx(String pfxFilePath) {
    RCFProtoJNI.Win32Certificate_exportToPfx(swigCPtr, this, pfxFilePath);
  }

  /**
   * Attempts to locate a root certificate for this certificate, in the given certificate store. Returns the root certificate if found, and otherwise null. 
   */
  public Win32Certificate findRootCertificate(Win32CertificateLocation certStoreLocation, Win32CertificateStore certStore) {
    long cPtr = RCFProtoJNI.Win32Certificate_findRootCertificate(swigCPtr, this, certStoreLocation.swigValue(), certStore.swigValue());
    return (cPtr == 0) ? null : new Win32Certificate(cPtr, true);
  }

}
