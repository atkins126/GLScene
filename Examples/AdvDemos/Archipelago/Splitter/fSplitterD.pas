//
// The graphics engine GLXEngine
//
unit fSplitterD;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Imaging.Jpeg,
  Vcl.StdCtrls,
  Vcl.ComCtrls,

  Stage.Utils;

type
  TForm1 = class(TForm)
    EditFile: TEdit;
    Button1: TButton;
    EDTileSize: TEdit;
    EditMask: TEdit;
    ProgressBar: TProgressBar;
    Label1: TLabel;
    LAAction: TLabel;
    RBFull: TRadioButton;
    RBHalf: TRadioButton;
    RBLow: TRadioButton;
    procedure Button1Click(Sender: TObject);
  private
    PathJpgIn, PathJpgOut: TFileName;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  GLS.VectorLists;

procedure TForm1.Button1Click(Sender: TObject);
var
  pic: TPicture;
  bmp, bmp2: TBitmap;
  s, sd, f: Integer;
  x, y: Integer;
begin
  PathJpgIn := GetCurrentAssetPath() + '\map';
  SetCurrentDir(PathJpgIn);

  s := StrToInt(EDTileSize.Text);
  pic := TPicture.Create;

  if RBHalf.Checked then
    f := 2
  else if RBLow.Checked then
    f := 4
  else
    f := 1;
  sd := s div f;

  ProgressBar.Position := 0;
  Screen.Cursor := crHourGlass;

  bmp := TBitmap.Create;
  bmp.PixelFormat := pf24bit;
  bmp.Width := sd;
  bmp.Height := sd;

  if f <> 1 then
  begin
    bmp2 := TBitmap.Create;
    bmp2.PixelFormat := pf24bit;
    bmp2.Width := s;
    bmp2.Height := s;
  end
  else
    bmp2 := nil;

  LAAction.Caption := 'Loading Jpeg texture...';
  LAAction.Visible := True;
  Refresh;
  pic.LoadFromFile(EditFile.Text);
  x := 0;
  while x < pic.Width do
  begin
    y := 0;
    while y < pic.Height do
    begin

      if sd <> s then
      begin
        bmp2.Canvas.Draw(-x, -y, pic.Graphic);
        bmp.Canvas.StretchDraw(Rect(0, 0, sd, sd), bmp2);
      end
      else
        bmp.Canvas.Draw(-x, -y, pic.Graphic);
      LAAction.Caption := Format('Generating tile %d-%d...', [x div s, y div s]);
      Refresh;

      PathJpgOut := ExtractFilePath(ParamStr(0));
      SetCurrentDir(PathJpgOut);

      bmp.SaveToFile(Format(EditMask.Text, [x div s, y div s]));
      ProgressBar.StepBy(1);

      Inc(y, s);
    end;
    Inc(x, s);
  end;

  bmp2.Free;
  bmp.Free;
  pic.Free;

  Screen.Cursor := crDefault;
  LAAction.Caption := 'Completed';
  ShowMessage('Done!');
  Application.Terminate;
end;

end.

