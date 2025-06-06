unit GR32_Filters;

(* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1 or LGPL 2.1 with linking exception
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * Alternatively, the contents of this file may be used under the terms of the
 * Free Pascal modified version of the GNU Lesser General Public License
 * Version 2.1 (the "FPC modified LGPL License"), in which case the provisions
 * of this license are applicable instead of those above.
 * Please see the file LICENSE.txt for additional information concerning this
 * license.
 *
 * The Original Code is Graphics32
 *
 * The Initial Developer of the Original Code is
 * Alex A. Denisov
 *
 * Portions created by the Initial Developer are Copyright (C) 2000-2009
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *  Michael Hansen <dyster_tid@hotmail.com>
 *      - 2007/02/25 - Logical Mask Operations and related types
 *      - 2007/02/27 - CopyComponents
 *      - 2007/05/10 - Logical Mask Operation functions in pascal versions
 *
 * ***** END LICENSE BLOCK ***** *)

interface

{$include GR32.inc}

{$IFDEF TARGET_X64}
{$DEFINE PUREPASCAL} // It seems the asm implementations haven't been ported to 64-bit
{$ENDIF}

uses
  Classes, SysUtils, GR32;

{ Basic processing }
type
  TLUT8 = array [Byte] of Byte;
  TLogicalOperator = (loXOR, loAND, loOR);

procedure CopyComponents(Dst, Src: TCustomBitmap32; Components: TColor32Components);overload;
procedure CopyComponents(Dst: TCustomBitmap32; DstX, DstY: Integer; Src: TCustomBitmap32;
  SrcRect: TRect; Components: TColor32Components); overload;

procedure AlphaToGrayscale(Dst, Src: TCustomBitmap32);
procedure ColorToGrayscale(Dst, Src: TCustomBitmap32; PreserveAlpha: Boolean = False);
procedure IntensityToAlpha(Dst, Src: TCustomBitmap32);

procedure Invert(Dst, Src: TCustomBitmap32; Components : TColor32Components = [ccAlpha, ccRed, ccGreen, ccBlue]);
procedure InvertRGB(Dst, Src: TCustomBitmap32);

procedure ApplyLUT(Dst, Src: TCustomBitmap32; const LUT: TLUT8; PreserveAlpha: Boolean = False);
procedure ChromaKey(ABitmap: TCustomBitmap32; TrColor: TColor32);

function CreateBitmask(Components: TColor32Components): TColor32;

procedure ApplyBitmask(Dst: TCustomBitmap32; DstX, DstY: Integer; Src: TCustomBitmap32;
  SrcRect: TRect; Bitmask: TColor32; LogicalOperator: TLogicalOperator); overload;
procedure ApplyBitmask(ABitmap: TCustomBitmap32; ARect: TRect; Bitmask: TColor32;
  LogicalOperator: TLogicalOperator); overload;

procedure CheckParams(Dst, Src: TCustomBitmap32; ResizeDst: Boolean = True);

implementation

uses
  Types,
  GR32_Bindings,
  GR32_Lowlevel;

const
  SEmptyBitmap = 'The bitmap is nil';
  SEmptySource = 'The source is nil';
  SEmptyDestination = 'Destination is nil';

type
{ Function Prototypes }
  TLogicalMaskLine  = procedure(Dst: PColor32; Mask: TColor32; Count: Integer); //Inplace
  TLogicalMaskLineEx  = procedure(Src, Dst: PColor32; Count: Integer; Mask: TColor32); //"Src To Dst"

{$HINTS OFF}
var
{ masked logical operation functions }
  LogicalMaskLineXor: TLogicalMaskLine;
  LogicalMaskLineOr: TLogicalMaskLine;
  LogicalMaskLineAnd: TLogicalMaskLine;

  LogicalMaskLineXorEx: TLogicalMaskLineEx;
  LogicalMaskLineOrEx: TLogicalMaskLineEx;
  LogicalMaskLineAndEx: TLogicalMaskLineEx;
{$HINTS ON}

{ Access to masked logical operation functions corresponding to a logical operation mode }
const
  LOGICAL_MASK_LINE: array[TLogicalOperator] of ^TLogicalMaskLine = (
    (@@LogicalMaskLineXor),
    (@@LogicalMaskLineAnd),
    (@@LogicalMaskLineOr)
  );

  LOGICAL_MASK_LINE_EX: array[TLogicalOperator] of ^TLogicalMaskLineEx = (
    (@@LogicalMaskLineXorEx),
    (@@LogicalMaskLineAndEx),
    (@@LogicalMaskLineOrEx)
  );

procedure CheckParams(Dst, Src: TCustomBitmap32; ResizeDst: Boolean = True);
begin
  if not Assigned(Src) then
    raise Exception.Create(SEmptySource);

  if not Assigned(Dst) then
    raise Exception.Create(SEmptyDestination);

  if ResizeDst then Dst.SetSize(Src.Width, Src.Height);
end;

procedure CopyComponents(Dst, Src: TCustomBitmap32; Components: TColor32Components);
begin
  if Components = [] then Exit;
  CheckParams(Dst, Src);
  CopyComponents(Dst, 0, 0, Src, Src.BoundsRect, Components);
end;

procedure CopyComponents(Dst: TCustomBitmap32; DstX, DstY: Integer; Src: TCustomBitmap32;
  SrcRect: TRect; Components: TColor32Components);
var
  I, J, Count, ComponentCount, XOffset: Integer;
  Mask: TColor32;
  SrcRow, DstRow: PColor32Array;
  PBDst, PBSrc: PByteArray;
  DstRect: TRect;
