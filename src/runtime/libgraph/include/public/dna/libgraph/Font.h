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

#ifndef FF53A940_D29D_485F_9382_7C81DFD659A3
#define FF53A940_D29D_485F_9382_7C81DFD659A3

#include <dna/libgraph/FontFamily.h>
#include <dna/libgraph/libIGraph.h>


typedef struct tFont_ tFont;
struct tFont_ {
  tFontFamily *pFontFamily;
  float emSize;
  U32 fontStyle;

  // Cache information about this font
  I32 unitsPerEm;
  I32 ascender, descender;
  I32 height;
  I32 maxAdvanceWidth, maxAdvanceHeight;
  I32 underlinePosition;
  I32 underlineThickness;
  U32 charMapIndex;

  // And pre-calculated pixel values
  I32 pixelSizeX, pixelSizeY;
  I32 pixelAscender, pixelDescender, pixelHeight;
};

tFont *CreateFont_(tFontFamily *pFontFamily, float emSize, U32 fontStyle);
void DisposeFont_(tFont *pFont);

#endif /* FF53A940_D29D_485F_9382_7C81DFD659A3 */
