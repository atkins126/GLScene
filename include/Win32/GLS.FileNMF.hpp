﻿// CodeGear C++Builder
// Copyright (c) 1995, 2024 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'GLS.FileNMF.pas' rev: 36.00 (Windows)

#ifndef GLS_FileNMFHPP
#define GLS_FileNMFHPP

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
#include <Stage.VectorTypes.hpp>
#include <GLS.VectorFileObjects.hpp>
#include <GLS.PersistentClasses.hpp>
#include <Stage.VectorGeometry.hpp>
#include <GLS.VectorLists.hpp>
#include <GLS.ApplicationFileIO.hpp>
#include <GLS.BaseClasses.hpp>

//-- user supplied -----------------------------------------------------------

namespace Gls
{
namespace Filenmf
{
//-- forward type declarations -----------------------------------------------
struct TNmHeader;
struct TNmRawTriangle;
class DELPHICLASS TFileNMF;
class DELPHICLASS TGLNMFVectorFile;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TNmHeader
{
public:
	System::StaticArray<char, 4> hdr;
	unsigned size;
};


struct DECLSPEC_DRECORD TNmRawTriangle
{
public:
	System::StaticArray<Stage::Vectortypes::TVector3f, 3> vert;
	System::StaticArray<Stage::Vectortypes::TVector3f, 3> norm;
	System::StaticArray<Stage::Vectorgeometry::TTexPoint, 3> texCoord;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TFileNMF : public System::TObject
{
	typedef System::TObject inherited;
	
	
private:
	typedef System::DynamicArray<TNmRawTriangle> _TFileNMF__1;
	
	
public:
	TNmHeader FileHeader;
	TNmHeader TrisHeader;
	int NumTris;
	_TFileNMF__1 RawTriangles;
	void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	void __fastcall SaveToStream(System::Classes::TStream* Stream);
public:
	/* TObject.Create */ inline __fastcall TFileNMF() : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TFileNMF() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TGLNMFVectorFile : public Gls::Vectorfileobjects::TGLVectorFile
{
	typedef Gls::Vectorfileobjects::TGLVectorFile inherited;
	
public:
	__classmethod virtual Gls::Applicationfileio::TGLDataFileCapabilities __fastcall Capabilities();
	virtual void __fastcall LoadFromStream(System::Classes::TStream* aStream);
	virtual void __fastcall SaveToStream(System::Classes::TStream* aStream);
public:
	/* TGLVectorFile.Create */ inline __fastcall virtual TGLNMFVectorFile(System::Classes::TPersistent* AOwner) : Gls::Vectorfileobjects::TGLVectorFile(AOwner) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TGLNMFVectorFile() { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define NMF_HEADER_TAG L"NMF "
#define NMF_TRIANGLE_TAG L"TRIS"
}	/* namespace Filenmf */
}	/* namespace Gls */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GLS_FILENMF)
using namespace Gls::Filenmf;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GLS)
using namespace Gls;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GLS_FileNMFHPP