begin
  if Components = [] then Exit;
  CheckParams(Dst, Src, False);

  ComponentCount := 0;
  XOffset := 0;
  Mask := 0;
  if ccAlpha in Components then
  begin
    Inc(ComponentCount);
    Inc(Mask, $FF000000);
    XOffset := 3;
  end;
  if ccRed in Components then
  begin
    Inc(ComponentCount);
    Inc(Mask, $00FF0000);
    XOffset := 2;
  end;
  if ccGreen in Components then
  begin
    Inc(ComponentCount);
    Inc(Mask, $0000FF00);
    XOffset := 1;
  end;
  if ccBlue in Components then
  begin
    Inc(ComponentCount);
    Inc(Mask, $000000FF);
  end;

  with Dst do
  begin
    GR32.IntersectRect(SrcRect, SrcRect, Src.BoundsRect);
    if (SrcRect.Right < SrcRect.Left) or (SrcRect.Bottom < SrcRect.Top) then Exit;

    DstX := Clamp(DstX, 0, Width);
    DstY := Clamp(DstY, 0, Height);

    DstRect.TopLeft := GR32.Point(DstX, DstY);
    DstRect.Right := DstX + SrcRect.Right - SrcRect.Left;
    DstRect.Bottom := DstY + SrcRect.Bottom - SrcRect.Top;

    GR32.IntersectRect(DstRect, DstRect, BoundsRect);
    GR32.IntersectRect(DstRect, DstRect, ClipRect);
    if (DstRect.Right < DstRect.Left) or (DstRect.Bottom < DstRect.Top) then Exit;

    if not MeasuringMode then
    begin
      BeginUpdate;
      try
        with DstRect do
        if (Bottom - Top) > 0 then
        begin
          SrcRow := Pointer(Src.PixelPtr[SrcRect.Left, SrcRect.Top]);
          DstRow := Pointer(PixelPtr[Left, Top]);
          Count := Right - Left;
          if Count > 16 then
          case ComponentCount of
            1://Byte ptr approach
              begin
                PBSrc := Pointer(SrcRow);
                Inc(PBSrc, XOffset); // shift the pointer to the given component of the first pixel
                PBDst := Pointer(DstRow);
                Inc(PBDst, XOffset);

                Count := Count * 4 - 64;
                Inc(PBSrc, Count);
                Inc(PBDst, Count);

                for I := 0 to Bottom - Top - 1 do
                begin
                  //16x enrolled loop
                  J := - Count;
                  repeat
                    PBDst[J] := PBSrc[J];
                    PBDst[J +  4] := PBSrc[J +  4];
                    PBDst[J +  8] := PBSrc[J +  8];
                    PBDst[J + 12] := PBSrc[J + 12];
                    PBDst[J + 16] := PBSrc[J + 16];
                    PBDst[J + 20] := PBSrc[J + 20];
                    PBDst[J + 24] := PBSrc[J + 24];
                    PBDst[J + 28] := PBSrc[J + 28];
                    PBDst[J + 32] := PBSrc[J + 32];
                    PBDst[J + 36] := PBSrc[J + 36];
                    PBDst[J + 40] := PBSrc[J + 40];
                    PBDst[J + 44] := PBSrc[J + 44];
                    PBDst[J + 48] := PBSrc[J + 48];
                    PBDst[J + 52] := PBSrc[J + 52];
                    PBDst[J + 56] := PBSrc[J + 56];
                    PBDst[J + 60] := PBSrc[J + 60];
                    Inc(J, 64)
                  until J > 0;

                  //The rest
                  Dec(J, 64);
                  while J < 0 do
                  begin
                    PBDst[J + 64] := PBSrc[J + 64];
                    Inc(J, 4);
                  end;
                  Inc(PBSrc, Src.Width * 4);
                  Inc(PBDst, Width * 4);
                end;
              end;
            2, 3: //Masked approach
              begin
                Count := Count - 8;
                Inc(DstRow, Count);
                Inc(SrcRow, Count);
                for I := 0 to Bottom - Top - 1 do
                begin
                  //8x enrolled loop
                  J := - Count;
                  repeat
                    Mask := not Mask;
                    DstRow[J] := DstRow[J] and Mask;
                    DstRow[J + 1] := DstRow[J + 1] and Mask;
                    DstRow[J + 2] := DstRow[J + 2] and Mask;
                    DstRow[J + 3] := DstRow[J + 3] and Mask;
                    DstRow[J + 4] := DstRow[J + 4] and Mask;
                    DstRow[J + 5] := DstRow[J + 5] and Mask;
                    DstRow[J + 6] := DstRow[J + 6] and Mask;
                    DstRow[J + 7] := DstRow[J + 7] and Mask;

                    Mask := not Mask;
                    DstRow[J] := DstRow[J] or SrcRow[J] and Mask;
                    DstRow[J + 1] := DstRow[J + 1] or SrcRow[J + 1] and Mask;
                    DstRow[J + 2] := DstRow[J + 2] or SrcRow[J + 2] and Mask;
                    DstRow[J + 3] := DstRow[J + 3] or SrcRow[J + 3] and Mask;
                    DstRow[J + 4] := DstRow[J + 4] or SrcRow[J + 4] and Mask;
                    DstRow[J + 5] := DstRow[J + 5] or SrcRow[J + 5] and Mask;
                    DstRow[J + 6] := DstRow[J + 6] or SrcRow[J + 6] and Mask;
                    DstRow[J + 7] := DstRow[J + 7] or SrcRow[J + 7] and Mask;

                    Inc(J, 8);
                  until J > 0;

                  //The rest
                  Dec(J, 8);
                  while J < 0 do
                  begin
                    DstRow[J + 8] := DstRow[J + 8] and not Mask or SrcRow[J + 8] and Mask;
                    Inc(J);
                  end;
                  Inc(SrcRow, Src.Width);
                  Inc(DstRow, Width);
                end;
              end;
            4: //full copy approach approach, use MoveLongWord
              for I := 0 to Bottom - Top - 1 do
              begin
                MoveLongWord(SrcRow^, DstRow^, Count);
                Inc(SrcRow, Src.Width);
                Inc(DstRow, Width);
              end;
          end
          else
          begin
            for I := 0 to Bottom - Top - 1 do
            begin
              for J := 0 to Count - 1 do
                DstRow[J] := DstRow[J] and not Mask or SrcRow[J] and Mask;
              Inc(SrcRow, Src.Width);
              Inc(DstRow, Width);
            end;
          end;
        end;
      finally
        EndUpdate;
      end;
    end;
    Changed(DstRect);
  end;
end;

procedure AlphaToGrayscale(Dst, Src: TCustomBitmap32);
var
  I: Integer;
  D, S : PColor32EntryArray;
  Alpha: Byte;
begin
  CheckParams(Dst, Src);
  S := PColor32EntryArray(@Src.Bits[0]);
  D := PColor32EntryArray(@Dst.Bits[0]);
  for I := 0 to Src.Height * Src.Width -1 do
  begin
    Alpha := S[I].A;
    with D[I] do
    begin
      R := Alpha;  
      G := Alpha;  
      B := Alpha;  
    end;  
  end;
  Dst.Changed;
end;

procedure IntensityToAlpha(Dst, Src: TCustomBitmap32);
var
  I: Integer;
  D, S : PColor32EntryArray;
begin
  CheckParams(Dst, Src);
  S := PColor32EntryArray(@Src.Bits[0]);
  D := PColor32EntryArray(@Dst.Bits[0]);
  for I := 0 to Src.Width * Src.Height - 1 do
    D[I].A := (S[I].R * 61 + S[I].G * 174 + S[I].B * 21) shr 8;
  Dst.Changed;
end;

procedure Invert(Dst, Src: TCustomBitmap32; Components : TColor32Components = [ccAlpha, ccRed, ccGreen, ccBlue]);
var
  Mask: TColor32;
begin
  if Components = [] then Exit;
  Mask := CreateBitmask(Components);
  if Src = Dst then
  begin
    //Inplace
    CheckParams(Dst, Src, False);
    ApplyBitmask(Src, Src.BoundsRect, Mask, loXOR);
  end
  else
  begin
    //Src -> Dst
    CheckParams(Dst, Src);
    ApplyBitmask(Dst, 0, 0, Src, Src.BoundsRect, Mask, loXOR);
  end;
end;

procedure InvertRGB(Dst, Src: TCustomBitmap32);
begin
  Invert(Src, Dst, [ccRed, ccGreen, ccBlue]);
end;

procedure ColorToGrayscale(Dst, Src: TCustomBitmap32; PreserveAlpha: Boolean = False);
var
  I: Integer;
  D, S: PColor32;
