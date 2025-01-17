// Copyright (c) 2012 DotNetAnywhere
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#include <dna/runtime/clr/Sys.h>
#include <dna/runtime/clr/pla/Compat.h>

#include <dna/runtime/clr/Heap.h>
#include <dna/runtime/clr/Type.h>
#include <dna/runtime/clr/cli/MetaData.h>
#include <dna/runtime/clr/pla/Types.h>

#include <dna/runtime/fx/system/System.Array.h>

tAsyncCall *System_GC_Collect(PTR pThis_, PTR pParams, PTR pReturnValue) {
  Heap_GarbageCollect();
  return NULL;
}

tAsyncCall *System_GC_Internal_CollectionCount(PTR pThis_, PTR pParams,
                                               PTR pReturnValue) {
  *(U32 *)pReturnValue = Heap_NumCollections();
  return NULL;
}

tAsyncCall *System_GC_GetTotalMemory(PTR pThis_, PTR pParams,
                                     PTR pReturnValue) {
  if (*(U32 *)pParams) {
    Heap_GarbageCollect();
  }
  *(U64 *)pReturnValue = Heap_GetTotalMemory();
  return NULL;
}

tAsyncCall *System_GC_SuppressFinalize(PTR pThis_, PTR pParams,
                                       PTR pReturnValue) {
  HEAP_PTR obj = ((HEAP_PTR *)pParams)[0];
  Heap_UnmarkFinalizer(obj);
  return NULL;
}
