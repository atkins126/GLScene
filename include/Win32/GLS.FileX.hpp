﻿// CodeGear C++Builder
// Copyright (c) 1995, 2024 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'GLS.FileX.pas' rev: 36.00 (Windows)

#ifndef GLS_FileXHPP
#define GLS_FileXHPP

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
#include <GLS.VectorLists.hpp>
#include <Stage.VectorGeometry.hpp>
#include <GLS.VectorFileObjects.hpp>
#include <GLS.ApplicationFileIO.hpp>
#include <GLS.Texture.hpp>
#include <GLS.Material.hpp>
#include <Formats.X.hpp>
#include <GLS.BaseClasses.hpp>

//-- user supplied -----------------------------------------------------------

namespace Gls
{
namespace Filex
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TGLXVectorFile;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TGLXVectorFile : public Gls::Vectorfileobjects::TGLVectorFile
{
	typedef Gls::Vectorfileobjects::TGLVectorFile inherited;
	
public:
	__classmethod virtual Gls::Applicationfileio::TGLDataFileCapabilities __fastcall Capabilities();
	virtual void __fastcall LoadFromStream(System::Classes::TStream* aStream);
public:
	/* TGLVectorFile.Create */ inline __fastcall virtual TGLXVectorFile(System::Classes::TPersistent* AOwner) : Gls::Vectorfileobjects::TGLVectorFile(AOwner) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TGLXVectorFile() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Filex */
}	/* namespace Gls */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GLS_FILEX)
using namespace Gls::Filex;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GLS)
using namespace Gls;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GLS_FileXHPP
