﻿// CodeGear C++Builder
// Copyright (c) 1995, 2024 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'GLS.FileQ3MD3.pas' rev: 36.00 (Windows)

#ifndef GLS_FileQ3MD3HPP
#define GLS_FileQ3MD3HPP

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
#include <Stage.VectorGeometry.hpp>
#include <GLS.VectorFileObjects.hpp>
#include <GLS.VectorLists.hpp>
#include <GLS.Material.hpp>
#include <GLS.PersistentClasses.hpp>
#include <Formats.MD3.hpp>

//-- user supplied -----------------------------------------------------------

namespace Gls
{
namespace Fileq3md3
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TMD3TagList;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TMD3TagList : public System::TObject
{
	typedef System::TObject inherited;
	
	
private:
	typedef System::DynamicArray<Formats::Md3::TMD3Tag> _TMD3TagList__1;
	
	
private:
	_TMD3TagList__1 FTags;
	int FNumTags;
	int FNumFrames;
	Formats::Md3::TMD3Tag __fastcall GetTag(int index);
	
public:
	void __fastcall LoadFromFile(const System::UnicodeString FileName);
	void __fastcall LoadFromStream(System::Classes::TStream* AStream);
	Stage::Vectortypes::TGLMatrix __fastcall GetTransform(const System::UnicodeString TagName, int Frame);
	__property int TagCount = {read=FNumTags, nodefault};
	__property int FrameCount = {read=FNumFrames, nodefault};
	__property Formats::Md3::TMD3Tag Tags[int index] = {read=GetTag};
public:
	/* TObject.Create */ inline __fastcall TMD3TagList() : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TMD3TagList() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall LoadQ3Anims(Gls::Vectorfileobjects::TGLActorAnimations* Animations, const System::UnicodeString FileName, const System::UnicodeString NamePrefix)/* overload */;
extern DELPHI_PACKAGE void __fastcall LoadQ3Anims(Gls::Vectorfileobjects::TGLActorAnimations* Animations, System::Classes::TStrings* Strings, const System::UnicodeString NamePrefix)/* overload */;
extern DELPHI_PACKAGE void __fastcall LoadQ3Skin(const System::UnicodeString FileName, Gls::Vectorfileobjects::TGLActor* Actor);
}	/* namespace Fileq3md3 */
}	/* namespace Gls */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GLS_FILEQ3MD3)
using namespace Gls::Fileq3md3;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GLS)
using namespace Gls;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GLS_FileQ3MD3HPP