begin
  CheckParams(Dst, Src);
  D := @Dst.Bits[0];
  S := @Src.Bits[0];
  
  if PreserveAlpha then
    for I := 0 to Src.Width * Src.Height - 1 do
    begin
      D^ := Gray32(Intensity(S^), AlphaComponent(S^));
      Inc(S); Inc(D);
    end
  else
    for I := 0 to Src.Width * Src.Height - 1 do
    begin
      D^ := Gray32(Intensity(S^));
      Inc(S); Inc(D);
    end;
    
  Dst.Changed;
end;

procedure ApplyLUT(Dst, Src: TCustomBitmap32; const LUT: TLUT8; PreserveAlpha: Boolean = False);
var
  I: Integer;
  D, S: PColor32Entry;
begin
  CheckParams(Dst, Src);
  D := @Dst.Bits[0];
  S := @Src.Bits[0];

  if PreserveAlpha then
    for I := 0 to Src.Width * Src.Height - 1 do
    begin
      D.ARGB := D.ARGB and $FF000000 + LUT[S.B] + LUT[S.G] shl 8 + LUT[S.R] shl 16;
      Inc(S);
      Inc(D);
    end
  else
    for I := 0 to Src.Width * Src.Height - 1 do
    begin
      D.ARGB := $FF000000 + LUT[S.B] + LUT[S.G] shl 8 + LUT[S.R] shl 16;
      Inc(S);
      Inc(D);
    end;
    
  Dst.Changed;
end;

procedure ChromaKey(ABitmap: TCustomBitmap32; TrColor: TColor32);
var
  P: PColor32;
  C: TColor32;
  I: Integer;
begin
  TrColor := TrColor and $00FFFFFF;
  with ABitmap do
  begin
    P := PixelPtr[0, 0];
    for I := 0 to Width * Height - 1 do
    begin
      C := P^ and $00FFFFFF;
      if C = TrColor then P^ := C;
      Inc(P)
    end;
  end;

  ABitmap.Changed;
end;

function CreateBitmask(Components: TColor32Components): TColor32;
begin
  Result := 0;
  if ccAlpha in Components then Inc(Result, $FF000000);
  if ccRed in Components then Inc(Result, $00FF0000);
  if ccGreen in Components then Inc(Result, $0000FF00);
  if ccBlue in Components then Inc(Result, $000000FF);
end;

procedure ApplyBitmask(Dst: TCustomBitmap32; DstX, DstY: Integer; Src: TCustomBitmap32;
  SrcRect: TRect; Bitmask: TColor32; LogicalOperator: TLogicalOperator);
var
  I, Count: Integer;
  DstRect: TRect;
  MaskProc : TLogicalMaskLineEx;
begin
  CheckParams(Dst, Src, False);

  MaskProc := LOGICAL_MASK_LINE_EX[LogicalOperator]^;

  if Assigned(MaskProc) then
  with Dst do
  begin
    GR32.IntersectRect(SrcRect, SrcRect, Src.BoundsRect);
    if (SrcRect.Right < SrcRect.Left) or (SrcRect.Bottom < SrcRect.Top) then Exit;

    DstX := Clamp(DstX, 0, Width);
    DstY := Clamp(DstY, 0, Height);

    DstRect.TopLeft := GR32.Point(DstX, DstY);
    DstRect.Right := DstX + SrcRect.Right - SrcRect.Left;
    DstRect.Bottom := DstY + SrcRect.Bottom - SrcRect.Top;

    GR32.IntersectRect(DstRect, DstRect, Dst.BoundsRect);
    GR32.IntersectRect(DstRect, DstRect, Dst.ClipRect);
    if (DstRect.Right < DstRect.Left) or (DstRect.Bottom < DstRect.Top) then
      Exit;

    if not MeasuringMode then
    begin
      BeginUpdate;
      try
        with DstRect do
        if (Bottom - Top) > 0 then
        begin
          Count := Right - Left;
          if Count > 0 then
              for I := 0 to Bottom - Top - 1 do
                MaskProc(Src.PixelPtr[SrcRect.Left, SrcRect.Top + I], PixelPtr[Left, Top + I], Count, Bitmask)
        end;
      finally
        EndUpdate;
      end;
    end;

    Changed(DstRect);
  end;
end;

procedure ApplyBitmask(ABitmap: TCustomBitmap32; ARect: TRect; Bitmask: TColor32;
  LogicalOperator: TLogicalOperator);
var
  I, Count: Integer;
  MaskProc : TLogicalMaskLine;
begin
  if not Assigned(ABitmap) then
    raise Exception.Create(SEmptyBitmap);

  MaskProc := LOGICAL_MASK_LINE[LogicalOperator]^;

  if Assigned(MaskProc) then
  with ABitmap do
  begin
    GR32.IntersectRect(ARect, ARect, BoundsRect);
    GR32.IntersectRect(ARect, ARect, ClipRect);
    if (ARect.Right < ARect.Left) or (ARect.Bottom < ARect.Top) then Exit;

    if not MeasuringMode then
    begin
      BeginUpdate;
      try
        with ARect do
        if (Bottom - Top) > 0 then
        begin
          Count := Right - Left;
          if Count > 0 then
          begin
            if Count = Width then
              MaskProc(PixelPtr[Left, Top], Bitmask, Count * (Bottom - Top))
            else
              for I := Top to Bottom - 1 do
                MaskProc(PixelPtr[Left, I], Bitmask, Count);
          end;
        end;
      finally
        EndUpdate;
      end;
    end;

    Changed(ARect);
  end;
end;

{ In-place logical mask functions }
{ Non - MMX versions}

procedure XorLine_Pas(Dst: PColor32; Mask: TColor32; Count: Integer);
var
  DstRow: PColor32Array absolute Dst;
begin
  Inc(Dst, Count);
  Count := - Count;
  repeat
    DstRow[Count] := DstRow[Count] xor Mask;
    Inc(Count);
  until Count = 0;
end;

procedure OrLine_Pas(Dst: PColor32; Mask: TColor32; Count: Integer);
var
  DstRow: PColor32Array absolute Dst;
begin
  Inc(Dst, Count);
  Count := - Count;
  repeat
    DstRow[Count] := DstRow[Count] or Mask;
    Inc(Count);
  until Count = 0;
end;

procedure AndLine_Pas(Dst: PColor32; Mask: TColor32; Count: Integer);
var
  DstRow: PColor32Array absolute Dst;
begin
  Inc(Dst, Count);
  Count := - Count;
  repeat
    DstRow[Count] := DstRow[Count] and Mask;
    Inc(Count);
  until Count = 0;
end;

{$IFNDEF PUREPASCAL}

procedure XorLine_ASM(Dst: PColor32; Mask: TColor32; Count: Integer); {$IFDEF FPC}assembler;{$ENDIF}
// No speedup achieveable using MMX
asm
{$IFDEF TARGET_x86}
        TEST    ECX, ECX
        JZ      @Exit

        PUSH    EBX
        MOV     EBX, ECX
        SHR     ECX, 4
        SHL     ECX, 4
        JZ      @PrepSingleLoop
        LEA     EAX, [EAX + ECX * 4]
        SHL     ECX, 2
        NEG     ECX

