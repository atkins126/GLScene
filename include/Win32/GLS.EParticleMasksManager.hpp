﻿// CodeGear C++Builder
// Copyright (c) 1995, 2024 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'GLS.EParticleMasksManager.pas' rev: 36.00 (Windows)

#ifndef GLS_EParticleMasksManagerHPP
#define GLS_EParticleMasksManagerHPP

#pragma delphiheader begin
#pragma option push
#if defined(__BORLANDC__) && !defined(__clang__)
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#endif
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Types.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Math.hpp>
#include <Vcl.Graphics.hpp>
#include <Stage.VectorGeometry.hpp>
#include <Stage.VectorTypes.hpp>
#include <GLS.Texture.hpp>
#include <GLS.Material.hpp>
#include <GLS.Scene.hpp>
#include <GLS.ParticleFX.hpp>
#include <GLS.Coordinates.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Gls
{
namespace Eparticlemasksmanager
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TGLEParticleMask;
class DELPHICLASS TGLEParticleMasks;
class DELPHICLASS TGLEParticleMasksManager;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TGLEProjectedParticleMask : unsigned char { pptXMask, pptYMask, pptZMask };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TGLEParticleMask : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FName;
	Gls::Coordinates::TGLCoordinates* FScale;
	Gls::Coordinates::TGLCoordinates* FPosition;
	Gls::Material::TGLLibMaterialName FYMask;
	Gls::Material::TGLLibMaterialName FZMask;
	Gls::Material::TGLLibMaterialName FXMask;
	Gls::Material::TGLMaterialLibrary* FMaterialLibrary;
	System::Uitypes::TColor FBackgroundColor;
	System::Uitypes::TColor FMaskColor;
	int FMaxX;
	int FMaxY;
	int FMaxZ;
	int FMinX;
	int FMinY;
	int FMinZ;
	int IXW;
	int IXH;
	int IYW;
	int IYH;
	int IZW;
	int IZH;
	int LX;
	int LY;
	int LZ;
	int MX;
	int MY;
	bool BogusMask;
	bool BogusMaskX;
	bool BogusMaskY;
	bool BogusMaskZ;
	float FRollAngle;
	float FPitchAngle;
	float FTurnAngle;
	void __fastcall SetName(const System::UnicodeString Value);
	void __fastcall SetXMask(const Gls::Material::TGLLibMaterialName Value);
	void __fastcall SetYMask(const Gls::Material::TGLLibMaterialName Value);
	void __fastcall SetZMask(const Gls::Material::TGLLibMaterialName Value);
	void __fastcall SetMaterialLibrary(Gls::Material::TGLMaterialLibrary* const Value);
	Vcl::Graphics::TBitmap* __fastcall XCan();
	Vcl::Graphics::TBitmap* __fastcall YCan();
	Vcl::Graphics::TBitmap* __fastcall ZCan();
	Gls::Material::TGLAbstractMaterialLibrary* __fastcall GetMaterialLibrary();
	HRESULT __stdcall QueryInterface(const GUID &IID, /* out */ void *Obj);
	int __stdcall _AddRef();
	int __stdcall _Release();
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName();
	
public:
	__fastcall virtual TGLEParticleMask(System::Classes::TCollection* Collection);
	__fastcall virtual ~TGLEParticleMask();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall UpdateExtents();
	void __fastcall Roll(float Angle);
	void __fastcall Turn(float Angle);
	void __fastcall Pitch(float Angle);
	void __fastcall GenerateMaskFromProjection(TGLEProjectedParticleMask FromMask, TGLEProjectedParticleMask ToMask, int Depth);
	
__published:
	__property Gls::Coordinates::TGLCoordinates* Scale = {read=FScale, write=FScale};
	__property Gls::Coordinates::TGLCoordinates* Position = {read=FPosition, write=FPosition};
	__property System::UnicodeString Name = {read=FName, write=SetName};
	__property Gls::Material::TGLMaterialLibrary* MaterialLibrary = {read=FMaterialLibrary, write=SetMaterialLibrary};
	__property Gls::Material::TGLLibMaterialName XMask = {read=FXMask, write=SetXMask};
	__property Gls::Material::TGLLibMaterialName YMask = {read=FYMask, write=SetYMask};
	__property Gls::Material::TGLLibMaterialName ZMask = {read=FZMask, write=SetZMask};
	__property System::Uitypes::TColor BackgroundColor = {read=FBackgroundColor, write=FBackgroundColor, nodefault};
	__property System::Uitypes::TColor MaskColor = {read=FMaskColor, write=FMaskColor, nodefault};
	__property float RollAngle = {read=FRollAngle, write=FRollAngle};
	__property float PitchAngle = {read=FPitchAngle, write=FPitchAngle};
	__property float TurnAngle = {read=FTurnAngle, write=FTurnAngle};
private:
	void *__IGLMaterialLibrarySupported;	// Gls::Material::IGLMaterialLibrarySupported 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {8E442AF9-D212-4A5E-8A88-92F798BABFD1}
	operator Gls::Material::_di_IGLMaterialLibrarySupported()
	{
		Gls::Material::_di_IGLMaterialLibrarySupported intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Gls::Material::IGLMaterialLibrarySupported*(void) { return (Gls::Material::IGLMaterialLibrarySupported*)&__IGLMaterialLibrarySupported; }
	#endif
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TGLEParticleMasks : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TGLEParticleMask* operator[](int Index) { return this->Items[Index]; }
	
protected:
	System::Classes::TComponent* Owner;
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner();
	void __fastcall SetItems(int Index, TGLEParticleMask* const Val);
	TGLEParticleMask* __fastcall GetItems(int Index);
	
public:
	HIDESBASE TGLEParticleMask* __fastcall Add();
	__fastcall TGLEParticleMasks(System::Classes::TComponent* AOwner);
	__property TGLEParticleMask* Items[int Index] = {read=GetItems, write=SetItems/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TGLEParticleMasks() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TGLEParticleMasksManager : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	TGLEParticleMasks* FParticleMasks;
	
protected:
	void __fastcall ApplyOrthoGraphic(Stage::Vectortypes::TVector3f &Vec, TGLEParticleMask* Mask);
	void __fastcall ApplyRotation(Stage::Vectortypes::TVector3f &Vec, TGLEParticleMask* Mask);
	void __fastcall ApplyRotationTarget(Stage::Vectortypes::TVector3f &Vec, TGLEParticleMask* Mask, Gls::Scene::TGLBaseSceneObject* TargetObject);
	void __fastcall ApplyScaleAndPosition(Stage::Vectortypes::TVector3f &Vec, TGLEParticleMask* Mask);
	void __fastcall ApplyScaleAndPositionTarget(Stage::Vectortypes::TVector3f &Vec, TGLEParticleMask* Mask, Gls::Scene::TGLBaseSceneObject* TargetObject);
	void __fastcall FindParticlePosition(Stage::Vectortypes::TVector3f &Vec, TGLEParticleMask* Mask);
	
public:
	__fastcall virtual TGLEParticleMasksManager(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TGLEParticleMasksManager();
	Stage::Vectortypes::TVector3f __fastcall CreateParticlePositionFromMask(System::UnicodeString MaskName);
	Stage::Vectortypes::TVector3f __fastcall TargetParticlePositionFromMask(Gls::Scene::TGLBaseSceneObject* TargetObject, System::UnicodeString MaskName);
	void __fastcall SetParticlePositionFromMask(Gls::Particlefx::TGLParticle* Particle, System::UnicodeString MaskName);
	void __fastcall SetParticlePositionFromMaskTarget(Gls::Particlefx::TGLParticle* Particle, System::UnicodeString MaskName, Gls::Scene::TGLBaseSceneObject* TargetObject);
	TGLEParticleMask* __fastcall ParticleMaskByName(System::UnicodeString MaskName);
	
__published:
	__property TGLEParticleMasks* ParticleMasks = {read=FParticleMasks, write=FParticleMasks};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eparticlemasksmanager */
}	/* namespace Gls */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GLS_EPARTICLEMASKSMANAGER)
using namespace Gls::Eparticlemasksmanager;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GLS)
using namespace Gls;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GLS_EParticleMasksManagerHPP
