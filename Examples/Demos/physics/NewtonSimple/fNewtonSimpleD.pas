unit fNewtonSimpleD;

interface

uses
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  GLS.Scene,
  GLS.Objects,
  GLS.Coordinates,
  GLS.SimpleNavigation,
  GLS.Cadencer,
  GLS.SceneViewer,
  GLS.Color,
 
  GLS.BaseClasses,
  GLS.NGDManager,
  GLS.GeomObjects,
  GLS.BitmapFont,
  GLS.WindowsFont,
  GLS.HUDObjects;

type
  TFormNewtonSimple = class(TForm)
    GLScene1: TGLScene;
    GLSceneViewer1: TGLSceneViewer;
    GLCadencer1: TGLCadencer;
    GLSimpleNavigation1: TGLSimpleNavigation;
    GLCamera1: TGLCamera;
    GLLightSource1: TGLLightSource;
    Floor: TGLCube;
    GLDummyCube1: TGLDummyCube;
    GLNGDManager1: TGLNGDManager;
    GLResolutionIndependantHUDText1: TGLResolutionIndependantHUDText;
    Panel1: TPanel;
    btnAddCube: TButton;
    btnAddSphere: TButton;
    btnAddCone: TButton;
    btnAddCylinder: TButton;
    btnAddCapsule: TButton;
    btnRemoveAll: TButton;
    procedure GLCadencer1Progress(Sender: TObject;
      const deltaTime, newTime: Double);
    procedure btnAddCubeClick(Sender: TObject);
    procedure btnAddSphereClick(Sender: TObject);
    procedure btnAddConeClick(Sender: TObject);
    procedure btnAddCylinderClick(Sender: TObject);
    procedure btnAddCapsuleClick(Sender: TObject);
    procedure btnRemoveAllClick(Sender: TObject);
  private
  public
  end;

var
  FormNewtonSimple: TFormNewtonSimple;

implementation

{$R *.dfm}

procedure TFormNewtonSimple.btnAddCubeClick(Sender: TObject);
var
  GLCube1: TGLCube;
  DynNGDBehav: TGLNGDDynamic;
begin
  GLCube1 := TGLCube.CreateAsChild(GLDummyCube1);
  GLCube1.Material.FrontProperties.Diffuse.RandomColor;
  DynNGDBehav := GLCube1.GetOrCreateBehaviour(TGLNGDDynamic) as TGLNGDDynamic;
  DynNGDBehav.Manager := GLNGDManager1;
end;

procedure TFormNewtonSimple.btnAddSphereClick(Sender: TObject);
var
  GLSphere1: TGLSphere;
  DynNGDBehav: TGLNGDDynamic;
begin
  GLSphere1 := TGLSphere.CreateAsChild(GLDummyCube1);
  GLSphere1.Material.FrontProperties.Diffuse.RandomColor;
  DynNGDBehav := GLSphere1.GetOrCreateBehaviour(TGLNGDDynamic) as TGLNGDDynamic;
  DynNGDBehav.Manager := GLNGDManager1;
end;

procedure TFormNewtonSimple.btnAddConeClick(Sender: TObject);
var
  GLCone1: TGLCone;
  DynNGDBehav: TGLNGDDynamic;
begin
  GLCone1 := TGLCone.CreateAsChild(GLDummyCube1);
  GLCone1.Material.FrontProperties.Diffuse.RandomColor;
  DynNGDBehav := GLCone1.GetOrCreateBehaviour(TGLNGDDynamic) as TGLNGDDynamic;
  DynNGDBehav.Manager := GLNGDManager1;
end;

procedure TFormNewtonSimple.btnAddCylinderClick(Sender: TObject);
var
  GLCylinder1: TGLCylinder;
  DynNGDBehav: TGLNGDDynamic;
begin
  GLCylinder1 := TGLCylinder.CreateAsChild(GLDummyCube1);
  GLCylinder1.Material.FrontProperties.Diffuse.RandomColor;
  DynNGDBehav := GLCylinder1.GetOrCreateBehaviour(TGLNGDDynamic)
    as TGLNGDDynamic;
  DynNGDBehav.Manager := GLNGDManager1;
end;

procedure TFormNewtonSimple.btnAddCapsuleClick(Sender: TObject);
var
  GLCapsule1: TGLCapsule;
  DynNGDBehav: TGLNGDDynamic;
begin
  GLCapsule1 := TGLCapsule.CreateAsChild(GLDummyCube1);
  GLCapsule1.Material.FrontProperties.Diffuse.RandomColor;
  DynNGDBehav := GLCapsule1.GetOrCreateBehaviour(TGLNGDDynamic)
    as TGLNGDDynamic;
  DynNGDBehav.Manager := GLNGDManager1;
end;

procedure TFormNewtonSimple.btnRemoveAllClick(Sender: TObject);
begin
  GLDummyCube1.DeleteChildren;
  GLSceneViewer1.Invalidate;
end;

procedure TFormNewtonSimple.GLCadencer1Progress(Sender: TObject;
  const deltaTime, newTime: Double);
begin
  GLNGDManager1.Step(deltaTime);
  GLResolutionIndependantHUDText1.Text := 'Bodycount:=' + inttostr
    (GLNGDManager1.NewtonBodyCount);
end;

end.
