//
// The graphics engine GLXEngine. The unit of GXScene for Delphi
//
unit GXS.ODESkeletonColliders;

(* Skeleton colliders for defining and controlling ODE geoms *)

interface

uses
  System.Classes,

  ODE.Import,

  Stage.VectorTypes,
  GXS.PersistentClasses,
  Stage.VectorGeometry,
  GXS.VectorFileObjects;

type

  // Base ODE skeleton collider class.
  TSCODEBase = class(TgxSkeletonCollider)
  private
    FGeom: PdxGeom;
  public
    procedure WriteToFiler(writer: TgxVirtualWriter); override;
    procedure ReadFromFiler(reader: TgxVirtualReader); override;
    procedure AddToSpace(Space: PdxSpace); virtual;
    procedure AlignCollider; override;
    // The geoms are created through the AddToSpace procedure
    property Geom: PdxGeom read FGeom;
  end;

  // Sphere shaped ODE geom in a skeleton collider.
  TSCODESphere = class(TSCODEBase)
  private
    FRadius: TdReal;
  protected
    procedure SetRadius(const val: TdReal);
  public
    constructor Create; override;
    procedure WriteToFiler(writer: TgxVirtualWriter); override;
    procedure ReadFromFiler(reader: TgxVirtualReader); override;
    procedure AddToSpace(Space: PdxSpace); override;
    property Radius: TdReal read FRadius write SetRadius;
  end;

  // Capsule (sphere capped cylinder) shaped ODE geom in a skeleton collider.
  TSCODECCylinder = class(TSCODEBase)
  private
    FRadius, FLength: Single;
  protected
    procedure SetRadius(const val: Single);
    procedure SetLength(const val: Single);
  public
    constructor Create; override;
    procedure WriteToFiler(writer: TgxVirtualWriter); override;
    procedure ReadFromFiler(reader: TgxVirtualReader); override;
    procedure AddToSpace(Space: PdxSpace); override;
    property Radius: Single read FRadius write SetRadius;
    property Length: Single read FLength write SetLength;
  end;

  // Box shaped ODE geom in a skeleton collider.
  TSCODEBox = class(TSCODEBase)
  private
    FBoxWidth, FBoxHeight, FBoxDepth: TdReal;
  protected
    procedure SetBoxWidth(const val: TdReal);
    procedure SetBoxHeight(const val: TdReal);
    procedure SetBoxDepth(const val: TdReal);
  public
    constructor Create; override;
    procedure WriteToFiler(writer: TgxVirtualWriter); override;
    procedure ReadFromFiler(reader: TgxVirtualReader); override;
    procedure AddToSpace(Space: PdxSpace); override;
    property BoxWidth: TdReal read FBoxWidth write SetBoxWidth;
    property BoxHeight: TdReal read FBoxHeight write SetBoxHeight;
    property BoxDepth: TdReal read FBoxDepth write SetBoxDepth;
  end;

(* After loading call this function to add all the geoms in a
   skeleton collider list to a given ODE space. *)
procedure AddSCODEGeomsToODESpace(colliders: TgxSkeletonColliderList;
  Space: PdxSpace);

// ------------------------------------------------------------------
implementation
// ------------------------------------------------------------------


// ------------------
// ------------------ Global methods ------------------
// ------------------

procedure AddSCODEGeomsToODESpace(colliders: TgxSkeletonColliderList;
  Space: PdxSpace);
var
  i: Integer;
begin
  for i := 0 to colliders.Count - 1 do
    if colliders[i] is TSCODEBase then
      TSCODEBase(colliders[i]).AddToSpace(Space);
end;

// ------------------
// ------------------ TSCODEBase ------------------
// ------------------

procedure TSCODEBase.WriteToFiler(writer: TgxVirtualWriter);
begin
  inherited WriteToFiler(writer);
  with writer do
  begin
    WriteInteger(0); // Archive Version 0
  end;
end;

procedure TSCODEBase.ReadFromFiler(reader: TgxVirtualReader);
var
  archiveVersion: Integer;
begin
  inherited ReadFromFiler(reader);
  archiveVersion := reader.ReadInteger;
  if archiveVersion = 0 then
    with reader do
      // Nothing yet
    else
      RaiseFilerException(archiveVersion);
end;

procedure TSCODEBase.AddToSpace(Space: PdxSpace);
begin
  AlignCollider;
end;

procedure TSCODEBase.AlignCollider;
var
  R: TdMatrix3;
  Mat: TMatrix4f;
begin
  inherited;
  if Assigned(FGeom) then
  begin
    Mat := GlobalMatrix;
    dGeomSetPosition(FGeom, Mat.W.X, Mat.W.Y, Mat.W.Z);
    R[0] := Mat.X.X;
    R[1] := Mat.Y.X;
    R[2] := Mat.Z.X;
    R[3] := 0;
    R[4] := Mat.X.Y;
    R[5] := Mat.Y.Y;
    R[6] := Mat.Z.Y;
    R[7] := 0;
    R[8] := Mat.X.Z;
    R[9] := Mat.Y.Z;
    R[10] := Mat.Z.Z;
    R[11] := 0;
    dGeomSetRotation(FGeom, R);
  end;
end;


// ------------------
// ------------------ TSCODESphere ------------------
// ------------------

