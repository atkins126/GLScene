//
//
// The graphics engine GLXEngine. The unit of GXScene for Delphi
//
//

unit GXS.FileMD2;

(* Quake2 MD2 vector file format implementation *)

interface

{$I Stage.Defines.inc}

uses
  System.Classes,
  System.SysUtils,
  GXS.VectorFileObjects,
  GXS.ApplicationFileIO,

  Formatx.FileMD2;

type
  (* The MD2 vector file (Quake2 actor file).
    Stores a set of "frames" describing the different postures of the actor,
    it may be animated by TgxActor. The "Skin" must be loaded indepentendly
    (the whole mesh uses a single texture bitmap).
    Based on code by Roger Cao. *)
  TgxMD2VectorFile = class(TgxVectorFile)
  public
    class function Capabilities: TDataFileCapabilities; override;
    procedure LoadFromStream(aStream: TStream); override;
  end;

//===================================================================
implementation
//===================================================================

// ------------------
// ------------------ TgxMD2VectorFile ------------------
// ------------------

class function TgxMD2VectorFile.Capabilities: TDataFileCapabilities;
begin
  Result := [dfcRead];
end;

procedure TgxMD2VectorFile.LoadFromStream(aStream: TStream);
var
  i, j: Integer;
  MD2File: TFileMD2;
  mesh: TgxMorphableMeshObject;
  faceGroup: TgxFGIndexTexCoordList;
  morphTarget: TgxMeshMorphTarget;
begin
  MD2File := TFileMD2.Create;
  MD2File.LoadFromStream(aStream);
  try
    // retrieve mesh data
    mesh := TgxMorphableMeshObject.CreateOwned(Owner.MeshObjects);
    with mesh, MD2File do
    begin
      Mode := momFaceGroups;
      faceGroup := TgxFGIndexTexCoordList.CreateOwned(FaceGroups);
      with faceGroup do
      begin
        MaterialName := '';
        VertexIndices.Capacity := iTriangles * 3;
        TexCoords.Capacity := iTriangles * 3;
        // copy the face list
        for i := 0 to iTriangles - 1 do
          with IndexList[i] do
          begin
            Add(a, a_s, -a_t);
            Add(b, b_s, -b_t);
            Add(c, c_s, -c_t);
          end;
      end;
      // retrieve frames data (morph targets)
      for i := 0 to iFrames - 1 do
      begin
        morphTarget := TgxMeshMorphTarget.CreateOwned(MorphTargets);
        with morphTarget do
        begin
          Name := 'Frame' + IntToStr(i);
          Vertices.Capacity := iVertices;
          for j := 0 to iVertices - 1 do
            Vertices.Add(VertexList[i][j]);
          BuildNormals(faceGroup.VertexIndices, momTriangles);
        end;
      end;
    end;
    if GetOwner is TgxActor then
      with TgxActor(GetOwner).Animations do
      begin
        Clear;
        with MD2File do
          for i := 0 to frameNames.Count - 1 do
            with Add do
            begin
              Name := frameNames[i];
              Reference := aarMorph;
              StartFrame := Integer(frameNames.Objects[i]);
              if i < frameNames.Count - 1 then
                EndFrame := Integer(frameNames.Objects[i + 1]) - 1
              else
                EndFrame := iFrames - 1;
            end;
      end;
    if mesh.MorphTargets.Count > 0 then
      mesh.MorphTo(0);
  finally
    MD2File.Free;
  end;
end;

// ------------------------------------------------------------------
initialization
// ------------------------------------------------------------------

RegisterVectorFileFormat('md2', 'Quake II model files', TgxMD2VectorFile);

end.
