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

#ifndef B62DB9CA_76E8_4258_9F05_D26922405E6E
#define B62DB9CA_76E8_4258_9F05_D26922405E6E

#include <dna/libgraph/libIGraph.h>

#include <dna/libgraph/Image.h>

typedef struct tBitmap_ tBitmap;
struct tBitmap_ {
  tImage image;
  U32 memSize;
  U32 stride;
  U8 pBmp[0];
};

tBitmap *CreateBitmap_(I32 width, I32 height, U32 pixelFormat);
tGraphics *GetGraphicsFromBitmap_(tBitmap *pBitmap);
tBitmap *BitmapFromFile_(STRING filename, I32 *pWidth, I32 *pHeight,
                         U32 *pPixelFormat);

#endif /* B62DB9CA_76E8_4258_9F05_D26922405E6E */
