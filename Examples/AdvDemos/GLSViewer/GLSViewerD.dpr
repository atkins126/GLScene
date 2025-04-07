program GLSViewerD;

uses
  Forms,
  fGLForm in 'Source\fGLForm.pas' {GLForm},
  fGLDialog in 'Source\fGLDialog.pas' {GLDialog},
  fGLSViewer in 'Source\fGLSViewer.pas' {frmGLSViewer},
  uGlobals in 'Source\uGlobals.pas',
  uSettings in 'Source\uSettings.pas',
  dImages in 'Source\dImages.pas' {dmImages: TDataModule},
  fGLAbout in 'Source\fGLAbout.pas' {GLAbout},
  fGLOptions in 'Source\fGLOptions.pas' {FormOptions},
  dDialogs in 'Source\dDialogs.pas' {dmDialogs: TDataModule};

{$R *.res}

begin
 // Application.Initialize;
 // Application.Title := 'GLSViewer';
  Application.CreateForm(TfrmGLSViewer, frmGLSViewer);
  Application.CreateForm(TdmImages, dmImages);
  Application.CreateForm(TdmDialogs, dmDialogs);
  Application.Run;
end.
