/* ----------------------------------------------------------------------------
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 2.0.4
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
 * ----------------------------------------------------------------------------- */

package com.deltavsoft.rcfproto;

/**
 * Represents a server-side thread pool. 
 */
public class ThreadPool {
  private long swigCPtr;
  private boolean swigCMemOwnBase;

  ThreadPool(long cPtr, boolean cMemoryOwn) {
    swigCMemOwnBase = cMemoryOwn;
    swigCPtr = cPtr;
  }

  protected static long getCPtr(ThreadPool obj) {
    return (obj == null) ? 0 : obj.swigCPtr;
  }

  protected void finalize() {
    delete();
  }

  public synchronized void delete() {
    if (swigCPtr != 0) {
      if (swigCMemOwnBase) {
        swigCMemOwnBase = false;
        RCFProtoJNI.delete_ThreadPool(swigCPtr);
      }
      swigCPtr = 0;
    }
  }

  public ThreadPool(long fixedThreadCount) {
    this(RCFProtoJNI.new_ThreadPool__SWIG_0(fixedThreadCount), true);
  }

  public ThreadPool(long threadMinCount, long threadMaxCount) {
    this(RCFProtoJNI.new_ThreadPool__SWIG_1(threadMinCount, threadMaxCount), true);
  }

  /**
   * Sets the minimum number of threads in the thread pool. 
   */
  public void setThreadMinCount(long threadMinCount) {
    RCFProtoJNI.ThreadPool_setThreadMinCount(swigCPtr, this, threadMinCount);
  }

  /**
   * Returns the minimum number of threads in the thread pool. 
   */
  public long getThreadMinCount() {
    return RCFProtoJNI.ThreadPool_getThreadMinCount(swigCPtr, this);
  }

  /**
   * Sets the maximum number of threads in the thread pool. 
   */
  public void setThreadMaxCount(long threadMaxCount) {
    RCFProtoJNI.ThreadPool_setThreadMaxCount(swigCPtr, this, threadMaxCount);
  }

  /**
   * Returns the maximum number of threads in the thread pool. 
   */
  public long getThreadMaxCount() {
    return RCFProtoJNI.ThreadPool_getThreadMaxCount(swigCPtr, this);
  }

  /**
   * Sets the thread idle timeout value, in milliseconds. After a thread has been idle for this time, it will be shut down, unless the thread count is already at the minimum value for the thread pool. 
   */
  public void setThreadIdleTimeoutMs(long threadIdleTimeoutMs) {
    RCFProtoJNI.ThreadPool_setThreadIdleTimeoutMs(swigCPtr, this, threadIdleTimeoutMs);
  }

  /**
   * Returns the thread idle timeout value, in milliseconds. 
   */
  public long getThreadIdleTimeoutMs() {
    return RCFProtoJNI.ThreadPool_getThreadIdleTimeoutMs(swigCPtr, this);
  }

  /**
   * If this setting is true, clients will receive an error message right away, if all threads in the thread pool are busy. Otherwise, the client will wait for a thread in the thread pool to become free. 
   */
  public void setReserveLastThread(boolean reserveLastThread) {
    RCFProtoJNI.ThreadPool_setReserveLastThread(swigCPtr, this, reserveLastThread);
  }

  public boolean getReserveLastThread() {
    return RCFProtoJNI.ThreadPool_getReserveLastThread(swigCPtr, this);
  }

  /**
   * Sets the thread name of the thread pool threads, as visible in a debugger. 
   */
  public void setThreadName(String threadName) {
    RCFProtoJNI.ThreadPool_setThreadName(swigCPtr, this, threadName);
  }

  /**
   * Returns the thread name of the thread pool threads. 
   */
  public String getThreadName() {
    return RCFProtoJNI.ThreadPool_getThreadName(swigCPtr, this);
  }

}
