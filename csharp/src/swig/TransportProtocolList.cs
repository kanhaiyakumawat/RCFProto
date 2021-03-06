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

public class TransportProtocolList : IDisposable, System.Collections.IEnumerable
#if !SWIG_DOTNET_1
    , System.Collections.Generic.IEnumerable<TransportProtocol>
#endif
 {
  private HandleRef swigCPtr;
  protected bool swigCMemOwn;

  internal TransportProtocolList(IntPtr cPtr, bool cMemoryOwn) {
    swigCMemOwn = cMemoryOwn;
    swigCPtr = new HandleRef(this, cPtr);
  }

  internal static HandleRef getCPtr(TransportProtocolList obj) {
    return (obj == null) ? new HandleRef(null, IntPtr.Zero) : obj.swigCPtr;
  }

  ~TransportProtocolList() {
    Dispose();
  }

  public virtual void Dispose() {
    lock(this) {
      if (swigCPtr.Handle != IntPtr.Zero) {
        if (swigCMemOwn) {
          swigCMemOwn = false;
          RCFProtoPINVOKE.delete_TransportProtocolList(swigCPtr);
        }
        swigCPtr = new HandleRef(null, IntPtr.Zero);
      }
      GC.SuppressFinalize(this);
    }
  }

  public TransportProtocolList(System.Collections.ICollection c) : this() {
    if (c == null)
      throw new ArgumentNullException("c");
    foreach (TransportProtocol element in c) {
      this.Add(element);
    }
  }

  public bool IsFixedSize {
    get {
      return false;
    }
  }

  public bool IsReadOnly {
    get {
      return false;
    }
  }

  public TransportProtocol this[int index]  {
    get {
      return getitem(index);
    }
    set {
      setitem(index, value);
    }
  }

  public int Capacity {
    get {
      return (int)capacity();
    }
    set {
      if (value < size())
        throw new ArgumentOutOfRangeException("Capacity");
      reserve((uint)value);
    }
  }

  public int Count {
    get {
      return (int)size();
    }
  }

  public bool IsSynchronized {
    get {
      return false;
    }
  }

#if DOTNET_1
  public void CopyTo(System.Array array)
#else
  public void CopyTo(TransportProtocol[] array)
#endif
  {
    CopyTo(0, array, 0, this.Count);
  }

#if DOTNET_1
  public void CopyTo(System.Array array, int arrayIndex)
#else
  public void CopyTo(TransportProtocol[] array, int arrayIndex)
#endif
  {
    CopyTo(0, array, arrayIndex, this.Count);
  }

#if DOTNET_1
  public void CopyTo(int index, System.Array array, int arrayIndex, int count)
#else
  public void CopyTo(int index, TransportProtocol[] array, int arrayIndex, int count)
#endif
  {
    if (array == null)
      throw new ArgumentNullException("array");
    if (index < 0)
      throw new ArgumentOutOfRangeException("index", "Value is less than zero");
    if (arrayIndex < 0)
      throw new ArgumentOutOfRangeException("arrayIndex", "Value is less than zero");
    if (count < 0)
      throw new ArgumentOutOfRangeException("count", "Value is less than zero");
    if (array.Rank > 1)
      throw new ArgumentException("Multi dimensional array.", "array");
    if (index+count > this.Count || arrayIndex+count > array.Length)
      throw new ArgumentException("Number of elements to copy is too large.");
    for (int i=0; i<count; i++)
      array.SetValue(getitemcopy(index+i), arrayIndex+i);
  }

#if !SWIG_DOTNET_1
  System.Collections.Generic.IEnumerator<TransportProtocol> System.Collections.Generic.IEnumerable<TransportProtocol>.GetEnumerator() {
    return new TransportProtocolListEnumerator(this);
  }
#endif

  System.Collections.IEnumerator System.Collections.IEnumerable.GetEnumerator() {
    return new TransportProtocolListEnumerator(this);
  }

  public TransportProtocolListEnumerator GetEnumerator() {
    return new TransportProtocolListEnumerator(this);
  }

  // Type-safe enumerator
  /// Note that the IEnumerator documentation requires an InvalidOperationException to be thrown
  /// whenever the collection is modified. This has been done for changes in the size of the
  /// collection but not when one of the elements of the collection is modified as it is a bit
  /// tricky to detect unmanaged code that modifies the collection under our feet.
  public sealed class TransportProtocolListEnumerator : System.Collections.IEnumerator
#if !SWIG_DOTNET_1
    , System.Collections.Generic.IEnumerator<TransportProtocol>
#endif
  {
    private TransportProtocolList collectionRef;
    private int currentIndex;
    private object currentObject;
    private int currentSize;

    public TransportProtocolListEnumerator(TransportProtocolList collection) {
      collectionRef = collection;
      currentIndex = -1;
      currentObject = null;
      currentSize = collectionRef.Count;
    }

    // Type-safe iterator Current
    public TransportProtocol Current {
      get {
        if (currentIndex == -1)
          throw new InvalidOperationException("Enumeration not started.");
        if (currentIndex > currentSize - 1)
          throw new InvalidOperationException("Enumeration finished.");
        if (currentObject == null)
          throw new InvalidOperationException("Collection modified.");
        return (TransportProtocol)currentObject;
      }
    }

    // Type-unsafe IEnumerator.Current
    object System.Collections.IEnumerator.Current {
      get {
        return Current;
      }
    }

    public bool MoveNext() {
      int size = collectionRef.Count;
      bool moveOkay = (currentIndex+1 < size) && (size == currentSize);
      if (moveOkay) {
        currentIndex++;
        currentObject = collectionRef[currentIndex];
      } else {
        currentObject = null;
      }
      return moveOkay;
    }

    public void Reset() {
      currentIndex = -1;
      currentObject = null;
      if (collectionRef.Count != currentSize) {
        throw new InvalidOperationException("Collection modified.");
      }
    }

#if !SWIG_DOTNET_1
    public void Dispose() {
        currentIndex = -1;
        currentObject = null;
    }
#endif
  }

  public void Clear() {
    RCFProtoPINVOKE.TransportProtocolList_Clear(swigCPtr);
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
  }

  public void Add(TransportProtocol x) {
    RCFProtoPINVOKE.TransportProtocolList_Add(swigCPtr, (int)x);
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
  }

  private uint size() {
    uint ret = RCFProtoPINVOKE.TransportProtocolList_size(swigCPtr);
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
    return ret;
  }

  private uint capacity() {
    uint ret = RCFProtoPINVOKE.TransportProtocolList_capacity(swigCPtr);
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
    return ret;
  }

  private void reserve(uint n) {
    RCFProtoPINVOKE.TransportProtocolList_reserve(swigCPtr, n);
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
  }

  public TransportProtocolList() : this(RCFProtoPINVOKE.new_TransportProtocolList__SWIG_0(), true) {
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
  }

  public TransportProtocolList(TransportProtocolList other) : this(RCFProtoPINVOKE.new_TransportProtocolList__SWIG_1(TransportProtocolList.getCPtr(other)), true) {
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
  }

  public TransportProtocolList(int capacity) : this(RCFProtoPINVOKE.new_TransportProtocolList__SWIG_2(capacity), true) {
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
  }

  private TransportProtocol getitemcopy(int index) {
    TransportProtocol ret = (TransportProtocol)RCFProtoPINVOKE.TransportProtocolList_getitemcopy(swigCPtr, index);
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
    return ret;
  }

  private TransportProtocol getitem(int index) {
    TransportProtocol ret = (TransportProtocol)RCFProtoPINVOKE.TransportProtocolList_getitem(swigCPtr, index);
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
    return ret;
  }

  private void setitem(int index, TransportProtocol val) {
    RCFProtoPINVOKE.TransportProtocolList_setitem(swigCPtr, index, (int)val);
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
  }

  public void AddRange(TransportProtocolList values) {
    RCFProtoPINVOKE.TransportProtocolList_AddRange(swigCPtr, TransportProtocolList.getCPtr(values));
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
  }

  public TransportProtocolList GetRange(int index, int count) {
    IntPtr cPtr = RCFProtoPINVOKE.TransportProtocolList_GetRange(swigCPtr, index, count);
    TransportProtocolList ret = (cPtr == IntPtr.Zero) ? null : new TransportProtocolList(cPtr, true);
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
    return ret;
  }

  public void Insert(int index, TransportProtocol x) {
    RCFProtoPINVOKE.TransportProtocolList_Insert(swigCPtr, index, (int)x);
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
  }

  public void InsertRange(int index, TransportProtocolList values) {
    RCFProtoPINVOKE.TransportProtocolList_InsertRange(swigCPtr, index, TransportProtocolList.getCPtr(values));
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
  }

  public void RemoveAt(int index) {
    RCFProtoPINVOKE.TransportProtocolList_RemoveAt(swigCPtr, index);
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
  }

  public void RemoveRange(int index, int count) {
    RCFProtoPINVOKE.TransportProtocolList_RemoveRange(swigCPtr, index, count);
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
  }

  public static TransportProtocolList Repeat(TransportProtocol value, int count) {
    IntPtr cPtr = RCFProtoPINVOKE.TransportProtocolList_Repeat((int)value, count);
    TransportProtocolList ret = (cPtr == IntPtr.Zero) ? null : new TransportProtocolList(cPtr, true);
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
    return ret;
  }

  public void Reverse() {
    RCFProtoPINVOKE.TransportProtocolList_Reverse__SWIG_0(swigCPtr);
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
  }

  public void Reverse(int index, int count) {
    RCFProtoPINVOKE.TransportProtocolList_Reverse__SWIG_1(swigCPtr, index, count);
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
  }

  public void SetRange(int index, TransportProtocolList values) {
    RCFProtoPINVOKE.TransportProtocolList_SetRange(swigCPtr, index, TransportProtocolList.getCPtr(values));
    if (RCFProtoPINVOKE.SWIGPendingException.Pending) throw RCFProtoPINVOKE.SWIGPendingException.Retrieve();
  }

}

}
