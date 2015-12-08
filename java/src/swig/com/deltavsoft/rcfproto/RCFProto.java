/* ----------------------------------------------------------------------------
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 2.0.4
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
 * ----------------------------------------------------------------------------- */

package com.deltavsoft.rcfproto;

public class RCFProto {
  /**
   * Reference-counted initialization of RCF framework. May be called multiple times (see deinit()). 
   */
  public static void init() {
    Util.LoadRCFProtoNativeDll();
    RCFProtoJNI.init();
  }

  /**
   * Reference-counted deinitialization of RCF framework. For actual deinitialization to take place, deinit() must be called as many times as init() has been called. 
   */
  public static void deinit() {
    RCFProtoJNI.deinit();
  }

  /**
   * 
   */
  public static boolean isProBuild() {
    return RCFProtoJNI.isProBuild();
  }

  /**
   * Configures logging for the RCF runtime. logTarget is where the log output will appear. loglevel is the detail level of the log, ranging from 0 (no logging), 1 (errors-only logging) to 4 (maximum detail logging). logFormat is an optional parameter describing the format of the log output. 
   */
  public static void enableLogging(LogTarget logTarget, int logLevel, String logFormat) {
    RCFProtoJNI.enableLogging(LogTarget.getCPtr(logTarget), logTarget, logLevel, logFormat);
  }

  /**
   * Disables logging for the RCF runtime. 
   */
  public static void disableLogging() {
    RCFProtoJNI.disableLogging();
  }

  /**
   * Sets the default SSL implementation to use (OpenSSL or Schannel). The default is OpenSSL. 
   */
  public static void setDefaultSslImplementation(SslImplementation sslImplementation) {
    RCFProtoJNI.setDefaultSslImplementation(sslImplementation.swigValue());
  }

  /**
   * Gets the default SSL implementation. 
   */
  public static SslImplementation getDefaultSslImplementation() {
    return SslImplementation.swigToEnum(RCFProtoJNI.getDefaultSslImplementation());
  }

}
