﻿// CodeGear C++Builder
// Copyright (c) 1995, 2024 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'GLS.MeshBSP.pas' rev: 36.00 (Windows)

#ifndef GLS_MeshBSPHPP
#define GLS_MeshBSPHPP

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
#include <System.Math.hpp>
#include <GLS.VectorFileObjects.hpp>
#include <GLS.Material.hpp>
#include <Stage.VectorGeometry.hpp>
#include <GLS.VectorLists.hpp>
#include <GLS.Color.hpp>
#include <GLS.RenderContextInfo.hpp>
#include <Stage.VectorTypes.hpp>
#include <GLS.PersistentClasses.hpp>

//-- user supplied -----------------------------------------------------------

namespace Gls
{
namespace Meshbsp
{
//-- forward type declarations -----------------------------------------------
struct TBSPCullingSphere;
struct TBSPRenderContextInfo;
class DELPHICLASS TBSPClusterVisibility;
class DELPHICLASS TBSPMeshObject;
class DELPHICLASS TFGBSPNode;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TBSPCullingSphere
{
public:
	Stage::Vectortypes::TGLVector position;
	float radius;
};


struct DECLSPEC_DRECORD TBSPRenderContextInfo
{
	
private:
	typedef System::DynamicArray<TBSPCullingSphere> _TBSPRenderContextInfo__1;
	
	
public:
	Stage::Vectortypes::TGLVector cameraLocal;
	Gls::Rendercontextinfo::PGLRenderContextInfo rci;
	System::Classes::TList* faceGroups;
	_TBSPRenderContextInfo__1 cullingSpheres;
};


enum DECLSPEC_DENUM TBSPRenderSort : unsigned char { rsNone, rsBackToFront, rsFrontToBack };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TBSPClusterVisibility : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Stage::Vectorgeometry::PByteArray FData;
	int FSize;
	int FBytesPerCluster;
	int FCount;
	
protected:
	void __fastcall SetCount(int NumClusters);
	bool __fastcall GetVisibility(int Source, int Destination);
	void __fastcall SetVisibility(int Source, int Destination, const bool Value);
	
public:
	__fastcall TBSPClusterVisibility();
	__fastcall virtual ~TBSPClusterVisibility();
	void __fastcall SetData(System::PByte Source, int NumClusters);
	__property int Count = {read=FCount, write=SetCount, nodefault};
	__property bool Visibility[int src][int dst] = {read=GetVisibility, write=SetVisibility};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TBSPMeshObject : public Gls::Vectorfileobjects::TGLMeshObject
{
	typedef Gls::Vectorfileobjects::TGLMeshObject inherited;
	
private:
	TBSPRenderSort FRenderSort;
	TBSPClusterVisibility* FClusterVisibility;
	bool FUseClusterVisibility;
	
public:
	__fastcall TBSPMeshObject(Gls::Vectorfileobjects::TGLMeshObjectList* AOwner);
	__fastcall virtual ~TBSPMeshObject();
	virtual void __fastcall BuildList(Gls::Rendercontextinfo::TGLRenderContextInfo &mrci);
	void __fastcall CleanupUnusedNodes();
	float __fastcall AverageDepth();
	TFGBSPNode* __fastcall FindNodeByPoint(const Stage::Vectortypes::TGLVector &aPoint);
	__property TBSPRenderSort RenderSort = {read=FRenderSort, write=FRenderSort, nodefault};
	__property TBSPClusterVisibility* ClusterVisibility = {read=FClusterVisibility};
	__property bool UseClusterVisibility = {read=FUseClusterVisibility, write=FUseClusterVisibility, nodefault};
public:
	/* TGLMeshObject.Create */ inline __fastcall virtual TBSPMeshObject() : Gls::Vectorfileobjects::TGLMeshObject() { }
	
public:
	/* TGLPersistentObject.CreateFromFiler */ inline __fastcall TBSPMeshObject(Gls::Persistentclasses::TGLVirtualReader* reader) : Gls::Vectorfileobjects::TGLMeshObject(reader) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TFGBSPNode : public Gls::Vectorfileobjects::TFGVertexIndexList
{
	typedef Gls::Vectorfileobjects::TFGVertexIndexList inherited;
	
private:
	Stage::Vectorgeometry::THmgPlane FSplitPlane;
	int FPositiveSubNodeIndex;
	int FNegativeSubNodeIndex;
	int FCluster;
	
protected:
	int __fastcall AddLerp(int iA, int iB, float fB, float fA);
	int __fastcall AddLerpIfDistinct(int iA, int iB, int iMid);
	
public:
	__fastcall virtual TFGBSPNode(Gls::Vectorfileobjects::TGLFaceGroups* AOwner);
	__fastcall virtual ~TFGBSPNode();
	void __fastcall IsCulled(const TBSPRenderContextInfo &bsprci, bool &positive, bool &negative);
	void __fastcall CollectNoSort(TBSPRenderContextInfo &bsprci);
	void __fastcall CollectFrontToBack(TBSPRenderContextInfo &bsprci);
	void __fastcall CollectBackToFront(TBSPRenderContextInfo &bsprci);
	Stage::Vectorgeometry::THmgPlane __fastcall FindSplitPlane(float triangleSplitCost = 1.000000E+00f, float triangleImbalanceCost = 5.000000E-01f);
	void __fastcall EvaluateSplitPlane(const Stage::Vectorgeometry::THmgPlane &splitPlane, int &nbTriangleSplit, int &nbPositiveTriangles, int &nbNegativeTriangles);
	void __fastcall PerformSplit(const Stage::Vectorgeometry::THmgPlane &splitPlane, const int maxTrianglesPerLeaf = 0x7fffffff);
	void __fastcall FixTJunctions(Gls::Vectorlists::TGLIntegerList* const tJunctionsCandidates);
	__property Stage::Vectorgeometry::THmgPlane splitPlane = {read=FSplitPlane, write=FSplitPlane};
	__property int PositiveSubNodeIndex = {read=FPositiveSubNodeIndex, write=FPositiveSubNodeIndex, nodefault};
	__property int NegativeSubNodeIndex = {read=FNegativeSubNodeIndex, write=FNegativeSubNodeIndex, nodefault};
	__property int Cluster = {read=FCluster, write=FCluster, nodefault};
public:
	/* TFGVertexIndexList.Create */ inline __fastcall virtual TFGBSPNode() : Gls::Vectorfileobjects::TFGVertexIndexList() { }
	
public:
	/* TGLPersistentObject.CreateFromFiler */ inline __fastcall TFGBSPNode(Gls::Persistentclasses::TGLVirtualReader* reader) : Gls::Vectorfileobjects::TFGVertexIndexList(reader) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Meshbsp */
}	/* namespace Gls */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GLS_MESHBSP)
using namespace Gls::Meshbsp;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GLS)
using namespace Gls;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GLS_MeshBSPHPP
