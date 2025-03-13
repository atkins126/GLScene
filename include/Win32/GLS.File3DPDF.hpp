﻿// CodeGear C++Builder
// Copyright (c) 1995, 2024 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'GLS.File3DPDF.pas' rev: 36.00 (Windows)

#ifndef GLS_File3DPDFHPP
#define GLS_File3DPDFHPP

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
#include <Winapi.ShellAPI.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.StrUtils.hpp>
#include <Stage.VectorTypes.hpp>
#include <GLS.PersistentClasses.hpp>
#include <Stage.VectorGeometry.hpp>
#include <GLS.VectorLists.hpp>
#include <GLS.VectorFileObjects.hpp>
#include <GLS.ApplicationFileIO.hpp>
#include <Stage.Utils.hpp>
#include <GLS.BaseClasses.hpp>

//-- user supplied -----------------------------------------------------------

namespace Gls
{
namespace File3dpdf
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TGLIDTFVectorFile;
class DELPHICLASS TGLU3DVectorFile;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TGLIDTFVectorFile : public Gls::Vectorfileobjects::TGLVectorFile
{
	typedef Gls::Vectorfileobjects::TGLVectorFile inherited;
	
private:
	void __fastcall BuildNormals(Gls::Vectorfileobjects::TGLMeshObject* m);
	
public:
	__classmethod virtual Gls::Applicationfileio::TGLDataFileCapabilities __fastcall Capabilities();
	virtual void __fastcall SaveToStream(System::Classes::TStream* aStream);
public:
	/* TGLVectorFile.Create */ inline __fastcall virtual TGLIDTFVectorFile(System::Classes::TPersistent* AOwner) : Gls::Vectorfileobjects::TGLVectorFile(AOwner) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TGLIDTFVectorFile() { }
	
};


class PASCALIMPLEMENTATION TGLU3DVectorFile : public TGLIDTFVectorFile
{
	typedef TGLIDTFVectorFile inherited;
	
public:
	__classmethod virtual Gls::Applicationfileio::TGLDataFileCapabilities __fastcall Capabilities();
	virtual void __fastcall SaveToStream(System::Classes::TStream* aStream);
public:
	/* TGLVectorFile.Create */ inline __fastcall virtual TGLU3DVectorFile(System::Classes::TPersistent* AOwner) : TGLIDTFVectorFile(AOwner) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TGLU3DVectorFile() { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::UnicodeString IDTFConverterFileName;
}	/* namespace File3dpdf */
}	/* namespace Gls */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GLS_FILE3DPDF)
using namespace Gls::File3dpdf;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GLS)
using namespace Gls;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GLS_File3DPDFHPP
