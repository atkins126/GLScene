﻿// CodeGear C++Builder
// Copyright (c) 1995, 2024 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Formatx.Q3BSP.pas' rev: 36.00 (Windows)

#ifndef Formatx_Q3BSPHPP
#define Formatx_Q3BSPHPP

#pragma delphiheader begin
#pragma option push
#if defined(__BORLANDC__) && !defined(__clang__)
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#endif
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Stage.VectorTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Formatx
{
namespace Q3bsp
{
//-- forward type declarations -----------------------------------------------
struct TBSPHeader;
struct TBSPLump;
struct TBSPNode;
struct TBSPLeaf;
struct TBSPModel;
struct TBSPVertex;
struct TBSPFace;
struct TBSPTexture;
struct TBSPLightmap;
struct TBSPVisData;
class DELPHICLASS TQ3BSP;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TBSPHeader
{
public:
	System::StaticArray<char, 4> StrID;
	int Version;
};


struct DECLSPEC_DRECORD TBSPLump
{
public:
	int Offset;
	int Length;
};


typedef System::StaticArray<int, 6> TBSPBBox;

struct DECLSPEC_DRECORD TBSPNode
{
public:
	int Plane;
	System::StaticArray<int, 2> Children;
	TBSPBBox BBox;
};


struct DECLSPEC_DRECORD TBSPLeaf
{
public:
	int Cluster;
	int Area;
	TBSPBBox BBox;
	int FirstFace;
	int NumFaces;
	int FirstBrush;
	int NumBrushes;
};


struct DECLSPEC_DRECORD TBSPModel
{
public:
	TBSPBBox BBox;
	int FirstFace;
	int NumFaces;
	int FirstBrush;
	int NumBrushes;
};


struct DECLSPEC_DRECORD TBSPVertex
{
public:
	Stage::Vectortypes::TVector3f Position;
	Stage::Vectortypes::TVector2f TextureCoord;
	Stage::Vectortypes::TVector2f LightmapCoord;
	Stage::Vectortypes::TVector3f Normal;
	System::StaticArray<System::Byte, 4> Color;
};


typedef TBSPVertex *PBSPVertex;

struct DECLSPEC_DRECORD TBSPFace
{
public:
	int textureID;
	int effect;
	int FaceType;
	int startVertIndex;
	int numOfVerts;
	int meshVertIndex;
	int numMeshVerts;
	int lightmapID;
	System::StaticArray<int, 2> lMapCorner;
	System::StaticArray<int, 2> lMapSize;
	Stage::Vectortypes::TVector3f lMapPos;
	System::StaticArray<Stage::Vectortypes::TVector3f, 2> lMapVecs;
	Stage::Vectortypes::TVector3f vNormal;
	System::StaticArray<int, 2> Size;
};


typedef TBSPFace *PBSPFace;

struct DECLSPEC_DRECORD TBSPTexture
{
public:
	System::StaticArray<System::WideChar, 64> TextureName;
	int flags;
	int contents;
};


typedef TBSPTexture *PBSPTexture;

struct DECLSPEC_DRECORD TBSPLightmap
{
public:
	System::StaticArray<System::Byte, 49152> imageBits;
};


typedef TBSPLightmap *PBSPLightmap;

struct DECLSPEC_DRECORD TBSPVisData
{
	
private:
	typedef System::DynamicArray<System::Byte> _TBSPVisData__1;
	
	
public:
	int numOfClusters;
	int bytesPerCluster;
	_TBSPVisData__1 bitSets;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TQ3BSP : public System::TObject
{
	typedef System::TObject inherited;
	
	
private:
	typedef System::DynamicArray<TBSPLump> _TQ3BSP__1;
	
	typedef System::DynamicArray<TBSPVertex> _TQ3BSP__2;
	
	typedef System::DynamicArray<TBSPNode> _TQ3BSP__3;
	
	typedef System::DynamicArray<Stage::Vectortypes::TVector4f> _TQ3BSP__4;
	
	typedef System::DynamicArray<TBSPLeaf> _TQ3BSP__5;
	
	typedef System::DynamicArray<TBSPFace> _TQ3BSP__6;
	
	typedef System::DynamicArray<TBSPTexture> _TQ3BSP__7;
	
	typedef System::DynamicArray<TBSPLightmap> _TQ3BSP__8;
	
	
public:
	TBSPHeader Header;
	_TQ3BSP__1 Lumps;
	int numOfVerts;
	int NumOfNodes;
	int NumOfPlanes;
	int NumOfLeaves;
	int NumOfFaces;
	int NumOfTextures;
	int NumOfLightmaps;
	_TQ3BSP__2 Vertices;
	_TQ3BSP__3 Nodes;
	_TQ3BSP__4 Planes;
	_TQ3BSP__5 Leaves;
	_TQ3BSP__6 Faces;
	_TQ3BSP__7 Textures;
	_TQ3BSP__8 Lightmaps;
	TBSPVisData VisData;
	__fastcall TQ3BSP(System::Classes::TStream* bspStream);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TQ3BSP() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static _DELPHI_CONST System::Int8 FACE_POLYGON = System::Int8(0x1);
static _DELPHI_CONST System::Word MAX_TEXTURES = System::Word(0x3e8);
static _DELPHI_CONST System::Int8 kEntities = System::Int8(0x0);
static _DELPHI_CONST System::Int8 kTextures = System::Int8(0x1);
static _DELPHI_CONST System::Int8 kPlanes = System::Int8(0x2);
static _DELPHI_CONST System::Int8 kNodes = System::Int8(0x3);
static _DELPHI_CONST System::Int8 kLeafs = System::Int8(0x4);
static _DELPHI_CONST System::Int8 kLeafFaces = System::Int8(0x5);
static _DELPHI_CONST System::Int8 kLeafBrushes = System::Int8(0x6);
static _DELPHI_CONST System::Int8 kModels = System::Int8(0x7);
static _DELPHI_CONST System::Int8 kBrushes = System::Int8(0x8);
static _DELPHI_CONST System::Int8 kBrushSides = System::Int8(0x9);
static _DELPHI_CONST System::Int8 kVertices = System::Int8(0xa);
static _DELPHI_CONST System::Int8 kMeshVerts = System::Int8(0xb);
static _DELPHI_CONST System::Int8 kShaders = System::Int8(0xc);
static _DELPHI_CONST System::Int8 kFaces = System::Int8(0xd);
static _DELPHI_CONST System::Int8 kLightmaps = System::Int8(0xe);
static _DELPHI_CONST System::Int8 kLightVolumes = System::Int8(0xf);
static _DELPHI_CONST System::Int8 kVisData = System::Int8(0x10);
static _DELPHI_CONST System::Int8 kMaxLumps = System::Int8(0x11);
}	/* namespace Q3bsp */
}	/* namespace Formatx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FORMATX_Q3BSP)
using namespace Formatx::Q3bsp;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FORMATX)
using namespace Formatx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Formatx_Q3BSPHPP
