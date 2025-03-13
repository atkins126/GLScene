﻿// CodeGear C++Builder
// Copyright (c) 1995, 2024 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'GLS.MeshCSG.pas' rev: 36.00 (Windows)

#ifndef GLS_MeshCSGHPP
#define GLS_MeshCSGHPP

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
#include <System.Math.hpp>
#include <GLS.Scene.hpp>
#include <Stage.VectorTypes.hpp>
#include <GLS.VectorFileObjects.hpp>
#include <Stage.VectorGeometry.hpp>
#include <GLS.MeshBSP.hpp>
#include <GLS.VectorLists.hpp>

//-- user supplied -----------------------------------------------------------

namespace Gls
{
namespace Meshcsg
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TCSGOperation : unsigned char { CSG_Union, CSG_Subtraction, CSG_Intersection };

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall CSG_Operation(Gls::Vectorfileobjects::TGLMeshObject* obj1, Gls::Vectorfileobjects::TGLMeshObject* obj2, TCSGOperation Operation, Gls::Vectorfileobjects::TGLMeshObject* Res, const System::UnicodeString MaterialName1, const System::UnicodeString MaterialName2);
}	/* namespace Meshcsg */
}	/* namespace Gls */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GLS_MESHCSG)
using namespace Gls::Meshcsg;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GLS)
using namespace Gls;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GLS_MeshCSGHPP