@ChunkLoop:
        //16x unrolled loop
        XOR     [EAX + ECX], EDX
        XOR     [EAX + ECX + 4], EDX
        XOR     [EAX + ECX + 8], EDX
        XOR     [EAX + ECX + 12], EDX

        XOR     [EAX + ECX + 16], EDX
        XOR     [EAX + ECX + 20], EDX
        XOR     [EAX + ECX + 24], EDX
        XOR     [EAX + ECX + 28], EDX

        XOR     [EAX + ECX + 32], EDX
        XOR     [EAX + ECX + 36], EDX
        XOR     [EAX + ECX + 40], EDX
        XOR     [EAX + ECX + 44], EDX

        XOR     [EAX + ECX + 48], EDX
        XOR     [EAX + ECX + 52], EDX
        XOR     [EAX + ECX + 56], EDX
        XOR     [EAX + ECX + 60], EDX

        ADD     ECX, 16 * 4
        JNZ     @ChunkLoop

@PrepSingleLoop:
        MOV     ECX, EBX
        SHR     EBX, 4
        SHL     EBX, 4
        SUB     ECX, EBX
        JZ      @PopExit

        LEA     EAX, [EAX + ECX * 4]
        NEG     ECX

@SingleLoop:
        XOR     [EAX + ECX * 4], EDX
        INC     ECX
        JNZ     @SingleLoop

@PopExit:
        POP     EBX

@Exit:
{$ENDIF}

{$IFDEF TARGET_x64}
        TEST    R8D, R8D
        JZ      @Exit

        MOV     EAX, R8D
        SHR     R8D, 4
        SHL     R8D, 4
        JZ      @PrepSingleLoop
        LEA     RCX, [RCX + R8D * 4]
        SHL     R8D, 2
        NEG     R8D

@ChunkLoop:
        //16x unrolled loop
        XOR     [RCX + R8D], EDX
        XOR     [RCX + R8D + 4], EDX
        XOR     [RCX + R8D + 8], EDX
        XOR     [RCX + R8D + 12], EDX

        XOR     [RCX + R8D + 16], EDX
        XOR     [RCX + R8D + 20], EDX
        XOR     [RCX + R8D + 24], EDX
        XOR     [RCX + R8D + 28], EDX

        XOR     [RCX + R8D + 32], EDX
        XOR     [RCX + R8D + 36], EDX
        XOR     [RCX + R8D + 40], EDX
        XOR     [RCX + R8D + 44], EDX

        XOR     [RCX + R8D + 48], EDX
        XOR     [RCX + R8D + 52], EDX
        XOR     [RCX + R8D + 56], EDX
        XOR     [RCX + R8D + 60], EDX

        ADD     R8D, 16 * 4
        JNZ     @ChunkLoop

@PrepSingleLoop:
        MOV     R8D, EAX
        SHR     EAX, 4
        SHL     EAX, 4
        SUB     R8D, EAX
        JZ      @Exit

        LEA     RCX, [RCX + R8D * 4]
        NEG     R8D

@SingleLoop:
        XOR     [RCX + R8D * 4], EDX
        INC     R8D
        JNZ     @SingleLoop

@Exit:
{$ENDIF}
end;

procedure OrLine_ASM(Dst: PColor32; Mask: TColor32; Count: Integer);
// No speedup achieveable using MMX
asm
{$IFDEF TARGET_x86}
        TEST    ECX, ECX
        JZ      @Exit

        PUSH    EBX
        MOV     EBX, ECX
        SHR     ECX, 4
        SHL     ECX, 4
        JZ      @PrepSingleLoop
        LEA     EAX, [EAX + ECX * 4]
        SHL     ECX, 2
        NEG     ECX

@ChunkLoop:
        //16x unrolled loop
        OR      [EAX + ECX], EDX
        OR      [EAX + ECX + 4], EDX
        OR      [EAX + ECX + 8], EDX
        OR      [EAX + ECX + 12], EDX

        OR      [EAX + ECX + 16], EDX
        OR      [EAX + ECX + 20], EDX
        OR      [EAX + ECX + 24], EDX
        OR      [EAX + ECX + 28], EDX

        OR      [EAX + ECX + 32], EDX
        OR      [EAX + ECX + 36], EDX
        OR      [EAX + ECX + 40], EDX
        OR      [EAX + ECX + 44], EDX

        OR      [EAX + ECX + 48], EDX
        OR      [EAX + ECX + 52], EDX
        OR      [EAX + ECX + 56], EDX
        OR      [EAX + ECX + 60], EDX

        ADD     ECX, 16 * 4
        JNZ     @ChunkLoop

@PrepSingleLoop:
        MOV     ECX, EBX
        SHR     EBX, 4
        SHL     EBX, 4
        SUB     ECX, EBX
        JZ      @PopExit

        LEA     EAX, [EAX + ECX * 4]
        NEG     ECX

@SingleLoop:
        OR      [EAX + ECX * 4], EDX
        INC     ECX
        JNZ     @SingleLoop

@PopExit:
        POP     EBX

@Exit:
{$ENDIF}

{$IFDEF TARGET_x64}
        TEST    R8D, R8D
        JZ      @Exit

        MOV     EAX, R8D
        SHR     R8D, 4
        SHL     R8D, 4
        JZ      @PrepSingleLoop
        LEA     RCX, [RCX + R8D * 4]
        SHL     R8D, 2
        NEG     R8D

@ChunkLoop:
        //16x unrolled loop
        OR      [RCX + R8D], EDX
        OR      [RCX + R8D + 4], EDX
        OR      [RCX + R8D + 8], EDX
        OR      [RCX + R8D + 12], EDX

        OR      [RCX + R8D + 16], EDX
        OR      [RCX + R8D + 20], EDX
        OR      [RCX + R8D + 24], EDX
        OR      [RCX + R8D + 28], EDX

        OR      [RCX + R8D + 32], EDX
        OR      [RCX + R8D + 36], EDX
        OR      [RCX + R8D + 40], EDX
        OR      [RCX + R8D + 44], EDX

        OR      [RCX + R8D + 48], EDX
        OR      [RCX + R8D + 52], EDX
        OR      [RCX + R8D + 56], EDX
        OR      [RCX + R8D + 60], EDX

        ADD     R8D, 16 * 4
        JNZ     @ChunkLoop

@PrepSingleLoop:
        MOV     R8D, EAX
        SHR     EAX, 4
        SHL     EAX, 4
        SUB     R8D, EAX
        JZ      @Exit

        LEA     RCX, [RCX + R8D * 4]
        NEG     R8D

@SingleLoop:
        OR      [RCX + R8D * 4], EDX
        INC     R8D
        JNZ     @SingleLoop

@Exit:
{$ENDIF}
end;

procedure AndLine_ASM(Dst: PColor32; Mask: TColor32; Count: Integer);
// No speedup achieveable using MMX
asm
{$IFDEF TARGET_x86}
        TEST    ECX, ECX
        JZ      @Exit

        PUSH    EBX
        MOV     EBX, ECX
        SHR     ECX, 4
        SHL     ECX, 4
        JZ      @PrepSingleLoop
        LEA     EAX, [EAX + ECX * 4]
        SHL     ECX, 2
        NEG     ECX

