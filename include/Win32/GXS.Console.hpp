﻿// CodeGear C++Builder
// Copyright (c) 1995, 2024 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'GXS.Console.pas' rev: 36.00 (Windows)

#ifndef GXS_ConsoleHPP
#define GXS_ConsoleHPP

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
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.TypInfo.hpp>
#include <System.UITypes.hpp>
#include <System.UIConsts.hpp>
#include <FMX.Graphics.hpp>
#include <Stage.VectorTypes.hpp>
#include <GXS.PersistentClasses.hpp>
#include <Stage.Strings.hpp>
#include <Stage.Utils.hpp>
#include <GXS.Coordinates.hpp>
#include <GXS.Scene.hpp>
#include <GXS.Objects.hpp>
#include <GXS.HUDObjects.hpp>
#include <GXS.SceneViewer.hpp>
#include <GXS.BitmapFont.hpp>
#include <GXS.Context.hpp>
#include <GXS.Texture.hpp>
#include <GXS.Material.hpp>
#include <GXS.ImageUtils.hpp>
#include <GXS.RenderContextInfo.hpp>
#include <GXS.BaseClasses.hpp>

//-- user supplied -----------------------------------------------------------

namespace Gxs
{
namespace Console
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS EGLConsoleException;
struct TgxUserInputCommand;
class DELPHICLASS TgxConsoleStringList;
class DELPHICLASS TgxConsoleCommand;
class DELPHICLASS TgxConsoleCommandList;
class DELPHICLASS TgxConsoleControls;
class DELPHICLASS TgxCustomConsole;
class DELPHICLASS TgxConsole;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION EGLConsoleException : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EGLConsoleException(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EGLConsoleException(const System::UnicodeString Msg, const System::TVarRec *Args, const System::NativeInt Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EGLConsoleException(System::NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EGLConsoleException(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EGLConsoleException(System::NativeUInt Ident, const System::TVarRec *Args, const System::NativeInt Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EGLConsoleException(System::PResStringRec ResStringRec, const System::TVarRec *Args, const System::NativeInt Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EGLConsoleException(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EGLConsoleException(const System::UnicodeString Msg, const System::TVarRec *Args, const System::NativeInt Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EGLConsoleException(System::NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EGLConsoleException(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EGLConsoleException(System::PResStringRec ResStringRec, const System::TVarRec *Args, const System::NativeInt Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EGLConsoleException(System::NativeUInt Ident, const System::TVarRec *Args, const System::NativeInt Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EGLConsoleException() { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TgxConsoleOption : unsigned char { coAutoCompleteCommandsOnKeyPress, coAutoCompleteCommandsOnEnter, coShowConsoleHelpIfUnknownCommand, coRemoveQuotes };

typedef System::Set<TgxConsoleOption, TgxConsoleOption::coAutoCompleteCommandsOnKeyPress, TgxConsoleOption::coRemoveQuotes> TgxConsoleOptions;

struct DECLSPEC_DRECORD TgxUserInputCommand
{
	
private:
	typedef System::DynamicArray<System::UnicodeString> _TgxUserInputCommand__1;
	
	
public:
	int CommandCount;
	_TgxUserInputCommand__1 Strings;
	bool UnknownCommand;
};


typedef void __fastcall (__closure *TgxlConsoleEvent)(TgxConsoleCommand* const ConsoleCommand, TgxCustomConsole* const Console, TgxUserInputCommand &Command);

typedef System::Set<System::Int8, 0, 120> TgxConsoleMatchList;

class PASCALIMPLEMENTATION TgxConsoleStringList : public System::Classes::TStringList
{
	typedef System::Classes::TStringList inherited;
	
private:
	TgxCustomConsole* FConsole;
	
protected:
	virtual void __fastcall Changed();
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner();
	
public:
	bool __fastcall CommandExists(const System::UnicodeString Command);
	__fastcall TgxConsoleStringList(TgxCustomConsole* const Owner);
public:
	/* TStringList.Destroy */ inline __fastcall virtual ~TgxConsoleStringList() { }
	
};


class PASCALIMPLEMENTATION TgxConsoleCommand : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	bool FVisible;
	bool FEnabled;
	bool FSilentDisabled;
	TgxConsoleCommandList* FCommandList;
	System::UnicodeString FCommandName;
	System::UnicodeString FShortHelp;
	System::Classes::TStringList* FLongHelp;
	TgxlConsoleEvent FOnCommand;
	System::Classes::TNotifyEvent FOnHelp;
	void __fastcall SetCommandName(const System::UnicodeString Value);
	
protected:
	virtual void __fastcall ShowInvalidUseOfCommandError();
	virtual void __fastcall ShowInvalidNumberOfArgumentsError(const bool ShowHelpAfter = true);
	virtual void __fastcall DoOnCommand(TgxUserInputCommand &UserInputCommand);
	virtual System::UnicodeString __fastcall GetDisplayName();
	
public:
	virtual void __fastcall ShowHelp();
	virtual void __fastcall ShowShortHelp();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__fastcall virtual TgxConsoleCommand(System::Classes::TCollection* Collection);
	__fastcall virtual ~TgxConsoleCommand();
	
__published:
	__property System::UnicodeString CommandName = {read=FCommandName, write=SetCommandName};
	__property System::UnicodeString ShortHelp = {read=FShortHelp, write=FShortHelp};
	__property System::Classes::TStringList* LongHelp = {read=FLongHelp};
	__property TgxlConsoleEvent OnCommand = {read=FOnCommand, write=FOnCommand};
	__property System::Classes::TNotifyEvent OnHelp = {read=FOnHelp, write=FOnHelp};
	__property bool Enabled = {read=FEnabled, write=FEnabled, default=1};
	__property bool SilentDisabled = {read=FSilentDisabled, write=FSilentDisabled, default=0};
	__property bool Visible = {read=FVisible, write=FVisible, default=1};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TgxConsoleCommandList : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TgxConsoleCommand* operator[](const int Index) { return this->Items[Index]; }
	
private:
	TgxCustomConsole* FConsole;
	TgxConsoleCommand* __fastcall GetItems(const int Index);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner();
	
public:
	void __fastcall SortCommands(const bool Ascending = true);
	bool __fastcall CommandExists(const System::UnicodeString Command);
	int __fastcall GetCommandIndex(const System::UnicodeString Command);
	TgxConsoleCommand* __fastcall LastConsoleCommand();
	HIDESBASE TgxConsoleCommand* __fastcall Add()/* overload */;
	__fastcall TgxConsoleCommandList(TgxCustomConsole* const AOwner);
	__fastcall virtual ~TgxConsoleCommandList();
	__property TgxConsoleCommand* Items[const int Index] = {read=GetItems/*, default*/};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TgxConsoleControls : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::Classes::TPersistent* FOwner;
	System::Byte FNavigatePageUp;
	System::Byte FAutoCompleteCommand;
	System::Byte FPreviousCommand;
	System::Byte FNextCommand;
	System::Byte FNavigateUp;
	System::Byte FNavigatePageDown;
	System::Byte FNavigateDown;
	int FDblClickDelay;
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner();
	
public:
	__fastcall TgxConsoleControls(System::Classes::TPersistent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property System::Byte NavigateUp = {read=FNavigateUp, write=FNavigateUp, default=36};
	__property System::Byte NavigateDown = {read=FNavigateDown, write=FNavigateDown, default=35};
	__property System::Byte NavigatePageUp = {read=FNavigatePageUp, write=FNavigatePageUp, default=33};
	__property System::Byte NavigatePageDown = {read=FNavigatePageDown, write=FNavigatePageDown, default=34};
	__property System::Byte NextCommand = {read=FNextCommand, write=FNextCommand, default=40};
	__property System::Byte PreviousCommand = {read=FPreviousCommand, write=FPreviousCommand, default=38};
	__property System::Byte AutoCompleteCommand = {read=FAutoCompleteCommand, write=FAutoCompleteCommand, default=17};
	__property int DblClickDelay = {read=FDblClickDelay, write=FDblClickDelay, default=300};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TgxConsoleControls() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TgxCustomConsole : public Gxs::Scene::TgxBaseSceneObject
{
	typedef Gxs::Scene::TgxBaseSceneObject inherited;
	
private:
	Gxs::Hudobjects::TgxHUDSprite* FHudSprite;
	Gxs::Hudobjects::TgxHUDText* FHudText;
	Gxs::Sceneviewer::TgxSceneViewer* FSceneViewer;
	System::UnicodeString FInputLine;
	int FStartLine;
	int FCurrentCommand;
	int FPreviousTickCount;
	float FSize;
	System::Classes::TStringList* FColsoleLog;
	TgxConsoleCommandList* FCommands;
	TgxConsoleStringList* FAdditionalCommands;
	System::Classes::TStringList* FTypedCommands;
	TgxConsoleControls* FControls;
	TgxlConsoleEvent FOnCommandIssued;
	TgxConsoleOptions FOptions;
	System::UnicodeString FHint;
	void __fastcall SetSize(const float Value);
	void __fastcall SetSceneViewer(Gxs::Sceneviewer::TgxSceneViewer* const Value);
	Gxs::Bitmapfont::TgxCustomBitmapFont* __fastcall GetFont();
	void __fastcall SetFont(Gxs::Bitmapfont::TgxCustomBitmapFont* const Value);
	
protected:
	virtual void __fastcall DoOnCommandIssued(TgxUserInputCommand &UserInputCommand);
	virtual void __fastcall SetFontColor(const System::Uitypes::TColor Color);
	virtual System::Uitypes::TColor __fastcall GetFontColor();
	virtual void __fastcall SetHUDSpriteColor(const System::Uitypes::TColor Color);
	virtual System::Uitypes::TColor __fastcall GetHUDSpriteColor();
	virtual int __fastcall NumLines();
	virtual void __fastcall ShowConsoleHelp();
	virtual void __fastcall HandleUnknownCommand(const System::UnicodeString Command);
	virtual void __fastcall AutoCompleteCommand()/* overload */;
	void __fastcall AutoCompleteCommand(int &MatchCount, TgxConsoleMatchList &AdditionalCommandsMatchList, TgxConsoleMatchList &CommandsMatchList)/* overload */;
	virtual void __fastcall CommandIssued(TgxUserInputCommand &UserInputCommand);
	virtual void __fastcall FixCommand(TgxUserInputCommand &UserInputCommand);
	virtual TgxUserInputCommand __fastcall ParseString(System::UnicodeString str, System::UnicodeString caract);
	virtual void __fastcall ProcessInput();
	virtual void __fastcall RefreshHud();
	virtual void __fastcall RegisterBuiltInCommands();
	virtual void __fastcall ProcessInternalCommandHelp(TgxConsoleCommand* const ConsoleCommand, TgxCustomConsole* const Console, TgxUserInputCommand &Command);
	virtual void __fastcall ProcessInternalCommandClearScreen(TgxConsoleCommand* const ConsoleCommand, TgxCustomConsole* const Console, TgxUserInputCommand &Command);
	virtual void __fastcall ProcessInternalCommandConsoleHide(TgxConsoleCommand* const ConsoleCommand, TgxCustomConsole* const Console, TgxUserInputCommand &Command);
	virtual void __fastcall ProcessInternalCommandConsoleColor(TgxConsoleCommand* const ConsoleCommand, TgxCustomConsole* const Console, TgxUserInputCommand &Command);
	virtual void __fastcall ProcessInternalCommandConsoleRename(TgxConsoleCommand* const ConsoleCommand, TgxCustomConsole* const Console, TgxUserInputCommand &Command);
	virtual void __fastcall ProcessInternalCommandConsoleClearTypedCommands(TgxConsoleCommand* const ConsoleCommand, TgxCustomConsole* const Console, TgxUserInputCommand &Command);
	virtual void __fastcall ProcessInternalCommandSystemTime(TgxConsoleCommand* const ConsoleCommand, TgxCustomConsole* const Console, TgxUserInputCommand &Command);
	virtual void __fastcall ProcessInternalCommandSystemDate(TgxConsoleCommand* const ConsoleCommand, TgxCustomConsole* const Console, TgxUserInputCommand &Command);
	virtual void __fastcall ProcessInternalCommandViewerFPS(TgxConsoleCommand* const ConsoleCommand, TgxCustomConsole* const Console, TgxUserInputCommand &Command);
	virtual void __fastcall ProcessInternalCommandViewerResetPerformanceMonitor(TgxConsoleCommand* const ConsoleCommand, TgxCustomConsole* const Console, TgxUserInputCommand &Command);
	virtual void __fastcall ProcessInternalCommandViewerVSync(TgxConsoleCommand* const ConsoleCommand, TgxCustomConsole* const Console, TgxUserInputCommand &Command);
	virtual void __fastcall ProcessInternalCommandViewerAntiAliasing(TgxConsoleCommand* const ConsoleCommand, TgxCustomConsole* const Console, TgxUserInputCommand &Command);
	virtual void __fastcall GetHelpInternalCommandRename(System::TObject* Sender);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SetName(const System::Classes::TComponentName Value);
	
public:
	virtual void __fastcall ProcessKeyPress(const System::WideChar c);
	virtual void __fastcall ProcessKeyDown(const System::Word key);
	void __fastcall NavigateUp();
	void __fastcall NavigateDown();
	void __fastcall NavigatePageUp();
	void __fastcall NavigatePageDown();
	virtual void __fastcall RefreshHudSize();
	void __fastcall AddLine(const System::UnicodeString str);
	void __fastcall ClearTypedCommands();
	void __fastcall ExecuteCommand(const System::UnicodeString Command);
	void __fastcall ExecuteCommands(System::Classes::TStrings* const Commands);
	__fastcall virtual TgxCustomConsole(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TgxCustomConsole();
	__property System::Uitypes::TColor FontColor = {read=GetFontColor, write=SetFontColor, stored=false, nodefault};
	__property System::Uitypes::TColor HUDSpriteColor = {read=GetHUDSpriteColor, write=SetHUDSpriteColor, stored=false, nodefault};
	__property System::UnicodeString InputLine = {read=FInputLine, write=FInputLine};
	__property System::Classes::TStringList* TypedCommands = {read=FTypedCommands};
	__property TgxConsoleCommandList* Commands = {read=FCommands};
	__property TgxConsoleStringList* AdditionalCommands = {read=FAdditionalCommands};
	__property TgxConsoleControls* Controls = {read=FControls};
	__property System::Classes::TStringList* ColsoleLog = {read=FColsoleLog};
	__property float Size = {read=FSize, write=SetSize};
	__property Gxs::Sceneviewer::TgxSceneViewer* SceneViewer = {read=FSceneViewer, write=SetSceneViewer};
	__property Gxs::Hudobjects::TgxHUDSprite* HudSprite = {read=FHudSprite};
	__property Gxs::Hudobjects::TgxHUDText* HudText = {read=FHudText};
	__property Gxs::Bitmapfont::TgxCustomBitmapFont* Font = {read=GetFont, write=SetFont, stored=false};
	__property TgxConsoleOptions Options = {read=FOptions, write=FOptions, nodefault};
	__property TgxlConsoleEvent OnCommandIssued = {read=FOnCommandIssued, write=FOnCommandIssued};
	__property System::UnicodeString Hint = {read=FHint, write=FHint};
	__property Visible = {default=0};
public:
	/* TgxBaseSceneObject.CreateAsChild */ inline __fastcall TgxCustomConsole(Gxs::Scene::TgxBaseSceneObject* aParentOwner) : Gxs::Scene::TgxBaseSceneObject(aParentOwner) { }
	
};


class PASCALIMPLEMENTATION TgxConsole : public TgxCustomConsole
{
	typedef TgxCustomConsole inherited;
	
__published:
	__property FontColor;
	__property HUDSpriteColor;
	__property InputLine = {default=0};
	__property TypedCommands;
	__property Commands;
	__property AdditionalCommands;
	__property Controls;
	__property ColsoleLog;
	__property SceneViewer;
	__property HudSprite;
	__property HudText;
	__property Font;
	__property Options;
	__property OnCommandIssued;
	__property Hint = {default=0};
	__property Tag = {default=0};
	__property ObjectsSorting = {default=0};
	__property Visible = {default=0};
	__property OnProgress;
public:
	/* TgxCustomConsole.Create */ inline __fastcall virtual TgxConsole(System::Classes::TComponent* AOwner) : TgxCustomConsole(AOwner) { }
	/* TgxCustomConsole.Destroy */ inline __fastcall virtual ~TgxConsole() { }
	
public:
	/* TgxBaseSceneObject.CreateAsChild */ inline __fastcall TgxConsole(Gxs::Scene::TgxBaseSceneObject* aParentOwner) : TgxCustomConsole(aParentOwner) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static _DELPHI_CONST System::Int8 CONSOLE_MAX_COMMANDS = System::Int8(0x78);
}	/* namespace Console */
}	/* namespace Gxs */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GXS_CONSOLE)
using namespace Gxs::Console;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GXS)
using namespace Gxs;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GXS_ConsoleHPP
