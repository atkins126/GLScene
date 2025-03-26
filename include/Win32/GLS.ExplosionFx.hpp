﻿// CodeGear C++Builder
// Copyright (c) 1995, 2025 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'GLS.ExplosionFx.pas' rev: 36.00 (Windows)

#ifndef GLS_ExplosionFxHPP
#define GLS_ExplosionFxHPP

#pragma delphiheader begin
#pragma option push
#if defined(__BORLANDC__) && !defined(__clang__)
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#endif
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.OpenGL.hpp>
#include <Stage.OpenGLTokens.hpp>
#include <Stage.VectorGeometry.hpp>
#include <Stage.VectorTypes.hpp>
#include <GLS.Scene.hpp>
#include <GLS.VectorFileObjects.hpp>
#include <GLS.VectorLists.hpp>
#include <GLS.XCollection.hpp>
#include <GLS.Coordinates.hpp>
#include <GLS.RenderContextInfo.hpp>
#include <GLS.Context.hpp>
#include <GLS.State.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Gls
{
namespace Explosionfx
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TGLBExplosionFX;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TGLBExplosionFX : public Gls::Scene::TGLObjectPreEffect
{
	typedef Gls::Scene::TGLObjectPreEffect inherited;
	
private:
	Gls::Vectorlists::TGLAffineVectorList* FTriList;
	Gls::Vectorlists::TGLAffineVectorList* FRotList;
	Gls::Vectorlists::TGLAffineVectorList* FDirList;
	Gls::Vectorlists::TGLAffineVectorList* FPosList;
	bool FEnabled;
	int FFaceCount;
	float FSpeed;
	Gls::Coordinates::TGLCoordinates* FDirection;
	int FMaxSteps;
	int FStep;
	void __fastcall SetTriList(Gls::Vectorlists::TGLAffineVectorList* Value);
	void __fastcall SetRotList(Gls::Vectorlists::TGLAffineVectorList* Value);
	void __fastcall SetDirList(Gls::Vectorlists::TGLAffineVectorList* Value);
	void __fastcall SetPosList(Gls::Vectorlists::TGLAffineVectorList* Value);
	void __fastcall SetDirection(Gls::Coordinates::TGLCoordinates* value);
	void __fastcall SetEnabled(bool value);
	
protected:
	__property Gls::Vectorlists::TGLAffineVectorList* TriList = {read=FTriList, write=SetTriList};
	__property Gls::Vectorlists::TGLAffineVectorList* RotList = {read=FRotList, write=SetRotList};
	__property Gls::Vectorlists::TGLAffineVectorList* DirList = {read=FDirList, write=SetDirList};
	__property Gls::Vectorlists::TGLAffineVectorList* PosList = {read=FPosList, write=SetPosList};
	__property int FaceCount = {read=FFaceCount, write=FFaceCount, nodefault};
	void __fastcall CacheInfo();
	
public:
	__property bool Enabled = {read=FEnabled, write=SetEnabled, nodefault};
	__property int Step = {read=FStep, nodefault};
	__fastcall virtual TGLBExplosionFX(Gls::Xcollection::TXCollection* aOwner);
	__fastcall virtual ~TGLBExplosionFX();
	virtual void __fastcall Render(Gls::Rendercontextinfo::TGLRenderContextInfo &rci);
	void __fastcall Reset();
	__classmethod virtual System::UnicodeString __fastcall FriendlyName();
	__classmethod virtual System::UnicodeString __fastcall FriendlyDescription();
	
__published:
	__property int MaxSteps = {read=FMaxSteps, write=FMaxSteps, nodefault};
	__property float Speed = {read=FSpeed, write=FSpeed};
	__property Gls::Coordinates::TGLCoordinates* Direction = {read=FDirection, write=SetDirection};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Explosionfx */
}	/* namespace Gls */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GLS_EXPLOSIONFX)
using namespace Gls::Explosionfx;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GLS)
using namespace Gls;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GLS_ExplosionFxHPP
