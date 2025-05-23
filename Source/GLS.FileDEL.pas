//
// The graphics engine GLXEngine. The unit of GLScene for Delphi
//
unit GLS.FileDEL;
(*
  Supports to import TetGen files from http://wias-berlin.de/software/tetgen/fformats.html 
  combined in a DEL ASCII file for Delaunay tetrahedralization.
*)
interface

{$I Stage.Defines.inc}

uses
  System.Classes,
  System.SysUtils,

  Stage.VectorTypes,
  Stage.VectorTypesExt,
  Stage.VectorGeometry,

  GLS.VectorFileObjects,
  GLS.ApplicationFileIO,
  Stage.Utils;


type
   (* The DEL vector file (tetrahedra irregular network)*)
   TGLDELVectorFile = class(TGLVectorFile)
      public
        class function Capabilities: TGLDataFileCapabilities; override;
        procedure LoadFromStream(aStream : TStream); override;
   end;

// ------------------------------------------------------------------
implementation
// ------------------------------------------------------------------

const
  cNODE_LABEL = 'node';
  cEDGE_LABEL = 'edge';
  cFACE_LABEL = 'face';
  cCELL_LABEL = 'ele';
  cNEIGH_LABEL = 'neigh';
// ------------------
// ------------------ TGLDELVectorFile ------------------
// ------------------

class function TGLDELVectorFile.Capabilities: TGLDataFileCapabilities;
begin
   Result := [dfcRead];
end;

procedure TGLDELVectorFile.LoadFromStream(aStream : TStream);
var
   i, j : Integer;
   sl, tl : TStringList;
   mesh : TGLMeshObject;
   v1, v2, v3, n : TAffineVector;
   ActiveTin : Boolean;
   Id_Tin : Integer;
   Tnam: string;
   Id_Mat, NVert, NTri : Integer;

   VertArr :  TPoint3DArray;
   n1, n2, n3 : Integer;


begin
  sl := TStringList.Create;
  tl := TStringList.Create;
  i := 0;
  try
    sl.LoadFromStream(aStream);
    mesh      := TGLMeshObject.CreateOwned(Owner.MeshObjects);
    mesh.Mode := momTriangles;
    // the file with nodes, edges, faces and eles described by triangles and materials
    while i < sl.Count - 1  do
    begin
      Inc(i);
      tl.DelimitedText := sl[i];
      if (tl.CommaText = 'BEGT') then // the beginning of new tin
      begin
        repeat
          Inc(i); tl.DelimitedText := sl[i];
          if (tl[0] = 'ACTIVETIN') then
            ActiveTin := True;
          if (tl[0] = 'ID') then
            Id_Tin := StrToInt(tl[1]);
          if (tl[0] = 'TNAM') then
            Tnam := tl[1];
          if (tl[0] = 'MAT') then
            Id_Mat := StrToInt(tl[1]);
          if (tl[0] = 'VERT') then
            NVert := StrToInt(tl[1]);
        until tl[0]='VERT';
        SetLength(VertArr, NVert);
        j := 0;
        repeat
          Inc(i);
          tl.DelimitedText := sl[i];
          VertArr[j].X := GLStrToFloatDef(tl[0]);
          VertArr[j].Y := GLStrToFloatDef(tl[1]);
          VertArr[j].Z := GLStrToFloatDef(tl[2]);
          Inc(j);
        until (j = NVert);
        Inc(i);  
		tl.DelimitedText := sl[i];
        NTri := StrToInt(tl[1]);
        j := 0;
        repeat
          Inc(i); Inc(j);
          tl.DelimitedText := sl[i];
          n1 := StrToInt(tl[0]); n2 := StrToInt(tl[1]); n3 := StrToInt(tl[2]);
          SetVector(v1, VertArr[n1-1].X, VertArr[n1-1].Y, VertArr[n1-1].Z);
          SetVector(v2, VertArr[n2-1].X, VertArr[n2-1].Y, VertArr[n2-1].Z);
          SetVector(v3, VertArr[n3-1].X, VertArr[n3-1].Y, VertArr[n3-1].Z);
          mesh.Vertices.Add(v1, v2, v3);
          n := CalcPlaneNormal(v1, v2, v3);
          mesh.Normals.Add(n, n, n);
        until (j = NTri);
        Inc(i); tl.DelimitedText := sl[i]; //tl.DelimitedText = 'ENDT';
      end;
    end;
  finally
    tl.Free;
    sl.Free;
  end;
end;

// ------------------------------------------------------------------
initialization
// ------------------------------------------------------------------

   RegisterVectorFileFormat('delaunay', 'Triangular Irregular Network', TGLDELVectorFile);

end.
