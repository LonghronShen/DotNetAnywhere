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

#ifndef AFEFCDAC_C6C9_45C8_B89A_5BEA6951C407
#define AFEFCDAC_C6C9_45C8_B89A_5BEA6951C407

#include <dna/libgraph/Graphics.h>
#include <dna/libgraph/libIGraph.h>

tGraphics *GetScreen_(I32 *pXSize, I32 *pYSize, U32 *pPixelFormat);
void ScreenDispose();
U32 GetScreenPixel(I32 x, I32 y);

U32 IsKeyDown_Internal_(U32 key);
U32 LatestKeyUp_Internal_();
U32 LatestKeyDown_Internal_();

#endif /* AFEFCDAC_C6C9_45C8_B89A_5BEA6951C407 */
