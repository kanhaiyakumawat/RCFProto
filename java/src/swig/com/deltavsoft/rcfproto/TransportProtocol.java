/* ----------------------------------------------------------------------------
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 2.0.4
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
 * ----------------------------------------------------------------------------- */

package com.deltavsoft.rcfproto;

/**
 * Describes the transport protocols used by a RCF connection. Transport protocols are layered on top of the transport type. 
 */
public enum TransportProtocol {
  /**
   * Unspecified 
   */
  Unspecified,
  /**
   * Clear text 
   */
  Clear,
  /**
   * Windows NTLM 
   */
  Ntlm,
  /**
   * Windows Kerberos 
   */
  Kerberos,
  /**
   * Windows Negotiate (Kerberos or NTLM) 
   */
  Negotiate,
  /**
   * SSL 
   */
  Ssl;

  final int swigValue() {
    return swigValue;
  }

  static TransportProtocol swigToEnum(int swigValue) {
    TransportProtocol[] swigValues = TransportProtocol.class.getEnumConstants();
    if (swigValue < swigValues.length && swigValue >= 0 && swigValues[swigValue].swigValue == swigValue)
      return swigValues[swigValue];
    for (TransportProtocol swigEnum : swigValues)
      if (swigEnum.swigValue == swigValue)
        return swigEnum;
    throw new IllegalArgumentException("No enum " + TransportProtocol.class + " with value " + swigValue);
  }

  @SuppressWarnings("unused")
  private TransportProtocol() {
    this.swigValue = SwigNext.next++;
  }

  @SuppressWarnings("unused")
  private TransportProtocol(int swigValue) {
    this.swigValue = swigValue;
    SwigNext.next = swigValue+1;
  }

  @SuppressWarnings("unused")
  private TransportProtocol(TransportProtocol swigEnum) {
    this.swigValue = swigEnum.swigValue;
    SwigNext.next = this.swigValue+1;
  }

  private final int swigValue;

  private static class SwigNext {
    private static int next = 0;
  }
}

