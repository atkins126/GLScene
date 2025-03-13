﻿// CodeGear C++Builder
// Copyright (c) 1995, 2024 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'GXS.CUDA.API.pas' rev: 36.00 (Windows)

#ifndef GXS_CUDA_APIHPP
#define GXS_CUDA_APIHPP

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
#include <FMX.Dialogs.hpp>
#include <GXS.PersistentClasses.hpp>
#include <GXS.BaseClasses.hpp>
#include <Stage.VectorGeometry.hpp>
#include <Stage.VectorTypes.hpp>
#include <GXS.VectorLists.hpp>
#include <Stage.Strings.hpp>
#include <Stage.Utils.hpp>
#include <GXS.Context.hpp>
#include <GXS.Graphics.hpp>
#include <CUDA.Runtime.hpp>
#include <CUDA.Parser.hpp>
#include <CUDA.FourierTransform.hpp>
#include <CUDA.DataAccess.hpp>
#include <CUDA.Import.hpp>
#include <GXS.CUDA.Compiler.hpp>
#include <GXS.CUDA.Context.hpp>

//-- user supplied -----------------------------------------------------------

namespace Gxs
{
namespace Cuda
{
namespace Api
{
//-- forward type declarations -----------------------------------------------
struct TChannelTypeAndNum;
class DELPHICLASS TCUDAComponent;
class DELPHICLASS TCUDAModule;
class DELPHICLASS TCUDAGraphicResource;
class DELPHICLASS TCUDAMemData;
class DELPHICLASS TCUDAUniform;
class DELPHICLASS TCUDAConstant;
class DELPHICLASS TCUDAFuncParam;
class DELPHICLASS TCUDAFunction;
class DELPHICLASS TCUDATexture;
class DELPHICLASS TgxSCUDA;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TCUDAChange : unsigned char { cuchDevice, cuchContext, cuchSize, cuchAddresMode, cuchFlag, cuchFilterMode, cuchArray, cuchFormat, cuchMapping };

typedef System::Set<TCUDAChange, TCUDAChange::cuchDevice, TCUDAChange::cuchMapping> TCUDAChanges;

enum DECLSPEC_DENUM TCuAddresMode : unsigned char { amWrap, amClamp, amMirror };

enum DECLSPEC_DENUM TCuFilterMode : unsigned char { fmPoint, fmLinear };

enum DECLSPEC_DENUM TCUDAChannelType : unsigned char { ctUndefined, ctUInt8, ctUInt16, ctUInt32, ctInt8, ctInt16, ctInt32, ctHalfFloat, ctFloat, ctDouble };

enum DECLSPEC_DENUM TCUDAChannelNum : unsigned char { cnOne, cnTwo, cnThree, cnFour };

struct DECLSPEC_DRECORD TChannelTypeAndNum
{
public:
	TCUDAChannelType F;
	TCUDAChannelNum C;
};


enum DECLSPEC_DENUM TCUDAMapping : unsigned char { grmDefault, grmReadOnly, grmWriteDiscard };

class PASCALIMPLEMENTATION TCUDAComponent : public Gxs::Cuda::Context::TCUDAHandlesMaster
{
	typedef Gxs::Cuda::Context::TCUDAHandlesMaster inherited;
	
private:
	TCUDAComponent* FMaster;
	Gxs::Persistentclasses::TgxPersistentObjectList* FItems;
	void __fastcall SetMaster(TCUDAComponent* AMaster);
	TCUDAComponent* __fastcall GetItem(const int i);
	int __fastcall GetItemsCount();
	
protected:
	Cuda::Import::TCUresult FStatus;
	TCUDAChanges FChanges;
	virtual Gxs::Cuda::Context::TCUDAContext* __fastcall GetContext();
	void __fastcall CollectStatus(Cuda::Import::TCUresult AStatus);
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc AProc, System::Classes::TComponent* Root);
	void __fastcall AddItem(TCUDAComponent* AItem);
	void __fastcall RemoveItem(TCUDAComponent* AItem);
	void __fastcall DeleteItems();
	virtual void __fastcall SetName(const System::Classes::TComponentName NewName);
	virtual bool __fastcall GetIsAllocated() = 0 ;
	
public:
	__fastcall virtual ~TCUDAComponent();
	virtual void __fastcall CuNotifyChange(TCUDAChange AChange);
	DYNAMIC System::Classes::TComponent* __fastcall GetParentComponent();
	DYNAMIC void __fastcall SetParentComponent(System::Classes::TComponent* Value);
	DYNAMIC bool __fastcall HasParent();
	TCUDAComponent* __fastcall GetItemByName(const System::UnicodeString name);
	System::UnicodeString __fastcall MakeUniqueName(const System::UnicodeString BaseName);
	__property TCUDAComponent* Master = {read=FMaster, write=SetMaster};
	__property Gxs::Cuda::Context::TCUDAContext* Context = {read=GetContext};
	__property TCUDAComponent* Items[const int i] = {read=GetItem};
	__property int ItemsCount = {read=GetItemsCount, nodefault};
	__property Cuda::Import::TCUresult Status = {read=FStatus, nodefault};
	__property bool IsAllocated = {read=GetIsAllocated, nodefault};
public:
	/* TComponent.Create */ inline __fastcall virtual TCUDAComponent(System::Classes::TComponent* AOwner) : Gxs::Cuda::Context::TCUDAHandlesMaster(AOwner) { }
	
};


typedef System::TMetaClass* TCUDAComponentClass;

class PASCALIMPLEMENTATION TCUDAModule : public TCUDAComponent
{
	typedef TCUDAComponent inherited;
	
private:
	Cuda::Import::PCUmodule FHandle;
	System::Classes::TStringList* FCode;
	Gxs::Cuda::Compiler::TgxSCUDACompilerOutput FCodeType;
	Gxs::Cuda::Compiler::TgxSCUDACompiler* FCompiler;
	void __fastcall SetCode(System::Classes::TStringList* const Value);
	void __fastcall SetCompiler(Gxs::Cuda::Compiler::TgxSCUDACompiler* const Value);
	TCUDAFunction* __fastcall GetKernelFunction(const System::UnicodeString AName);
	TCUDATexture* __fastcall GetKernelTexture(const System::UnicodeString AName);
	TCUDAConstant* __fastcall GetKernelConstant(const System::UnicodeString AName);
	
protected:
	virtual void __fastcall AllocateHandles();
	virtual void __fastcall DestroyHandles();
	void __fastcall OnChangeCode(System::TObject* Sender);
	virtual void __fastcall Loaded();
	virtual Gxs::Cuda::Context::TCUDAContext* __fastcall GetContext();
	virtual bool __fastcall GetIsAllocated();
	
public:
	__fastcall virtual TCUDAModule(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCUDAModule();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall LoadFromFile(const System::UnicodeString AFilename);
	void __fastcall LoadFromSource();
	void __fastcall Unload();
	void __fastcall LoadAndCompile();
	__property Gxs::Cuda::Context::TCUDAContext* Context = {read=GetContext};
	__property Gxs::Cuda::Compiler::TgxSCUDACompilerOutput CodeType = {read=FCodeType, nodefault};
	__property TCUDAFunction* KernelFunction[const System::UnicodeString AName] = {read=GetKernelFunction};
	__property TCUDATexture* KernelTexture[const System::UnicodeString AName] = {read=GetKernelTexture};
	__property TCUDAConstant* KernelConstant[const System::UnicodeString AName] = {read=GetKernelConstant};
	
__published:
	__property System::Classes::TStringList* Code = {read=FCode, write=SetCode};
	__property Gxs::Cuda::Compiler::TgxSCUDACompiler* Compiler = {read=FCompiler, write=SetCompiler};
};


enum DECLSPEC_DENUM TgxResourceType : unsigned char { rtTexture, rtBuffer };

class PASCALIMPLEMENTATION TCUDAGraphicResource : public TCUDAComponent
{
	typedef TCUDAComponent inherited;
	
protected:
	System::StaticArray<Cuda::Import::PCUgraphicsResource, 8> FHandle;
	TCUDAMapping FMapping;
	TgxResourceType FResourceType;
	Gxs::Context::TgxVirtualHandle* FGLContextHandle;
	int FMapCounter;
	virtual bool __fastcall GetIsAllocated();
	void __fastcall OnGLHandleAllocate(Gxs::Context::TgxVirtualHandle* Sender, unsigned &Handle);
	void __fastcall OnGLHandleDestroy(Gxs::Context::TgxVirtualHandle* Sender, unsigned &Handle);
	virtual void __fastcall BindArrayToTexture(TCUDAMemData* &cudaArray, System::LongWord ALeyer, System::LongWord ALevel) = 0 ;
	void __fastcall SetArray(TCUDAMemData* &AArray, Cuda::Import::PCUarray AHandle, bool ForGLTexture, bool Volume);
	virtual System::LongWord __fastcall GetAttributeArraySize(const System::UnicodeString Attr) = 0 ;
	virtual void * __fastcall GetAttributeArrayAddress(const System::UnicodeString Attr) = 0 ;
	virtual System::LongWord __fastcall GetElementArrayDataSize() = 0 ;
	virtual void * __fastcall GetElementArrayAddress() = 0 ;
	virtual void __fastcall SetMapping(const TCUDAMapping Value);
	__property TCUDAMapping Mapping = {read=FMapping, write=SetMapping, default=0};
	
public:
	virtual void __fastcall MapResources() = 0 ;
	virtual void __fastcall UnMapResources() = 0 ;
public:
	/* TCUDAComponent.Destroy */ inline __fastcall virtual ~TCUDAGraphicResource() { }
	
public:
	/* TComponent.Create */ inline __fastcall virtual TCUDAGraphicResource(System::Classes::TComponent* AOwner) : TCUDAComponent(AOwner) { }
	
};


enum DECLSPEC_DENUM TCUDAMemType : unsigned char { mtHost, mtDevice, mtArray };

enum DECLSPEC_DENUM TCUDAMemMapFlag : unsigned char { mmfPortable, mmfFastWrite };

typedef System::Set<TCUDAMemMapFlag, TCUDAMemMapFlag::mmfPortable, TCUDAMemMapFlag::mmfFastWrite> TCUDAMemMapFlags;

class PASCALIMPLEMENTATION TCUDAMemData : public TCUDAComponent
{
	typedef TCUDAComponent inherited;
	
private:
	Cuda::Import::TCUdeviceptr FData;
	Cuda::Import::TCUdeviceptr FMappedMemory;
	Cuda::Import::PCUarray FHandle;
	int FWidth;
	int FHeight;
	int FDepth;
	unsigned FPitch;
	int FElementSize;
	int FDataSize;
	TCUDAChannelType FChannelsType;
	TCUDAChannelNum fChannelsNum;
	TCUDAMemType FMemoryType;
	TCUDATexture* FTexture;
	bool FOpenGLRefArray;
	bool FMapping;
	void __fastcall SetMemoryType(const TCUDAMemType AType);
	void __fastcall SetWidth(const int Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetDepth(const int Value);
	void __fastcall SetChannelType(const TCUDAChannelType Value);
	void __fastcall SetChannelNum(const TCUDAChannelNum Value);
	Cuda::Import::TCUdeviceptr __fastcall GetData();
	Cuda::Import::PCUarray __fastcall GetArrayHandle();
	
protected:
	virtual void __fastcall AllocateHandles();
	virtual void __fastcall DestroyHandles();
	virtual bool __fastcall GetIsAllocated();
	
public:
	__fastcall virtual TCUDAMemData(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCUDAMemData();
	virtual void __fastcall CuNotifyChange(TCUDAChange AChange);
	void __fastcall Map(const TCUDAMemMapFlags AFlags = TCUDAMemMapFlags() );
	void __fastcall UnMap();
	template<typename EType> Cuda::Dataaccess::GCUDAHostElementAccess__1<EType>* __fastcall Data(int X)/* overload */;
	template<typename EType> Cuda::Dataaccess::GCUDAHostElementAccess__1<EType>* __fastcall Data(int X, int Y)/* overload */;
	template<typename EType> Cuda::Dataaccess::GCUDAHostElementAccess__1<EType>* __fastcall Data(int X, int Y, int Z)/* overload */;
	void __fastcall FillMem(const void *Value);
	void __fastcall CopyTo(TCUDAMemData* const ADstMemData)/* overload */;
	void __fastcall CopyTo(Gxs::Graphics::TgxImage* const AGLImage)/* overload */;
	void __fastcall CopyTo(TCUDAGraphicResource* const AGLGraphic, System::UnicodeString aAttr = System::UnicodeString())/* overload */;
	void __fastcall CopyFrom(TCUDAMemData* const ASrcMemData)/* overload */;
	void __fastcall CopyFrom(Gxs::Graphics::TgxBitmap32* const AGLImage)/* overload */;
	void __fastcall CopyFrom(TCUDAGraphicResource* const AGLGraphic, System::UnicodeString aAttr = System::UnicodeString())/* overload */;
	void __fastcall SubCopyTo(TCUDAMemData* const ADstMemData, const Cuda::Dataaccess::IntElement &ASrcXYZ, const Cuda::Dataaccess::IntElement &ADstXYZ, const Cuda::Dataaccess::IntElement &ASizes);
	__property int ElementSize = {read=FElementSize, nodefault};
	__property int DataSize = {read=FDataSize, nodefault};
	__property unsigned Pitch = {read=FPitch, nodefault};
	__property Cuda::Import::TCUdeviceptr RawData = {read=GetData};
	__property Cuda::Import::TCUdeviceptr MappedMemoryAddress = {read=FMappedMemory};
	__property Cuda::Import::PCUarray ArrayHandle = {read=GetArrayHandle};
	
__published:
	__property int Width = {read=FWidth, write=SetWidth, default=256};
	__property int Height = {read=FHeight, write=SetHeight, default=0};
	__property int Depth = {read=FDepth, write=SetDepth, default=0};
	__property TCUDAMemType MemoryType = {read=FMemoryType, write=SetMemoryType, default=0};
	__property TCUDAChannelType ChannelsType = {read=FChannelsType, write=SetChannelType, default=4};
	__property TCUDAChannelNum ChannelsNum = {read=fChannelsNum, write=SetChannelNum, default=0};
};


class PASCALIMPLEMENTATION TCUDAUniform : public TCUDAComponent
{
	typedef TCUDAComponent inherited;
	
protected:
	Cuda::Import::TCUdeviceptr FHandle;
	unsigned FSize;
	System::UnicodeString FKernelName;
	Cuda::Parser::TCUDAType FType;
	System::UnicodeString FCustomType;
	bool FRef;
	bool FDefined;
	void __fastcall SetKernelName(const System::UnicodeString AName);
	void __fastcall SetType(Cuda::Parser::TCUDAType AValue);
	void __fastcall SetCustomType(const System::UnicodeString AValue);
	void __fastcall SetSize(const unsigned AValue);
	void __fastcall SetRef(bool AValue);
	void __fastcall SetDefined(bool AValue);
	__property System::UnicodeString KernelName = {read=FKernelName, write=SetKernelName};
	__property Cuda::Parser::TCUDAType DataType = {read=FType, write=SetType, nodefault};
	__property System::UnicodeString CustomType = {read=FCustomType, write=SetCustomType};
	__property unsigned Size = {read=FSize, write=SetSize, nodefault};
	__property bool Reference = {read=FRef, write=SetRef, nodefault};
	virtual bool __fastcall GetIsAllocated();
	
public:
	__fastcall virtual TCUDAUniform(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCUDAUniform();
	__property bool IsValueDefined = {read=FDefined, write=SetDefined, nodefault};
};


class PASCALIMPLEMENTATION TCUDAConstant : public TCUDAUniform
{
	typedef TCUDAUniform inherited;
	
protected:
	virtual void __fastcall AllocateHandles();
	virtual void __fastcall DestroyHandles();
	Cuda::Import::TCUdeviceptr __fastcall GetDeviceAddress();
	
public:
	__property Cuda::Import::TCUdeviceptr DeviceAddress = {read=GetDeviceAddress};
	
__published:
	__property KernelName = {default=0};
	__property DataType;
	__property CustomType = {default=0};
	__property Size;
	__property Reference;
public:
	/* TCUDAUniform.Create */ inline __fastcall virtual TCUDAConstant(System::Classes::TComponent* AOwner) : TCUDAUniform(AOwner) { }
	/* TCUDAUniform.Destroy */ inline __fastcall virtual ~TCUDAConstant() { }
	
};


class PASCALIMPLEMENTATION TCUDAFuncParam : public TCUDAUniform
{
	typedef TCUDAUniform inherited;
	
protected:
	virtual void __fastcall AllocateHandles();
	virtual void __fastcall DestroyHandles();
	
public:
	__fastcall virtual TCUDAFuncParam(System::Classes::TComponent* AOwner);
	
__published:
	__property KernelName = {default=0};
	__property DataType;
	__property CustomType = {default=0};
	__property Size;
	__property Reference;
public:
	/* TCUDAUniform.Destroy */ inline __fastcall virtual ~TCUDAFuncParam() { }
	
};


class PASCALIMPLEMENTATION TCUDAFunction : public TCUDAComponent
{
	typedef TCUDAComponent inherited;
	
private:
	System::UnicodeString FKernelName;
	Cuda::Import::PCUfunction FHandle;
	bool FAutoSync;
	Gxs::Cuda::Context::TCUDADimensions* FBlockShape;
	Gxs::Cuda::Context::TCUDADimensions* FGrid;
	int ParamOffset;
	bool FLaunching;
	System::Classes::TNotifyEvent FOnParameterSetup;
	void __fastcall SetBlockShape(Gxs::Cuda::Context::TCUDADimensions* const AShape);
	void __fastcall SetGrid(Gxs::Cuda::Context::TCUDADimensions* const AGrid);
	void __fastcall SetKernelName(const System::UnicodeString AName);
	Cuda::Import::PCUfunction __fastcall GetHandle();
	void __fastcall SetSharedMemorySize(int Value);
	int __fastcall GetSharedMemorySize();
	int __fastcall GetMaxThreadPerBlock();
	int __fastcall GetConstMemorySize();
	int __fastcall GetLocalMemorySize();
	int __fastcall GetNumRegisters();
	TCUDAFuncParam* __fastcall GetParameter(const System::UnicodeString AName);
	
protected:
	virtual void __fastcall AllocateHandles();
	virtual void __fastcall DestroyHandles();
	virtual bool __fastcall GetIsAllocated();
	
public:
	__fastcall virtual TCUDAFunction(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCUDAFunction();
	void __fastcall SetParam(int Value)/* overload */;
	void __fastcall SetParam(unsigned Value)/* overload */;
	void __fastcall SetParam(float Value)/* overload */;
	void __fastcall SetParam(const Stage::Vectortypes::TVector2i &Value)/* overload */;
	void __fastcall SetParam(const Stage::Vectortypes::TVector3i &Value)/* overload */;
	void __fastcall SetParam(const Stage::Vectortypes::TVector4i &Value)/* overload */;
	void __fastcall SetParam(const Stage::Vectortypes::TVector2f &Value)/* overload */;
	void __fastcall SetParam(const Stage::Vectortypes::TVector3f &Value)/* overload */;
	void __fastcall SetParam(const Stage::Vectortypes::TVector4f &Value)/* overload */;
	void __fastcall SetParam(TCUDAMemData* MemData)/* overload */;
	void __fastcall SetParam(TCUDATexture* TexRef)/* overload */;
	void __fastcall SetParam(void * Ptr)/* overload */;
	__property TCUDAFuncParam* Parameters[const System::UnicodeString AName] = {read=GetParameter};
	void __fastcall Launch(bool Grided = true);
	__property Cuda::Import::PCUfunction Handle = {read=GetHandle};
	__property int SharedMemorySize = {read=GetSharedMemorySize, write=SetSharedMemorySize, nodefault};
	__property int MaxThreadPerBlock = {read=GetMaxThreadPerBlock, nodefault};
	__property int ConstMemorySize = {read=GetConstMemorySize, nodefault};
	__property int LocalMemorySize = {read=GetLocalMemorySize, nodefault};
	__property int NumRegisters = {read=GetNumRegisters, nodefault};
	
__published:
	__property System::UnicodeString KernelName = {read=FKernelName, write=SetKernelName};
	__property bool AutoSync = {read=FAutoSync, write=FAutoSync, default=1};
	__property Gxs::Cuda::Context::TCUDADimensions* BlockShape = {read=FBlockShape, write=SetBlockShape};
	__property Gxs::Cuda::Context::TCUDADimensions* Grid = {read=FGrid, write=SetGrid};
	__property System::Classes::TNotifyEvent OnParameterSetup = {read=FOnParameterSetup, write=FOnParameterSetup};
};


class PASCALIMPLEMENTATION TCUDATexture : public TCUDAComponent
{
	typedef TCUDAComponent inherited;
	
private:
	System::UnicodeString FKernelName;
	Cuda::Import::PCUtexref FHandle;
	TCUDAMemData* fArray;
	TCuAddresMode fAddressModeS;
	TCuAddresMode fAddressModeT;
	TCuAddresMode fAddressModeR;
	bool fNormalizedCoord;
	bool fReadAsInteger;
	TCuFilterMode fFilterMode;
	TCUDAChannelType fFormat;
	TCUDAChannelNum fChannelNum;
	void __fastcall SetKernelName(const System::UnicodeString AName);
	void __fastcall SetAddressModeS(const TCuAddresMode AMode);
	void __fastcall SetAddressModeT(const TCuAddresMode AMode);
	void __fastcall SetAddressModeR(const TCuAddresMode AMode);
	void __fastcall SetNormalizedCoord(const bool flag);
	void __fastcall SetReadAsInteger(const bool flag);
	void __fastcall SetFilterMode(const TCuFilterMode mode);
	void __fastcall SetFormat(TCUDAChannelType AValue);
	void __fastcall SetChannelNum(TCUDAChannelNum AValue);
	void __fastcall SetArray(TCUDAMemData* Value);
	Cuda::Import::PCUtexref __fastcall GetHandle();
	
protected:
	virtual void __fastcall AllocateHandles();
	virtual void __fastcall DestroyHandles();
	virtual bool __fastcall GetIsAllocated();
	
public:
	__fastcall virtual TCUDATexture(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCUDATexture();
	__property Cuda::Import::PCUtexref Handle = {read=GetHandle};
	
__published:
	__property System::UnicodeString KernelName = {read=FKernelName, write=SetKernelName};
	__property TCuAddresMode AddressModeS = {read=fAddressModeS, write=SetAddressModeS, default=1};
	__property TCuAddresMode AddressModeT = {read=fAddressModeT, write=SetAddressModeT, default=1};
	__property TCuAddresMode AddressModeR = {read=fAddressModeR, write=SetAddressModeR, default=1};
	__property bool NormalizedCoord = {read=fNormalizedCoord, write=SetNormalizedCoord, default=1};
	__property bool ReadAsInteger = {read=fReadAsInteger, write=SetReadAsInteger, default=0};
	__property TCuFilterMode FilterMode = {read=fFilterMode, write=SetFilterMode, default=0};
	__property TCUDAChannelType Format = {read=fFormat, write=SetFormat, nodefault};
	__property TCUDAChannelNum ChannelNum = {read=fChannelNum, write=SetChannelNum, nodefault};
	__property TCUDAMemData* MemDataArray = {read=fArray, write=SetArray};
};


class PASCALIMPLEMENTATION TgxSCUDA : public TCUDAComponent
{
	typedef TCUDAComponent inherited;
	
private:
	Gxs::Cuda::Context::TgxSCUDADevice* fDevice;
	Gxs::Cuda::Context::TCUDAContext* fContext;
	Gxs::Cuda::Context::TOnOpenGLInteropInit FOnOpenGLInteropInit;
	void __fastcall SetDevice(Gxs::Cuda::Context::TgxSCUDADevice* const Value);
	void __fastcall SetOnOpenGLInteropInit(Gxs::Cuda::Context::TOnOpenGLInteropInit AEvent);
	TCUDAModule* __fastcall GetModule(const int i);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual Gxs::Cuda::Context::TCUDAContext* __fastcall GetContext();
	virtual bool __fastcall GetIsAllocated();
	
public:
	__fastcall virtual TgxSCUDA(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TgxSCUDA();
	__property Gxs::Cuda::Context::TCUDAContext* Context = {read=GetContext};
	__property TCUDAModule* Modules[const int i] = {read=GetModule};
	
__published:
	__property Gxs::Cuda::Context::TgxSCUDADevice* ComputingDevice = {read=fDevice, write=SetDevice};
	__property Gxs::Cuda::Context::TOnOpenGLInteropInit OnOpenGLInteropInit = {read=FOnOpenGLInteropInit, write=SetOnOpenGLInteropInit};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TChannelTypeAndNum __fastcall GetChannelTypeAndNum(Cuda::Parser::TCUDAType AType);
extern DELPHI_PACKAGE void __fastcall RegisterCUDAComponentNameChangeEvent(System::Classes::TNotifyEvent ANotifyEvent);
extern DELPHI_PACKAGE void __fastcall DeRegisterCUDAComponentNameChangeEvent(void);
}	/* namespace Api */
}	/* namespace Cuda */
}	/* namespace Gxs */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GXS_CUDA_API)
using namespace Gxs::Cuda::Api;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GXS_CUDA)
using namespace Gxs::Cuda;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GXS)
using namespace Gxs;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GXS_CUDA_APIHPP
