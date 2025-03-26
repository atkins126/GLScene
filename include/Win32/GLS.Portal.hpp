﻿// CodeGear C++Builder
// Copyright (c) 1995, 2025 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'GLS.Portal.pas' rev: 36.00 (Windows)

#ifndef GLS_PortalHPP
#define GLS_PortalHPP

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
#include <GLS.PersistentClasses.hpp>
#include <Stage.VectorTypes.hpp>
#include <GLS.VectorFileObjects.hpp>
#include <GLS.Scene.hpp>
#include <GLS.Material.hpp>
#include <Stage.VectorGeometry.hpp>
#include <GLS.RenderContextInfo.hpp>

//-- user supplied -----------------------------------------------------------

namespace Gls
{
namespace Portal
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TGLPortalMeshObjectList;
class DELPHICLASS TGLSectorMeshObject;
class DELPHICLASS TFGPolygon;
class DELPHICLASS TFGPortalPolygon;
class DELPHICLASS TGLPortal;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TGLPortalMeshObjectList : public Gls::Vectorfileobjects::TGLMeshObjectList
{
	typedef Gls::Vectorfileobjects::TGLMeshObjectList inherited;
	
public:
	__fastcall TGLPortalMeshObjectList(Gls::Vectorfileobjects::TGLBaseMesh* AOwner);
	__fastcall virtual ~TGLPortalMeshObjectList();
	virtual void __fastcall BuildList(Gls::Rendercontextinfo::TGLRenderContextInfo &mrci);
public:
	/* TGLPersistentObjectList.Create */ inline __fastcall virtual TGLPortalMeshObjectList() : Gls::Vectorfileobjects::TGLMeshObjectList() { }
	
public:
	/* TGLPersistentObject.CreateFromFiler */ inline __fastcall TGLPortalMeshObjectList(Gls::Persistentclasses::TGLVirtualReader* reader) : Gls::Vectorfileobjects::TGLMeshObjectList(reader) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TGLSectorMeshObject : public Gls::Vectorfileobjects::TGLMorphableMeshObject
{
	typedef Gls::Vectorfileobjects::TGLMorphableMeshObject inherited;
	
private:
	bool FRenderDone;
	
public:
	__fastcall TGLSectorMeshObject(Gls::Vectorfileobjects::TGLMeshObjectList* AOwner);
	__fastcall virtual ~TGLSectorMeshObject();
	virtual void __fastcall BuildList(Gls::Rendercontextinfo::TGLRenderContextInfo &mrci);
	virtual void __fastcall Prepare();
	__property bool RenderDone = {read=FRenderDone, write=FRenderDone, nodefault};
public:
	/* TGLMorphableMeshObject.Create */ inline __fastcall virtual TGLSectorMeshObject() : Gls::Vectorfileobjects::TGLMorphableMeshObject() { }
	
public:
	/* TGLPersistentObject.CreateFromFiler */ inline __fastcall TGLSectorMeshObject(Gls::Persistentclasses::TGLVirtualReader* reader) : Gls::Vectorfileobjects::TGLMorphableMeshObject(reader) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TFGPolygon : public Gls::Vectorfileobjects::TFGVertexNormalTexIndexList
{
	typedef Gls::Vectorfileobjects::TFGVertexNormalTexIndexList inherited;
	
public:
	__fastcall virtual TFGPolygon(Gls::Vectorfileobjects::TGLFaceGroups* AOwner);
	__fastcall virtual ~TFGPolygon();
	virtual void __fastcall Prepare();
public:
	/* TFGVertexNormalTexIndexList.Create */ inline __fastcall virtual TFGPolygon() : Gls::Vectorfileobjects::TFGVertexNormalTexIndexList() { }
	
public:
	/* TGLPersistentObject.CreateFromFiler */ inline __fastcall TFGPolygon(Gls::Persistentclasses::TGLVirtualReader* reader) : Gls::Vectorfileobjects::TFGVertexNormalTexIndexList(reader) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TFGPortalPolygon : public TFGPolygon
{
	typedef TFGPolygon inherited;
	
private:
	int FDestinationSectorIndex;
	Stage::Vectorgeometry::TAffineVector FCenter;
	Stage::Vectorgeometry::TAffineVector FNormal;
	float FRadius;
	
public:
	__fastcall virtual TFGPortalPolygon(Gls::Vectorfileobjects::TGLFaceGroups* AOwner);
	__fastcall virtual ~TFGPortalPolygon();
	virtual void __fastcall BuildList(Gls::Rendercontextinfo::TGLRenderContextInfo &mrci);
	virtual void __fastcall Prepare();
	__property int DestinationSectorIndex = {read=FDestinationSectorIndex, write=FDestinationSectorIndex, nodefault};
public:
	/* TFGVertexNormalTexIndexList.Create */ inline __fastcall virtual TFGPortalPolygon() : TFGPolygon() { }
	
public:
	/* TGLPersistentObject.CreateFromFiler */ inline __fastcall TFGPortalPolygon(Gls::Persistentclasses::TGLVirtualReader* reader) : TFGPolygon(reader) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TGLPortal : public Gls::Vectorfileobjects::TGLBaseMesh
{
	typedef Gls::Vectorfileobjects::TGLBaseMesh inherited;
	
public:
	__fastcall virtual TGLPortal(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TGLPortal();
	
__published:
	__property MaterialLibrary;
public:
	/* TGLBaseSceneObject.CreateAsChild */ inline __fastcall TGLPortal(Gls::Scene::TGLBaseSceneObject* aParentOwner) : Gls::Vectorfileobjects::TGLBaseMesh(aParentOwner) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Portal */
}	/* namespace Gls */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GLS_PORTAL)
using namespace Gls::Portal;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GLS)
using namespace Gls;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GLS_PortalHPP
