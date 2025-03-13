﻿// CodeGear C++Builder
// Copyright (c) 1995, 2024 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'GLS.MeshBuilder.pas' rev: 36.00 (Windows)

#ifndef GLS_MeshBuilderHPP
#define GLS_MeshBuilderHPP

#pragma delphiheader begin
#pragma option push
#if defined(__BORLANDC__) && !defined(__clang__)
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#endif
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Stage.VectorTypes.hpp>
#include <Stage.VectorGeometry.hpp>
#include <GLS.VectorLists.hpp>
#include <GLS.PersistentClasses.hpp>
#include <GLS.Scene.hpp>
#include <GLS.VectorFileObjects.hpp>
#include <GLS.MeshUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Gls
{
namespace Meshbuilder
{
//-- forward type declarations -----------------------------------------------
struct TGLHexahedronProperties;
struct TGLSphereProperties;
struct TGLCylinderProperties;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TGLHexahedronProperties
{
public:
	Stage::Vectortypes::TVector3f Normal3f;
	System::StaticArray<Stage::Vectortypes::TVector3f, 4> VertexCoords;
	System::StaticArray<Stage::Vectortypes::TVector2f, 4> TextureCoords;
	System::StaticArray<int, 6> PartIndices;
	System::UnicodeString Material;
};


struct DECLSPEC_DRECORD TGLSphereProperties
{
public:
	Stage::Vectortypes::TVector3f Normal3f;
	System::StaticArray<Stage::Vectortypes::TVector3f, 5> VertexCoords;
	System::StaticArray<Stage::Vectortypes::TVector2f, 5> TextureCoords;
	System::StaticArray<int, 2> PartIndices;
	System::UnicodeString Material;
};


struct DECLSPEC_DRECORD TGLCylinderProperties
{
public:
	Stage::Vectortypes::TVector3f Normal3f;
	System::StaticArray<Stage::Vectortypes::TVector3f, 6> VertexCoords;
	System::StaticArray<Stage::Vectortypes::TVector2f, 6> TextureCoords;
	System::StaticArray<int, 8> PartIndices;
	System::UnicodeString Material;
};


enum DECLSPEC_DENUM TGLMeshOptimizerOption : unsigned char { mooStandardize, mooVertexCache, mooSortByMaterials, mooMergeObjects };

typedef System::Set<TGLMeshOptimizerOption, TGLMeshOptimizerOption::mooStandardize, TGLMeshOptimizerOption::mooMergeObjects> TGLMeshOptimizerOptions;

typedef System::StaticArray<TGLHexahedronProperties, 6> Gls_Meshbuilder__1;

typedef System::StaticArray<TGLSphereProperties, 2> Gls_Meshbuilder__2;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Gls_Meshbuilder__1 cMeshHexahedron;
extern DELPHI_PACKAGE Gls_Meshbuilder__2 cMeshSphere;
extern DELPHI_PACKAGE TGLMeshOptimizerOptions vDefaultMeshOptimizerOptions;
extern DELPHI_PACKAGE void __fastcall BuildMeshCube(Gls::Vectorfileobjects::TGLMeshObject* Mesh, const Stage::Vectorgeometry::TAffineVector &Position, const Stage::Vectorgeometry::TAffineVector &Scale);
extern DELPHI_PACKAGE void __fastcall BuildMeshCylinder(Gls::Vectorfileobjects::TGLMeshObject* Mesh, const Stage::Vectorgeometry::TAffineVector &Position, const Stage::Vectorgeometry::TAffineVector &Scale, int Slices);
extern DELPHI_PACKAGE void __fastcall BuildMeshCylinderAdv(Gls::Vectorfileobjects::TGLMeshObject* Mesh, const Stage::Vectorgeometry::TAffineVector &Position, const Stage::Vectorgeometry::TAffineVector &Scale, float TopRadius, float BottomRadius, float Height, int Slices);
extern DELPHI_PACKAGE void __fastcall MakeMeshHexahedron(Gls::Vectorfileobjects::TGLMeshObject* MeshObject);
extern DELPHI_PACKAGE void __fastcall BuildMeshHemiSphere(Gls::Vectorfileobjects::TGLMeshObject* Mesh, const Stage::Vectorgeometry::TAffineVector &Position, const Stage::Vectorgeometry::TAffineVector &Scale);
extern DELPHI_PACKAGE void __fastcall BuildMeshHemiCylinder(Gls::Vectorfileobjects::TGLMeshObject* Mesh, const Stage::Vectorgeometry::TAffineVector &Position, const Stage::Vectorgeometry::TAffineVector &Scale, int Slices);
extern DELPHI_PACKAGE void __fastcall MakeMeshSphere(Gls::Vectorfileobjects::TGLMeshObject* MeshObject);
extern DELPHI_PACKAGE void __fastcall MakeMeshTetrahedron(Gls::Vectorfileobjects::TGLMeshObject* MeshObject);
extern DELPHI_PACKAGE void __fastcall OptimizeMesh(Gls::Vectorfileobjects::TGLMeshObjectList* aList)/* overload */;
extern DELPHI_PACKAGE void __fastcall OptimizeMesh(Gls::Vectorfileobjects::TGLMeshObjectList* aList, TGLMeshOptimizerOptions options)/* overload */;
extern DELPHI_PACKAGE void __fastcall OptimizeMesh(Gls::Vectorfileobjects::TGLMeshObject* aMeshObject)/* overload */;
extern DELPHI_PACKAGE void __fastcall OptimizeMesh(Gls::Vectorfileobjects::TGLMeshObject* aMeshObject, TGLMeshOptimizerOptions options)/* overload */;
extern DELPHI_PACKAGE void __fastcall FacesSmooth(Gls::Vectorfileobjects::TGLMeshObject* aMeshObj, float aWeldDistance = 1.000000E-07f, float aThreshold = 3.500000E+01f, bool InvertNormals = false);
}	/* namespace Meshbuilder */
}	/* namespace Gls */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GLS_MESHBUILDER)
using namespace Gls::Meshbuilder;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GLS)
using namespace Gls;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GLS_MeshBuilderHPP