constructor TSCODESphere.Create;
begin
  inherited;
  FRadius := 0.5;
  AlignCollider;
end;

procedure TSCODESphere.WriteToFiler(writer: TgxVirtualWriter);
begin
  inherited WriteToFiler(writer);
  with writer do
  begin
    WriteInteger(0); // Archive Version 0
    WriteFloat(FRadius);
  end;
end;

procedure TSCODESphere.ReadFromFiler(reader: TgxVirtualReader);
var
  archiveVersion: Integer;
begin
  inherited ReadFromFiler(reader);
  archiveVersion := reader.ReadInteger;
  if archiveVersion = 0 then
    with reader do
      Radius := ReadFloat
  else
    RaiseFilerException(archiveVersion);
end;

procedure TSCODESphere.AddToSpace(Space: PdxSpace);
begin
  FGeom := dCreateSphere(Space, FRadius);
  inherited;
end;

procedure TSCODESphere.SetRadius(const val: TdReal);
begin
  if val <> FRadius then
  begin
    FRadius := val;
    if Assigned(FGeom) then
      dGeomSphereSetRadius(Geom, TdReal(FRadius));
  end;
end;


// ------------------
// ------------------ TSCODECCylinder ------------------
// ------------------

constructor TSCODECCylinder.Create;
begin
  inherited;
  FRadius := 0.5;
  FLength := 1;
  AlignCollider;
end;

procedure TSCODECCylinder.WriteToFiler(writer: TgxVirtualWriter);
begin
  inherited WriteToFiler(writer);
  with writer do
  begin
    WriteInteger(0); // Archive Version 0
    WriteFloat(FRadius);
    WriteFloat(FLength);
  end;
end;

procedure TSCODECCylinder.ReadFromFiler(reader: TgxVirtualReader);
var
  archiveVersion: Integer;
begin
  inherited ReadFromFiler(reader);
  archiveVersion := reader.ReadInteger;
  if archiveVersion = 0 then
    with reader do
    begin
      Radius := ReadFloat;
      Length := ReadFloat;
    end
  else
    RaiseFilerException(archiveVersion);
end;

procedure TSCODECCylinder.AddToSpace(Space: PdxSpace);
begin
  FGeom := dCreateCapsule(Space, FRadius, FLength);
  inherited;
end;

procedure TSCODECCylinder.SetRadius(const val: Single);
begin
  if val <> FRadius then
  begin
    FRadius := val;
    if Assigned(FGeom) then
      dGeomCapsuleSetParams(FGeom, FRadius, FLength);
  end;
end;

procedure TSCODECCylinder.SetLength(const val: Single);
begin
  if val <> FLength then
  begin
    FLength := val;
    if Assigned(FGeom) then
      dGeomCapsuleSetParams(FGeom, FRadius, FLength);
  end;
end;

// ------------------
// ------------------ TSCODEBox ------------------
// ------------------

constructor TSCODEBox.Create;
begin
  inherited;
  FBoxWidth := 1;
  FBoxHeight := 1;
  FBoxDepth := 1;
  AlignCollider;
end;

procedure TSCODEBox.WriteToFiler(writer: TgxVirtualWriter);
begin
  inherited WriteToFiler(writer);
  with writer do
  begin
    WriteInteger(0); // Archive Version 0
    WriteFloat(FBoxWidth);
    WriteFloat(FBoxHeight);
    WriteFloat(FBoxDepth);
  end;
end;

procedure TSCODEBox.ReadFromFiler(reader: TgxVirtualReader);
var
  archiveVersion: Integer;
begin
  inherited ReadFromFiler(reader);
  archiveVersion := reader.ReadInteger;
  if archiveVersion = 0 then
    with reader do
    begin
      BoxWidth := ReadFloat;
      BoxHeight := ReadFloat;
      BoxDepth := ReadFloat;
    end
  else
    RaiseFilerException(archiveVersion);
end;

procedure TSCODEBox.AddToSpace(Space: PdxSpace);
begin
  FGeom := dCreateBox(Space, FBoxWidth, FBoxHeight, FBoxDepth);
  inherited;
end;

procedure TSCODEBox.SetBoxWidth(const val: TdReal);
begin
  if val <> FBoxWidth then
  begin
    FBoxWidth := val;
    if Assigned(FGeom) then
      dGeomBoxSetLengths(Geom, TdReal(FBoxWidth), TdReal(FBoxHeight),
        TdReal(FBoxDepth));
  end;
end;

procedure TSCODEBox.SetBoxHeight(const val: TdReal);
begin
  if val <> FBoxHeight then
  begin
    FBoxHeight := val;
    if Assigned(FGeom) then
      dGeomBoxSetLengths(Geom, TdReal(FBoxWidth), TdReal(FBoxHeight),
        TdReal(FBoxDepth));
  end;
end;

procedure TSCODEBox.SetBoxDepth(const val: TdReal);
begin
  if val <> FBoxDepth then
  begin
    FBoxDepth := val;
    if Assigned(FGeom) then
      dGeomBoxSetLengths(Geom, TdReal(FBoxWidth), TdReal(FBoxHeight),
        TdReal(FBoxDepth));
  end;
end;

// ------------------------------------------------------------------
initialization
// ------------------------------------------------------------------

RegisterClasses([TSCODEBase, TSCODESphere, TSCODECCylinder, TSCODEBox]);

end.
