unit MainUnit;

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
 * The Original Code is Texture Blend Example
 *
 * The Initial Developer(s) of the Original Code is:
 * Michael Hansen <dyster_tid@hotmail.com>
 *
 * Portions created by the Initial Developer are Copyright (C) 2000-2010
 * the Initial Developer. All Rights Reserved.
 *
 *
 * ***** END LICENSE BLOCK ***** *)

interface

{$include GR32.inc}

uses
  {$IFNDEF FPC} Windows, {$ELSE} LCLIntf, LResources, LCLType, Buttons, {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Math, StdCtrls, ExtCtrls,
  GR32_Image, GR32_RangeBars;

type
  TMainForm = class(TForm)
    BlendBox: TComboBox;
    CombImg: TImage32;
    GenerateButton: TButton;
    LabelBlendmode: TLabel;
    LabelBlendSettings: TLabel;
    LabelCombinedTexture: TLabel;
    LabelMasterAlpha: TLabel;
    LabelTextureA: TLabel;
    LabelTextureB: TLabel;
    LabelWeightmap: TLabel;
    LabelWeightmapSettings: TLabel;
    MasterAlphaBar: TGaugeBar;
    TexAImg: TImage32;
    TexBImg: TImage32;
    WeightmapImg: TImage32;
    procedure FormCreate(Sender: TObject);
    procedure MasterAlphaBarChange(Sender: TObject);
  public
    procedure GenerateWeightmap(Sender: TObject);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
{$IFDEF Darwin}
  MacOSAll,
{$ENDIF}
  GR32,
  GR32_Resamplers,
  GR32_LowLevel,
  GR32_Blend,
  GR32.ImageFormats.JPG;

var
  ColorAlgebraReg: TBlendReg;

function ColorAlgebraEx(F, B: TColor32; M: Cardinal): TColor32;
begin
  // Call the coloralgebra routine in action, restore foreground alpha and blend
  Result := BlendRegEx(ColorAlgebraReg(F, B) and $FFFFFF or F and $FF000000, B, M);
end;

function SoftMaskedEx(F, B: TColor32; M: Cardinal): TColor32;
var
   X: Integer;
begin
  // Some sort of masking with MasterAlpha (as threshold) included
  X := F shr 24 - (255 - M);
  if X > 0 then
    Result := F
  else
  if X = 0 then
    Result := ColorAverage(F, B) // Create soft edges
  else
    Result := B;
end;

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  // Load the textures (note size 256x256 is implicity expected!)
  TexAImg.Bitmap.LoadFromResourceName(HInstance, 'TextureA', RT_RCDATA);
  TexBImg.Bitmap.LoadFromResourceName(HInstance, 'TextureB', RT_RCDATA);

  BlendBox.ItemIndex := 0;

  CombImg.Bitmap.SetSizeFrom(TexBImg.Bitmap);

  // Set up Weightmap and trigger generate
  WeightmapImg.Bitmap.SetSize(256, 256);
  GenerateButton.OnClick := GenerateWeightmap;

  //we don't want the same series of weightmaps repeat every time the app is run
  Randomize;

  GenerateWeightmap(Self);
end;

procedure TMainForm.GenerateWeightmap(Sender: TObject);
// Below code is very much based on experimentation, feel free to play around..
var
  a, b, c: Single;

  function GenerateSomething(x, y : Single): Single;
  begin
    if a < 0.6 then
      Result := Max(Cos(x * PI * a * 2 + b), Sqr(0.1 + c + x*y - y)) *
        (Sin(y * b * a) - c + ArcTan2(x + Cos((x - y) * b), y + a))
    else
      Result := Cos(x * PI * a * 2 + c) * Sin(y * b * a) +
        Sin(ArcTan2(x + Cos((x - y) * b), y * c * Sin(x - a)));
  end;

const
  nS = 1 / 255;

var
  I, J: Integer;
  W : TColor32;
  D, WImg: PColor32;
  x, y: Single;
begin
  // Setup some random factors:
  a := 0.01 + Random;
  b := PI * 10 * a * (Random * Random * 2 - 1);
  c := Random - Random;

  // We use the weightmap as TexB alpha, so we write that on the loop too
  D := @TexBImg.Bitmap.Bits[0];
  WImg := @WeightmapImg.Bitmap.Bits[0];
  for J := 0 to 255 do
    for I := 0 to 255 do
    begin
      x := Cos(I * nS + (PI * a));
      y := Sin(J * nS * (PI * c));
      W := Round(Constrain(Abs(Min(GenerateSomething(x * c, y),
        GenerateSomething(y + c , x * a))) * 200, 0, 255));
      if c > 0 then
        WImg^ := ColorDifference(WImg^, $FF000000 + W shl 16 + W shl 8 + W)
      else
        WImg^ := $FF000000 + W shl 16 + W shl 8 + W;

      D^ := D^ and $00FFFFFF or W shl 24;
      Inc(D);
      Inc(WImg);
    end;

  WeightmapImg.Invalidate;
  MasterAlphaBarChange(Self);
end;

procedure TMainForm.MasterAlphaBarChange(Sender: TObject);
var
  ABlendRegEx: TBlendRegEx;
begin
  // Setup blendmode
  case BlendBox.ItemIndex of
    0: ABlendRegEx := BlendRegEx;
    1: ABlendRegEx := SoftMaskedEx;
  else
    begin
       ABlendRegEx := ColorAlgebraEx;
       case BlendBox.ItemIndex of
         2: ColorAlgebraReg := ColorAdd;
         3: ColorAlgebraReg := ColorSub;
         4: ColorAlgebraReg := ColorDiv;
         5: ColorAlgebraReg := ColorModulate;
         6: ColorAlgebraReg := ColorMax;
         7: ColorAlgebraReg := ColorMin;
         8: ColorAlgebraReg := ColorDifference;
         9: ColorAlgebraReg := ColorAverage;
         10: ColorAlgebraReg := ColorExclusion;
         11: ColorAlgebraReg := ColorScreen;
         12: ColorAlgebraReg := ColorScreen;
         13: ColorAlgebraReg := ColorDodge;
         14: ColorAlgebraReg := ColorBurn;
       end;
    end;
 end;

  // Combine Texture A with B
  BlendTransfer(CombImg.Bitmap, 0, 0, CombImg.Bitmap.BoundsRect, TexBImg.Bitmap,
    TexBImg.Bitmap.BoundsRect, TexAImg.Bitmap, TexAImg.Bitmap.BoundsRect,
    ABlendRegEx, MasterAlphaBar.Position);

  // Needed under Mac OS X
  CombImg.Invalidate;
end;

end.
