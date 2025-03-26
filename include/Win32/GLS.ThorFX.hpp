﻿// CodeGear C++Builder
// Copyright (c) 1995, 2025 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'GLS.ThorFX.pas' rev: 36.00 (Windows)

#ifndef GLS_ThorFXHPP
#define GLS_ThorFXHPP

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
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <System.Math.hpp>
#include <Stage.OpenGLTokens.hpp>
#include <GLS.Scene.hpp>
#include <GLS.XCollection.hpp>
#include <Stage.VectorGeometry.hpp>
#include <GLS.Context.hpp>
#include <GLS.VectorLists.hpp>
#include <Stage.VectorTypes.hpp>
#include <GLS.Cadencer.hpp>
#include <GLS.Color.hpp>
#include <GLS.BaseClasses.hpp>
#include <GLS.Coordinates.hpp>
#include <GLS.RenderContextInfo.hpp>
#include <Stage.PipelineTransform.hpp>
#include <Stage.Manager.hpp>
#include <GLS.State.hpp>
#include <Stage.TextureFormat.hpp>

//-- user supplied -----------------------------------------------------------

namespace Gls
{
namespace Thorfx
{
//-- forward type declarations -----------------------------------------------
struct TThorpoint;
class DELPHICLASS TGLThorFXManager;
class DELPHICLASS TGLBThorFX;
//-- type declarations -------------------------------------------------------
typedef TThorpoint *PThorpoint;

struct DECLSPEC_DRECORD TThorpoint
{
public:
	Stage::Vectortypes::TGLVector Position;
	float Size;
};


typedef System::StaticArray<TThorpoint, 33554432> TThorpointArray;

typedef TThorpointArray *PThorpointArray;

typedef void __fastcall (__closure *TCalcPointEvent)(System::TObject* Sender, int PointNo, float &x, float &y, float &z);

class PASCALIMPLEMENTATION TGLThorFXManager : public Gls::Baseclasses::TGLCadenceAbleComponent
{
	typedef Gls::Baseclasses::TGLCadenceAbleComponent inherited;
	
private:
	System::Classes::TList* FClients;
	PThorpointArray FThorpoints;
	Gls::Coordinates::TGLCoordinates* FTarget;
	Gls::Cadencer::TGLCadencer* FCadencer;
	int FMaxpoints;
	float FGlowSize;
	float FVibrate;
	float FWildness;
	int NP;
	Gls::Color::TGLColor* FInnerColor;
	Gls::Color::TGLColor* FOuterColor;
	Gls::Color::TGLColor* FCoreColor;
	bool FDisabled;
	bool FCore;
	bool FGlow;
	TCalcPointEvent FOnCalcPoint;
	
protected:
	void __fastcall RegisterClient(TGLBThorFX* aClient);
	void __fastcall DeRegisterClient(TGLBThorFX* aClient);
	void __fastcall DeRegisterAllClients();
	void __fastcall SetTarget(Gls::Coordinates::TGLCoordinates* const val);
	void __fastcall SetCadencer(Gls::Cadencer::TGLCadencer* const val);
	void __fastcall SetMaxpoints(const int val);
	bool __fastcall StoreGlowSize();
	bool __fastcall StoreVibrate();
	void __fastcall SetInnerColor(Gls::Color::TGLColor* const val);
	void __fastcall SetOuterColor(Gls::Color::TGLColor* const val);
	void __fastcall SetCoreColor(Gls::Color::TGLColor* const val);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall ThorInit();
	void __fastcall CalcThor();
	void __fastcall CalcFrac(int left, int right, float lh, float rh, int xyz);
	
public:
	__fastcall virtual TGLThorFXManager(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TGLThorFXManager();
	virtual void __fastcall DoProgress(const Gls::Baseclasses::TGLProgressTimes &progressTime);
	
__published:
	__property Gls::Coordinates::TGLCoordinates* Target = {read=FTarget, write=SetTarget};
	__property Gls::Cadencer::TGLCadencer* Cadencer = {read=FCadencer, write=SetCadencer};
	__property int Maxpoints = {read=FMaxpoints, write=SetMaxpoints, default=256};
	__property float GlowSize = {read=FGlowSize, write=FGlowSize, stored=StoreGlowSize};
	__property float Vibrate = {read=FVibrate, write=FVibrate, stored=StoreVibrate};
	__property Gls::Color::TGLColor* InnerColor = {read=FInnerColor, write=SetInnerColor};
	__property Gls::Color::TGLColor* OuterColor = {read=FOuterColor, write=SetOuterColor};
	__property Gls::Color::TGLColor* CoreColor = {read=FCoreColor, write=SetCoreColor};
	__property bool Disabled = {read=FDisabled, write=FDisabled, nodefault};
	__property bool Core = {read=FCore, write=FCore, nodefault};
	__property bool Glow = {read=FGlow, write=FGlow, nodefault};
	__property float Wildness = {read=FWildness, write=FWildness};
	__property TCalcPointEvent OnCalcPoint = {read=FOnCalcPoint, write=FOnCalcPoint};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TGLBThorFX : public Gls::Scene::TGLObjectPostEffect
{
	typedef Gls::Scene::TGLObjectPostEffect inherited;
	
private:
	TGLThorFXManager* FManager;
	System::UnicodeString FManagerName;
	Gls::Coordinates::TGLCoordinates* FTarget;
	
protected:
	void __fastcall SetManager(TGLThorFXManager* const val);
	virtual void __fastcall WriteToFiler(System::Classes::TWriter* writer);
	virtual void __fastcall ReadFromFiler(System::Classes::TReader* reader);
	DYNAMIC void __fastcall Loaded();
	void __fastcall SetTarget(Gls::Coordinates::TGLCoordinates* const val);
	
public:
	__fastcall virtual TGLBThorFX(Gls::Xcollection::TXCollection* AOwner);
	__fastcall virtual ~TGLBThorFX();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod virtual System::UnicodeString __fastcall FriendlyName();
	__classmethod virtual System::UnicodeString __fastcall FriendlyDescription();
	virtual void __fastcall Render(Gls::Rendercontextinfo::TGLRenderContextInfo &rci);
	
__published:
	__property TGLThorFXManager* Manager = {read=FManager, write=SetManager};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TGLBThorFX* __fastcall GetOrCreateThorFX(Gls::Scene::TGLBaseSceneObject* obj, const System::UnicodeString name = System::UnicodeString());
}	/* namespace Thorfx */
}	/* namespace Gls */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GLS_THORFX)
using namespace Gls::Thorfx;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GLS)
using namespace Gls;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GLS_ThorFXHPP
