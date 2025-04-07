unit fxGR32;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Objects,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  System.Math.Vectors,
  GR32_Transforms,
  GR32, System.Math,
  FMX.Layouts,
  TypInfo,
  FMX.Platform,
  FMX.ListBox,
  GR32_Resamplers;

type
  TfxFMXGR32 = class(TForm)
    Image1: TImage;
    Layout2: TLayout;
    Image2: TImage;
    Rectangle3: TRectangle;
    Label13: TLabel;
    Rectangle1: TRectangle;
    Label1: TLabel;
    CmbResamplerClassNames: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Layout2Resize(Sender: TObject);
    procedure CmbResamplerClassNamesChange(Sender: TObject);
  private const
    DESIRE_FORMAT: TPixelFormat =
    {$IFDEF RGBA_FORMAT}
    TPixelFormat.RGBA
    {$ELSE}
    TPixelFormat.BGRA
    {$ENDIF}
    ;
  private
    { Private declarations }
    Transformation: TProjectiveTransformation;
    FScaleFactor: Single;
    Vertices: array [0..3] of TPointF;
    procedure DoPointChanged(Sender: TObject; var X, Y: Single);
    procedure DoTransform;
  public
    { Public declarations }
  end;

var
  fxFMXGR32: TfxFMXGR32;

implementation
{$R *.fmx}

procedure TfxFMXGR32.Button1Click(Sender: TObject);
//var
//  M: TMatrix;
begin
//  M.m11 := 0.945039331912994;
//  m.m21 := 0;
//  m.m31 := -0.000584687339141965;
//  m.m12 := 0;
//  m.m22 := 0.535142779350281;
//  m.m32 := -0.00280034448951483;
//  m.m13 := 0;
//  m.m23 := 0;
//  m.m33 := 1;
//
//
//  PaintBox1.Canvas.BeginScene();
//  paintBox1.Canvas.MultiplyMatrix(M);
//  PaintBox1.Canvas.DrawBitmap(Image1.Bitmap, RectF(0,0,Image1.Bitmap.Width,Image1.Bitmap.Height), PaintBox1.LocalRect, 1);
//  paintBox1.Canvas.EndScene;

  DoTransform;
end;

procedure TfxFMXGR32.CmbResamplerClassNamesChange(Sender: TObject);
begin
  DoTransform;
end;

procedure TfxFMXGR32.DoPointChanged(Sender: TObject; var X, Y: Single);
var
  idx: Integer;
begin
  idx := (Sender as TComponent).Tag;
  Vertices[idx].X := X;
  Vertices[idx].Y := Y;
  DoTransform;
end;

procedure TfxFMXGR32.DoTransform;
var
  src, dst: TBitmap32;
  maxx,maxy: Single;
  I: Integer;
  s: string;
  dstBitmap, tmp: TBitmap;
begin
  if image1.Bitmap.PixelFormat <> DESIRE_FORMAT then
  begin
    s := TypInfo.GetEnumName(TypeInfo(TPixelFormat), Integer(image1.Bitmap.PixelFormat));
    ShowMessage('wrong with ' + s);
    Exit;
  end;

  maxx := 0;
  maxy := 0;
  for I := 0 to 3 do
  begin
    maxx := max(maxx, Vertices[I].X);
    maxy := max(maxy, Vertices[I].Y);
  end;

  Transformation.X0 := Vertices[0].X;
  Transformation.Y0 := Vertices[0].Y;
  Transformation.X1 := Vertices[1].X;
  Transformation.Y1 := Vertices[1].Y;
  Transformation.X2 := Vertices[2].X;
  Transformation.Y2 := Vertices[2].Y;
  Transformation.X3 := Vertices[3].X;
  Transformation.Y3 := Vertices[3].Y;
  Transformation.SrcRect := FloatRect(0,0,200,200);
  src := TBitmap32.Create();
  dst := TBitmap32.Create();
  dstBitmap := TBitmap.Create;
  try
    src.Assign(Image1.Bitmap);
    with CmbResamplerClassNames do
      if ItemIndex >= 0 then
        Src.ResamplerClassName := Items[ ItemIndex ];
    dst.SetSize(ceil(maxx), ceil(maxy));
    Dst.Clear($00000000);
    Transform(Dst, Src, Transformation);
    dstBitmap.Assign(dst);
    if FScaleFactor = 1 then
      Image2.Bitmap := dstBitmap
    else
    begin
      tmp := TBitmap.Create;
      try
        tmp.SetSize(Round(dstBitmap.Width * FScaleFactor), Round(dstBitmap.Height * FScaleFactor));
        tmp.Canvas.BeginScene;
        tmp.Clear(0);
        tmp.Canvas.DrawBitmap(dstBitmap, dstBitmap.Bounds, tmp.Bounds, 1);
        tmp.Canvas.EndScene;
        Image2.Bitmap := tmp;
      finally
        tmp.Free;
      end;
    end;
  finally
    dstBitmap.Free;
    dst.Free;
    src.Free;
  end;
end;

procedure TfxFMXGR32.FormCreate(Sender: TObject);
var
  I: Integer;
  Shape: TSelectionPoint;
  ScreenSrv: IFMXScreenService;
begin

  if TPlatformServices.Current.SupportsPlatformService(IFMXScreenService, ScreenSrv) then
    FScaleFactor := ScreenSrv.GetScreenScale
  else
    FScaleFactor := 1;

  Transformation := TProjectiveTransformation.Create;
  Vertices[0] := Point(-10,-20);
  Vertices[1] := Point(200,0);
  Vertices[2] := Point(200,200);
  Vertices[3] := Point(0,200);
//  Vertices[0] := Point(18,49);
//  Vertices[1] := Point(265,6);
//  Vertices[2] := Point(292,196);
//  Vertices[3] := Point(58,239);
  for I := 0 to 3 do
  begin
    Shape := TSelectionPoint.Create(Self);
    Shape.Parent := Image2;
    Shape.GripSize := 9;
    Shape.Position.X := Vertices[i].X;
    Shape.Position.Y := Vertices[i].Y;
    Shape.OnTrack := DoPointChanged;
    Shape.Tag := i;
  end;
  ResamplerList.GetClassNames(CmbResamplerClassNames.Items);
  CmbResamplerClassNames.ItemIndex := 0;
end;

procedure TfxFMXGR32.Layout2Resize(Sender: TObject);
begin
  Image1.Position.Point := TPoint.Zero;
  if Layout2.Width > Layout2.Height then
  begin
    Image1.Size.Size := TSizeF.Create(Layout2.Width / 2, Layout2.Height);
    Image2.Position.Point := PointF(Layout2.Width/2, 0);
    Image2.Size.Size := TSizeF.Create(Layout2.Width / 2, Layout2.Height);
  end
  else
  begin
    Image1.Size.Size := TSizeF.Create(Layout2.Width, Layout2.Height/2);
    Image2.Position.Point := PointF(0, Layout2.Height/2);
    Image2.Size.Size := TSizeF.Create(Layout2.Width, Layout2.Height/2);
  end;
end;

end.