@ChunkLoop:
        //16x unrolled loop
        AND     [EAX + ECX], EDX
        AND     [EAX + ECX + 4], EDX
        AND     [EAX + ECX + 8], EDX
        AND     [EAX + ECX + 12], EDX

        AND     [EAX + ECX + 16], EDX
        AND     [EAX + ECX + 20], EDX
        AND     [EAX + ECX + 24], EDX
        AND     [EAX + ECX + 28], EDX

        AND     [EAX + ECX + 32], EDX
        AND     [EAX + ECX + 36], EDX
        AND     [EAX + ECX + 40], EDX
        AND     [EAX + ECX + 44], EDX

        AND     [EAX + ECX + 48], EDX
        AND     [EAX + ECX + 52], EDX
        AND     [EAX + ECX + 56], EDX
        AND     [EAX + ECX + 60], EDX

        ADD     ECX, 16 * 4
        JNZ     @ChunkLoop

@PrepSingleLoop:
        MOV     ECX, EBX
        SHR     EBX, 4
        SHL     EBX, 4
        SUB     ECX, EBX
        JZ      @PopExit

        LEA     EAX, [EAX + ECX * 4]
        NEG     ECX

@SingleLoop:
        AND     [EAX + ECX * 4], EDX
        INC     ECX
        JNZ     @SingleLoop

@PopExit:
        POP     EBX

@Exit:
{$ENDIF}

{$IFDEF TARGET_x64}
        TEST    R8D, R8D
        JZ      @Exit

        MOV     EAX, R8D
        SHR     R8D, 4
        SHL     R8D, 4
        JZ      @PrepSingleLoop
        LEA     RCX, [RCX + R8D * 4]
        SHL     R8D, 2
        NEG     R8D

@ChunkLoop:
        //16x unrolled loop
        AND     [RCX + R8D], EDX
        AND     [RCX + R8D + 4], EDX
        AND     [RCX + R8D + 8], EDX
        AND     [RCX + R8D + 12], EDX

        AND     [RCX + R8D + 16], EDX
        AND     [RCX + R8D + 20], EDX
        AND     [RCX + R8D + 24], EDX
        AND     [RCX + R8D + 28], EDX

        AND     [RCX + R8D + 32], EDX
        AND     [RCX + R8D + 36], EDX
        AND     [RCX + R8D + 40], EDX
        AND     [RCX + R8D + 44], EDX

        AND     [RCX + R8D + 48], EDX
        AND     [RCX + R8D + 52], EDX
        AND     [RCX + R8D + 56], EDX
        AND     [RCX + R8D + 60], EDX

        ADD     R8D, 16 * 4
        JNZ     @ChunkLoop

@PrepSingleLoop:
        MOV     R8D, EAX
        SHR     EAX, 4
        SHL     EAX, 4
        SUB     R8D, EAX
        JZ      @Exit

        LEA     RCX, [RCX + R8D * 4]
        NEG     R8D

@SingleLoop:
        AND     [RCX + R8D * 4], EDX
        INC     R8D
        JNZ     @SingleLoop

@Exit:
{$ENDIF}
end;

{$ENDIF}

{ extended logical mask functions Src -> Dst }
{ Non - MMX versions}

procedure XorLineEx_Pas(Src, Dst: PColor32; Count: Integer; Mask: TColor32);
var
  SrcRow: PColor32Array absolute Src;
  DstRow: PColor32Array absolute Dst;
begin
  Inc(Dst, Count);
  Inc(Src, Count);
  Count := - Count;
  repeat
    DstRow[Count] := SrcRow[Count] xor Mask;
    Inc(Count);
  until Count = 0;
end;

procedure OrLineEx_Pas(Src, Dst: PColor32; Count: Integer; Mask: TColor32);
var
  SrcRow: PColor32Array absolute Src;
  DstRow: PColor32Array absolute Dst;
begin
  Inc(Dst, Count);
  Inc(Src, Count);
  Count := - Count;
  repeat
    DstRow[Count] := SrcRow[Count] or Mask;
    Inc(Count);
  until Count = 0;
end;

procedure AndLineEx_Pas(Src, Dst: PColor32; Count: Integer; Mask: TColor32);
var
  SrcRow: PColor32Array absolute Src;
  DstRow: PColor32Array absolute Dst;
begin
  Inc(Dst, Count);
  Inc(Src, Count);
  Count := - Count;
  repeat
    DstRow[Count] := SrcRow[Count] and Mask;
    Inc(Count);
  until Count = 0;
end;

{$IFNDEF PUREPASCAL}

procedure XorLineEx_ASM(Src, Dst: PColor32; Count: Integer; Mask: TColor32); {$IFDEF FPC}assembler;{$ENDIF}
asm
{$IFDEF TARGET_x86}
        PUSH    EBX
        PUSH    EDI

        LEA     EAX, [EAX + ECX * 4]
        LEA     EDX, [EDX + ECX * 4]
        NEG     ECX
        JZ      @Exit

        MOV     EDI, Mask

@Loop:
        MOV     EBX, [EAX + ECX * 4]
        XOR     EBX, EDI
        MOV     [EDX + ECX * 4], EBX
        INC     ECX
        JNZ     @Loop

@Exit:
        POP     EDI
        POP     EBX
{$ENDIF}

{$IFDEF TARGET_x64}
        LEA     RCX, [RCX + R8D * 4]
        LEA     RDX, [RDX + R8D * 4]
        NEG     R8D
        JZ      @Exit

@Loop:
        MOV     EAX, [RCX + R8D * 4]
        XOR     EAX, R9D
        MOV     [RDX + R8D * 4], EAX
        INC     R8D
        JNZ     @Loop

@Exit:
{$ENDIF}
end;

procedure OrLineEx_ASM(Src, Dst: PColor32; Count: Integer; Mask: TColor32);
asm
{$IFDEF TARGET_x86}
        PUSH    EBX
        PUSH    EDI

        LEA     EAX, [EAX + ECX * 4]
        LEA     EDX, [EDX + ECX * 4]
        NEG     ECX
        JZ      @Exit

        MOV     EDI, Mask

@Loop:
        MOV     EBX, [EAX + ECX * 4]
        OR      EBX, EDI
        MOV     [EDX + ECX * 4], EBX
        INC     ECX
        JNZ     @Loop

@Exit:

        POP     EDI
        POP     EBX
{$ENDIF}

{$IFDEF TARGET_x64}
        LEA     RCX, [RCX + R8D * 4]
        LEA     RDX, [RDX + R8D * 4]
        NEG     R8D
        JZ      @Exit

@Loop:
        MOV     EBX, [RCX + R8D * 4]
        OR      EBX, R9D
        MOV     [RDX + R8D * 4], EBX
        INC     R8D
        JNZ     @Loop

@Exit:
{$ENDIF}
end;

procedure AndLineEx_ASM(Src, Dst: PColor32; Count: Integer; Mask: TColor32);
asm
{$IFDEF TARGET_x86}
        PUSH    EBX
        PUSH    EDI

        LEA     EAX, [EAX + ECX * 4]
        LEA     EDX, [EDX + ECX * 4]
        NEG     ECX
        JZ      @Exit

        MOV     EDI, Mask

