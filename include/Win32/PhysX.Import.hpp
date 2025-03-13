﻿// CodeGear C++Builder
// Copyright (c) 1995, 2024 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'PhysX.Import.pas' rev: 36.00 (Windows)

#ifndef PhysX_ImportHPP
#define PhysX_ImportHPP

#pragma delphiheader begin
#pragma option push
#if defined(__BORLANDC__) && !defined(__clang__)
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#endif
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>

//-- user supplied -----------------------------------------------------------

namespace Physx
{
namespace Import
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
#define PhysXDLL L"PhysXwrap.dll"
extern "C" void __stdcall SDK_Version(unsigned* major, unsigned* minor, unsigned* bugfix);
extern "C" void __stdcall InitNx(void);
extern "C" void __stdcall ReleaseNx(void);
extern "C" void __stdcall SimulateNx(float dt);
extern "C" void __stdcall GetResultsNx(void);
extern "C" void __stdcall ActorCount(unsigned* count);
extern "C" void __stdcall GetActor(unsigned index, unsigned* obj);
extern "C" void __stdcall GetActorGlobalPosition(unsigned actor, Winapi::Windows::PSingle x, Winapi::Windows::PSingle y, Winapi::Windows::PSingle z);
extern "C" void __stdcall SetActorGlobalPosition(unsigned actor, float x, float y, float z);
extern "C" void __stdcall GetActorGlobalOrientation(unsigned actor, Winapi::Windows::PSingle x, Winapi::Windows::PSingle y, Winapi::Windows::PSingle z, Winapi::Windows::PSingle w);
extern "C" void __stdcall SetActorGlobalOrientation(unsigned actor, float x, float y, float z, float w);
extern "C" void __stdcall GetActorCMassGlobalPosition(unsigned actor, Winapi::Windows::PSingle x, Winapi::Windows::PSingle y, Winapi::Windows::PSingle z);
extern "C" void __stdcall SetActorCMassGlobalPosition(unsigned actor, float x, float y, float z);
extern "C" void __stdcall GetActorMass(unsigned actor, Winapi::Windows::PSingle m);
extern "C" void __stdcall SetActorMass(unsigned actor, float m);
extern "C" void __stdcall ActorAddForce(unsigned actor, float x, float y, float z);
extern "C" void __stdcall CreateGroundPlane(unsigned* actor);
extern "C" void __stdcall CreateBox(unsigned* actor, float sx, float sy, float sz, float dens);
extern "C" void __stdcall CreateSphere(unsigned* actor, float rad, float dens);
extern "C" void __stdcall CreateCylinder(unsigned* actor, float rad, float height, float dens);
}	/* namespace Import */
}	/* namespace Physx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PHYSX_IMPORT)
using namespace Physx::Import;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PHYSX)
using namespace Physx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PhysX_ImportHPP
