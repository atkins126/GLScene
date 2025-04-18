program ImgView_Layers;

{$R 'Media.res' 'Media.rc'}

uses
  Forms,
  MainUnit in 'MainUnit.pas',
  NewImageUnit in 'NewImageUnit.pas',
  RGBALoaderUnit in 'RGBALoaderUnit.pas';

{.$R '..\..\manifest.res'}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TFrmNewImage, FrmNewImage);
  Application.CreateForm(TRGBALoaderForm, RGBALoaderForm);
  Application.Run;
end.