@Loop:
        MOV     EBX, [EAX + ECX * 4]
        AND     EBX, EDI
        MOV     [EDX + ECX * 4], EBX
        INC     ECX
        JNZ     @Loop

@Exit:

        POP     EDI
        POP     EBX
{$ENDIF}

{$IFDEF TARGET_x64}
        LEA     RCX, [RCX + R8D * 4]
        LEA     RDX, [RDX + R8D * 4]
        NEG     R8D
        JZ      @Exit

@Loop:
        MOV     EAX, [RCX + R8D * 4]
        AND     EAX, R9D
        MOV     [RDX + R8D * 4], EAX
        INC     R8D
        JNZ     @Loop

@Exit:
{$ENDIF}
end;

{ MMX versions}

{$IFNDEF OMIT_MMX}
procedure XorLineEx_MMX(Src, Dst: PColor32; Count: Integer; Mask: TColor32);
//MMX version
var
  QMask: Int64;

asm
        PUSH      EBX
        PUSH      EDI

        TEST      ECX, ECX
        JZ        @Exit

        MOV       EBX, ECX
        SHR       ECX, 4
        SHL       ECX, 4
        JZ        @PrepSingleLoop

        SAR       ECX, 1
        LEA       EAX, [EAX + ECX * 8]
        LEA       EDX, [EDX + ECX * 8]
        NEG       ECX

        MOVD      MM7, MASK
        PUNPCKLDQ MM7, MM7
        MOVQ      QMask, MM7
        EMMS

@Loop:
        MOVQ      MM0, [EAX + ECX * 8]
        MOVQ      MM1, [EAX + ECX * 8 + 8]
        MOVQ      MM2, [EAX + ECX * 8 + 16]
        MOVQ      MM3, [EAX + ECX * 8 + 24]
        MOVQ      MM4, [EAX + ECX * 8 + 32]
        MOVQ      MM5, [EAX + ECX * 8 + 40]
        MOVQ      MM6, [EAX + ECX * 8 + 48]
        MOVQ      MM7, [EAX + ECX * 8 + 56]

        PXOR      MM0, QMask
        PXOR      MM1, QMask
        PXOR      MM2, QMask
        PXOR      MM3, QMask
        PXOR      MM4, QMask
        PXOR      MM5, QMask
        PXOR      MM6, QMask
        PXOR      MM7, QMask

        MOVQ      [EDX + ECX * 8], MM0
        MOVQ      [EDX + ECX * 8 + 8], MM1
        MOVQ      [EDX + ECX * 8 + 16], MM2
        MOVQ      [EDX + ECX * 8 + 24], MM3
        MOVQ      [EDX + ECX * 8 + 32], MM4
        MOVQ      [EDX + ECX * 8 + 40], MM5
        MOVQ      [EDX + ECX * 8 + 48], MM6
        MOVQ      [EDX + ECX * 8 + 56], MM7

        ADD       ECX, 8
        JS        @Loop

        EMMS

@PrepSingleLoop:
        MOV       ECX, EBX
        SHR       EBX, 4
        SHL       EBX, 4
        SUB       ECX, EBX
        JZ        @Exit

        LEA       EAX, [EAX + ECX * 4]
        LEA       EDX, [EDX + ECX * 4]
        NEG       ECX

        MOV       EDI, Mask

@SingleLoop:
        MOV       EBX, [EAX + ECX * 4]
        XOR       EBX, EDI
        MOV       [EDX + ECX * 4], EBX
        INC       ECX
        JNZ       @SingleLoop

@Exit:
        POP       EDI
        POP       EBX
end;

procedure OrLineEx_MMX(Src, Dst: PColor32; Count: Integer; Mask: TColor32);
//MMX version
var
  QMask: Int64;

asm
        PUSH      EBX
        PUSH      EDI

        TEST      ECX, ECX
        JZ        @Exit

        MOV       EBX, ECX
        SHR       ECX, 4
        SHL       ECX, 4
        JZ        @PrepSingleLoop

        SAR       ECX, 1
        LEA       EAX, [EAX + ECX * 8]
        LEA       EDX, [EDX + ECX * 8]
        NEG       ECX

        MOVD      MM7, MASK
        PUNPCKLDQ MM7, MM7
        MOVQ      QMask, MM7
        EMMS

@Loop:
        MOVQ      MM0, [EAX + ECX * 8]
        MOVQ      MM1, [EAX + ECX * 8 + 8]
        MOVQ      MM2, [EAX + ECX * 8 + 16]
        MOVQ      MM3, [EAX + ECX * 8 + 24]
        MOVQ      MM4, [EAX + ECX * 8 + 32]
        MOVQ      MM5, [EAX + ECX * 8 + 40]
        MOVQ      MM6, [EAX + ECX * 8 + 48]
        MOVQ      MM7, [EAX + ECX * 8 + 56]

        POR       MM0, QMask
        POR       MM1, QMask
        POR       MM2, QMask
        POR       MM3, QMask
        POR       MM4, QMask
        POR       MM5, QMask
        POR       MM6, QMask
        POR       MM7, QMask

        MOVQ      [EDX + ECX * 8], MM0
        MOVQ      [EDX + ECX * 8 + 8], MM1
        MOVQ      [EDX + ECX * 8 + 16], MM2
        MOVQ      [EDX + ECX * 8 + 24], MM3
        MOVQ      [EDX + ECX * 8 + 32], MM4
        MOVQ      [EDX + ECX * 8 + 40], MM5
        MOVQ      [EDX + ECX * 8 + 48], MM6
        MOVQ      [EDX + ECX * 8 + 56], MM7

        ADD       ECX, 8
        JS        @Loop

        EMMS

@PrepSingleLoop:
        MOV       ECX, EBX
        SHR       EBX, 4
        SHL       EBX, 4
        SUB       ECX, EBX
        JZ        @Exit

        LEA       EAX, [EAX + ECX * 4]
        LEA       EDX, [EDX + ECX * 4]
        NEG       ECX

        MOV       EDI, Mask

@SingleLoop:
        MOV       EBX, [EAX + ECX * 4]
        OR        EBX, EDI
        MOV       [EDX + ECX * 4], EBX
        INC       ECX
        JNZ       @SingleLoop

@Exit:
        POP       EDI
        POP       EBX
end;

procedure AndLineEx_MMX(Src, Dst: PColor32; Count: Integer; Mask: TColor32);
//MMX version
var
  QMask: Int64;
asm
        PUSH      EBX
        PUSH      EDI

        TEST      ECX, ECX
        JZ        @Exit

        MOV       EBX, ECX
        SHR       ECX, 4
        SHL       ECX, 4
        JZ        @PrepSingleLoop

        SAR       ECX, 1
        LEA       EAX, [EAX + ECX * 8]
        LEA       EDX, [EDX + ECX * 8]
        NEG       ECX

        MOVD      MM7, MASK
        PUNPCKLDQ MM7, MM7
        MOVQ      QMask, MM7
        EMMS

