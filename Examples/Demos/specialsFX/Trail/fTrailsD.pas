unit fTrailsD;

interface

uses
  Winapi.OpenGL,
  System.SysUtils,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  
  GLS.Cadencer, 
  GLS.Scene, 
  GLS.Objects, 
  GLS.GeomObjects,
  GLS.SceneViewer,
  GLS.Trail,
  GLS.Texture, 
  Stage.VectorGeometry, 
  GLS.Mesh, 
  Stage.VectorTypes,
  GLS.Coordinates, 
  GLS.BaseClasses;

type
  TFormTrails = class(TForm)
    GLScene1: TGLScene;
    GLSceneViewer1: TGLSceneViewer;
    GLCamera1: TGLCamera;
    GLCadencer1: TGLCadencer;
    Timer1: TTimer;
    GLSphere1: TGLSphere;
    Room: TGLSphere;
    GLLightSource1: TGLLightSource;
    Panel1: TPanel;
    TrackBarSpeed: TTrackBar;
    Label1: TLabel;
    procedure GLCadencer1Progress(Sender: TObject; const deltaTime,
      newTime: Double);
    procedure GLSceneViewer1MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure GLSceneViewer1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
     
  public
     
    mx,my : integer;
    Trail: TGLTrail;
    Direction : TVector3f;
    LastTimeDirectionChange : Double;
  end;

var
  FormTrails: TFormTrails;

implementation

{$R *.dfm}

procedure TFormTrails.FormCreate(Sender: TObject);
begin
     Randomize;
     Direction := VectorScale(AffineVectormake(random-0.5,random-0.5,random-0.5),0.5);
     with TGLTrail(GLScene1.Objects.AddNewChild(TGLTrail)) do
     begin
          TrailObject := GLSphere1;     // Trail will follow this sphere
          TimeLimit   := 0.2;           // 0.2 seconds trail
          VertLimit   := 200;           // max 200 vertices for trail
          MinDistance := 0.1;           // minimal distance before adding a segment to the trail
          MarkStyle   := msFaceCamera;  // Trail will be facing the camera (ideal for bullets trails or similar)
          MarkWidth   := 0.5;
          Material.FrontProperties.Diffuse.AsWinColor := clWhite;
     end;
end;


procedure TFormTrails.GLCadencer1Progress(Sender: TObject; const deltaTime,
  newTime: Double);
begin

     GLSphere1.Position.AsAffineVector := VectorAdd(GLSphere1.Position.AsAffineVector,VectorScale(Direction,TrackBarSpeed.Position));

     // Keep sphere in place
     if VectorLength(GLSphere1.Position.AsAffineVector)> 6 then
     begin
          // move to previous position
          GLSphere1.Position.AsAffineVector := VectorSubtract(GLSphere1.Position.AsAffineVector,VectorScale(Direction,TrackBarSpeed.Position));
          // set opposite direction
          Direction := VectorNegate(Direction);
          // Add some randomness
          Direction := VectorScale(AffineVectormake(random-0.5,random-0.5,random-0.5),deltatime*10);
     end;

     GLSceneViewer1.Invalidate;
end;


procedure TFormTrails.GLSceneViewer1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     mx := x;
     my := y;
end;

procedure TFormTrails.GLSceneViewer1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
     if ssLeft in Shift then
     begin
          GLCamera1.MoveAroundTarget(my-y,mx-x);
     end;

     mx := x;
     my := y;
end;

procedure TFormTrails.Timer1Timer(Sender: TObject);
begin
     caption := Inttostr(Round(GLSceneViewer1.FramesPerSecond));
     GLSceneViewer1.ResetPerformanceMonitor;
end;


end.
