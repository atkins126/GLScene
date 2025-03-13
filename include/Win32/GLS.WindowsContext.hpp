﻿// CodeGear C++Builder
// Copyright (c) 1995, 2024 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'GLS.WindowsContext.pas' rev: 36.00 (Windows)

#ifndef GLS_WindowsContextHPP
#define GLS_WindowsContextHPP

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
#include <Winapi.OpenGLext.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <Stage.VectorTypes.hpp>
#include <Stage.OpenGLTokens.hpp>
#include <GLS.OpenGLAdapter.hpp>
#include <Stage.PipelineTransform.hpp>
#include <GLS.Context.hpp>
#include <GLS.State.hpp>
#include <Stage.Logger.hpp>
#include <Stage.Strings.hpp>
#include <Stage.VectorGeometry.hpp>

//-- user supplied -----------------------------------------------------------

namespace Gls
{
namespace Windowscontext
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TGLWindowsContext;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TGLWindowsContext : public Gls::Context::TGLContext
{
	typedef Gls::Context::TGLContext inherited;
	
	
private:
	typedef System::DynamicArray<int> _TGLWindowsContext__1;
	
	typedef System::DynamicArray<float> _TGLWindowsContext__2;
	
	
protected:
	System::NativeUInt FDC;
	System::NativeUInt FRC;
	TGLWindowsContext* FShareContext;
	Stage::Opengltokens::HPBUFFERARB FHPBUFFER;
	_TGLWindowsContext__1 FiAttribs;
	_TGLWindowsContext__2 FfAttribs;
	bool FLegacyContextsOnly;
	bool FSwapBufferSupported;
	void __fastcall SpawnLegacyContext(HDC aDC);
	virtual void __fastcall CreateOldContext(HDC aDC);
	virtual void __fastcall CreateNewContext(HDC aDC);
	void __fastcall ClearIAttribs();
	void __fastcall AddIAttrib(int attrib, int value);
	void __fastcall ChangeIAttrib(int attrib, int newValue);
	void __fastcall DropIAttrib(int attrib);
	void __fastcall ClearFAttribs();
	void __fastcall AddFAttrib(float attrib, float value);
	void __fastcall DestructionEarlyWarning(System::TObject* sender);
	void __fastcall ChooseWGLFormat(HDC DC, unsigned nMaxFormats, System::PInteger piFormats, int &nNumFormats, int BufferCount = 0x1);
	virtual void __fastcall DoCreateContext(HDC ADeviceHandle);
	virtual void __fastcall DoCreateMemoryContext(HWND outputDevice, int width, int height, int BufferCount);
	virtual bool __fastcall DoShareLists(Gls::Context::TGLContext* aContext);
	virtual void __fastcall DoDestroyContext();
	virtual void __fastcall DoActivate();
	virtual void __fastcall DoDeactivate();
	
public:
	__fastcall virtual TGLWindowsContext();
	__fastcall virtual ~TGLWindowsContext();
	virtual bool __fastcall IsValid();
	virtual void __fastcall SwapBuffers();
	virtual void * __fastcall RenderOutputDevice();
	__property System::NativeUInt DC = {read=FDC, nodefault};
	__property System::NativeUInt RC = {read=FRC, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool vUseWindowTrackingHook;
extern DELPHI_PACKAGE System::NativeUInt __fastcall CreateTempWnd(void);
}	/* namespace Windowscontext */
}	/* namespace Gls */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GLS_WINDOWSCONTEXT)
using namespace Gls::Windowscontext;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GLS)
using namespace Gls;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GLS_WindowsContextHPP
