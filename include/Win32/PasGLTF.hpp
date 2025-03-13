﻿// CodeGear C++Builder
// Copyright (c) 1995, 2024 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'PasGLTF.pas' rev: 36.00 (Windows)

#ifndef PasGLTFHPP
#define PasGLTFHPP

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
#include <PasJSON.hpp>

//-- user supplied -----------------------------------------------------------

namespace Pasgltf
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS EPasGLTF;
class DELPHICLASS EPasGLTFInvalidDocument;
class DELPHICLASS EPasGLTFInvalidBase64;
template<typename T> class DELPHICLASS TPasGLTFTypedSort__1;
template<typename T> class DELPHICLASS TPasGLTFDynamicArray__1;
template<typename T> class DELPHICLASS TPasGLTFObjectList__1;
template<typename TPasGLTFHashMapValue> class DELPHICLASS TPasGLTFUTF8StringHashMap__1;
class DELPHICLASS TPasGLTF;
//-- type declarations -------------------------------------------------------
typedef System::Int8 *PPasGLTFInt8;

typedef PPasGLTFInt8 *PPPasGLTFInt8;

typedef System::Int8 TPasGLTFInt8;

typedef System::Byte *PPasGLTFUInt8;

typedef PPasGLTFUInt8 *PPPasGLTFUInt8;

typedef System::Byte TPasGLTFUInt8;

typedef System::StaticArray<System::Byte, 65536> TPasGLTFUInt8Array;

typedef TPasGLTFUInt8Array *PPasGLTFUInt8Array;

typedef PPasGLTFUInt8Array *PPPasGLTFUInt8Array;

typedef System::DynamicArray<System::Byte> TPasGLTFUInt8DynamicArray;

typedef short *PPasGLTFInt16;

typedef PPasGLTFInt16 *PPPasGLTFInt16;

typedef short TPasGLTFInt16;

typedef System::Word *PPasGLTFUInt16;

typedef PPasGLTFUInt16 *PPPasGLTFUInt16;

typedef System::Word TPasGLTFUInt16;

typedef int *PPasGLTFInt32;

typedef PPasGLTFInt32 *PPPasGLTFInt32;

typedef System::LongInt TPasGLTFInt32;

typedef System::DynamicArray<int> TPasGLTFInt32DynamicArray;

typedef unsigned *PPasGLTFUInt32;

typedef PPasGLTFUInt32 *PPPasGLTFUInt32;

typedef System::LongWord TPasGLTFUInt32;

typedef System::StaticArray<unsigned, 65536> TPasGLTFUInt32Array;

typedef TPasGLTFUInt32Array *PPasGLTFUInt32Array;

typedef PPasGLTFUInt32Array *PPPasGLTFUInt32Array;

typedef System::DynamicArray<unsigned> TPasGLTFUInt32DynamicArray;

typedef __int64 *PPasGLTFInt64;

typedef PPasGLTFInt64 *PPPasGLTFInt64;

typedef __int64 TPasGLTFInt64;

typedef System::DynamicArray<__int64> TPasGLTFInt64DynamicArray;

typedef unsigned __int64 *PPasGLTFUInt64;

typedef PPasGLTFUInt64 *PPPasGLTFUInt64;

typedef unsigned __int64 TPasGLTFUInt64;

typedef System::DynamicArray<unsigned __int64> TPasGLTFUInt64DynamicArray;

typedef char * *PPPasGLTFChar;

typedef char * PPasGLTFChar;

typedef char TPasGLTFChar;

typedef char * *PPPasGLTFRawByteChar;

typedef char * PPasGLTFRawByteChar;

typedef char TPasGLTFRawByteChar;

typedef System::WideChar * *PPPasGLTFUTF16Char;

typedef System::WideChar * PPasGLTFUTF16Char;

typedef System::WideChar TPasGLTFUTF16Char;

typedef void * *PPasGLTFPointer;

typedef PPasGLTFPointer *PPPasGLTFPointer;

typedef void * TPasGLTFPointer;

typedef System::StaticArray<void *, 65536> TPasGLTFPointers;

typedef TPasGLTFPointers *PPasGLTFPointers;

typedef PPasGLTFPointers *PPPasGLTFPointers;

typedef void * *PPPasGLTFVoid;

typedef TPasGLTFPointer PPasGLTFVoid;

typedef float *PPasGLTFFloat;

typedef PPasGLTFFloat *PPPasGLTFFloat;

typedef float TPasGLTFFloat;

typedef System::DynamicArray<float> TPasGLTFFloatDynamicArray;

typedef double *PPasGLTFDouble;

typedef PPasGLTFDouble *PPPasGLTFDouble;

typedef double TPasGLTFDouble;

typedef System::DynamicArray<double> TPasGLTFDoubleDynamicArray;

typedef unsigned *PPasGLTFPtrUInt;

typedef PPasGLTFPtrUInt *PPPasGLTFPtrUInt;

typedef int *PPasGLTFPtrInt;

typedef PPasGLTFPtrInt *PPPasGLTFPtrInt;

typedef System::NativeUInt TPasGLTFPtrUInt;

typedef System::NativeInt TPasGLTFPtrInt;

typedef unsigned *PPasGLTFSizeUInt;

typedef PPasGLTFSizeUInt *PPPasGLTFSizeUInt;

typedef TPasGLTFPtrUInt TPasGLTFSizeUInt;

typedef System::DynamicArray<unsigned> TPasGLTFSizeUIntDynamicArray;

typedef int *PPasGLTFSizeInt;

typedef PPasGLTFSizeInt *PPPasGLTFSizeInt;

typedef TPasGLTFPtrInt TPasGLTFSizeInt;

typedef System::DynamicArray<int> TPasGLTFSizeIntDynamicArray;

typedef unsigned *PPasGLTFNativeUInt;

typedef PPasGLTFNativeUInt *PPPasGLTFNativeUInt;

typedef TPasGLTFPtrUInt TPasGLTFNativeUInt;

typedef int *PPasGLTFNativeInt;

typedef PPasGLTFNativeInt *PPPasGLTFNativeInt;

typedef TPasGLTFPtrInt TPasGLTFNativeInt;

typedef PPasGLTFSizeUInt *PPPasGLTFSize;

typedef unsigned *PPasGLTFSize;

typedef TPasGLTFPtrUInt TPasGLTFSize;

typedef int *PPasGLTFPtrDiff;

typedef PPasGLTFPtrDiff *PPPasGLTFPtrDiff;

typedef TPasGLTFPtrInt TPasGLTFPtrDiff;

typedef System::RawByteString *PPasGLTFRawByteString;

typedef PPasGLTFRawByteString *PPPasGLTFRawByteString;

typedef System::RawByteString TPasGLTFRawByteString;

typedef System::UTF8String *PPasGLTFUTF8String;

typedef PPasGLTFUTF8String *PPPasGLTFUTF8String;

typedef System::UTF8String TPasGLTFUTF8String;

typedef System::UnicodeString *PPasGLTFUTF16String;

typedef PPasGLTFUTF16String *PPPasGLTFUTF16String;

typedef System::UnicodeString TPasGLTFUTF16String;