@Loop:
        MOVQ      MM0, [EAX + ECX * 8]
        MOVQ      MM1, [EAX + ECX * 8 + 8]
        MOVQ      MM2, [EAX + ECX * 8 + 16]
        MOVQ      MM3, [EAX + ECX * 8 + 24]
        MOVQ      MM4, [EAX + ECX * 8 + 32]
        MOVQ      MM5, [EAX + ECX * 8 + 40]
        MOVQ      MM6, [EAX + ECX * 8 + 48]
        MOVQ      MM7, [EAX + ECX * 8 + 56]

        PAND      MM0, QMask
        PAND      MM1, QMask
        PAND      MM2, QMask
        PAND      MM3, QMask
        PAND      MM4, QMask
        PAND      MM5, QMask
        PAND      MM6, QMask
        PAND      MM7, QMask

        MOVQ      [EDX + ECX * 8], MM0
        MOVQ      [EDX + ECX * 8 + 8], MM1
        MOVQ      [EDX + ECX * 8 + 16], MM2
        MOVQ      [EDX + ECX * 8 + 24], MM3
        MOVQ      [EDX + ECX * 8 + 32], MM4
        MOVQ      [EDX + ECX * 8 + 40], MM5
        MOVQ      [EDX + ECX * 8 + 48], MM6
        MOVQ      [EDX + ECX * 8 + 56], MM7

        ADD       ECX, 8
        JS        @Loop

        EMMS

@PrepSingleLoop:
        MOV       ECX, EBX
        SHR       EBX, 4
        SHL       EBX, 4
        SUB       ECX, EBX
        JZ        @Exit

        LEA       EAX, [EAX + ECX * 4]
        LEA       EDX, [EDX + ECX * 4]
        NEG       ECX

        MOV       EDI, Mask

@SingleLoop:
        MOV       EBX, [EAX + ECX * 4]
        AND       EBX, EDI
        MOV       [EDX + ECX * 4], EBX
        INC       ECX
        JNZ       @SingleLoop

@Exit:
        POP       EDI
        POP       EBX
end;

{ Extended MMX versions}

procedure XorLineEx_EMMX(Src, Dst: PColor32; Count: Integer; Mask: TColor32);
//EMMX version
var
  QMask: Int64;

asm
        PUSH      EBX
        PUSH      EDI

        TEST      ECX, ECX
        JZ        @Exit

        MOV       EBX, ECX
        SHR       ECX, 4
        SHL       ECX, 4
        JZ        @PrepSingleLoop

        SAR       ECX, 1
        LEA       EAX, [EAX + ECX * 8]
        LEA       EDX, [EDX + ECX * 8]
        NEG       ECX

        MOVD      MM7, MASK
        PUNPCKLDQ MM7, MM7
        MOVQ      QMask, MM7
        EMMS

@Loop:
        MOVQ      MM0, [EAX + ECX * 8]
        MOVQ      MM1, [EAX + ECX * 8 + 8]
        MOVQ      MM2, [EAX + ECX * 8 + 16]
        MOVQ      MM3, [EAX + ECX * 8 + 24]
        MOVQ      MM4, [EAX + ECX * 8 + 32]
        MOVQ      MM5, [EAX + ECX * 8 + 40]
        MOVQ      MM6, [EAX + ECX * 8 + 48]
        MOVQ      MM7, [EAX + ECX * 8 + 56]

        PXOR      MM0, QMask
        PXOR      MM1, QMask
        PXOR      MM2, QMask
        PXOR      MM3, QMask
        PXOR      MM4, QMask
        PXOR      MM5, QMask
        PXOR      MM6, QMask
        PXOR      MM7, QMask

        MOVNTQ    [EDX + ECX * 8], MM0
        MOVNTQ    [EDX + ECX * 8 + 8], MM1
        MOVNTQ    [EDX + ECX * 8 + 16], MM2
        MOVNTQ    [EDX + ECX * 8 + 24], MM3
        MOVNTQ    [EDX + ECX * 8 + 32], MM4
        MOVNTQ    [EDX + ECX * 8 + 40], MM5
        MOVNTQ    [EDX + ECX * 8 + 48], MM6
        MOVNTQ    [EDX + ECX * 8 + 56], MM7

        ADD       ECX, 8
        JS        @Loop

        EMMS

@PrepSingleLoop:
        MOV       ECX, EBX
        SHR       EBX, 4
        SHL       EBX, 4
        SUB       ECX, EBX
        JZ        @Exit

        LEA   EAX, [EAX + ECX * 4]
        LEA   EDX, [EDX + ECX * 4]
        NEG   ECX

        MOV   EDI, Mask

@SingleLoop:
        MOV   EBX, [EAX + ECX * 4]
        XOR   EBX, EDI
        MOV   [EDX + ECX * 4], EBX
        INC   ECX
        JNZ   @SingleLoop

@Exit:
        POP   EDI
        POP   EBX
end;

procedure OrLineEx_EMMX(Src, Dst: PColor32; Count: Integer; Mask: TColor32);
//EMMX version
var
  QMask: Int64;

asm
        PUSH      EBX
        PUSH      EDI

        TEST      ECX, ECX
        JZ        @Exit

        MOV       EBX, ECX
        SHR       ECX, 4
        SHL       ECX, 4
        JZ        @PrepSingleLoop

        SAR       ECX, 1
        LEA       EAX, [EAX + ECX * 8]
        LEA       EDX, [EDX + ECX * 8]
        NEG       ECX

        MOVD      MM7, MASK
        PUNPCKLDQ MM7, MM7
        MOVQ      QMask, MM7
        EMMS

@Loop:
        MOVQ      MM0, [EAX + ECX * 8]
        MOVQ      MM1, [EAX + ECX * 8 + 8]
        MOVQ      MM2, [EAX + ECX * 8 + 16]
        MOVQ      MM3, [EAX + ECX * 8 + 24]
        MOVQ      MM4, [EAX + ECX * 8 + 32]
        MOVQ      MM5, [EAX + ECX * 8 + 40]
        MOVQ      MM6, [EAX + ECX * 8 + 48]
        MOVQ      MM7, [EAX + ECX * 8 + 56]

        POR       MM0, QMask
        POR       MM1, QMask
        POR       MM2, QMask
        POR       MM3, QMask
        POR       MM4, QMask
        POR       MM5, QMask
        POR       MM6, QMask
        POR       MM7, QMask

        MOVNTQ    [EDX + ECX * 8], MM0
        MOVNTQ    [EDX + ECX * 8 + 8], MM1
        MOVNTQ    [EDX + ECX * 8 + 16], MM2
        MOVNTQ    [EDX + ECX * 8 + 24], MM3
        MOVNTQ    [EDX + ECX * 8 + 32], MM4
        MOVNTQ    [EDX + ECX * 8 + 40], MM5
        MOVNTQ    [EDX + ECX * 8 + 48], MM6
        MOVNTQ    [EDX + ECX * 8 + 56], MM7

        ADD       ECX, 8
        JS        @Loop

        EMMS

