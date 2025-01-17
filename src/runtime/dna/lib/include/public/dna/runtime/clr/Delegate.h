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

#ifndef DF54A444_F5B9_4E0B_AD0E_6F8FBD6A30A8
#define DF54A444_F5B9_4E0B_AD0E_6F8FBD6A30A8

#include <dna/runtime/clr/cli/MetaData.h>
#include <dna/runtime/clr/pla/Types.h>

fnInternalCall Map_Delegate(tMD_MethodDef *pMethod);

tMD_MethodDef *Delegate_GetMethod(void *pThis_);
tMD_MethodDef *Delegate_GetMethodAndStore(void *pThis_, HEAP_PTR *pTargetObj,
                                          void **ppNextDelegate);

#endif /* DF54A444_F5B9_4E0B_AD0E_6F8FBD6A30A8 */