#pragma pack(push,4)
class PASCALIMPLEMENTATION EPasGLTF : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EPasGLTF(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EPasGLTF(const System::UnicodeString Msg, const System::TVarRec *Args, const System::NativeInt Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EPasGLTF(System::NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EPasGLTF(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EPasGLTF(System::NativeUInt Ident, const System::TVarRec *Args, const System::NativeInt Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EPasGLTF(System::PResStringRec ResStringRec, const System::TVarRec *Args, const System::NativeInt Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EPasGLTF(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EPasGLTF(const System::UnicodeString Msg, const System::TVarRec *Args, const System::NativeInt Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EPasGLTF(System::NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EPasGLTF(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EPasGLTF(System::PResStringRec ResStringRec, const System::TVarRec *Args, const System::NativeInt Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EPasGLTF(System::NativeUInt Ident, const System::TVarRec *Args, const System::NativeInt Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EPasGLTF() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION EPasGLTFInvalidDocument : public EPasGLTF
{
	typedef EPasGLTF inherited;
	
public:
	/* Exception.Create */ inline __fastcall EPasGLTFInvalidDocument(const System::UnicodeString Msg) : EPasGLTF(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EPasGLTFInvalidDocument(const System::UnicodeString Msg, const System::TVarRec *Args, const System::NativeInt Args_High) : EPasGLTF(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EPasGLTFInvalidDocument(System::NativeUInt Ident)/* overload */ : EPasGLTF(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EPasGLTFInvalidDocument(System::PResStringRec ResStringRec)/* overload */ : EPasGLTF(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EPasGLTFInvalidDocument(System::NativeUInt Ident, const System::TVarRec *Args, const System::NativeInt Args_High)/* overload */ : EPasGLTF(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EPasGLTFInvalidDocument(System::PResStringRec ResStringRec, const System::TVarRec *Args, const System::NativeInt Args_High)/* overload */ : EPasGLTF(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EPasGLTFInvalidDocument(const System::UnicodeString Msg, int AHelpContext) : EPasGLTF(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EPasGLTFInvalidDocument(const System::UnicodeString Msg, const System::TVarRec *Args, const System::NativeInt Args_High, int AHelpContext) : EPasGLTF(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EPasGLTFInvalidDocument(System::NativeUInt Ident, int AHelpContext)/* overload */ : EPasGLTF(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EPasGLTFInvalidDocument(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : EPasGLTF(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EPasGLTFInvalidDocument(System::PResStringRec ResStringRec, const System::TVarRec *Args, const System::NativeInt Args_High, int AHelpContext)/* overload */ : EPasGLTF(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EPasGLTFInvalidDocument(System::NativeUInt Ident, const System::TVarRec *Args, const System::NativeInt Args_High, int AHelpContext)/* overload */ : EPasGLTF(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EPasGLTFInvalidDocument() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION EPasGLTFInvalidBase64 : public EPasGLTF
{
	typedef EPasGLTF inherited;
	
public:
	/* Exception.Create */ inline __fastcall EPasGLTFInvalidBase64(const System::UnicodeString Msg) : EPasGLTF(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EPasGLTFInvalidBase64(const System::UnicodeString Msg, const System::TVarRec *Args, const System::NativeInt Args_High) : EPasGLTF(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EPasGLTFInvalidBase64(System::NativeUInt Ident)/* overload */ : EPasGLTF(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EPasGLTFInvalidBase64(System::PResStringRec ResStringRec)/* overload */ : EPasGLTF(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EPasGLTFInvalidBase64(System::NativeUInt Ident, const System::TVarRec *Args, const System::NativeInt Args_High)/* overload */ : EPasGLTF(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EPasGLTFInvalidBase64(System::PResStringRec ResStringRec, const System::TVarRec *Args, const System::NativeInt Args_High)/* overload */ : EPasGLTF(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EPasGLTFInvalidBase64(const System::UnicodeString Msg, int AHelpContext) : EPasGLTF(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EPasGLTFInvalidBase64(const System::UnicodeString Msg, const System::TVarRec *Args, const System::NativeInt Args_High, int AHelpContext) : EPasGLTF(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EPasGLTFInvalidBase64(System::NativeUInt Ident, int AHelpContext)/* overload */ : EPasGLTF(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EPasGLTFInvalidBase64(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : EPasGLTF(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EPasGLTFInvalidBase64(System::PResStringRec ResStringRec, const System::TVarRec *Args, const System::NativeInt Args_High, int AHelpContext)/* overload */ : EPasGLTF(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EPasGLTFInvalidBase64(System::NativeUInt Ident, const System::TVarRec *Args, const System::NativeInt Args_High, int AHelpContext)/* overload */ : EPasGLTF(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EPasGLTFInvalidBase64() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
// Template declaration generated by Delphi parameterized types is
// used only for accessing Delphi variables and fields.
// Don't instantiate with new type parameters in user code.
template<typename T> class PASCALIMPLEMENTATION TPasGLTFTypedSort__1 : public System::TObject
{
	typedef System::TObject inherited;
	
	
private:
	#pragma pack(push,8)
	// Template declaration generated by Delphi parameterized types is
	// used only for accessing Delphi variables and fields.
	// Don't instantiate with new type parameters in user code.
	struct DECLSPEC_DRECORD TStackItem
	{
	public:
		TPasGLTFSizeInt Left;
		TPasGLTFSizeInt Right;
		TPasGLTFInt32 Depth;
	};
	#pragma pack(pop)
	
	
	typedef TStackItem *PStackItem;
	
	
public:
	/* [Template Alias] */
	#if defined(__clang__)
	using TPasGLTFTypedSortCompareFunction = int __fastcall (*)(const T a, const T b);
	#endif
	
	
private:
	static TPasGLTFInt32 __fastcall BSRDWord(TPasGLTFUInt32 aValue);
	
public:
	typedef int __fastcall (*_dt_Pasgltf_1)(const T a, const T b);
	static void __fastcall IntroSort(const TPasGLTFPointer pItems, const TPasGLTFSizeInt pLeft, const TPasGLTFSizeInt pRight, const _dt_Pasgltf_1 pCompareFunc);
public:
	/* TObject.Create */ inline __fastcall TPasGLTFTypedSort__1() : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TPasGLTFTypedSort__1() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
// Template declaration generated by Delphi parameterized types is
// used only for accessing Delphi variables and fields.
// Don't instantiate with new type parameters in user code.
template<typename T> class PASCALIMPLEMENTATION TPasGLTFDynamicArray__1 : public System::TObject
{
	typedef System::TObject inherited;
	
	
private:
	#pragma pack(push,8)
	// Template declaration generated by Delphi parameterized types is
	// used only for accessing Delphi variables and fields.
	// Don't instantiate with new type parameters in user code.
	struct DECLSPEC_DRECORD TValueEnumerator
	{
	private:
		TPasGLTFDynamicArray__1<T>* fDynamicArray;
		TPasGLTFSizeInt fIndex;
		T __fastcall GetCurrent();
		
	public:
		__fastcall TValueEnumerator(TPasGLTFDynamicArray__1<T>* const aDynamicArray);
		bool __fastcall MoveNext();
		__property T Current = {read=GetCurrent};
		TValueEnumerator() {}
	};
	#pragma pack(pop)
	
	
	
public:
	typedef System::DynamicArray<T> _1;
	
	
public:
	T operator[](const TPasGLTFSizeInt pIndex) { return this->Items[pIndex]; }
	
private:
	System::DynamicArray<T> fItems;
	TPasGLTFSizeInt fCount;
	TPasGLTFSizeInt fAllocated;
	void __fastcall SetCount(const TPasGLTFSizeInt pNewCount);
	T __fastcall GetItem(const TPasGLTFSizeInt pIndex);
	void __fastcall SetItem(const TPasGLTFSizeInt pIndex, const T pItem);
	
public:
	__fastcall TPasGLTFDynamicArray__1();
	__fastcall virtual ~TPasGLTFDynamicArray__1();
	void __fastcall Clear();
	TPasGLTFSizeInt __fastcall Add(const T pItem)/* overload */;
	TPasGLTFSizeInt __fastcall Add(const T *pItems, const System::NativeInt pItems_High)/* overload */;
	void __fastcall Insert(const TPasGLTFSizeInt pIndex, const T pItem);
	void __fastcall Delete(const TPasGLTFSizeInt pIndex);
	void __fastcall Exchange(const TPasGLTFSizeInt pIndex, const TPasGLTFSizeInt pWithIndex);
	TValueEnumerator __fastcall GetEnumerator();
	TPasGLTFPointer __fastcall Memory();
	__property TPasGLTFSizeInt Count = {read=fCount, write=SetCount, nodefault};
	__property TPasGLTFSizeInt Allocated = {read=fAllocated, nodefault};
	__property T Items[const TPasGLTFSizeInt pIndex] = {read=GetItem, write=SetItem/*, default*/};
};

#pragma pack(pop)

#pragma pack(push,4)
// Template declaration generated by Delphi parameterized types is
// used only for accessing Delphi variables and fields.
// Don't instantiate with new type parameters in user code.
template<typename T> class PASCALIMPLEMENTATION TPasGLTFObjectList__1 : public System::TObject
{
	typedef System::TObject inherited;
	
	
private:
	#pragma pack(push,8)
	// Template declaration generated by Delphi parameterized types is
	// used only for accessing Delphi variables and fields.
	// Don't instantiate with new type parameters in user code.
	struct DECLSPEC_DRECORD TValueEnumerator
	{
	private:
		TPasGLTFObjectList__1<T>* fObjectList;
		TPasGLTFSizeInt fIndex;
		T __fastcall GetCurrent();
		
	public:
		__fastcall TValueEnumerator(TPasGLTFObjectList__1<T>* const aObjectList);
		bool __fastcall MoveNext();
		__property T Current = {read=GetCurrent};
		TValueEnumerator() {}
	};
	#pragma pack(pop)
	
	
	
public:
	typedef System::DynamicArray<T> _1;
	
	
public:
	T operator[](const TPasGLTFSizeInt pIndex) { return this->Items[pIndex]; }
	
private:
	System::DynamicArray<T> fItems;
	TPasGLTFSizeInt fCount;
	TPasGLTFSizeInt fAllocated;
	bool fOwnsObjects;
	TPasGLTFSizeUInt __fastcall RoundUpToPowerOfTwoSizeUInt(TPasGLTFSizeUInt x);
	void __fastcall SetCount(const TPasGLTFSizeInt pNewCount);
	T __fastcall GetItem(const TPasGLTFSizeInt pIndex);
	void __fastcall SetItem(const TPasGLTFSizeInt pIndex, const T pItem);
	
public:
	__fastcall TPasGLTFObjectList__1();
	__fastcall virtual ~TPasGLTFObjectList__1();
	void __fastcall Clear();
	TPasGLTFSizeInt __fastcall IndexOf(const T pItem);
	TPasGLTFSizeInt __fastcall Add(const T pItem);
	void __fastcall Insert(const TPasGLTFSizeInt pIndex, const T pItem);
	void __fastcall Delete(const TPasGLTFSizeInt pIndex);
	void __fastcall Remove(const T pItem);
	void __fastcall Exchange(const TPasGLTFSizeInt pIndex, const TPasGLTFSizeInt pWithIndex);
	TValueEnumerator __fastcall GetEnumerator();
	__property TPasGLTFSizeInt Count = {read=fCount, write=SetCount, nodefault};
	__property TPasGLTFSizeInt Allocated = {read=fAllocated, nodefault};
	__property T Items[const TPasGLTFSizeInt pIndex] = {read=GetItem, write=SetItem/*, default*/};
	__property bool OwnsObjects = {read=fOwnsObjects, write=fOwnsObjects, nodefault};
};

#pragma pack(pop)

typedef System::DynamicArray<int> TPasGLTFHashMapEntityIndices;

typedef System::StaticArray<unsigned __int64, 2> TPasGLTFHashMapUInt128;

#pragma pack(push,4)
// Template declaration generated by Delphi parameterized types is
// used only for accessing Delphi variables and fields.
// Don't instantiate with new type parameters in user code.
template<typename TPasGLTFHashMapValue> class PASCALIMPLEMENTATION TPasGLTFUTF8StringHashMap__1 : public System::TObject
{
	typedef System::TObject inherited;
	
	
public:
	typedef System::UTF8String TPasGLTFHashMapKey;
	typedef TPasGLTFHashMapEntity *PPasGLTFHashMapEntity;
	
	#pragma pack(push,8)
	// Template declaration generated by Delphi parameterized types is
	// used only for accessing Delphi variables and fields.
	// Don't instantiate with new type parameters in user code.
	struct DECLSPEC_DRECORD TPasGLTFHashMapEntity
	{
	public:
		System::UTF8String Key;
		TPasGLTFHashMapValue Value;
	};
	#pragma pack(pop)
	
	
	typedef System::DynamicArray<TPasGLTFHashMapEntity> TPasGLTFHashMapEntities;
	
	
private:
	#pragma pack(push,8)
	// Template declaration generated by Delphi parameterized types is
	// used only for accessing Delphi variables and fields.
	// Don't instantiate with new type parameters in user code.
	struct DECLSPEC_DRECORD TPasGLTFHashMapEntityEnumerator
	{
	private:
		TPasGLTFUTF8StringHashMap__1<TPasGLTFHashMapValue>* fHashMap;
		TPasGLTFSizeInt fIndex;
		typename TPasGLTFUTF8StringHashMap__1<TPasGLTFHashMapValue>::TPasGLTFHashMapEntity __fastcall GetCurrent();
		
	public:
		__fastcall TPasGLTFHashMapEntityEnumerator(TPasGLTFUTF8StringHashMap__1<TPasGLTFHashMapValue>* const aHashMap);
		bool __fastcall MoveNext();
		__property typename TPasGLTFUTF8StringHashMap__1<TPasGLTFHashMapValue>::TPasGLTFHashMapEntity Current = {read=GetCurrent};
		TPasGLTFHashMapEntityEnumerator() {}
	};
	#pragma pack(pop)
	
	
	#pragma pack(push,8)
	// Template declaration generated by Delphi parameterized types is
	// used only for accessing Delphi variables and fields.
	// Don't instantiate with new type parameters in user code.
	struct DECLSPEC_DRECORD TPasGLTFHashMapKeyEnumerator
	{
	private:
		TPasGLTFUTF8StringHashMap__1<TPasGLTFHashMapValue>* fHashMap;
		TPasGLTFSizeInt fIndex;
		System::UTF8String __fastcall GetCurrent();
		
	public:
		__fastcall TPasGLTFHashMapKeyEnumerator(TPasGLTFUTF8StringHashMap__1<TPasGLTFHashMapValue>* const aHashMap);
		bool __fastcall MoveNext();
		__property System::UTF8String Current = {read=GetCurrent};
		TPasGLTFHashMapKeyEnumerator() {}
	};
	#pragma pack(pop)
	
	
	#pragma pack(push,8)
	// Template declaration generated by Delphi parameterized types is
	// used only for accessing Delphi variables and fields.
	// Don't instantiate with new type parameters in user code.
	struct DECLSPEC_DRECORD TPasGLTFHashMapValueEnumerator
	{
	private:
		TPasGLTFUTF8StringHashMap__1<TPasGLTFHashMapValue>* fHashMap;
		TPasGLTFSizeInt fIndex;
		TPasGLTFHashMapValue __fastcall GetCurrent();
		
	public:
		__fastcall TPasGLTFHashMapValueEnumerator(TPasGLTFUTF8StringHashMap__1<TPasGLTFHashMapValue>* const aHashMap);
		bool __fastcall MoveNext();
		__property TPasGLTFHashMapValue Current = {read=GetCurrent};
		TPasGLTFHashMapValueEnumerator() {}
	};
	#pragma pack(pop)
	
	
	class DELPHICLASS TPasGLTFHashMapEntitiesObject;
	// Template declaration generated by Delphi parameterized types is
	// used only for accessing Delphi variables and fields.
	// Don't instantiate with new type parameters in user code.
	class PASCALIMPLEMENTATION TPasGLTFHashMapEntitiesObject : public System::TObject
	{
		typedef System::TObject inherited;
		
	private:
		TPasGLTFUTF8StringHashMap__1<TPasGLTFHashMapValue>* fOwner;
		
	public:
		__fastcall TPasGLTFHashMapEntitiesObject(TPasGLTFUTF8StringHashMap__1<TPasGLTFHashMapValue>* const aOwner);
		typename TPasGLTFUTF8StringHashMap__1<TPasGLTFHashMapValue>::TPasGLTFHashMapEntityEnumerator __fastcall GetEnumerator();
	public:
		/* TObject.Destroy */ inline __fastcall virtual ~TPasGLTFHashMapEntitiesObject() { }
		
	};
	
	
	class DELPHICLASS TPasGLTFHashMapKeysObject;
	// Template declaration generated by Delphi parameterized types is
	// used only for accessing Delphi variables and fields.
	// Don't instantiate with new type parameters in user code.
	class PASCALIMPLEMENTATION TPasGLTFHashMapKeysObject : public System::TObject
	{
		typedef System::TObject inherited;
		
	private:
		TPasGLTFUTF8StringHashMap__1<TPasGLTFHashMapValue>* fOwner;
		
	public:
		__fastcall TPasGLTFHashMapKeysObject(TPasGLTFUTF8StringHashMap__1<TPasGLTFHashMapValue>* const aOwner);
		typename TPasGLTFUTF8StringHashMap__1<TPasGLTFHashMapValue>::TPasGLTFHashMapKeyEnumerator __fastcall GetEnumerator();
	public:
		/* TObject.Destroy */ inline __fastcall virtual ~TPasGLTFHashMapKeysObject() { }
		
	};
	
	
	class DELPHICLASS TPasGLTFHashMapValuesObject;
	// Template declaration generated by Delphi parameterized types is
	// used only for accessing Delphi variables and fields.
	// Don't instantiate with new type parameters in user code.
	class PASCALIMPLEMENTATION TPasGLTFHashMapValuesObject : public System::TObject
	{
		typedef System::TObject inherited;
		
public:
		TPasGLTFHashMapValue operator[](const System::UTF8String Key) { return this->Values[Key]; }
		
	private:
		TPasGLTFUTF8StringHashMap__1<TPasGLTFHashMapValue>* fOwner;
		TPasGLTFHashMapValue __fastcall GetValue(const System::UTF8String Key);
		void __fastcall SetValue(const System::UTF8String Key, const TPasGLTFHashMapValue aValue);
		
	public:
		__fastcall TPasGLTFHashMapValuesObject(TPasGLTFUTF8StringHashMap__1<TPasGLTFHashMapValue>* const aOwner);
		typename TPasGLTFUTF8StringHashMap__1<TPasGLTFHashMapValue>::TPasGLTFHashMapValueEnumerator __fastcall GetEnumerator();
		__property TPasGLTFHashMapValue Values[const System::UTF8String Key] = {read=GetValue, write=SetValue/*, default*/};
	public:
		/* TObject.Destroy */ inline __fastcall virtual ~TPasGLTFHashMapValuesObject() { }
		
	};
	
	
	
public:
	TPasGLTFHashMapValue operator[](const System::UTF8String Key) { return this->EntityValues[Key]; }
	
public:
	static _DELPHI_CONST System::Int8 CELL_EMPTY = System::Int8(-1);
	
	static _DELPHI_CONST System::Int8 CELL_DELETED = System::Int8(-2);
	
	static _DELPHI_CONST System::Int8 ENT_EMPTY = System::Int8(-1);
	
	static _DELPHI_CONST System::Int8 ENT_DELETED = System::Int8(-2);
	
	
private:
	TPasGLTFInt32 fRealSize;
	TPasGLTFInt32 fLogSize;
	TPasGLTFInt32 fSize;
	System::DynamicArray<TPasGLTFHashMapEntity> fEntities;
	TPasGLTFHashMapEntityIndices fEntityToCellIndex;
	TPasGLTFHashMapEntityIndices fCellToEntityIndex;
	TPasGLTFHashMapValue fDefaultValue;
	bool fCanShrink;
	TPasGLTFHashMapEntitiesObject* fEntitiesObject;
	TPasGLTFHashMapKeysObject* fKeysObject;
	TPasGLTFHashMapValuesObject* fValuesObject;
	TPasGLTFUInt32 __fastcall HashData(const TPasGLTFPointer Data, const TPasGLTFSizeUInt DataLength);
	TPasGLTFUInt32 __fastcall HashKey(const System::UTF8String Key);
	bool __fastcall CompareKey(const System::UTF8String KeyA, const System::UTF8String KeyB);
	TPasGLTFUInt32 __fastcall FindCell(const System::UTF8String Key);
	void __fastcall Resize();
	
protected:
	TPasGLTFHashMapValue __fastcall GetValue(const System::UTF8String Key);
	void __fastcall SetValue(const System::UTF8String Key, const TPasGLTFHashMapValue Value);
	
public:
	__fastcall TPasGLTFUTF8StringHashMap__1(const TPasGLTFHashMapValue DefaultValue);
	__fastcall virtual ~TPasGLTFUTF8StringHashMap__1();
	void __fastcall Clear();
	PPasGLTFHashMapEntity __fastcall Add(const System::UTF8String Key, const TPasGLTFHashMapValue Value);
	PPasGLTFHashMapEntity __fastcall Get(const System::UTF8String Key, const bool CreateIfNotExist = false);
	bool __fastcall TryGet(const System::UTF8String Key, /* out */ TPasGLTFHashMapValue &Value);
	bool __fastcall ExistKey(const System::UTF8String Key);
	bool __fastcall Delete(const System::UTF8String Key);
	__property TPasGLTFHashMapValue EntityValues[const System::UTF8String Key] = {read=GetValue, write=SetValue/*, default*/};
	__property TPasGLTFHashMapEntitiesObject* Entities = {read=fEntitiesObject};
	__property TPasGLTFHashMapKeysObject* Keys = {read=fKeysObject};
	__property TPasGLTFHashMapValuesObject* Values = {read=fValuesObject};
	__property bool CanShrink = {read=fCanShrink, write=fCanShrink, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TPasGLTF : public System::TObject
{
	typedef System::TObject inherited;
	
	
public:
	class DELPHICLASS TBase64;
	class PASCALIMPLEMENTATION TBase64 : public System::TObject
	{
		typedef System::TObject inherited;
		
	public:
		static System::StaticArray<char, 64> EncodingLookUpTable;
		static System::StaticArray<System::Int8, 256> DecodingLookUpTable;
		static TPasGLTFRawByteString __fastcall Encode(const void *aData, const TPasGLTFSizeInt aDataLength)/* overload */;
		static TPasGLTFRawByteString __fastcall Encode(const System::Byte *aData, const System::NativeInt aData_High)/* overload */;
		static TPasGLTFRawByteString __fastcall Encode(const TPasGLTFRawByteString aData)/* overload */;
		static TPasGLTFRawByteString __fastcall Encode(System::Classes::TStream* const aData)/* overload */;
		static bool __fastcall Decode(const TPasGLTFRawByteString aInput, System::Classes::TStream* const aOutput)/* overload */;
	public:
		/* TObject.Create */ inline __fastcall TBase64() : System::TObject() { }
		/* TObject.Destroy */ inline __fastcall virtual ~TBase64() { }
		
	};
	
	
	#pragma pack(push,1)
	struct DECLSPEC_DRECORD TChunkHeader
	{
	public:
		TPasGLTFUInt32 ChunkLength;
		TPasGLTFUInt32 ChunkType;
	};
	#pragma pack(pop)
	
	
	typedef TChunkHeader *PChunkHeader;
	
	#pragma pack(push,1)
	struct DECLSPEC_DRECORD TGLBHeader
	{
	public:
		TPasGLTFUInt32 Magic;
		TPasGLTFUInt32 Version;
		TPasGLTFUInt32 Length;
		TPasGLTF::TChunkHeader JSONChunkHeader;
	};
	#pragma pack(pop)
	
	
	typedef System::StaticArray<float, 2> TVector2;
	
	typedef TVector2 *PVector2;
	
	typedef System::DynamicArray<TVector2> TVector2DynamicArray;
	
	typedef System::StaticArray<float, 3> TVector3;
	
	typedef TVector3 *PVector3;
	
	typedef System::DynamicArray<TVector3> TVector3DynamicArray;
	
	typedef System::StaticArray<float, 4> TVector4;
	
	typedef TVector4 *PVector4;
	
	typedef System::DynamicArray<TVector4> TVector4DynamicArray;
	
	typedef System::StaticArray<int, 4> TInt32Vector4;
	
	typedef TInt32Vector4 *PInt32Vector4;
	
	typedef System::DynamicArray<TInt32Vector4> TInt32Vector4DynamicArray;
	
	typedef System::StaticArray<unsigned, 4> TUInt32Vector4;
	
	typedef TUInt32Vector4 *PUInt32Vector4;
	
	typedef System::DynamicArray<TUInt32Vector4> TUInt32Vector4DynamicArray;
	
	typedef System::StaticArray<float, 4> TMatrix2x2;
	
	typedef TMatrix2x2 *PMatrix2x2;
	
	typedef System::DynamicArray<TMatrix2x2> TMatrix2x2DynamicArray;
	
	typedef System::StaticArray<float, 10> TMatrix3x3;
	
	typedef TMatrix3x3 *PMatrix3x3;
	
	typedef System::DynamicArray<TMatrix3x3> TMatrix3x3DynamicArray;
	
	typedef System::StaticArray<float, 16> TMatrix4x4;
	
	typedef TMatrix4x4 *PMatrix4x4;
	
	typedef System::DynamicArray<TMatrix4x4> TMatrix4x4DynamicArray;
	
	class DELPHICLASS TDefaults;
	class PASCALIMPLEMENTATION TDefaults : public System::TObject
	{
		typedef System::TObject inherited;
		
	public:
		static _DELPHI_CONST bool AccessorNormalized = false;
		
		#define TPasGLTF_TDefaults_MaterialAlphaCutoff  (5.000000E-01)
		
		static _DELPHI_CONST bool MaterialDoubleSided = false;
		
		#define TPasGLTF_TDefaults_IdentityScalar  (1.000000E+00)
		
		#define TPasGLTF_TDefaults_FloatSentinel  (1.000000E+27)
		
		static TPasGLTF::TVector3 NullVector3;
		static TPasGLTF::TVector3 IdentityVector3;
		static TPasGLTF::TVector4 IdentityVector4;
		static TPasGLTF::TVector4 IdentityQuaternion;
		static TPasGLTF::TMatrix4x4 NullMatrix4x4;
		static TPasGLTF::TMatrix4x4 IdentityMatrix4x4;
	public:
		/* TObject.Create */ inline __fastcall TDefaults() : System::TObject() { }
		/* TObject.Destroy */ inline __fastcall virtual ~TDefaults() { }
		
	};
	
	
	class DELPHICLASS TDocument;
	class DELPHICLASS TBaseExtensionsExtrasObject;
	class DELPHICLASS TBaseObject;
	class PASCALIMPLEMENTATION TBaseObject : public System::TObject
	{
		typedef System::TObject inherited;
		
	private:
		TPasGLTF::TDocument* fDocument;
		
	public:
		__fastcall virtual TBaseObject(TPasGLTF::TDocument* const aDocument);
		__fastcall virtual ~TBaseObject();
	};
	
	
	class PASCALIMPLEMENTATION TBaseExtensionsExtrasObject : public TPasGLTF::TBaseObject
	{
		typedef TPasGLTF::TBaseObject inherited;
		
	private:
		Pasjson::TPasJSONItemObject* fExtensions;
		Pasjson::TPasJSONItemObject* fExtras;
		
	public:
		__fastcall virtual TBaseExtensionsExtrasObject(TPasGLTF::TDocument* const aDocument);
		__fastcall virtual ~TBaseExtensionsExtrasObject();
		
	__published:
		__property Pasjson::TPasJSONItemObject* Extensions = {read=fExtensions};
		__property Pasjson::TPasJSONItemObject* Extras = {read=fExtras};
	};
	
	
	class DELPHICLASS TAsset;
	class DELPHICLASS TAccessor;
	class DELPHICLASS TAnimation;
	class DELPHICLASS TBuffer;
	class DELPHICLASS TBufferView;
	class DELPHICLASS TCamera;
	class DELPHICLASS TImage;
	class DELPHICLASS TMaterial;
	class DELPHICLASS TMesh;
	class DELPHICLASS TNode;
	class DELPHICLASS TSampler;
	class DELPHICLASS TScene;
	class DELPHICLASS TSkin;
	class DELPHICLASS TTexture;
	#pragma pack(push,8)
	class PASCALIMPLEMENTATION TDocument : public TPasGLTF::TBaseExtensionsExtrasObject
	{
		typedef TPasGLTF::TBaseExtensionsExtrasObject inherited;
		
		
	public:
		typedef System::Classes::TStream* __fastcall (__closure *TGetURI)(const TPasGLTFUTF8String aURI);
		
		
	private:
		TPasGLTF::TAsset* fAsset;
		TAccessors* fAccessors;
		TAnimations* fAnimations;
		TBuffers* fBuffers;
		TBufferViews* fBufferViews;
		TCameras* fCameras;
		TImages* fImages;
		TMaterials* fMaterials;
		TMeshes* fMeshes;
		TNodes* fNodes;
		TSamplers* fSamplers;
		TPasGLTFSizeInt fScene;
		TScenes* fScenes;
		TSkins* fSkins;
		TTextures* fTextures;
		System::Classes::TStringList* fExtensionsUsed;
		System::Classes::TStringList* fExtensionsRequired;
		TPasGLTFUTF8String fRootPath;
		TGetURI fGetURI;
		System::Classes::TStream* __fastcall DefaultGetURI(const TPasGLTFUTF8String aURI);
		void __fastcall LoadURISource(const TPasGLTFUTF8String aURI, System::Classes::TStream* const aStream);
		void __fastcall LoadURISources();
		
	public:
		__fastcall virtual TDocument(TPasGLTF::TDocument* const aDocument);
		__fastcall virtual ~TDocument();
		void __fastcall LoadFromJSON(Pasjson::TPasJSONItem* const aJSONRootItem);
		void __fastcall LoadFromBinary(System::Classes::TStream* const aStream);
		void __fastcall LoadFromStream(System::Classes::TStream* const aStream);
		Pasjson::TPasJSONRawByteString __fastcall SaveToJSON(const bool aFormatted = false);
		void __fastcall SaveToBinary(System::Classes::TStream* const aStream);
		void __fastcall SaveToStream(System::Classes::TStream* const aStream, const bool aBinary = false, const bool aFormatted = false);
		
	__published:
		__property TPasGLTF::TAsset* Asset = {read=fAsset};
		__property TAccessors* Accessors = {read=fAccessors};
		__property TAnimations* Animations = {read=fAnimations};
		__property TBuffers* Buffers = {read=fBuffers};
		__property TBufferViews* BufferViews = {read=fBufferViews};
		__property TCameras* Cameras = {read=fCameras};
		__property TImages* Images = {read=fImages};
		__property TMaterials* Materials = {read=fMaterials};
		__property TMeshes* Meshes = {read=fMeshes};
		__property TNodes* Nodes = {read=fNodes};
		__property TSamplers* Samplers = {read=fSamplers};
		__property TPasGLTFSizeInt Scene = {read=fScene, write=fScene, nodefault};
		__property TScenes* Scenes = {read=fScenes};
		__property TSkins* Skins = {read=fSkins};
		__property TTextures* Textures = {read=fTextures};
		__property System::Classes::TStringList* ExtensionsUsed = {read=fExtensionsUsed};
		__property System::Classes::TStringList* ExtensionsRequired = {read=fExtensionsRequired};
		__property TPasGLTFUTF8String RootPath = {read=fRootPath, write=fRootPath};
		__property TGetURI GetURI = {read=fGetURI, write=fGetURI};
	};
	
	#pragma pack(pop)
	
	typedef TPasGLTFUTF8StringHashMap__1<int> TAttributes;
	typedef TPasGLTFObjectList__1<TPasGLTFUTF8StringHashMap__1<TPasGLTFSizeInt>*> TAttributesList;
	class PASCALIMPLEMENTATION TAccessor : public TPasGLTF::TBaseExtensionsExtrasObject
	{
		typedef TPasGLTF::TBaseExtensionsExtrasObject inherited;
		
		
	public:
		enum class DECLSPEC_DENUM TComponentType : unsigned short { None, SignedByte = 5120, UnsignedByte, SignedShort, UnsignedShort, UnsignedInt = 5125, Float };
		
		typedef TComponentType *PComponentType;
		
		struct TComponentTypeHelper /* Helper for enum 'TComponentType' */;
		typedef System::Word TRawComponentType;
		typedef System::Word *PRawComponentType;
		
		enum class DECLSPEC_DENUM TType : unsigned char { None, Scalar, Vec2, Vec3, Vec4, Mat2, Mat3, Mat4 };
		
		typedef TType *PType;
		
		struct TTypeHelper /* Helper for enum 'TType' */;
		typedef System::Byte TRawType;
		typedef System::Byte *PRawType;
		
		typedef TPasGLTFDynamicArray__1<float> TMinMaxDynamicArray;
		class DELPHICLASS TSparse;
		class PASCALIMPLEMENTATION TSparse : public TPasGLTF::TBaseExtensionsExtrasObject
		{
			typedef TPasGLTF::TBaseExtensionsExtrasObject inherited;
			
			
		public:
			class DELPHICLASS TIndices;
			class PASCALIMPLEMENTATION TIndices : public TPasGLTF::TBaseExtensionsExtrasObject
			{
				typedef TPasGLTF::TBaseExtensionsExtrasObject inherited;
				
			private:
				TPasGLTF::TAccessor::TComponentType fComponentType;
				TPasGLTFSizeInt fBufferView;
				TPasGLTFSizeUInt fByteOffset;
				bool fEmpty;
				
			public:
				__fastcall virtual TIndices(TPasGLTF::TDocument* const aDocument);
				__fastcall virtual ~TIndices();
				
			__published:
				__property TPasGLTF::TAccessor::TComponentType ComponentType = {read=fComponentType, write=fComponentType, default=0};
				__property TPasGLTFSizeInt BufferView = {read=fBufferView, write=fBufferView, default=0};
				__property TPasGLTFSizeUInt ByteOffset = {read=fByteOffset, write=fByteOffset, default=0};
				__property bool Empty = {read=fEmpty, write=fEmpty, nodefault};
			};
			
			
			class DELPHICLASS TValues;
			class PASCALIMPLEMENTATION TValues : public TPasGLTF::TBaseExtensionsExtrasObject
			{
				typedef TPasGLTF::TBaseExtensionsExtrasObject inherited;
				
			private:
				TPasGLTFSizeInt fBufferView;
				TPasGLTFSizeUInt fByteOffset;
				bool fEmpty;
				
			public:
				__fastcall virtual TValues(TPasGLTF::TDocument* const aDocument);
				__fastcall virtual ~TValues();
				
			__published:
				__property TPasGLTFSizeInt BufferView = {read=fBufferView, write=fBufferView, default=0};
				__property TPasGLTFSizeUInt ByteOffset = {read=fByteOffset, write=fByteOffset, default=0};
				__property bool Empty = {read=fEmpty, write=fEmpty, nodefault};
			};
			
			
			
		private:
			TPasGLTFSizeInt fCount;
			TIndices* fIndices;
			TValues* fValues;
			bool __fastcall GetEmpty();
			
		public:
			__fastcall virtual TSparse(TPasGLTF::TDocument* const aDocument);
			__fastcall virtual ~TSparse();
			
		__published:
			__property TPasGLTFSizeInt Count = {read=fCount, write=fCount, default=0};
			__property TIndices* Indices = {read=fIndices};
			__property TValues* Values = {read=fValues};
			__property bool Empty = {read=GetEmpty, nodefault};
		};
		
		
		
	public:
		static System::StaticArray<int, 8> TypeComponentCountTable;
		
	private:
		TPasGLTFUTF8String fName;
		TComponentType fComponentType;
		TType fType;
		TPasGLTFSizeInt fBufferView;
		TPasGLTFSizeUInt fByteOffset;
		TPasGLTFSizeUInt fCount;
		bool fNormalized;
		TMinMaxDynamicArray* fMinArray;
		TMinMaxDynamicArray* fMaxArray;
		TSparse* fSparse;
		
	public:
		__fastcall virtual TAccessor(TPasGLTF::TDocument* const aDocument);
		__fastcall virtual ~TAccessor();
		TPasGLTFDoubleDynamicArray __fastcall DecodeAsDoubleArray(const bool aForVertex = true);
		TPasGLTFInt32DynamicArray __fastcall DecodeAsInt32Array(const bool aForVertex = true);
		TPasGLTFUInt32DynamicArray __fastcall DecodeAsUInt32Array(const bool aForVertex = true);
		TPasGLTFInt64DynamicArray __fastcall DecodeAsInt64Array(const bool aForVertex = true);
		TPasGLTFUInt64DynamicArray __fastcall DecodeAsUInt64Array(const bool aForVertex = true);
		TPasGLTFFloatDynamicArray __fastcall DecodeAsFloatArray(const bool aForVertex = true);
		TPasGLTF::TVector2DynamicArray __fastcall DecodeAsVector2Array(const bool aForVertex = true);
		TPasGLTF::TVector3DynamicArray __fastcall DecodeAsVector3Array(const bool aForVertex = true);
		TPasGLTF::TVector4DynamicArray __fastcall DecodeAsVector4Array(const bool aForVertex = true);
		TPasGLTF::TInt32Vector4DynamicArray __fastcall DecodeAsInt32Vector4Array(const bool aForVertex = true);
		TPasGLTF::TUInt32Vector4DynamicArray __fastcall DecodeAsUInt32Vector4Array(const bool aForVertex = true);
		TPasGLTF::TVector4DynamicArray __fastcall DecodeAsColorArray(const bool aForVertex = true);
		TPasGLTF::TMatrix2x2DynamicArray __fastcall DecodeAsMatrix2x2Array(const bool aForVertex = true);
		TPasGLTF::TMatrix3x3DynamicArray __fastcall DecodeAsMatrix3x3Array(const bool aForVertex = true);
		TPasGLTF::TMatrix4x4DynamicArray __fastcall DecodeAsMatrix4x4Array(const bool aForVertex = true);
		
	__published:
		__property TComponentType ComponentType = {read=fComponentType, write=fComponentType, default=0};
		__property TType Type_ = {read=fType, write=fType, default=0};
		__property TPasGLTFSizeInt BufferView = {read=fBufferView, write=fBufferView, default=-1};
		__property TPasGLTFSizeUInt ByteOffset = {read=fByteOffset, write=fByteOffset, default=0};
		__property TPasGLTFSizeUInt Count = {read=fCount, write=fCount, default=0};
		__property TMinMaxDynamicArray* MinArray = {read=fMinArray};
		__property TMinMaxDynamicArray* MaxArray = {read=fMaxArray};
		__property bool Normalized = {read=fNormalized, write=fNormalized, default=0};
		__property TSparse* Sparse = {read=fSparse};
	};
	
	
	typedef TPasGLTFObjectList__1<TAccessor*> TAccessors;
	class PASCALIMPLEMENTATION TAnimation : public TPasGLTF::TBaseExtensionsExtrasObject
	{
		typedef TPasGLTF::TBaseExtensionsExtrasObject inherited;
		
		
	public:
		class DELPHICLASS TChannel;
		class PASCALIMPLEMENTATION TChannel : public TPasGLTF::TBaseExtensionsExtrasObject
		{
			typedef TPasGLTF::TBaseExtensionsExtrasObject inherited;
			
			
		public:
			class DELPHICLASS TTarget;
			class PASCALIMPLEMENTATION TTarget : public TPasGLTF::TBaseExtensionsExtrasObject
			{
				typedef TPasGLTF::TBaseExtensionsExtrasObject inherited;
				
			private:
				TPasGLTFSizeInt fNode;
				TPasGLTFUTF8String fPath;
				bool fEmpty;
				
			public:
				__fastcall virtual TTarget(TPasGLTF::TDocument* const aDocument);
				__fastcall virtual ~TTarget();
				
			__published:
				__property TPasGLTFSizeInt Node = {read=fNode, write=fNode, default=-1};
				__property TPasGLTFUTF8String Path = {read=fPath, write=fPath};
				__property bool Empty = {read=fEmpty, write=fEmpty, nodefault};
			};
			
			
			
		private:
			TPasGLTFSizeInt fSampler;
			TTarget* fTarget;
			
		public:
			__fastcall virtual TChannel(TPasGLTF::TDocument* const aDocument);
			__fastcall virtual ~TChannel();
			
		__published:
			__property TPasGLTFSizeInt Sampler = {read=fSampler, write=fSampler, default=-1};
			__property TTarget* Target = {read=fTarget};
		};
		
		
		typedef TPasGLTFObjectList__1<TChannel*> TChannels;
		class DELPHICLASS TSampler;
		class PASCALIMPLEMENTATION TSampler : public TPasGLTF::TBaseExtensionsExtrasObject
		{
			typedef TPasGLTF::TBaseExtensionsExtrasObject inherited;
			
			
		public:
			enum class DECLSPEC_DENUM TType : unsigned char { Linear, Step, CubicSpline };
			
			typedef TType *PType;
			
			
		private:
			TPasGLTFSizeInt fInput;
			TPasGLTFSizeInt fOutput;
			TType fInterpolation;
			
		public:
			__fastcall virtual TSampler(TPasGLTF::TDocument* const aDocument);
			__fastcall virtual ~TSampler();
			
		__published:
			__property TPasGLTFSizeInt Input = {read=fInput, write=fInput, default=-1};
			__property TPasGLTFSizeInt Output = {read=fOutput, write=fOutput, default=-1};
			__property TType Interpolation = {read=fInterpolation, write=fInterpolation, default=0};
		};
		
		
		typedef TPasGLTFObjectList__1<TSampler*> TSamplers;
		
	private:
		TPasGLTFUTF8String fName;
		TChannels* fChannels;
		TSamplers* fSamplers;
		
	public:
		__fastcall virtual TAnimation(TPasGLTF::TDocument* const aDocument);
		__fastcall virtual ~TAnimation();
		
	__published:
		__property TPasGLTFUTF8String Name = {read=fName, write=fName};
		__property TChannels* Channels = {read=fChannels};
		__property TSamplers* Samplers = {read=fSamplers};
	};
	
	
	typedef TPasGLTFObjectList__1<TAnimation*> TAnimations;
	class PASCALIMPLEMENTATION TAsset : public TPasGLTF::TBaseExtensionsExtrasObject
	{
		typedef TPasGLTF::TBaseExtensionsExtrasObject inherited;
		
	private:
		TPasGLTFUTF8String fCopyright;
		TPasGLTFUTF8String fGenerator;
		TPasGLTFUTF8String fMinVersion;
		TPasGLTFUTF8String fVersion;
		bool fEmpty;
		
	public:
		__fastcall virtual TAsset(TPasGLTF::TDocument* const aDocument);
		__fastcall virtual ~TAsset();
		
	__published:
		__property TPasGLTFUTF8String Copyright = {read=fCopyright, write=fCopyright};
		__property TPasGLTFUTF8String Generator = {read=fGenerator, write=fGenerator};
		__property TPasGLTFUTF8String MinVersion = {read=fMinVersion, write=fMinVersion};
		__property TPasGLTFUTF8String Version = {read=fVersion, write=fVersion};
		__property bool Empty = {read=fEmpty, write=fEmpty, nodefault};
	};
	
	
	class PASCALIMPLEMENTATION TBuffer : public TPasGLTF::TBaseExtensionsExtrasObject
	{
		typedef TPasGLTF::TBaseExtensionsExtrasObject inherited;
		
	private:
		TPasGLTFSizeUInt fByteLength;
		TPasGLTFUTF8String fName;
		TPasGLTFUTF8String fURI;
		System::Classes::TMemoryStream* fData;
		
	public:
		__fastcall virtual TBuffer(TPasGLTF::TDocument* const aDocument);
		__fastcall virtual ~TBuffer();
		void __fastcall SetEmbeddedResourceData();
		
	__published:
		__property TPasGLTFSizeUInt ByteLength = {read=fByteLength, write=fByteLength, nodefault};
		__property TPasGLTFUTF8String Name = {read=fName, write=fName};
		__property TPasGLTFUTF8String URI = {read=fURI, write=fURI};
		__property System::Classes::TMemoryStream* Data = {read=fData, write=fData};
	};
	
	
	typedef TPasGLTFObjectList__1<TBuffer*> TBuffers;
	class PASCALIMPLEMENTATION TBufferView : public TPasGLTF::TBaseExtensionsExtrasObject
	{
		typedef TPasGLTF::TBaseExtensionsExtrasObject inherited;
		
		
	public:
		enum class DECLSPEC_DENUM TTargetType : unsigned short { None, ArrayBuffer = 34962, ElementArrayBuffer };
		
		typedef TTargetType *PTargetType;
		
		
	private:
		TPasGLTFUTF8String fName;
		TPasGLTFSizeInt fBuffer;
		TPasGLTFSizeUInt fByteOffset;
		TPasGLTFSizeUInt fByteLength;
		TPasGLTFSizeUInt fByteStride;
		TTargetType fTarget;
		
	public:
		__fastcall virtual TBufferView(TPasGLTF::TDocument* const aDocument);
		__fastcall virtual ~TBufferView();
		TPasGLTFDoubleDynamicArray __fastcall Decode(const TPasGLTFSizeUInt aSkipEvery, const TPasGLTFSizeUInt aSkipBytes, const TPasGLTFSizeUInt aElementSize, const TPasGLTFSizeUInt aCount, const TPasGLTF::TAccessor::TType aType, const TPasGLTFSizeUInt aComponentCount, const TPasGLTF::TAccessor::TComponentType aComponentType, const TPasGLTFSizeUInt aComponentSize, const TPasGLTFSizeUInt aByteOffset, const bool aNormalized, const bool aForVertex);
		
	__published:
		__property TPasGLTFUTF8String Name = {read=fName, write=fName};
		__property TPasGLTFSizeInt Buffer = {read=fBuffer, write=fBuffer, nodefault};
		__property TPasGLTFSizeUInt ByteOffset = {read=fByteOffset, write=fByteOffset, nodefault};
		__property TPasGLTFSizeUInt ByteLength = {read=fByteLength, write=fByteLength, nodefault};
		__property TPasGLTFSizeUInt ByteStride = {read=fByteStride, write=fByteStride, nodefault};
		__property TTargetType Target = {read=fTarget, write=fTarget, default=0};
	};
	
	
	typedef TPasGLTFObjectList__1<TBufferView*> TBufferViews;
	class PASCALIMPLEMENTATION TCamera : public TPasGLTF::TBaseExtensionsExtrasObject
	{
		typedef TPasGLTF::TBaseExtensionsExtrasObject inherited;
		
		
	public:
		enum class DECLSPEC_DENUM TType : unsigned char { None, Orthographic, Perspective };
		
		class DELPHICLASS TOrthographic;
		class PASCALIMPLEMENTATION TOrthographic : public TPasGLTF::TBaseExtensionsExtrasObject
		{
			typedef TPasGLTF::TBaseExtensionsExtrasObject inherited;
			
		private:
			TPasGLTFFloat fXMag;
			TPasGLTFFloat fYMag;
			TPasGLTFFloat fZNear;
			TPasGLTFFloat fZFar;
			bool fEmpty;
			
		public:
			__fastcall virtual TOrthographic(TPasGLTF::TDocument* const aDocument);
			__fastcall virtual ~TOrthographic();
			
		__published:
			__property TPasGLTFFloat XMag = {read=fXMag, write=fXMag};
			__property TPasGLTFFloat YMag = {read=fYMag, write=fYMag};
			__property TPasGLTFFloat ZNear = {read=fZNear, write=fZNear};
			__property TPasGLTFFloat ZFar = {read=fZFar, write=fZFar};
			__property bool Empty = {read=fEmpty, write=fEmpty, nodefault};
		};
		
		
		class DELPHICLASS TPerspective;
		class PASCALIMPLEMENTATION TPerspective : public TPasGLTF::TBaseExtensionsExtrasObject
		{
			typedef TPasGLTF::TBaseExtensionsExtrasObject inherited;
			
		private:
			TPasGLTFFloat fAspectRatio;
			TPasGLTFFloat fYFov;
			TPasGLTFFloat fZNear;
			TPasGLTFFloat fZFar;
			bool fEmpty;
			
		public:
			__fastcall virtual TPerspective(TPasGLTF::TDocument* const aDocument);
			__fastcall virtual ~TPerspective();
			
		__published:
			__property TPasGLTFFloat AspectRatio = {read=fAspectRatio, write=fAspectRatio};
			__property TPasGLTFFloat YFov = {read=fYFov, write=fYFov};
			__property TPasGLTFFloat ZNear = {read=fZNear, write=fZNear};
			__property TPasGLTFFloat ZFar = {read=fZFar, write=fZFar};
			__property bool Empty = {read=fEmpty, write=fEmpty, nodefault};
		};
		
		
		
	private:
		TType fType;
		TOrthographic* fOrthographic;
		TPerspective* fPerspective;
		TPasGLTFUTF8String fName;
		
	public:
		__fastcall virtual TCamera(TPasGLTF::TDocument* const aDocument);
		__fastcall virtual ~TCamera();
		
	__published:
		__property TType Type_ = {read=fType, write=fType, nodefault};
		__property TOrthographic* Orthographic = {read=fOrthographic};
		__property TPerspective* Perspective = {read=fPerspective};
		__property TPasGLTFUTF8String Name = {read=fName, write=fName};
	};
	
	
	typedef TPasGLTFObjectList__1<TCamera*> TCameras;
	class PASCALIMPLEMENTATION TImage : public TPasGLTF::TBaseExtensionsExtrasObject
	{
		typedef TPasGLTF::TBaseExtensionsExtrasObject inherited;
		
	private:
		TPasGLTFSizeInt fBufferView;
		TPasGLTFUTF8String fName;
		TPasGLTFUTF8String fURI;
		TPasGLTFUTF8String fMimeType;
		
	public:
		__fastcall virtual TImage(TPasGLTF::TDocument* const aDocument);
		__fastcall virtual ~TImage();
		void __fastcall SetEmbeddedResourceData(System::Classes::TStream* const aStream);
		void __fastcall GetResourceData(System::Classes::TStream* const aStream);
		bool __fastcall IsExternalResource();
		
	__published:
		__property TPasGLTFSizeInt BufferView = {read=fBufferView, write=fBufferView, nodefault};
		__property TPasGLTFUTF8String Name = {read=fName, write=fName};
		__property TPasGLTFUTF8String URI = {read=fURI, write=fURI};
		__property TPasGLTFUTF8String MimeType = {read=fMimeType, write=fMimeType};
	};
	
	
	typedef TPasGLTFObjectList__1<TImage*> TImages;
	class PASCALIMPLEMENTATION TMaterial : public TPasGLTF::TBaseExtensionsExtrasObject
	{
		typedef TPasGLTF::TBaseExtensionsExtrasObject inherited;
		
		
	public:
		enum class DECLSPEC_DENUM TAlphaMode : unsigned char { Opaque, Mask, Blend };
		
		typedef TAlphaMode *PAlphaMode;
		
		typedef System::Set<TAlphaMode, _DELPHI_SET_ENUMERATOR(TAlphaMode::Opaque), _DELPHI_SET_ENUMERATOR(TAlphaMode::Blend)> TAlphaModes;
		
		class DELPHICLASS TTexture;
		class PASCALIMPLEMENTATION TTexture : public TPasGLTF::TBaseExtensionsExtrasObject
		{
			typedef TPasGLTF::TBaseExtensionsExtrasObject inherited;
			
		private:
			TPasGLTFSizeInt fIndex;
			TPasGLTFSizeInt fTexCoord;
			bool __fastcall GetEmpty();
			
		public:
			__fastcall virtual TTexture(TPasGLTF::TDocument* const aDocument);
			__fastcall virtual ~TTexture();
			
		__published:
			__property TPasGLTFSizeInt Index = {read=fIndex, write=fIndex, nodefault};
			__property TPasGLTFSizeInt TexCoord = {read=fTexCoord, write=fTexCoord, nodefault};
			__property bool Empty = {read=GetEmpty, nodefault};
		};
		
		
		class DELPHICLASS TNormalTexture;
		class PASCALIMPLEMENTATION TNormalTexture : public TPasGLTF::TMaterial::TTexture
		{
			typedef TPasGLTF::TMaterial::TTexture inherited;
			
		private:
			TPasGLTFFloat fScale;
			
		public:
			__fastcall virtual TNormalTexture(TPasGLTF::TDocument* const aDocument);
			
		__published:
			__property TPasGLTFFloat Scale = {read=fScale, write=fScale};
		public:
			/* TTexture.Destroy */ inline __fastcall virtual ~TNormalTexture() { }
			
		};
		
		
		class DELPHICLASS TOcclusionTexture;
		class PASCALIMPLEMENTATION TOcclusionTexture : public TPasGLTF::TMaterial::TTexture
		{
			typedef TPasGLTF::TMaterial::TTexture inherited;
			
		private:
			TPasGLTFFloat fStrength;
			
		public:
			__fastcall virtual TOcclusionTexture(TPasGLTF::TDocument* const aDocument);
			
		__published:
			__property TPasGLTFFloat Strength = {read=fStrength, write=fStrength};
		public:
			/* TTexture.Destroy */ inline __fastcall virtual ~TOcclusionTexture() { }
			
		};
		
		
		class DELPHICLASS TPBRMetallicRoughness;
		class PASCALIMPLEMENTATION TPBRMetallicRoughness : public TPasGLTF::TBaseExtensionsExtrasObject
		{
			typedef TPasGLTF::TBaseExtensionsExtrasObject inherited;
			
		private:
			TPasGLTF::TVector4 fBaseColorFactor;
			TPasGLTF::TMaterial::TTexture* fBaseColorTexture;
			TPasGLTFFloat fRoughnessFactor;
			TPasGLTFFloat fMetallicFactor;
			TPasGLTF::TMaterial::TTexture* fMetallicRoughnessTexture;
			bool __fastcall GetEmpty();
			
		public:
			__fastcall virtual TPBRMetallicRoughness(TPasGLTF::TDocument* const aDocument);
			__fastcall virtual ~TPBRMetallicRoughness();
			__property TPasGLTF::TVector4 BaseColorFactor = {read=fBaseColorFactor, write=fBaseColorFactor};
			
		__published:
			__property TPasGLTF::TMaterial::TTexture* BaseColorTexture = {read=fBaseColorTexture};
			__property TPasGLTFFloat RoughnessFactor = {read=fRoughnessFactor, write=fRoughnessFactor};
			__property TPasGLTFFloat MetallicFactor = {read=fMetallicFactor, write=fMetallicFactor};
			__property TPasGLTF::TMaterial::TTexture* MetallicRoughnessTexture = {read=fMetallicRoughnessTexture};
			__property bool Empty = {read=GetEmpty, nodefault};
		};
		
		
		
	private:
		TPasGLTFUTF8String fName;
		TPasGLTFFloat fAlphaCutOff;
		TAlphaMode fAlphaMode;
		bool fDoubleSided;
		TNormalTexture* fNormalTexture;
		TOcclusionTexture* fOcclusionTexture;
		TPBRMetallicRoughness* fPBRMetallicRoughness;
		TTexture* fEmissiveTexture;
		TPasGLTF::TVector3 fEmissiveFactor;
		
	public:
		__fastcall virtual TMaterial(TPasGLTF::TDocument* const aDocument);
		__fastcall virtual ~TMaterial();
		__property TPasGLTF::TVector3 EmissiveFactor = {read=fEmissiveFactor, write=fEmissiveFactor};
		
	__published:
		__property TPasGLTFUTF8String Name = {read=fName, write=fName};
		__property TPasGLTFFloat AlphaCutOff = {read=fAlphaCutOff, write=fAlphaCutOff};
		__property TAlphaMode AlphaMode = {read=fAlphaMode, write=fAlphaMode, nodefault};
		__property bool DoubleSided = {read=fDoubleSided, write=fDoubleSided, nodefault};
		__property TNormalTexture* NormalTexture = {read=fNormalTexture};
		__property TOcclusionTexture* OcclusionTexture = {read=fOcclusionTexture};
		__property TPBRMetallicRoughness* PBRMetallicRoughness = {read=fPBRMetallicRoughness};
		__property TTexture* EmissiveTexture = {read=fEmissiveTexture};
	};
	
	
	typedef TPasGLTFObjectList__1<TMaterial*> TMaterials;
	class PASCALIMPLEMENTATION TMesh : public TPasGLTF::TBaseExtensionsExtrasObject
	{
		typedef TPasGLTF::TBaseExtensionsExtrasObject inherited;
		
		
	public:
		class DELPHICLASS TPrimitive;
		class PASCALIMPLEMENTATION TPrimitive : public TPasGLTF::TBaseExtensionsExtrasObject
		{
			typedef TPasGLTF::TBaseExtensionsExtrasObject inherited;
			
			
		public:
			enum class DECLSPEC_DENUM TMode : unsigned char { Points, Lines, LineLoop, LineStrip, Triangles, TriangleStrip, TriangleFan };
			
			typedef TMode *PMode;
			
			
		private:
			TMode fMode;
			TPasGLTFSizeInt fIndices;
			TPasGLTFSizeInt fMaterial;
			TAttributes* fAttributes;
			TAttributesList* fTargets;
			
		public:
			__fastcall virtual TPrimitive(TPasGLTF::TDocument* const aDocument);
			__fastcall virtual ~TPrimitive();
			
		__published:
			__property TMode Mode = {read=fMode, write=fMode, nodefault};
			__property TPasGLTFSizeInt Indices = {read=fIndices, write=fIndices, nodefault};
			__property TPasGLTFSizeInt Material = {read=fMaterial, write=fMaterial, nodefault};
			__property TAttributes* Attributes = {read=fAttributes};
			__property TAttributesList* Targets = {read=fTargets};
		};
		
		
		typedef TPasGLTFObjectList__1<TPrimitive*> TPrimitives;
		typedef TPasGLTFDynamicArray__1<float> TWeights;
		
	private:
		TPasGLTFUTF8String fName;
		TWeights* fWeights;
		TPrimitives* fPrimitives;
		
	public:
		__fastcall virtual TMesh(TPasGLTF::TDocument* const aDocument);
		__fastcall virtual ~TMesh();
		
	__published:
		__property TPasGLTFUTF8String Name = {read=fName, write=fName};
		__property TWeights* Weights = {read=fWeights};
		__property TPrimitives* Primitives = {read=fPrimitives};
	};
	
	
	typedef TPasGLTFObjectList__1<TMesh*> TMeshes;
	class PASCALIMPLEMENTATION TNode : public TPasGLTF::TBaseExtensionsExtrasObject
	{
		typedef TPasGLTF::TBaseExtensionsExtrasObject inherited;
		
		
	public:
		typedef TPasGLTFDynamicArray__1<int> TChildren;
		typedef TPasGLTFDynamicArray__1<float> TWeights;
		
	private:
		TPasGLTFUTF8String fName;
		TPasGLTFSizeInt fCamera;
		TPasGLTFSizeInt fMesh;
		TPasGLTFSizeInt fSkin;
		TPasGLTF::TMatrix4x4 fMatrix;
		TPasGLTF::TVector4 fRotation;
		TPasGLTF::TVector3 fScale;
		TPasGLTF::TVector3 fTranslation;
		TChildren* fChildren;
		TWeights* fWeights;
		
	public:
		__fastcall virtual TNode(TPasGLTF::TDocument* const aDocument);
		__fastcall virtual ~TNode();
		__property TPasGLTF::TMatrix4x4 Matrix = {read=fMatrix, write=fMatrix};
		__property TPasGLTF::TVector4 Rotation = {read=fRotation, write=fRotation};
		__property TPasGLTF::TVector3 Scale = {read=fScale, write=fScale};
		__property TPasGLTF::TVector3 Translation = {read=fTranslation, write=fTranslation};
		
	__published:
		__property TPasGLTFUTF8String Name = {read=fName, write=fName};
		__property TPasGLTFSizeInt Camera = {read=fCamera, write=fCamera, nodefault};
		__property TPasGLTFSizeInt Mesh = {read=fMesh, write=fMesh, nodefault};
		__property TPasGLTFSizeInt Skin = {read=fSkin, write=fSkin, nodefault};
		__property TChildren* Children = {read=fChildren};
		__property TWeights* Weights = {read=fWeights};
	};
	
	
	typedef TPasGLTFObjectList__1<TNode*> TNodes;
	class PASCALIMPLEMENTATION TSampler : public TPasGLTF::TBaseExtensionsExtrasObject
	{
		typedef TPasGLTF::TBaseExtensionsExtrasObject inherited;
		
		
	public:
		enum class DECLSPEC_DENUM TMagFilter : unsigned short { None, Nearest = 9728, Linear };
		
		typedef TMagFilter *PMagFilter;
		
		enum class DECLSPEC_DENUM TMinFilter : unsigned short { None, Nearest = 9728, Linear, NearestMipMapNearest = 9984, LinearMipMapNearest, NearestMipMapLinear, LinearMipMapLinear };
		
		typedef TMinFilter *PMinFilter;
		
		enum class DECLSPEC_DENUM TWrappingMode : unsigned short { Repeat_ = 10497, ClampToEdge = 33071, MirroredRepeat = 33648 };
		
		typedef TWrappingMode *PWrappingMode;
		
		
	private:
		TPasGLTFUTF8String fName;
		TMagFilter fMagFilter;
		TMinFilter fMinFilter;
		TWrappingMode fWrapS;
		TWrappingMode fWrapT;
		bool __fastcall GetEmpty();
		
	public:
		__fastcall virtual TSampler(TPasGLTF::TDocument* const aDocument);
		__fastcall virtual ~TSampler();
		
	__published:
		__property TPasGLTFUTF8String Name = {read=fName, write=fName};
		__property TMagFilter MagFilter = {read=fMagFilter, write=fMagFilter, nodefault};
		__property TMinFilter MinFilter = {read=fMinFilter, write=fMinFilter, nodefault};
		__property TWrappingMode WrapS = {read=fWrapS, write=fWrapS, nodefault};
		__property TWrappingMode WrapT = {read=fWrapT, write=fWrapT, nodefault};
		__property bool Empty = {read=GetEmpty, nodefault};
	};
	
	
	typedef TPasGLTFObjectList__1<TSampler*> TSamplers;
	class PASCALIMPLEMENTATION TScene : public TPasGLTF::TBaseExtensionsExtrasObject
	{
		typedef TPasGLTF::TBaseExtensionsExtrasObject inherited;
		
		
	public:
		typedef TPasGLTFDynamicArray__1<unsigned> TNodes;
		
	private:
		TPasGLTFUTF8String fName;
		TPasGLTFDynamicArray__1<unsigned>* fNodes;
		
	public:
		__fastcall virtual TScene(TPasGLTF::TDocument* const aDocument);
		__fastcall virtual ~TScene();
		
	__published:
		__property TPasGLTFUTF8String Name = {read=fName, write=fName};
		__property TPasGLTFDynamicArray__1<unsigned>* Nodes = {read=fNodes};
	};
	
	
	typedef TPasGLTFObjectList__1<TScene*> TScenes;
	class PASCALIMPLEMENTATION TSkin : public TPasGLTF::TBaseExtensionsExtrasObject
	{
		typedef TPasGLTF::TBaseExtensionsExtrasObject inherited;
		
		
	public:
		typedef TPasGLTFDynamicArray__1<unsigned> TJoints;
		
	private:
		TPasGLTFUTF8String fName;
		TPasGLTFSizeInt fInverseBindMatrices;
		TPasGLTFSizeInt fSkeleton;
		TPasGLTFDynamicArray__1<unsigned>* fJoints;
		
	public:
		__fastcall virtual TSkin(TPasGLTF::TDocument* const aDocument);
		__fastcall virtual ~TSkin();
		
	__published:
		__property TPasGLTFUTF8String Name = {read=fName, write=fName};
		__property TPasGLTFSizeInt InverseBindMatrices = {read=fInverseBindMatrices, write=fInverseBindMatrices, nodefault};
		__property TPasGLTFSizeInt Skeleton = {read=fSkeleton, write=fSkeleton, nodefault};
		__property TPasGLTFDynamicArray__1<unsigned>* Joints = {read=fJoints};
	};
	
	
	typedef TPasGLTFObjectList__1<TSkin*> TSkins;
	class PASCALIMPLEMENTATION TTexture : public TPasGLTF::TBaseExtensionsExtrasObject
	{
		typedef TPasGLTF::TBaseExtensionsExtrasObject inherited;
		
	private:
		TPasGLTFUTF8String fName;
		TPasGLTFSizeInt fSampler;
		TPasGLTFSizeInt fSource;
		
	public:
		__fastcall virtual TTexture(TPasGLTF::TDocument* const aDocument);
		__fastcall virtual ~TTexture();
		
	__published:
		__property TPasGLTFUTF8String Name = {read=fName, write=fName};
		__property TPasGLTFSizeInt Sampler = {read=fSampler, write=fSampler, nodefault};
		__property TPasGLTFSizeInt Source = {read=fSource, write=fSource, nodefault};
	};
	
	
	typedef TPasGLTFObjectList__1<TTexture*> TTextures;
	
public:
	static _DELPHI_CONST int ChunkHeaderSize = int(0x8);
	
	static _DELPHI_CONST int GLBHeaderSize = int(0x14);
	
	static _DELPHI_CONST unsigned GLBHeaderMagicNativeEndianness = unsigned(0x46546c67);
	
	static _DELPHI_CONST unsigned GLBHeaderMagicOtherEndianness = unsigned(0x676c5446);
	
	static _DELPHI_CONST unsigned GLBChunkJSONNativeEndianness = unsigned(0x4e4f534a);
	
	static _DELPHI_CONST unsigned GLBChunkJSONOtherEndianness = unsigned(0x4a534f4e);
	
	static _DELPHI_CONST unsigned GLBChunkBinaryNativeEndianness = unsigned(0x4e4942);
	
	static _DELPHI_CONST unsigned GLBChunkBinaryOtherEndianness = unsigned(0x42494e00);
	
	#define TPasGLTF_MimeTypeApplicationOctet L"application/octet-stream"
	
	#define TPasGLTF_MimeTypeImagePNG L"image/png"
	
	#define TPasGLTF_MimeTypeImageJPG L"image/jpg"
	
	static TPasGLTFUTF8String __fastcall ResolveURIToPath(const TPasGLTFUTF8String aURI);
public:
	/* TObject.Create */ inline __fastcall TPasGLTF() : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TPasGLTF() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Pasgltf */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PASGLTF)
using namespace Pasgltf;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PasGLTFHPP