@PrepSingleLoop:
        MOV       ECX, EBX
        SHR       EBX, 4
        SHL       EBX, 4
        SUB       ECX, EBX
        JZ        @Exit

        LEA       EAX, [EAX + ECX * 4]
        LEA       EDX, [EDX + ECX * 4]
        NEG       ECX

        MOV       EDI, Mask

@SingleLoop:
        MOV       EBX, [EAX + ECX * 4]
        OR        EBX, EDI
        MOV       [EDX + ECX * 4], EBX
        INC       ECX
        JNZ       @SingleLoop

@Exit:
        POP       EDI
        POP       EBX
end;

procedure AndLineEx_EMMX(Src, Dst: PColor32; Count: Integer; Mask: TColor32);
//EMMX version
var
  QMask: Int64;

asm
        PUSH      EBX
        PUSH      EDI

        TEST      ECX, ECX
        JZ        @Exit

        MOV       EBX, ECX
        SHR       ECX, 4
        SHL       ECX, 4
        JZ        @PrepSingleLoop

        SAR       ECX, 1
        LEA       EAX, [EAX + ECX * 8]
        LEA       EDX, [EDX + ECX * 8]
        NEG       ECX

        MOVD      MM7, MASK
        PUNPCKLDQ MM7, MM7
        MOVQ      QMask, MM7
        EMMS

@Loop:
        MOVQ      MM0, [EAX + ECX * 8]
        MOVQ      MM1, [EAX + ECX * 8 + 8]
        MOVQ      MM2, [EAX + ECX * 8 + 16]
        MOVQ      MM3, [EAX + ECX * 8 + 24]
        MOVQ      MM4, [EAX + ECX * 8 + 32]
        MOVQ      MM5, [EAX + ECX * 8 + 40]
        MOVQ      MM6, [EAX + ECX * 8 + 48]
        MOVQ      MM7, [EAX + ECX * 8 + 56]

        PAND      MM0, QMask
        PAND      MM1, QMask
        PAND      MM2, QMask
        PAND      MM3, QMask
        PAND      MM4, QMask
        PAND      MM5, QMask
        PAND      MM6, QMask
        PAND      MM7, QMask

        MOVNTQ    [EDX + ECX * 8], MM0
        MOVNTQ    [EDX + ECX * 8 + 8], MM1
        MOVNTQ    [EDX + ECX * 8 + 16], MM2
        MOVNTQ    [EDX + ECX * 8 + 24], MM3
        MOVNTQ    [EDX + ECX * 8 + 32], MM4
        MOVNTQ    [EDX + ECX * 8 + 40], MM5
        MOVNTQ    [EDX + ECX * 8 + 48], MM6
        MOVNTQ    [EDX + ECX * 8 + 56], MM7

        ADD       ECX, 8
        JS        @Loop

        EMMS

@PrepSingleLoop:
        MOV       ECX, EBX
        SHR       EBX, 4
        SHL       EBX, 4
        SUB       ECX, EBX
        JZ        @Exit

        LEA       EAX, [EAX + ECX * 4]
        LEA       EDX, [EDX + ECX * 4]
        NEG       ECX

        MOV       EDI, Mask

@SingleLoop:
        MOV       EBX, [EAX + ECX * 4]
        AND       EBX, EDI
        MOV       [EDX + ECX * 4], EBX
        INC       ECX
        JNZ       @SingleLoop

@Exit:
        POP       EDI
        POP       EBX
end;

{$ENDIF}
{$ENDIF}

{CPU target and feature Function templates}

var
  Registry: TFunctionRegistry;

procedure RegisterBindings;
begin
  Registry := NewRegistry('GR32_Filters bindings');
  Registry.RegisterBinding(@@LogicalMaskLineAnd, 'LogicalMaskLineAnd');
  Registry.RegisterBinding(@@LogicalMaskLineOr, 'LogicalMaskLineOr');
  Registry.RegisterBinding(@@LogicalMaskLineXor, 'LogicalMaskLineXor');
  Registry.RegisterBinding(@@LogicalMaskLineAndEx, 'LogicalMaskLineAndEx');
  Registry.RegisterBinding(@@LogicalMaskLineOrEx, 'LogicalMaskLineOrEx');
  Registry.RegisterBinding(@@LogicalMaskLineXorEx, 'LogicalMaskLineXorEx');

  Registry[@@LogicalMaskLineAnd].Add(   @AndLine_Pas,   [isPascal]).Name := 'AndLine_Pas';
  Registry[@@LogicalMaskLineOr].Add(    @OrLine_Pas,    [isPascal]).Name := 'OrLine_Pas';
  Registry[@@LogicalMaskLineXor].Add(   @XorLine_Pas,   [isPascal]).Name := 'XorLine_Pas';
  Registry[@@LogicalMaskLineAndEx].Add( @AndLineEx_Pas, [isPascal]).Name := 'AndLineEx_Pas';
  Registry[@@LogicalMaskLineOrEx].Add(  @OrLineEx_Pas,  [isPascal]).Name := 'OrLineEx_Pas';
  Registry[@@LogicalMaskLineXorEx].Add( @XorLineEx_Pas, [isPascal]).Name := 'XorLineEx_Pas';

{$IFNDEF PUREPASCAL}
  Registry[@@LogicalMaskLineAnd].Add(   @AndLine_ASM,   [isAssembler]).Name := 'AndLine_ASM';
  Registry[@@LogicalMaskLineOr].Add(    @OrLine_ASM,    [isAssembler]).Name := 'OrLine_ASM';
  Registry[@@LogicalMaskLineXor].Add(   @XorLine_ASM,   [isAssembler]).Name := 'XorLine_ASM';
  Registry[@@LogicalMaskLineAndEx].Add( @AndLineEx_ASM, [isAssembler]).Name := 'AndLineEx_ASM';
  Registry[@@LogicalMaskLineOrEx].Add(  @OrLineEx_ASM,  [isAssembler]).Name := 'OrLineEx_ASM';
  Registry[@@LogicalMaskLineXorEx].Add( @XorLineEx_ASM, [isAssembler]).Name := 'XorLineEx_ASM';

  // TODO : rewrite MMX implementations using SSE
{$IFNDEF OMIT_MMX}
  Registry[@@LogicalMaskLin].Add(@AndLineEx_MMX, [isMMX]).Name := 'AndLineEx_MMX';
  Registry[@@LogicalMaskLineOrLi].Add(@OrLineEx_MMX, [isMMX]).Name := 'OrLineEx_MMX';
  Registry[@@LogicalMaskLineXorLi].Add(@XorLineEx_MMX, [isMMX]).Name := 'XorLineEx_MMX';
  Registry[@@LogicalMaskLineAndEx].Add(@AndLineEx_EMMX, [isExMMX]).Name := 'AndLineEx_EMMX';
  Registry[@@LogicalMaskLineOrEx].Add(@OrLineEx_EMMX, [isExMMX]).Name := 'OrLineEx_EMMX';
  Registry[@@LogicalMaskLineXorEx].Add(@XorLineEx_EMMX, [isExMMX]).Name := 'XorLineEx_EMMX';
{$ENDIF}

{$ENDIF}

  Registry.RebindAll;
end;

initialization
  RegisterBindings;

end.
