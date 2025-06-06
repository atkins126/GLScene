//
// The graphics engine GLXEngine. The unit of GXScene for Delphi
//
unit GXSL.ShapeShaders;

(*
   Erosion shader Erode surface object and render with Anisotropic Specular Reflection
   At this time one light source is supported
*)

interface

uses
  Winapi.OpenGL,
  Winapi.OpenGLext,
  System.Classes,
  System.SysUtils,

  Stage.OpenGLTokens,
  GXS.Scene,
  GXS.BaseClasses,
  GXS.State,
  GXS.Context,
  GXS.Graphics,
  GXS.RenderContextInfo,
  GXS.Coordinates,
  Stage.VectorGeometry,
  Stage.VectorTypes,
  Stage.TextureFormat,
  GXS.Color,
  GXS.Texture,
  GXS.Material,
  GXSL.Shader,
  GXSL.CustomShader;


//------------------ Cel Shader --------------------------


type
   (* A shader that applies cel shading through a vertex program
   and shade definition texture.
   Cel shading options:
     csoOutlines: Render a second outline pass.
     csoTextured: Allows for a primary texture that the cel shading
                  is modulated with and forces the shade definition
                  to render as a second texture. *)
  TgxCelShaderOption = (csoOutlines, csoTextured, csoNoBuildShadeTexture);
  TgxCelShaderOptions = set of TgxCelShaderOption;

  // An event for user defined cel intensity.
  TgxCelShaderGetIntensity = procedure(Sender: TObject; var intensity: Byte) of
    object;

  // A generic cel shader.
  TgxCelShader = class(TgxShader)
  private
    FOutlineWidth: Single;
    FCelShaderOptions: TgxCelShaderOptions;
    FVPHandle: TgxVertexProgramHandle;
    FShadeTexture: TgxTexture;
    FOnGetIntensity: TgxCelShaderGetIntensity;
    FOutlinePass,
      FUnApplyShadeTexture: Boolean;
    FOutlineColor: TgxColor;
  protected
    procedure SetCelShaderOptions(const val: TgxCelShaderOptions);
    procedure SetOutlineWidth(const val: Single);
    procedure SetOutlineColor(const val: TgxColor);
    procedure BuildShadeTexture;
    procedure Loaded; override;
    function GenerateVertexProgram: string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoApply(var rci: TgxRenderContextInfo; Sender: TObject); override;
    function DoUnApply(var rci: TgxRenderContextInfo): Boolean; override;
    property ShadeTexture: TgxTexture read FShadeTexture;
  published
    property CelShaderOptions: TgxCelShaderOptions read FCelShaderOptions write
      SetCelShaderOptions;
    property OutlineColor: TgxColor read FOutlineColor write SetOutlineColor;
    property OutlineWidth: Single read FOutlineWidth write SetOutlineWidth;
    property OnGetIntensity: TgxCelShaderGetIntensity read FOnGetIntensity write
      FOnGetIntensity;
  end;

//------------- Erosion Shader ---------------------

type
  (* Custom class for a shader that Erode surface object *)
  TgxCustomGLSLSimpleErosionShader = class(TGXSLCustomShader)
  private
    FMaterialLibrary: TgxAbstractMaterialLibrary;
    FMainTex  : TgxTexture;
    FNoiseTex : TgxTexture;
    FErosionTex : TgxTexture;
    FMainTexName   : TgxLibMaterialName;
    FNoiseTexName  : TgxLibMaterialName;
    FErosionTexName  : TgxLibMaterialName;
    FErosionScale: Single;
    FErosionFactor: Single;
    FIntensityFactor1: Single;
    FIntensityFactor2: Single;
    FSpecularColor : TgxColor;
    FAmbientColor : TgxColor;
    FAmbientFactor : Single;
    FDiffuseFactor : Single;
    FSpecularFactor : Single;
    FSpecularRoughness : Single;
    FAnisotropicRoughness : Single;
    function GetMaterialLibrary: TgxAbstractMaterialLibrary;
    procedure SetMainTexTexture(const Value: TgxTexture);
    procedure SetNoiseTexTexture(const Value: TgxTexture);
    procedure SetErosionTexTexture(const Value: TgxTexture);
    function GetMainTexName: TgxLibMaterialName;
    procedure SetMainTexName(const Value: TgxLibMaterialName);
    function GetNoiseTexName: TgxLibMaterialName;
    procedure SetNoiseTexName(const Value: TgxLibMaterialName);
    function GetErosionTexName: TgxLibMaterialName;
    procedure SetErosionTexName(const Value: TgxLibMaterialName);
    procedure SetAmbientColor(AValue: TgxColor);
    procedure SetSpecularColor(AValue: TgxColor);
  protected
    procedure DoApply(var rci : TgxRenderContextInfo; Sender : TObject); override;
    function DoUnApply(var rci: TgxRenderContextInfo): Boolean; override;
    procedure SetMaterialLibrary(const Value: TgxAbstractMaterialLibrary); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
//    property Color1: TgxColor read FColor1;
//    property Color2: TgxColor read FColor2;
    property MaterialLibrary: TgxAbstractMaterialLibrary read getMaterialLibrary write SetMaterialLibrary;
    property MainTexture: TgxTexture read FMainTex write SetMainTexTexture;
    property MainTextureName: TgxLibMaterialName read GetMainTexName write SetMainTexName;
    property NoiseTexture: TgxTexture read FNoiseTex write SetNoiseTexTexture;
    property NoiseTextureName: TgxLibMaterialName read GetNoiseTexName write SetNoiseTexName;
    property ErosionTexture: TgxTexture read FErosionTex write SetErosionTexTexture;
    property ErosionTextureName: TgxLibMaterialName read GetErosionTexName write SetErosionTexName;
    property ErosionFactor: Single read FErosionFactor write FErosionFactor;
    property ErosionScale: Single read FErosionFactor write FErosionFactor;
    property IntensityFactor1: Single read FIntensityFactor1 write FIntensityFactor1;
    property IntensityFactor2: Single read FIntensityFactor2 write FIntensityFactor2;
    property SpecularColor : TgxColor Read FSpecularColor Write setSpecularColor;
    property AmbientColor : TgxColor Read FAmbientColor Write setAmbientColor;
    property AmbientFactor : Single Read FAmbientFactor Write FAmbientFactor;
    property DiffuseFactor : Single Read FDiffuseFactor Write FDiffuseFactor;
    property SpecularFactor : Single Read FSpecularFactor Write FSpecularFactor;
    property SpecularRoughness : Single Read FSpecularRoughness  Write FSpecularRoughness;
    property AnisotropicRoughness : Single Read FAnisotropicRoughness Write FAnisotropicRoughness;
  end;

  TgxSLSimpleErosionShader = class(TgxCustomGLSLSimpleErosionShader)
  published
//    property Color1;
//    property Color2;
    property MaterialLibrary;
    property MainTexture;
    property MainTextureName;
    property NoiseTexture;
    property NoiseTextureName;
    property ErosionTexture;
    property ErosionTextureName;
    property ErosionScale;
    property ErosionFactor;
    property IntensityFactor1;
    property IntensityFactor2;
    property SpecularColor;
    property AmbientColor;
    property AmbientFactor;
    property DiffuseFactor;
    property SpecularFactor;
    property SpecularRoughness;
    property AnisotropicRoughness;
  end;

//-------------- Glass Shader --------------------

type
  (* Custom class for Glass shader:
     Environment mapping and refraction mapping using the fresnel terms *)
  TgxCustomGLSLGlassShader = class(TGXSLCustomShader)
  private
    FDiffuseColor: TgxColor;
    FDepth: Single;
    FMix: Single;
    FAlpha: Single;
    FMaterialLibrary: TgxAbstractMaterialLibrary;
    FMainTexture: TgxTexture; // EnvMap
    FMainTexName: TgxLibMaterialName;
    FRefractionTexture: TgxTexture;
    FRefractionTexName: TgxLibMaterialName;
    FOwnerObject: TgxBaseSceneObject;
    FBlendSrc: TgxBlendFunction;
    FBlendDst: TgxBlendFunction;
    function GetMaterialLibrary: TgxAbstractMaterialLibrary;
    procedure SetMainTexTexture(const Value: TgxTexture);
    function GetMainTexName: TgxLibMaterialName;
    procedure SetMainTexName(const Value: TgxLibMaterialName);
    procedure SetRefractionTexTexture(const Value: TgxTexture);
    function GetRefractionTexName: TgxLibMaterialName;
    procedure SetRefractionTexName(const Value: TgxLibMaterialName);
    procedure SetDiffuseColor(AValue: TgxColor);
  protected
    procedure DoApply(var rci: TgxRenderContextInfo; Sender: TObject); override;
    function DoUnApply(var rci: TgxRenderContextInfo): Boolean; override;
    procedure SetMaterialLibrary(const Value
      : TgxAbstractMaterialLibrary); virtual;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property DiffuseColor: TgxColor read FDiffuseColor Write SetDiffuseColor;
    property Depth: Single read FDepth write FDepth;
    property Mix: Single read FMix write FMix;
    property Alpha: Single read FAlpha write FAlpha;
    property MaterialLibrary: TgxAbstractMaterialLibrary read GetMaterialLibrary
      write SetMaterialLibrary;
    property MainTexture: TgxTexture read FMainTexture write SetMainTexTexture;
    property MainTextureName: TgxLibMaterialName read GetMainTexName
      write SetMainTexName;
    property RefractionTexture: TgxTexture read FRefractionTexture
      write SetRefractionTexTexture;
    property RefractionTextureName: TgxLibMaterialName read GetRefractionTexName
      write SetRefractionTexName;
    property OwnerObject: TgxBaseSceneObject read FOwnerObject
      write FOwnerObject;
    property BlendSrc: TgxBlendFunction read FBlendSrc write FBlendSrc
      default bfSrcAlpha;
    property BlendDst: TgxBlendFunction read FBlendDst write FBlendDst
      default bfDstAlpha;
  end;

  TgxSLGlassShader = class(TgxCustomGLSLGlassShader)
  published
    property DiffuseColor;
    property Depth;
    property Mix;
    property Alpha;
    property MaterialLibrary;
    property MainTexture;
    property MainTextureName;
    property RefractionTexture;
    property RefractionTextureName;
    property OwnerObject;
    property BlendSrc;
    property BlendDst;
  end;

//-----------Gooch Shader -----------------------

type
  (* Custom class for Gooch Shader *)
  TgxCustomGLSLSimpleGoochShader = class(TGXSLCustomShader)
  private
    FDiffuseColor : TgxColor;
    FWarmColor : TgxColor;
    FCoolColor : TgxColor;
    FSpecularColor : TgxColor;
    FAmbientColor : TgxColor;
    FDiffuseWarm : Single;
    FDiffuseCool : Single;
    FAmbientFactor : Single;
    FDiffuseFactor : Single;
    FSpecularFactor : Single;
    FBlendingMode: TgxBlendingModeEx;
    procedure SetDiffuseColor(AValue: TgxColor);
    procedure SetAmbientColor(AValue: TgxColor);
    procedure SetSpecularColor(AValue: TgxColor);
    procedure SetWarmColor(AValue: TgxColor);
    procedure SetCoolColor(AValue: TgxColor);
  protected
    procedure DoApply(var rci : TgxRenderContextInfo; Sender : TObject); override;
    function DoUnApply(var rci: TgxRenderContextInfo): Boolean; override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    property DiffuseColor : TgxColor read FDiffuseColor Write setDiffuseColor;
    property WarmColor : TgxColor read FWarmColor Write setWarmColor;
    property CoolColor : TgxColor Read FCoolColor Write setCoolColor;
    property SpecularColor : TgxColor Read FSpecularColor Write setSpecularColor;
    property AmbientColor : TgxColor Read FAmbientColor Write setAmbientColor;
    property WarmFactor : Single Read FDiffuseWarm Write FDiffuseWarm;
    property CoolFactor : Single Read FDiffuseCool Write FDiffuseCool;
    property AmbientFactor : Single Read FAmbientFactor Write FAmbientFactor;
    property DiffuseFactor : Single Read FDiffuseFactor Write FDiffuseFactor;
    property SpecularFactor : Single Read FSpecularFactor Write FSpecularFactor;
    property BlendingMode: TgxBlendingModeEx read FBlendingMode write FBlendingMode default bmxOpaque;
  end;

type
  TgxSLSimpleGoochShader = class(TgxCustomGLSLSimpleGoochShader)
  published
    property DiffuseColor;
    property WarmColor;
    property CoolColor;
    property SpecularColor;
    property AmbientColor;
    property WarmFactor;
    property CoolFactor;
    property AmbientFactor;
    property DiffuseFactor;
    property SpecularFactor;
  end;

//------------Fur Shader ------------------

type
  (* Custom class for Fur Shader *)
  TgxCustomGLSLFurShader = class(TGXSLCustomShader)
  private
    FMaterialLibrary: TgxAbstractMaterialLibrary;
    FCurrentPass: Integer;
    FPassCount: Single;
    FFurLength: Single;
    FMaxFurLength: Single;
    FFurScale: Single;
    FRandomFurLength : Boolean;
    FColorScale: TgxColor;
    FAmbient: TgxColor;
    FGravity : TgxCoordinates;
    FLightIntensity : Single;
    FMainTex  : TgxTexture;
    FNoiseTex : TgxTexture;
    FNoiseTexName  : TgxLibMaterialName;
    FMainTexName   : TgxLibMaterialName;
    FBlendSrc : TgxBlendFunction;
    FBlendDst : TgxBlendFunction;
   // FBlendEquation : TgxBlendEquation;
    function GetMaterialLibrary: TgxAbstractMaterialLibrary;
    procedure SetMainTexTexture(const Value: TgxTexture);
    procedure SetNoiseTexTexture(const Value: TgxTexture);
    function GetNoiseTexName: TgxLibMaterialName;
    procedure SetNoiseTexName(const Value: TgxLibMaterialName);
    function GetMainTexName: TgxLibMaterialName;
    procedure SetMainTexName(const Value: TgxLibMaterialName);
    procedure SetGravity(APosition:TgxCoordinates);
    procedure SetAmbient(AValue: TgxColor);
    procedure SetColorScale(AValue: TgxColor);
  protected
    procedure DoApply(var rci : TgxRenderContextInfo; Sender : TObject); override;
    function DoUnApply(var rci: TgxRenderContextInfo): Boolean; override;
    procedure SetMaterialLibrary(const Value: TgxAbstractMaterialLibrary); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    //Common stuff
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    property PassCount: Single read FPassCount write FPassCount;
    property FurLength: Single read FFurLength write FFurLength;
    property MaxFurLength: Single read FMaxFurLength write FMaxFurLength;
    property FurDensity: Single read FFurScale write FFurScale;
    property RandomFurLength : Boolean read FRandomFurLength Write FRandomFurLength;
    property ColorScale: TgxColor read FColorScale Write setColorScale;
    property Ambient: TgxColor read FAmbient write setAmbient;
    property MaterialLibrary: TgxAbstractMaterialLibrary read getMaterialLibrary write SetMaterialLibrary;
    property MainTexture: TgxTexture read FMainTex write SetMainTexTexture;
    property MainTextureName: TgxLibMaterialName read GetMainTexName write SetMainTexName;
    property NoiseTexture: TgxTexture read FNoiseTex write SetNoiseTexTexture;
    property NoiseTextureName: TgxLibMaterialName read GetNoiseTexName write SetNoiseTexName;
    //property BlendEquation : TBlendEquation read FBlendEquation write FBlendEquation default beMin;
    property BlendSrc  : TgxBlendFunction read FBlendSrc write FBlendSrc default bfSrcColor;
    property BlendDst  : TgxBlendFunction read FBlendDst write FBlendDst default bfOneMinusDstColor;
    property Gravity : TgxCoordinates Read FGravity write setGravity;
    property LightIntensity : Single read FLightIntensity Write FLightIntensity;
  end;

  TgxSLFurShader = class(TgxCustomGLSLFurShader)
  published
    property PassCount;
    property FurLength;
    property MaxFurLength;
    property FurDensity;
    property RandomFurLength;
    property ColorScale;
    property Ambient;
    property LightIntensity;
    property Gravity;
    property BlendSrc;
    property BlendDst;
    property MainTexture;
    property MainTextureName;
    property NoiseTexture;
    property NoiseTextureName;
  end;

//------------ Ivory Shader ----------------

type
  (* Custom class for a shader that simulate Ivory Material *)
  TgxCustomGLSLIvoryShader = class(TGXSLCustomShader)
  protected
    procedure DoApply(var rci : TgxRenderContextInfo; Sender : TObject); override;
    function DoUnApply(var rci: TgxRenderContextInfo): Boolean; override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  end;

type
  TgxSLIvoryShader = class(TgxCustomGLSLIvoryShader)
  end;

//------------- Lattice Shader ----------------------

type
  (* Custom class for a shader that simulate Lattice *)
  TgxCustomGLSLSimpleLatticeShader = class(TGXSLCustomShader)
  private
    FLatticeScale: TgxCoordinates2;
    FLatticeThreshold: TgxCoordinates2;
    procedure SetLatticeScale(const Value: TgxCoordinates2);
    procedure SetLatticeThreshold(const Value: TgxCoordinates2);
  protected
    procedure DoApply(var rci : TgxRenderContextInfo; Sender : TObject); override;
    function DoUnApply(var rci: TgxRenderContextInfo): Boolean; override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    property LatticeScale: TgxCoordinates2 read FLatticeScale write SetLatticeScale;
    property LatticeThreshold: TgxCoordinates2 read FLatticeThreshold write SetLatticeThreshold;
  end;

(* Custom class for GLSLLatticeShader.
 A shader that simulate Lattice with Diffuse/Specular and support Texture *)
  TgxCustomGLSLLatticeShader = class(TgxCustomGLSLSimpleLatticeShader)
  private
    FAmbientColor: TgxColor;
    FDiffuseColor: TgxColor;
    FSpecularColor: TgxColor;
    FMaterialLibrary: TgxAbstractMaterialLibrary;
    FMainTexture: TgxTexture;
    FMainTexName   : TgxLibMaterialName;
    FSpecularPower: Single;
    FLightPower: Single;
    function GetMaterialLibrary: TgxAbstractMaterialLibrary;
    procedure SetMainTexTexture(const Value: TgxTexture);
    function GetMainTexName: TgxLibMaterialName;
    procedure SetMainTexName(const Value: TgxLibMaterialName);
    procedure SetDiffuseColor(AValue: TgxColor);
    procedure SetAmbientColor(AValue: TgxColor);
    procedure SetSpecularColor(AValue: TgxColor);
  protected
    procedure DoInitialize(var rci : TgxRenderContextInfo; Sender : TObject); override;
    procedure DoApply(var rci : TgxRenderContextInfo; Sender : TObject); override;
    procedure SetMaterialLibrary(const Value: TgxAbstractMaterialLibrary); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    property DiffuseColor : TgxColor read FDiffuseColor Write setDiffuseColor;
    property SpecularColor : TgxColor Read FSpecularColor Write setSpecularColor;
    property AmbientColor : TgxColor Read FAmbientColor Write setAmbientColor;
    property MaterialLibrary: TgxAbstractMaterialLibrary read getMaterialLibrary write SetMaterialLibrary;
    property MainTexture: TgxTexture read FMainTexture write SetMainTexTexture;
    property MainTextureName: TgxLibMaterialName read GetMainTexName write SetMainTexName;
    property SpecularPower: Single read FSpecularPower write FSpecularPower;
    property LightPower: Single read FLightPower write FLightPower;
  end;

  TgxSLSimpleLatticeShader = class(TgxCustomGLSLSimpleLatticeShader)
  published
    property LatticeScale;
    property LatticeThreshold;
  end;

  TgxSLLatticeShader = class(TgxCustomGLSLLatticeShader)
  published
    property LatticeScale;
    property LatticeThreshold;
    property AmbientColor;
    property DiffuseColor;
    property SpecularColor;
    property MainTexture;
    property SpecularPower;
    property LightPower;
  end;

//----------------- SEM Shader ---------------------

type
  (* Custom class for SEM Shader : Spherical Environment Mapping *)
  TgxCustomGLSLSemShader = class(TGXSLCustomShader)
  private
    FAmbientColor: TgxColor;
//    FDiffuseColor: TgxColor;
    FSpecularColor: TgxColor;
    FAmbientFactor : Single;
    FDiffuseFactor : Single;
    FSpecularFactor : Single;
    FMaterialLibrary: TgxAbstractMaterialLibrary;
    FMainTexture: TgxTexture;
    FMainTexName   : TgxLibMaterialName;
//    FSpecularPower: Single;
//    FLightPower: Single;
    function GetMaterialLibrary: TgxAbstractMaterialLibrary;
    procedure SetMainTexTexture(const Value: TgxTexture);
    function GetMainTexName: TgxLibMaterialName;
    procedure SetMainTexName(const Value: TgxLibMaterialName);
    //procedure SetDiffuseColor(AValue: TgxColor);
    procedure SetAmbientColor(AValue: TgxColor);
    procedure SetSpecularColor(AValue: TgxColor);
  protected
    procedure DoApply(var rci : TgxRenderContextInfo; Sender : TObject); override;
    function DoUnApply(var rci: TgxRenderContextInfo): Boolean; override;
    procedure SetMaterialLibrary(const Value: TgxAbstractMaterialLibrary); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
//    property DiffuseColor : TgxColor read FDiffuseColor Write setDiffuseColor;
    property SpecularColor : TgxColor Read FSpecularColor Write setSpecularColor;
    property AmbientColor : TgxColor Read FAmbientColor Write setAmbientColor;
    property AmbientFactor : Single Read FAmbientFactor Write FAmbientFactor;
    property DiffuseFactor : Single Read FDiffuseFactor Write FDiffuseFactor;
    property SpecularFactor : Single Read FSpecularFactor Write FSpecularFactor;
    property MaterialLibrary: TgxAbstractMaterialLibrary read getMaterialLibrary write SetMaterialLibrary;
    property MainTexture: TgxTexture read FMainTexture write SetMainTexTexture;
    property MainTextureName: TgxLibMaterialName read GetMainTexName write SetMainTexName;
//    property SpecularPower: Single read FSpecularPower write FSpecularPower;
//    property LightPower: Single read FLightPower write FLightPower;
  end;

  TgxSLSemShader = class(TgxCustomGLSLSemShader)
  published
    property AmbientColor;
//    property DiffuseColor;
    property SpecularColor;
    property AmbientFactor;
    property DiffuseFactor;
    property SpecularFactor;
    property MaterialLibrary;
    property MainTexture;
    property MainTextureName;
  end;

//----------------- Toon Shader ---------------------

type
  (* Custom class for Toon Shader *)
  TgxCustomGLSLToonShader = class(TGXSLCustomShader)
  private
    FHighlightColor : TgxColor;
    FMidColor : TgxColor;
    FLightenShadowColor : TgxColor;
    FDarkenShadowColor : TgxColor;
    FOutlineColor : TgxColor;
    FHighlightSize : Single;
    FMidSize : Single;
    FShadowSize : Single;
    FOutlineWidth : Single;
    procedure SetHighLightColor(AValue: TgxColor);
    procedure SetMidColor(AValue: TgxColor);
    procedure SetLightenShadowColor(AValue: TgxColor);
    procedure SetDarkenShadowColor(AValue: TgxColor);
    procedure SetOutlineColor(AValue: TgxColor);
  protected
    procedure DoApply(var rci : TgxRenderContextInfo; Sender : TObject); override;
    function DoUnApply(var rci: TgxRenderContextInfo): Boolean; override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    property HighlightColor : TgxColor read FHighlightColor Write setHighlightColor;
    property MidColor : TgxColor read FMidColor Write setMidColor;
    property LightenShadowColor : TgxColor Read FLightenShadowColor Write setLightenShadowColor;
    property DarkenShadowrColor : TgxColor Read FDarkenShadowColor Write setDarkenShadowColor;
    property OutlinetColor : TgxColor Read FOutlineColor Write setOutlineColor;
    property HighlightSize : Single read FHighlightSize write FHighlightSize;
    property MidSize : Single read FMidSize write FMidSize;
    property ShadowSize : Single read FShadowSize write FShadowSize;
    property OutlineWidth : Single read FOutlineWidth write FOutlineWidth;
  end;

type
  TgxSLToonShader = class(TgxCustomGLSLToonShader)
  published
    property HighlightColor;
    property MidColor;
    property LightenShadowColor;
    property DarkenShadowrColor;
    property OutlinetColor;
    property HighlightSize;
    property MidSize;
    property ShadowSize;
    property OutlineWidth;
  end;

//----------- Vertex Displacement Shader -----------

 (*
   VertexDisplacement shader: Basic Vertex Displacement with Perlin Noise
   You can Improved it:
   The vertex displacement can be done by reading a 2D or 3D texture.
   It can be done along the normal or the tangent.
   It can be scaled, twisted, modulated, inverted...
   Converted from : https://www.clicktorelease.com/blog/vertex-displacement-noise-3d-webgl-glsl-three-js
   At this time only one light source is supported
*)
  TgxCustomGLSLVertexDisplacementShader = class(TGXSLCustomShader)
  private
    FAmbientColor: TgxColor;
//    FDiffuseColor: TgxColor;
    FSpecularColor: TgxColor;
    FAmbientFactor : Single;
    FDiffuseFactor : Single;
    FSpecularFactor : Single;
    FMaterialLibrary: TgxAbstractMaterialLibrary;
    FMainTexture: TgxTexture;
    FMainTexName   : TgxLibMaterialName;
    FElapsedTime : Single;
    FNoise : Single;
    FDisplacementScale : Single;
    FNoiseScale : Single;
    FTurbulenceFactor : Single;
    FNoisePeriod : Single;
    FTimeFactor : Single;
    function GetMaterialLibrary: TgxAbstractMaterialLibrary;
    procedure SetMainTexTexture(const Value: TgxTexture);
    function GetMainTexName: TgxLibMaterialName;
    procedure SetMainTexName(const Value: TgxLibMaterialName);
    //procedure SetDiffuseColor(AValue: TgxColor);
    procedure SetAmbientColor(AValue: TgxColor);
    procedure SetSpecularColor(AValue: TgxColor);
  protected
    procedure DoApply(var rci : TgxRenderContextInfo; Sender : TObject); override;
    function DoUnApply(var rci: TgxRenderContextInfo): Boolean; override;
    procedure SetMaterialLibrary(const Value: TgxAbstractMaterialLibrary); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
//    property DiffuseColor : TgxColor read FDiffuseColor Write setDiffuseColor;
    property SpecularColor : TgxColor Read FSpecularColor Write setSpecularColor;
    property AmbientColor : TgxColor Read FAmbientColor Write setAmbientColor;
    property AmbientFactor : Single Read FAmbientFactor Write FAmbientFactor;
    property DiffuseFactor : Single Read FDiffuseFactor Write FDiffuseFactor;
    property SpecularFactor : Single Read FSpecularFactor Write FSpecularFactor;
    property MaterialLibrary: TgxAbstractMaterialLibrary read getMaterialLibrary write SetMaterialLibrary;
    property MainTexture: TgxTexture read FMainTexture write SetMainTexTexture;
    property MainTextureName: TgxLibMaterialName read GetMainTexName write SetMainTexName;
    property ElapsedTime: Single read FElapsedTime write FElapsedTime;
    property NoiseFactor : Single read FNoise write FNoise;
    property NoiseScale : Single read FNoiseScale write FNoiseScale;
    property TurbulenceFactor : Single read FTurbulenceFactor write FTurbulenceFactor;
    property NoisePeriod : Single read FNoisePeriod write FNoisePeriod;
    property DisplacementScale : Single read FDisplacementScale write FDisplacementScale;
    property TimeFactor : Single read FTimeFactor write FTimeFactor;
  end;

  TgxSLVertexDisplacementShader = class(TgxCustomGLSLVertexDisplacementShader)
  published
    property AmbientColor;
//    property DiffuseColor;
    property SpecularColor;
    property AmbientFactor;
    property DiffuseFactor;
    property SpecularFactor;
    property MaterialLibrary;
    property MainTexture;
    property MainTextureName;
    property ElapsedTime;
    property NoiseFactor;
    property NoiseScale;
    property TurbulenceFactor;
    property NoisePeriod;
    property DisplacementScale;
    property TimeFactor;
  end;


//----------------------------------------------------------
implementation
//----------------------------------------------------------

const
  fBuffSize: Integer = 512;

(***************************************************
                 TgxCelShader
***************************************************)

constructor TgxCelShader.Create(AOwner: TComponent);
begin
  inherited;
  FOutlineWidth := 3;
  FCelShaderOptions := [csoOutlines];
  FShadeTexture := TgxTexture.Create(Self);
  with FShadeTexture do
  begin
    Enabled := True;
    MinFilter := miNearest;
    MagFilter := maNearest;
    TextureWrap := twNone;
    TextureMode := tmModulate;
  end;
  FOutlineColor := TgxColor.Create(Self);
  FOutlineColor.OnNotifyChange := NotifyChange;
  FOutlineColor.Initialize(clrBlack);
  ShaderStyle := ssLowLevel;
  FVPHandle := TgxVertexProgramHandle.Create;
end;

destructor TgxCelShader.Destroy;
begin
  FVPHandle.Free;
  FShadeTexture.Free;
  FOutlineColor.Free;
  inherited;
end;

procedure TgxCelShader.Loaded;
begin
  inherited;
  BuildShadeTexture;
end;


procedure TgxCelShader.BuildShadeTexture;
var
  bmp32: TgxBitmap32;
  i: Integer;
  intensity: Byte;
begin
  if csoNoBuildShadeTexture in FCelShaderOptions then
    exit;
  with FShadeTexture do
  begin
    ImageClassName := 'TgxBlankImage';
    TgxBlankImage(Image).Width := 128;
    TgxBlankImage(Image).Height := 2;
  end;

  bmp32 := FShadeTexture.Image.GetBitmap32;
  bmp32.Blank := false;
  for i := 0 to bmp32.Width - 1 do
  begin
    intensity := i * (256 div bmp32.Width);

    if Assigned(FOnGetIntensity) then
      FOnGetIntensity(Self, intensity)
    else
    begin
      if intensity > 230 then
        intensity := 255
      else if intensity > 150 then
        intensity := 230
      else if intensity > 100 then
        intensity := intensity + 50
      else
        intensity := 150;
    end;
    bmp32.Data^[i].r := intensity;
    bmp32.Data^[i].g := intensity;
    bmp32.Data^[i].b := intensity;
    bmp32.Data^[i].a := 1;
    bmp32.Data^[i + bmp32.Width] := bmp32.Data^[i];
  end;
end;

function TgxCelShader.GenerateVertexProgram: string;
var
  VP: TStringList;
begin
  VP := TStringList.Create;
  VP.Add('!!ARBvp1.0');
  VP.Add('OPTION ARB_position_invariant;');
  VP.Add('PARAM mvinv[4] = { state.matrix.modelview.inverse };');
  VP.Add('PARAM lightPos = program.local[0];');
  VP.Add('TEMP temp, light, normal;');
  VP.Add('   DP4 light.x, mvinv[0], lightPos;');
  VP.Add('   DP4 light.y, mvinv[1], lightPos;');
  VP.Add('   DP4 light.z, mvinv[2], lightPos;');
  VP.Add('   ADD light, light, -vertex.position;');
  VP.Add('   DP3 temp.x, light, light;');
  VP.Add('   RSQ temp.x, temp.x;');
  VP.Add('   MUL light, temp.x, light;');
  VP.Add('   DP3 temp, vertex.normal, vertex.normal;');
  VP.Add('   RSQ temp.x, temp.x;');
  VP.Add('   MUL normal, temp.x, vertex.normal;');
  VP.Add('   MOV result.color, state.material.diffuse;');
  if csoTextured in FCelShaderOptions then
  begin
    VP.Add('   MOV result.texcoord[0], vertex.texcoord[0];');
    VP.Add('   DP3 result.texcoord[1].x, normal, light;');
  end
  else
  begin
    VP.Add('   DP3 result.texcoord[0].x, normal, light;');
  end;
  VP.Add('END');
  Result := VP.Text;
  VP.Free;
end;


procedure TgxCelShader.DoApply(var rci: TgxRenderContextInfo; Sender: TObject);
var
  light: TGLVector;
begin
  if (csDesigning in ComponentState) then
    exit;

  FVPHandle.AllocateHandle;
  if FVPHandle.IsDataNeedUpdate then
  begin
    FVPHandle.LoadARBProgram(GenerateVertexProgram);
    Enabled := FVPHandle.Ready;
    FVPHandle.NotifyDataUpdated;
    if not Enabled then
      Abort;
  end;

  rci.gxStates.Disable(stLighting);
  glGetLightfv(GL_LIGHT0, GL_POSITION, @light.X);
  FVPHandle.Enable;
  FVPHandle.Bind;
  glProgramLocalParameter4fvARB(GL_VERTEX_PROGRAM_NV, 0, @light.X);

  if (csoTextured in FCelShaderOptions) then
    FShadeTexture.ApplyAsTexture2(rci, nil)
  else
    FShadeTexture.Apply(rci);

  FOutlinePass := csoOutlines in FCelShaderOptions;
  FUnApplyShadeTexture := True;
end;


function TgxCelShader.DoUnApply(var rci: TgxRenderContextInfo): Boolean;
begin
  Result := False;
  if (csDesigning in ComponentState) then
    exit;

  FVPHandle.Disable;

  if FUnApplyShadeTexture then
  begin
    if (csoTextured in FCelShaderOptions) then
      FShadeTexture.UnApplyAsTexture2(rci, false)
    else
      FShadeTexture.UnApply(rci);
    FUnApplyShadeTexture := False;
  end;

  if FOutlinePass then
    with rci.gxStates do
    begin
      ActiveTexture := 0;
      ActiveTextureEnabled[ttTexture2D] := False;
      Enable(stBlend);
      Enable(stLineSmooth);
      Disable(stLineStipple);
      Enable(stCullFace);

      PolygonMode := pmLines;
      LineWidth := FOutlineWidth;
      CullFaceMode := cmFront;
      LineSmoothHint := hintNicest;
      SetBlendFunc(bfSrcAlpha, bfOneMinusSrcAlpha);
      DepthFunc := cfLEqual;
      glColor4fv(@FOutlineColor.AsAddress^);

      Result := True;
      FOutlinePass := False;
      Exit;
    end
  else
    with rci.gxStates do
    begin
      rci.gxStates.PolygonMode := pmFill;
      rci.gxStates.CullFaceMode := cmBack;
      rci.gxStates.DepthFunc := cfLEqual;
    end;
end;

procedure TgxCelShader.SetCelShaderOptions(const val: TgxCelShaderOptions);
begin
  if val <> FCelShaderOptions then
  begin
    FCelShaderOptions := val;
    BuildShadeTexture;
    FVPHandle.NotifyChangesOfData;
    NotifyChange(Self);
  end;
end;


procedure TgxCelShader.SetOutlineWidth(const val: Single);
begin
  if val <> FOutlineWidth then
  begin
    FOutlineWidth := val;
    NotifyChange(Self);
  end;
end;


procedure TgxCelShader.SetOutlineColor(const val: TgxColor);
begin
  if val <> FOutlineColor then
  begin
    FOutlineColor.Assign(val);
    NotifyChange(Self);
  end;
end;




(****************************************
   TgxCustomGLSLSimpleErosionShader
*****************************************)

constructor TgxCustomGLSLSimpleErosionShader.Create(AOwner: TComponent);
begin
  inherited;
  with VertexProgram.Code do
  begin
    Add('uniform float Scale; ');
    Add('varying vec3 normal; ');
    Add('varying vec2 vTexCoord; ');
    Add('varying vec3 lightVec; ');
    Add('varying vec3 viewVec; ');
    Add('varying vec3 Position; ');
    Add(' ');
    Add('void main(void) { ');
   // Add('  mat4 mWorld = gl_ModelViewMatrix; ');
    Add('  vec3 Normal = gl_Normal; ');
    Add('  vec4 lightPos = gl_LightSource[0].position;');
    Add('  vec4 vert =  gl_ModelViewMatrix * gl_Vertex; ');
    Add('  normal = gl_NormalMatrix * gl_Normal; ');
    Add('  Position       = vec3(gl_Vertex)*Scale; ');
    Add('  vTexCoord = gl_MultiTexCoord0; ');
    Add('  lightVec = vec3(lightPos - vert); ');
    Add('  viewVec = -vec3(vert); ');
    Add('  gl_Position    = ftransform(); ');
    Add('} ');
  end;

  with FragmentProgram.Code do
  begin
    Add('uniform float ErosionFactor; ');
    Add('uniform float IntensityFactor1; ');
    Add('uniform float IntensityFactor2; ');
    Add('uniform sampler2D MainTexture; ');
    Add('uniform sampler2D Noise2d; ');
    Add('uniform sampler2D ErosionTexture; ');
    Add('uniform vec4  SpecularColor; ');
    Add('uniform vec4  AmbientColor; ');
    Add('uniform float DiffuseIntensity; ');
    Add('uniform float AmbientIntensity; ');
    Add('uniform float SpecularIntensity; ');
    Add('uniform float SpecularRoughness; ');
    Add('uniform float AnisoRoughness; ');
    Add('varying vec3 normal; ');
    Add('varying vec2 vTexCoord; ');
    Add('varying vec3 lightVec; ');
    Add('varying vec3 viewVec; ');
    Add('varying vec3 Position; ');
    Add(' ');
    Add('void main (void) ');
    Add('{ ');
    Add('  vec3 offset     = vec3(- ErosionFactor, - ErosionFactor + 0.06, - ErosionFactor * 0.92); ');
    Add('  vec4 DiffuseColor;    ');
    Add('  vec4 Color1 = texture2D(MainTexture,vTexCoord); ');
    Add('  vec4 Color2 = texture2D(ErosionTexture,vTexCoord); ');
    Add('  // Compute noise ');
    Add('  vec3 noiseCoord = Position.xyz + offset; ');
    Add('  vec4 noiseVec   = texture2D(Noise2d, noiseCoord.xy); ');
    Add('  float intensity = (abs(noiseVec[0] - 0.25) + ');
    Add('                     abs(noiseVec[1] - 0.125) + ');
    Add('                     abs(noiseVec[2] - 0.0625) + ');
    Add('                     abs(noiseVec[3] - 0.03125)); ');
    Add('  // continue noise evaluation');
    Add('  intensity = IntensityFactor1 * (noiseVec.x + noiseVec.y+ noiseVec.z + noiseVec.w); ');
    Add('  intensity = IntensityFactor2 * abs(2.0 * intensity -1.0); ');
    Add('  // discard pixels in a psuedo-random fashion (noise) ');
    Add('  if (intensity < fract(0.5 - offset.x - offset.y - offset.z)) discard; ');
    Add('  // color fragments different colors using noise ');
    Add('  clamp(intensity, 0.0, 1.0); ');
    Add('  Color2.a =1.0-intensity; ');
    Add('  Color1.a =1.0; ');
    Add('  DiffuseColor = mix(Color2, Color1, intensity); ');
    Add('  DiffuseColor.a = intensity; ');
    Add('  // Anisotropic Specular Lighting Reflection ');
    // Anisotropic Specular Reflection
    // This  is useful for depicting surfaces
    // such as velvet or brushed metal,
    // it allows you to stretch the highlight along a
    // SpecDirection vector (in object space)
    // add  new var and replace the follow line
    // vec3 T = cross(norm,V) by vec3 T = cross(norm,normalize(SpecDirection));
    Add('  vec3 norm = normalize(normal); ');
    Add('  vec3 L = normalize(lightVec); ');
    Add('  vec3 V = normalize(viewVec); ');
    Add('  vec3 halfAngle = normalize(L + V); ');
    Add('  vec3 T = cross(norm,V);  ');
    Add('  float NdotL = dot(L, norm); ');
    Add('  float NdotH = clamp(dot(halfAngle, norm), 0.0, 1.0); ');
    Add('  // "Half-Lambert" technique for more pleasing diffuse term ');
    Add('  float diffuse = 0.5 * NdotL + 0.5; ');
    Add('  float specular = pow(NdotH,1.0/SpecularRoughness); '); //54
    Add('  // Heidrich-Seidel anisotropic distribution ');
    Add('  float ldott = dot(L,T); ');
    Add('  float vdott = dot(V,T); ');
    Add('  float aniso = pow(sin(ldott)*sin(vdott) + cos(ldott)*cos(vdott),1.0/AnisoRoughness); ');
    Add(' vec3 FinalColour = AmbientColor*AmbientIntensity + ');
    Add('                         DiffuseColor*diffuse*DiffuseIntensity + ');
    Add('                         SpecularColor*aniso*specular*SpecularIntensity; ');
    Add('  gl_FragColor = vec4(FinalColour,intensity); ');
    Add('} ');
  end;

  //setup initial parameters

  FAmbientColor := TgxColor.Create(self);
  FAmbientColor.SetColor(0.2,0.2,0.2,1.0);
  FSpecularColor := TgxColor.Create(self);
  FSpecularColor.SetColor(0.75,0.75,0.75,1.0);
  FAmbientFactor  := 0.8;
  FDiffuseFactor  :=0.9;
  FSpecularFactor :=0.8;
  FSpecularRoughness :=0.45;
  FAnisotropicRoughness :=0.35;
  FErosionScale     := 0.03;
  FErosionFactor    := 0.35;
  FIntensityFactor1 := 0.75;
  FIntensityFactor2 := 1.95;
end;

destructor TgxCustomGLSLSimpleErosionShader.Destroy;
begin
  FAmbientColor.Free;
  FSpecularColor.Free;
  inherited;
end;

procedure TgxCustomGLSLSimpleErosionShader.DoApply(var rci : TgxRenderContextInfo; Sender : TObject);
begin
  GetGXSLProg.UseProgramObject;
  param['AmbientColor'].AsVector4f := FAmbientColor.Color;
  param['SpecularColor'].AsVector4f := FSpecularColor.Color;
  param['AmbientIntensity'].AsVector1f := FAmbientFactor;
  param['DiffuseIntensity'].AsVector1f := FDiffuseFactor;
  param['SpecularIntensity'].AsVector1f := FSpecularFactor;
  param['SpecularRoughness'].AsVector1f := FSpecularRoughness;
  param['AnisoRoughness'].AsVector1f := FAnisotropicRoughness;
  param['ErosionFactor'].AsVector1f := FErosionFactor;
  param['IntensityFactor1'].AsVector1f := FIntensityFactor1;
  param['IntensityFactor2'].AsVector1f := FIntensityFactor2;
  param['Scale'].AsVector1f := FErosionScale;
  param['MainTexture'].AsTexture2D[0] := FMainTex;
  param['Noise2d'].AsTexture2D[1] := FNoiseTex;
  param['ErosionTexture'].AsTexture2D[2] := FErosionTex;
 // GetGXSLProg.UniformTextureHandle['Noise2d', 1, GL_TEXTURE_2D] := FNoiseTexture.Handle;
end;

function TgxCustomGLSLSimpleErosionShader.DoUnApply(var rci: TgxRenderContextInfo): Boolean;
begin
  GetGXSLProg.EndUseProgramObject;
  //gl.PopAttrib;
  Result := False;
end;

function TgxCustomGLSLSimpleErosionShader.GetMaterialLibrary: TgxAbstractMaterialLibrary;
begin
  Result := FMaterialLibrary;
end;

procedure TgxCustomGLSLSimpleErosionShader.SetMaterialLibrary(const Value: TgxAbstractMaterialLibrary);
begin
  if FMaterialLibrary <> nil then FMaterialLibrary.RemoveFreeNotification(Self);
  FMaterialLibrary := Value;
  if (FMaterialLibrary <> nil)
    and (FMaterialLibrary is TgxAbstractMaterialLibrary) then
      FMaterialLibrary.FreeNotification(Self);
end;

procedure TgxCustomGLSLSimpleErosionShader.SetMainTexTexture(const Value: TgxTexture);
begin
  if FMainTex = Value then Exit;
  FMainTex := Value;
  NotifyChange(Self)
end;

procedure TgxCustomGLSLSimpleErosionShader.SetNoiseTexTexture(const Value: TgxTexture);
begin
  if FNoiseTex = Value then Exit;
  FNoiseTex := Value;
  NotifyChange(Self);
end;

procedure TgxCustomGLSLSimpleErosionShader.SetErosionTexTexture(const Value: TgxTexture);
begin
  if FErosionTex = Value then Exit;
  FErosionTex := Value;
  NotifyChange(Self);
end;

function TgxCustomGLSLSimpleErosionShader.GetNoiseTexName: TgxLibMaterialName;
begin
  Result := TgxMaterialLibrary(FMaterialLibrary).GetNameOfTexture(FNoiseTex);
  if Result = '' then Result := FNoiseTexName;
end;

procedure TgxCustomGLSLSimpleErosionShader.SetNoiseTexName(const Value: TgxLibMaterialName);
begin
  //Assert(not(assigned(FMaterialLibrary)),'You must set Material Library Before');
  if FNoiseTexName = Value then Exit;
  FNoiseTexName  := Value;
  FNoiseTex := TgxMaterialLibrary(FMaterialLibrary).TextureByName(FNoiseTexName);
  NotifyChange(Self);
end;

function TgxCustomGLSLSimpleErosionShader.GetMainTexName: TgxLibMaterialName;
begin
  Result := TgxMaterialLibrary(FMaterialLibrary).GetNameOfTexture(FMainTex);
  if Result = '' then Result := FMainTexName;
end;

procedure TgxCustomGLSLSimpleErosionShader.SetMainTexName(const Value: TgxLibMaterialName);
begin
 // Assert(not(assigned(FMaterialLibrary)),'You must set Material Library Before');
  if FMainTexName = Value then Exit;
  FMainTexName  := Value;

  FMainTex := TgxMaterialLibrary(FMaterialLibrary).TextureByName(FMainTexName);
  NotifyChange(Self);
end;

function TgxCustomGLSLSimpleErosionShader.GetErosionTexName: TgxLibMaterialName;
begin
  Result := TgxMaterialLibrary(FMaterialLibrary).GetNameOfTexture(FErosionTex);
  if Result = '' then Result := FErosionTexName;
end;

procedure TgxCustomGLSLSimpleErosionShader.SetErosionTexName(const Value: TgxLibMaterialName);
begin
 // Assert(not(assigned(FMaterialLibrary)),'You must set Material Library Before');
  if FErosionTexName = Value then Exit;
  FErosionTexName  := Value;

  FErosionTex := TgxMaterialLibrary(FMaterialLibrary).TextureByName(FErosionTexName);
  NotifyChange(Self);
end;

procedure TgxCustomGLSLSimpleErosionShader.SetAmbientColor(AValue: TgxColor);
begin
  FAmbientColor.DirectColor := AValue.Color;
end;

procedure TgxCustomGLSLSimpleErosionShader.SetSpecularColor(AValue: TgxColor);
begin
  FSpecularColor.DirectColor := AValue.Color;
end;


procedure TgxCustomGLSLSimpleErosionShader.Notification(AComponent: TComponent; Operation: TOperation);
var
  Index: Integer;
begin
  inherited;
  if Operation = opRemove then
    if AComponent = FMaterialLibrary then
      if FMaterialLibrary <> nil then
      begin
        // Need to nil the textures that were owned by it
        if FNoiseTex <> nil then
        begin
          Index := TgxMaterialLibrary(FMaterialLibrary).Materials.GetTextureIndex(FNoiseTex);
          if Index <> -1 then
            SetNoiseTexTexture(nil);
        end;

        if FMainTex <> nil then
        begin
          Index := TgxMaterialLibrary(FMaterialLibrary).Materials.GetTextureIndex(FMainTex);
          if Index <> -1 then
            SetMainTexTexture(nil);
        end;

        if FErosionTex <> nil then
        begin
          Index := TgxMaterialLibrary(FMaterialLibrary).Materials.GetTextureIndex(FErosionTex);
          if Index <> -1 then
            SetErosionTexTexture(nil);
        end;

        FMaterialLibrary := nil;
      end;
end;

(* ---------------------------------
  TgxCustomGLSLGlassShader
  ---------------------------------- *)

constructor TgxCustomGLSLGlassShader.Create(AOwner: TComponent);
begin
  inherited;
  with VertexProgram.Code do
  begin
    clear;
    Add('varying vec3  Normal; ');
    Add('varying vec3  EyeDir; ');
    Add('varying vec4  EyePos; ');
    Add('varying float LightIntensity; ');
    Add('void main(void) ');
    Add('{ ');
    Add('  gl_Position    = ftransform(); ');
    Add('  vec3 LightPos = gl_LightSource[0].position.xyz;');
    Add('  Normal         = normalize(gl_NormalMatrix * gl_Normal); ');
    Add('  vec4 pos       = gl_ModelViewMatrix * gl_Vertex; ');
    Add('  EyeDir         = -pos.xyz; ');
    Add('  EyePos		   = gl_ModelViewProjectionMatrix * gl_Vertex; ');
    Add('  LightIntensity = max(dot(normalize(LightPos - EyeDir), Normal), 0.0); ');
    Add('} ');
  end;

  with FragmentProgram.Code do
  begin
    clear;
    Add('const vec3 Xunitvec = vec3 (1.0, 0.0, 0.0); ');
    Add('const vec3 Yunitvec = vec3 (0.0, 1.0, 0.0); ');
    Add('uniform vec4  BaseColor; ');
    Add('uniform float Depth; ');
    Add('uniform float MixRatio; ');
    Add('uniform float AlphaIntensity; ');
    // need to scale our framebuffer - it has a fixed width/height of 2048
    Add('uniform float FrameWidth; ');
    Add('uniform float FrameHeight; ');
    Add('uniform sampler2D EnvMap; ');
    Add('uniform sampler2D RefractionMap; ');
    Add('varying vec3  Normal; ');
    Add('varying vec3  EyeDir; ');
    Add('varying vec4  EyePos; ');
    Add('varying float LightIntensity; ');
    Add('void main (void) ');
    Add('{ ');
    // Compute reflection vector
    Add('  vec3 reflectDir = reflect(EyeDir, Normal); ');
    // Compute altitude and azimuth angles
    Add('  vec2 index; ');
    Add('  index.y = dot(normalize(reflectDir), Yunitvec); ');
    Add('  reflectDir.y = 0.0; ');
    Add('  index.x = dot(normalize(reflectDir), Xunitvec) * 0.5; ');
    // Translate index values into proper range
    Add('  if (reflectDir.z >= 0.0) ');
    Add('      index = (index + 1.0) * 0.5; ');
    Add('  else ');
    Add('  { ');
    Add('    index.t = (index.t + 1.0) * 0.5; ');
    Add('    index.s = (-index.s) * 0.5 + 1.0; ');
    Add('  } ');
    // if reflectDir.z >= 0.0, s will go from 0.25 to 0.75
    // if reflectDir.z <  0.0, s will go from 0.75 to 1.25, and
    // that's OK, because we've set the texture to wrap.

    // Do a lookup into the environment map.
    Add('  vec4 envColor = texture2D(EnvMap, index); ');
    // calc fresnels term.  This allows a view dependant blend of reflection/refraction
    Add('  float fresnel = abs(dot(normalize(EyeDir), Normal)); ');
    Add('  fresnel *= MixRatio; ');
    Add('  fresnel = clamp(fresnel, 0.1, 0.9); ');
    // calc refraction
    Add('  vec3 refractionDir = normalize(EyeDir) - normalize(Normal); ');
    // Scale the refraction so the z element is equal to depth
    Add('  float depthVal = Depth / -refractionDir.z; ');
    // perform the div by w
    Add('  float recipW = 1.0 / EyePos.w; ');
    Add('  vec2 eye = EyePos.xy * vec2(recipW); ');
    // calc the refraction lookup
    Add('  index.s = (eye.x + refractionDir.x * depthVal); ');
    Add('  index.t = (eye.y + refractionDir.y * depthVal); ');
    // scale and shift so we're in the range 0-1
    Add('  index.s = index.s / 2.0 + 0.5; ');
    Add('  index.t = index.t / 2.0 + 0.5; ');
    // as we're looking at the framebuffer, we want it clamping at the edge of the rendered scene, not the edge of the texture,
    // so we clamp before scaling to fit
    Add('  float recip1k = 1.0 / 2048.0; ');
    Add('  index.s = clamp(index.s, 0.0, 1.0 - recip1k); ');
    Add('  index.t = clamp(index.t, 0.0, 1.0 - recip1k); ');
    // scale the texture so we just see the rendered framebuffer
    Add('  index.s = index.s * FrameWidth * recip1k; ');
    Add('  index.t = index.t * FrameHeight * recip1k; ');

    Add('  vec4 RefractionColor = texture2D(RefractionMap, index.st); ');
    // Add('  RefractionColor.a = 0.9; ');

    // Add('  RefractionColor = RefractionColor+vec3(0.75,0.75,0.75); ');//
    // Add lighting to base color and mix
    // Add('  vec4 base = LightIntensity * BaseColor; ');
    Add('  envColor = mix(envColor, BaseColor,LightIntensity); ');
    Add('  envColor = mix(envColor, RefractionColor, fresnel); ');
    Add('  envColor.a = AlphaIntensity; ');
    Add('  gl_FragColor = envColor; //vec4 (envColor.rgb, 0.3); ');
    Add('} ');
  end;
  // FMainTexture := TgxTexture.Create(nil);
  // FMainTexture.Disabled := False;
  // FMainTexture.Enabled := True;

  // setup initial parameters
  FDiffuseColor := TgxColor.Create(Self);
  FDepth := 0.1;
  FMix := 1.0;
  FAlpha := 1.0;
  FDiffuseColor.SetColor(0.15, 0.15, 0.15, 1.0);
  FBlendSrc := bfSrcAlpha;
  FBlendDst := bfDstAlpha;
end;

destructor TgxCustomGLSLGlassShader.Destroy;
begin
  FDiffuseColor.Destroy;
  inherited;
end;

procedure TgxCustomGLSLGlassShader.DoApply(var rci: TgxRenderContextInfo;
  Sender: TObject);
begin
  // Auto Render EnvMap
  // capture and create material from framebuffer

  // I don't say why but We need to reset and reaffect our texture otherwise one of the texture is broken
  with FMainTexture do
  begin
    PrepareBuildList;
    glActiveTexture(GL_TEXTURE0_ARB);
    glBindTexture(GL_TEXTURE_2D, Handle);
    glActiveTexture(GL_TEXTURE0_ARB);
  end;
  with FRefractionTexture do
  begin
    PrepareBuildList;
    glActiveTexture(GL_TEXTURE1_ARB);
    glBindTexture(GL_TEXTURE_2D, Handle);
    glActiveTexture(GL_TEXTURE0_ARB);
  end;

  FOwnerObject.Visible := False;
  TgxSceneBuffer(rci.buffer).CopyToTexture(FMainTexture);
  FOwnerObject.Visible := True;
  GetGXSLProg.UseProgramObject;

  // GetGXSLProg.Uniform4f['BaseColor'] := FDiffuseColor.Color;
  // GetGXSLProg.Uniform1f['Depth'] := FDepth;
  // GetGXSLProg.Uniform1f['MixRatio'] := FMix; // 0 - 2
  // GetGXSLProg.Uniform1f['FrameWidth'] := fBuffSize * 3.125;
  // GetGXSLProg.Uniform1f['FrameHeight'] := fBuffSize * 3.125;

  // SetTex('EnvMap',FMainTexture);  --> BUG
  // SetTex('RefractionMap',FRefractionTexture);

  param['BaseColor'].AsVector4f := FDiffuseColor.Color;
  param['Depth'].AsVector1f := FDepth; // 0 - 0.3
  param['MixRatio'].AsVector1f := FMix; // 0 - 2
  param['AlphaIntensity'].AsVector1f := FAlpha; // 0 - 2
  param['FrameWidth'].AsVector1f := fBuffSize * 3.75;
  param['FrameHeight'].AsVector1f := fBuffSize * 3.75;

  param['EnvMap'].AsTexture2D[0] := FMainTexture;
  param['RefractionMap'].AsTexture2D[1] := FRefractionTexture;

  glEnable(GL_BLEND);
  glBlendFunc(cGLBlendFunctionToGLEnum[FBlendSrc],
    cGLBlendFunctionToGLEnum[FBlendDst]);
end;

function TgxCustomGLSLGlassShader.DoUnApply
  (var rci: TgxRenderContextInfo): Boolean;
begin
  glDisable(GL_BLEND);
  GetGXSLProg.EndUseProgramObject;
  Result := False;
end;

function TgxCustomGLSLGlassShader.GetMaterialLibrary
  : TgxAbstractMaterialLibrary;
begin
  Result := FMaterialLibrary;
end;

procedure TgxCustomGLSLGlassShader.SetMaterialLibrary
  (const Value: TgxAbstractMaterialLibrary);
begin
  if FMaterialLibrary <> nil then
    FMaterialLibrary.RemoveFreeNotification(Self);
  FMaterialLibrary := Value;
  if (FMaterialLibrary <> nil) and
    (FMaterialLibrary is TgxAbstractMaterialLibrary) then
    FMaterialLibrary.FreeNotification(Self);
end;

procedure TgxCustomGLSLGlassShader.SetMainTexTexture(const Value: TgxTexture);
begin
  if FMainTexture = Value then
    Exit;
  FMainTexture := Value;
  NotifyChange(Self)
end;

function TgxCustomGLSLGlassShader.GetMainTexName: TgxLibMaterialName;
begin
  Result := TgxMaterialLibrary(FMaterialLibrary).GetNameOfTexture(FMainTexture);
  if Result = '' then
    Result := FMainTexName;
end;

procedure TgxCustomGLSLGlassShader.SetMainTexName
  (const Value: TgxLibMaterialName);
begin
  // Assert(not(assigned(FMaterialLibrary)),'You must set Material Library Before');
  if FMainTexName = Value then
    Exit;
  FMainTexName := Value;

  FMainTexture := TgxMaterialLibrary(FMaterialLibrary)
    .TextureByName(FMainTexName);
  NotifyChange(Self);
end;

procedure TgxCustomGLSLGlassShader.SetRefractionTexTexture
  (const Value: TgxTexture);
begin
  if FRefractionTexture = Value then
    Exit;
  FRefractionTexture := Value;
  NotifyChange(Self)
end;

function TgxCustomGLSLGlassShader.GetRefractionTexName: TgxLibMaterialName;
begin
  Result := TgxMaterialLibrary(FMaterialLibrary)
    .GetNameOfTexture(FRefractionTexture);
  if Result = '' then
    Result := FRefractionTexName;
end;

procedure TgxCustomGLSLGlassShader.SetRefractionTexName
  (const Value: TgxLibMaterialName);
begin
  // Assert(not(assigned(FMaterialLibrary)),'You must set Material Library Before');
  if FRefractionTexName = Value then
    Exit;
  FRefractionTexName := Value;

  FRefractionTexture := TgxMaterialLibrary(FMaterialLibrary)
    .TextureByName(FRefractionTexName);
  NotifyChange(Self);
end;

procedure TgxCustomGLSLGlassShader.SetDiffuseColor(AValue: TgxColor);
begin
  FDiffuseColor.DirectColor := AValue.Color;
end;

procedure TgxCustomGLSLGlassShader.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  Index: Integer;
begin
  inherited;
  if Operation = opRemove then
    if AComponent = FMaterialLibrary then
      if FMaterialLibrary <> nil then
      begin
        if FMainTexture <> nil then
        begin
          Index := TgxMaterialLibrary(FMaterialLibrary)
            .Materials.GetTextureIndex(FMainTexture);
          if Index <> -1 then
            SetMainTexTexture(nil);
        end;
        if FRefractionTexture <> nil then
        begin
          Index := TgxMaterialLibrary(FMaterialLibrary)
            .Materials.GetTextureIndex(FRefractionTexture);
          if Index <> -1 then
            SetRefractionTexTexture(nil);
        end;
        FMaterialLibrary := nil;
      end;
end;

//-------------------------------------------------------------
// TgxCustomGLSLSimpleGoochShader
//-------------------------------------------------------------

constructor TgxCustomGLSLSimpleGoochShader.Create(AOwner: TComponent);
begin
  inherited;

  with VertexProgram.Code do
  begin
    Clear;
    Add('varying vec3 vNormal; ');
    Add('varying vec3 lightVec; ');
    Add('varying vec3 viewVec; ');
    Add('varying vec3 ReflectVec; ');
    Add(' ');
    Add('void main() ');
    Add('{ ');
    Add('  gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex; ');
    Add('  vec4 lightPos = gl_LightSource[0].position;');
    Add('  vec4 vert =  gl_ModelViewMatrix * gl_Vertex; ');
    Add('  vec3 normal = gl_NormalMatrix * gl_Normal; ');
    Add('  vNormal  = normalize(normal); ');
    Add('  lightVec = vec3(lightPos - vert); ');
    Add('  ReflectVec    = normalize(reflect(-lightVec, vNormal)); ');
    Add('  viewVec = -vec3(vert); ');
    Add('} ');
  end;

  with FragmentProgram.Code do
  begin
    Clear;
    Add('uniform vec4  SurfaceColor; ');
    Add('uniform vec4  WarmColor; ');
    Add('uniform vec4  CoolColor; ');
    Add('uniform vec4  SpecularColor; ');
    Add('uniform vec4  AmbientColor; ');
    Add('uniform float DiffuseWarm; ');
    Add('uniform float DiffuseCool; ');
    Add('uniform float AmbientFactor; ');
    Add('uniform float DiffuseFactor; ');
    Add('uniform float SpecularFactor; ');
    Add('varying vec3 vNormal; ');
    Add('varying vec3 lightVec; ');
    Add('varying vec3 viewVec; ');
    Add('varying vec3 ReflectVec; ');
    Add(' ');
    Add('void main() ');
    Add('{ ');
    Add('vec3 L = normalize(lightVec); ');
    Add('vec3 V = normalize(viewVec); ');
    Add('vec3 halfAngle = normalize(L + V); ');
    Add('float NdotL   = (dot(L, vNormal) + 1.0) * 0.5; ');
    Add('float NdotH = clamp(dot(halfAngle, vNormal), 0.0, 1.0); ');
    Add('// "Half-Lambert" technique for more pleasing diffuse term ');
    Add('float diffuse = 0.5 * NdotL + 0.5; ');
    Add('vec3 nreflect = normalize(ReflectVec); ');
    Add('float specular    = max(dot(nreflect, V), 0.0); ');
    Add('specular          = pow(specular, 64.0); ');
    Add('vec4 kCool    = min(CoolColor + DiffuseCool * SurfaceColor, 1.0); ');
    Add('vec4 kWarm    = min(WarmColor + DiffuseWarm * SurfaceColor, 1.0); ');
    Add('vec4 Cgooch = mix(kWarm, kCool, diffuse); ');
    Add('vec3 result = AmbientFactor * AmbientColor.rgb + DiffuseFactor * Cgooch.rgb + SpecularColor.rgb * SpecularFactor *specular; ');
    Add('gl_FragColor = vec4(result,SurfaceColor.a); ');
    Add('} ');
  end;

  // Initial stuff.
  FDiffuseColor := TgxColor.Create(self);
  FDiffuseColor.SetColor(0.75,0.75,0.75,1.0);
  FWarmColor := TgxColor.Create(self);
  FWarmColor.SetColor(0.88,0.81,0.49,1.0);
  FCoolColor := TgxColor.Create(self);
  FCoolColor.SetColor(0.58,0.10,0.76,1.0);
  FAmbientColor := TgxColor.Create(self);
  FAmbientColor.SetColor(0.3,0.3,0.3,1.0);
  FSpecularColor := TgxColor.Create(self);
  FSpecularColor.SetColor(1.0,1.0,1.0,1.0);

  FDiffuseWarm    := 0.55;
  FDiffuseCool    := 0.30;
  FAmbientFactor  := 1.0;
  FDiffuseFactor  :=0.8;
  FSpecularFactor :=0.9;
  FBlendingMode:=bmxOpaque;
end;

destructor TgxCustomGLSLSimpleGoochShader.Destroy;
begin
  FDiffuseColor.Free;
  FWarmColor.Free;
  FCoolColor.Free;
  FSpecularColor.Free;
  FAmbientColor.Free;
  inherited;
end;

procedure TgxCustomGLSLSimpleGoochShader.DoApply(var rci: TgxRenderContextInfo;
  Sender: TObject);
begin
  GetGXSLProg.UseProgramObject;
  param['SurfaceColor'].AsVector4f := FDiffuseColor.Color;
  param['WarmColor'].AsVector4f := FWarmColor.Color;
  param['CoolColor'].AsVector4f := FCoolColor.Color;
  param['AmbientColor'].AsVector4f := FAmbientColor.Color;
  param['SpecularColor'].AsVector4f := FSpecularColor.Color;
  param['DiffuseWarm'].AsVector1f := FDiffuseWarm;
  param['DiffuseCool'].AsVector1f := FDiffuseCool;
  param['AmbientFactor'].AsVector1f := FAmbientFactor;
  param['DiffuseFactor'].AsVector1f := FDiffuseFactor;
  param['SpecularFactor'].AsVector1f := FSpecularFactor;

// gl.PushAttrib(GL_COLOR_BUFFER_BIT);
  ApplyBlendingModeEx(FBlendingMode);
//  gl.Enable(GL_BLEND);
//  gl.BlendFunc(cGLBlendFunctionToGLEnum[FBlendSrc],cGLBlendFunctionToGLEnum[FBlendDst]);
end;

function TgxCustomGLSLSimpleGoochShader.DoUnApply(var rci: TgxRenderContextInfo): Boolean;
begin

  glActiveTexture(GL_TEXTURE0_ARB);
  GetGXSLProg.EndUseProgramObject;
  UnApplyBlendingModeEx;
 // gl.PopAttrib;
  Result := False;
end;

procedure TgxCustomGLSLSimpleGoochShader.SetDiffuseColor(AValue: TgxColor);
begin
  FDiffuseColor.DirectColor := AValue.Color;
end;

procedure TgxCustomGLSLSimpleGoochShader.SetAmbientColor(AValue: TgxColor);
begin
  FAmbientColor.DirectColor := AValue.Color;
end;

procedure TgxCustomGLSLSimpleGoochShader.SetSpecularColor(AValue: TgxColor);
begin
  FSpecularColor.DirectColor := AValue.Color;
end;

procedure TgxCustomGLSLSimpleGoochShader.SetWarmColor(AValue: TgxColor);
begin
  FWarmColor.DirectColor := AValue.Color;
end;

procedure TgxCustomGLSLSimpleGoochShader.SetCoolColor(AValue: TgxColor);
begin
  FCoolColor.DirectColor := AValue.Color;
end;

(*------------------------------------------
// TgxCustomGLSLFurShader
 ------------------------------------------*)

constructor TgxCustomGLSLFurShader.Create(AOwner: TComponent);
begin
  inherited;
  with VertexProgram.Code do
  begin
    clear;
    Add('uniform float fFurLength; ');
    Add('uniform float fFurMaxLength; ');
    Add('uniform float pass_index; ');
    Add('uniform int UseRandomLength; ');
    Add('uniform float fLayer; // 0 to 1 for the level ');
    Add('uniform vec3 vGravity; ');
    Add('varying vec3 normal; ');
    Add('varying vec2  vTexCoord; ');
    Add('varying vec3 lightVec; ');
    // Add('varying vec3 viewVec; ');
    Add('float rand(vec2 co){ ');
    Add(' return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453); ');
    Add('} ');
    Add('void main() ');
    Add('{ ');
    Add('  mat4 mWorld = gl_ModelViewMatrix; ');
    Add('  vec3 Normal = gl_Normal; ');
    Add('  vec4 Position = gl_Vertex; ');
    Add('  vec4 lightPos = gl_LightSource[0].position;');
    Add('  vec4 vert =  gl_ModelViewMatrix * gl_Vertex; ');
    Add('  normal = gl_NormalMatrix * gl_Normal; ');
    // Additional Gravit/Force Code
    Add('  vec3 vGravity2 = vGravity *mat3(mWorld ); ');
    // We use the pow function, so that only the tips of the hairs bend
    Add('  float k = pow(fLayer, 3.0); ');
    // Random the Hair length  perhaps will can use a texture map for controling.
    Add(' vec3 vNormal = normalize( Normal * mat3(mWorld )); ');
    Add(' float RandomFurLength; ');
    Add('  if (UseRandomLength == 1) { RandomFurLength = fFurLength+fFurLength*rand(vNormal.xy); } ');
    Add('  else { RandomFurLength = fFurLength ; } ');

    Add('  RandomFurLength = pass_index*(RandomFurLength * vNormal); ');
    Add('  if (RandomFurLength > fFurMaxLength ) { RandomFurLength = fFurMaxLength; } ');

    Add('  Position.xyz += RandomFurLength +(vGravity2 * k);  ');

    Add('  Position.xyz += pass_index*(fFurLength * Normal)+(vGravity2 * k);  ');
    Add('  vTexCoord = gl_MultiTexCoord0; ');
    Add('   ');
    Add('   gl_Position =  gl_ModelViewProjectionMatrix * Position; ');
    Add('  lightVec = vec3(lightPos - vert); ');

    //  Add('  viewVec = -vec3(vert); ');
    Add('normal = vNormal; ');
    Add('} ');
  end;

  with FragmentProgram.Code do
  begin
    clear;
    Add('uniform vec4 fcolorScale; ');
    Add('uniform float pass_index; ');
    Add('uniform float fFurScale; ');
    Add('uniform vec4 vAmbient; ');
    Add('uniform float fLayer; // 0 to 1 for the level ');
    Add('uniform float vLightIntensity; ');
    Add('uniform sampler2D FurTexture; ');
    Add('uniform sampler2D ColourTexture; ');
    //textures
    Add('varying vec2 vTexCoord; ');
    Add('varying vec3 normal; ');
    Add('varying vec3 lightVec; ');
//    Add('varying vec3 viewVec; ');

    Add('void main() ');
    Add('{ ');
    // A Faking shadow
    Add('  vec4 fAlpha = texture2D( FurTexture, vTexCoord*fFurScale );     ');
    Add('  float fakeShadow =  mix(0.3, 1.0, fAlpha.a-fLayer); ');
    Add('     ');
    Add('  vec4 FinalColour = vec4(0.0,0.0,0.0,1.0); ');
    Add('FinalColour = (fcolorScale*texture2D( ColourTexture, vTexCoord))*fakeShadow; ');

    // This comment part it's for controling if we must draw the hair according the red channel and the alpha in NoiseMap
    // Don' t work well a this time the NoiseMap must be perfect
//    Add('float visibility = 0.0; ');
//    Add('if (pass_index == 1.0) ');
//    Add('{ ');
//    Add('   visibility = 1.0;  ');
//    Add('} ');
//    Add('else ');
//    Add('{ ');
//    Add('  if (fAlpha.a<fAlpha.r) { visibility = 0.0; } ');
//    Add('  else { visibility =mix(0.1,1.0,(1.02-fLayer)); } //-1.0; ');
//    Add('} ');

    Add('float visibility =mix(0.1,1.0,(1.02-fLayer)); ');   // The Last past must be transparent
    // Simply Lighting - For this time only ONE light source is supported
    Add('vec4 ambient = vAmbient*FinalColour;  ');
    Add('vec4 diffuse = FinalColour; ');
    Add('vec3 L = normalize(lightVec); ');
    Add('float NdotL = dot(L, normal); ');
    Add('// "Half-Lambert" technique for more pleasing diffuse term ');
    Add('diffuse = diffuse*(0.5*NdotL+0.5); ');
    Add('FinalColour = vLightIntensity*(ambient+ diffuse); // + no specular; ');
    Add('FinalColour.a = visibility ; ');
    Add('    // Return the calculated color ');
    Add('    gl_FragColor= FinalColour; ');
    Add('} ');
  end;

  //Fur stuff
  FPassCount := 16; // More is greater more the fur is dense
  FFurLength := 0.3000;  // The minimal Hair length
  FMaxFurLength := 3.0;
  FRandomFurLength := false;
  FFurScale:=1.0;

  FColorScale := TgxColor.Create(Self);
  FColorScale.SetColor(0.2196,0.2201,0.2201,1.0);

  FAmbient := TgxColor.Create(Self);
  FAmbient.SetColor(1.0,1.0,1.0,1.0);

  // The Blend Funcs are very important for realistic fur rendering it can vary follow your textures
  FBlendSrc := bfOneMinusSrcColor;
  FBlendDst := bfOneMinusSrcAlpha;
  FGravity := TgxCoordinates.Create(self);
  FGravity.AsAffineVector := AffinevectorMake(0.0,0.0,0.0);
  FLightIntensity := 2.5;
end;

destructor TgxCustomGLSLFurShader.Destroy;
begin
  Enabled:=false;
  FGravity.Free;
  FColorScale.Destroy;
  FAmbient.Destroy;
  inherited;
end;

procedure TgxCustomGLSLFurShader.DoApply(var rci: TgxRenderContextInfo;Sender: TObject);
begin
  GetGXSLProg.UseProgramObject;
  //Fur stuff
  FCurrentPass := 1;

  param['pass_index'].AsVector1f := 1.0;
  param['fFurLength'].AsVector1f := FFurLength;

  param['fFurMaxLength'].AsVector1f := FMaxFurLength;
  param['fFurScale'].AsVector1f := FFurScale;
  if FRandomFurLength then param['UseRandomLength'].AsVector1i := 1
  else param['UseRandomLength'].AsVector1i := 0;

  param['fcolorScale'].AsVector4f := FColorScale.Color;
  param['FurTexture'].AsTexture2D[0] := FNoiseTex;
  param['ColourTexture'].AsTexture2D[1] := FMainTex;
  param['vGravity'].AsVector3f := FGravity.AsAffineVector;

  param['vAmbient'].AsVector4f := FAmbient.Color; //vectorMake(0.5,0.5,0.5,1.0);
  param['fLayer'].AsVector1f := 1/PassCount;
  param['vLightIntensity'].AsVector1f := FLightIntensity;


  glPushAttrib(GL_COLOR_BUFFER_BIT);
  glEnable(GL_BLEND);
  glBlendFunc(cGLBlendFunctionToGLEnum[FBlendSrc],cGLBlendFunctionToGLEnum[FBlendDst]);

 // gl.BlendFunc(GL_SRC_ALPHA, cGLBlendFunctionToGLEnum[FBlendSrc]);
 // gl.BlendFunc(GL_DST_ALPHA,cGLBlendFunctionToGLEnum[FBlendDst]);
 // gl.BlendEquation(cGLBlendEquationToGLEnum[BlendEquation]);

end;

function TgxCustomGLSLFurShader.DoUnApply(var rci: TgxRenderContextInfo): Boolean;
begin
  if FCurrentPass < PassCount then
  begin
    Inc(FCurrentPass);
    //GetGXSLProg.Uniform1f['pass_index'] := FCurrentPass;
    param['pass_index'].AsVector1f  := FCurrentPass;
    param['fLayer'].AsVector1f := FCurrentPass/PassCount;
    Result := True;
  end
  else
  begin
   // glActiveTextureARB(GL_TEXTURE0_ARB);
    glActiveTexture(GL_TEXTURE0_ARB);
    GetGXSLProg.EndUseProgramObject;
    glPopAttrib;
    Result := False;
  end;
end;


function TgxCustomGLSLFurShader.GetMaterialLibrary: TgxAbstractMaterialLibrary;
begin
  Result := FMaterialLibrary;
end;

procedure TgxCustomGLSLFurShader.SetMaterialLibrary(const Value: TgxAbstractMaterialLibrary);
begin
  if FMaterialLibrary <> nil then FMaterialLibrary.RemoveFreeNotification(Self);
  FMaterialLibrary := Value;
  if (FMaterialLibrary <> nil)
    and (FMaterialLibrary is TgxAbstractMaterialLibrary) then
      FMaterialLibrary.FreeNotification(Self);
  end;

  procedure TgxCustomGLSLFurShader.SetMainTexTexture(const Value: TgxTexture);
  begin
    if FMainTex = Value then
      Exit;
    FMainTex := Value;
    NotifyChange(self)
  end;

  procedure TgxCustomGLSLFurShader.SetNoiseTexTexture(const Value: TgxTexture);
  begin
    if FNoiseTex = Value then
      Exit;
    FNoiseTex := Value;
    NotifyChange(self);
  end;

  function TgxCustomGLSLFurShader.GetNoiseTexName: TgxLibMaterialName;
  begin
    Result := TgxMaterialLibrary(FMaterialLibrary).GetNameOfTexture(FNoiseTex);
    if Result = '' then
      Result := FNoiseTexName;
  end;

  procedure TgxCustomGLSLFurShader.SetNoiseTexName
    (const Value: TgxLibMaterialName);
  begin
    // Assert(not(assigned(FMaterialLibrary)),'You must set Material Library Before');
    if FNoiseTexName = Value then
      Exit;
    FNoiseTexName := Value;
    FNoiseTex := TgxMaterialLibrary(FMaterialLibrary)
      .TextureByName(FNoiseTexName);
    NotifyChange(self);
  end;

  function TgxCustomGLSLFurShader.GetMainTexName: TgxLibMaterialName;
  begin
    Result := TgxMaterialLibrary(FMaterialLibrary).GetNameOfTexture(FMainTex);
    if Result = '' then
      Result := FMainTexName;
  end;

  procedure TgxCustomGLSLFurShader.SetMainTexName
    (const Value: TgxLibMaterialName);
  begin
    // Assert(not(assigned(FMaterialLibrary)),'You must set Material Library Before');
    if FMainTexName = Value then
      Exit;
    FMainTexName := Value;

    FMainTex := TgxMaterialLibrary(FMaterialLibrary)
      .TextureByName(FMainTexName);
    NotifyChange(self);
  end;

  procedure TgxCustomGLSLFurShader.Notification(AComponent: TComponent;
    Operation: TOperation);
  var
    Index: Integer;
  begin
    inherited;
    if Operation = opRemove then
      if AComponent = FMaterialLibrary then
        if FMaterialLibrary <> nil then
        begin
          // Need to nil the textures that were owned by it
          if FNoiseTex <> nil then
          begin
            Index := TgxMaterialLibrary(FMaterialLibrary)
              .Materials.GetTextureIndex(FNoiseTex);
            if Index <> -1 then
              SetNoiseTexTexture(nil);
          end;

          if FMainTex <> nil then
          begin
            Index := TgxMaterialLibrary(FMaterialLibrary)
              .Materials.GetTextureIndex(FMainTex);
            if Index <> -1 then
              SetMainTexTexture(nil);
          end;

          FMaterialLibrary := nil;
        end;
  end;

  procedure TgxCustomGLSLFurShader.SetGravity(APosition: TgxCoordinates);
  begin
    FGravity.SetPoint(APosition.DirectX, APosition.DirectY, APosition.DirectZ);
  end;

  procedure TgxCustomGLSLFurShader.SetAmbient(AValue: TgxColor);
  begin
    FAmbient.DirectColor := AValue.Color;
  end;

  procedure TgxCustomGLSLFurShader.SetColorScale(AValue: TgxColor);
  begin
    FColorScale.DirectColor := AValue.Color;
  end;

(*****************************************************
  TgxCustomGLSLIvoryShader
 ****************************************************)

  constructor TgxCustomGLSLIvoryShader.Create(AOwner: TComponent);
  begin
    inherited;
    with VertexProgram.Code do
    begin
      clear;
      Add('varying vec3 normal; ');
      Add('varying vec3 lightVec; ');
      Add('varying vec3 viewVec; ');
      Add(' ');
      Add('void main() ');
      Add('{ ');
      Add('  gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex; ');
      Add('  vec4 lightPos = gl_LightSource[0].position;');
      Add('  vec4 vert =  gl_ModelViewMatrix * gl_Vertex; ');
      Add('  normal = gl_NormalMatrix * gl_Normal; ');
      Add('  lightVec = vec3(lightPos - vert); ');
      Add('  viewVec = -vec3(vert); ');
      Add('} ');
    end;

    with FragmentProgram.Code do
    begin
      clear;
      Add('varying vec3 normal; ');
      Add('varying vec3 lightVec; ');
      Add('varying vec3 viewVec; ');
      Add(' ');
      Add('void main() ');
      Add('{ ');
      Add('vec3 norm = normalize(normal); ');
      Add('vec3 L = normalize(lightVec); ');
      Add('vec3 V = normalize(viewVec); ');
      Add('vec3 halfAngle = normalize(L + V); ');
      Add('float NdotL = dot(L, norm); ');
      Add('float NdotH = clamp(dot(halfAngle, norm), 0.0, 1.0); ');
      Add('// "Half-Lambert" technique for more pleasing diffuse term ');
      Add('float diffuse = 0.5 * NdotL + 0.5; ');
      Add('float specular = pow(NdotH, 64.0); ');
      Add('float result = diffuse + specular; ');
      Add('gl_FragColor = vec4(result); ');
      Add('} ');
    end;
    // Initial stuff.
  end;

  destructor TgxCustomGLSLIvoryShader.Destroy;
  begin
    inherited;
  end;

  procedure TgxCustomGLSLIvoryShader.DoApply(var rci: TgxRenderContextInfo;
    Sender: TObject);
  begin
    GetGXSLProg.UseProgramObject;
  end;

  function TgxCustomGLSLIvoryShader.DoUnApply
    (var rci: TgxRenderContextInfo): Boolean;
  begin
    Result := False;
    GetGXSLProg.EndUseProgramObject;
  end;

(*****************************************************
  TgxCustomGLSLSimpleLatticeShader
*****************************************************)

  constructor TgxCustomGLSLSimpleLatticeShader.Create(AOwner: TComponent);
  begin
    inherited;
    with FragmentProgram.Code do
    begin
      clear;
      Add('  uniform vec2  Scale; ');
      Add('  uniform vec2  Threshold; ');
      Add(' ');
      Add('  void main (void) ');
      Add('{ ');
      Add('    float ss = fract(gl_TexCoord[0].s * Scale.s); ');
      Add('    float tt = fract(gl_TexCoord[0].t * Scale.t); ');
      Add(' ');
      Add('    if ((ss > Threshold.s) && (tt > Threshold.t)) discard; ');
      Add('    gl_FragColor = gl_Color;');
      Add('} ');
    end;
    // Initial stuff.
    FLatticeScale := TgxCoordinates2.Create(self);
    FLatticeThreshold := TgxCoordinates2.Create(self);

    FLatticeScale.SetPoint2D(10, 40);
    FLatticeThreshold.SetPoint2D(0.15, 0.3);
  end;

  destructor TgxCustomGLSLSimpleLatticeShader.Destroy;
  begin
    FLatticeScale.Destroy;
    FLatticeThreshold.Destroy;
    inherited;
  end;

  procedure TgxCustomGLSLSimpleLatticeShader.DoApply
    (var rci: TgxRenderContextInfo; Sender: TObject);
  begin
    GetGXSLProg.UseProgramObject;
    param['Scale'].AsVector2f := FLatticeScale.AsPoint2D;
    param['Threshold'].AsVector2f := FLatticeThreshold.AsPoint2D;
  end;

  function TgxCustomGLSLSimpleLatticeShader.DoUnApply
    (var rci: TgxRenderContextInfo): Boolean;
  begin
    Result := False;
    // gl.ActiveTexture(GL_TEXTURE0_ARB);
    GetGXSLProg.EndUseProgramObject;
  end;

  procedure TgxCustomGLSLSimpleLatticeShader.SetLatticeScale
    (const Value: TgxCoordinates2);
  begin
    FLatticeScale.Assign(Value);
  end;

  procedure TgxCustomGLSLSimpleLatticeShader.SetLatticeThreshold
    (const Value: TgxCoordinates2);
  begin
    FLatticeThreshold.Assign(Value);
  end;

  // TgxCustomGLSLLatticeShader

  constructor TgxCustomGLSLLatticeShader.Create(AOwner: TComponent);
  begin
    inherited;
    FAmbientColor := TgxColor.Create(self);
    FDiffuseColor := TgxColor.Create(self);
    FSpecularColor := TgxColor.Create(self);

    // setup initial parameters
    FAmbientColor.SetColor(0.15, 0.15, 0.15, 1);
    FDiffuseColor.SetColor(1, 1, 1, 1);
    FSpecularColor.SetColor(1, 1, 1, 1);

    FSpecularPower := 8; // 6
    FLightPower := 1;
  end;

  destructor TgxCustomGLSLLatticeShader.Destroy;
  begin
    FAmbientColor.Destroy;
    FDiffuseColor.Destroy;
    FSpecularColor.Destroy;
    inherited;
  end;

  procedure TgxCustomGLSLLatticeShader.DoApply(var rci: TgxRenderContextInfo;
    Sender: TObject);
  begin
    inherited;
    param['AmbientColor'].AsVector4f := FAmbientColor.Color;
    param['DiffuseColor'].AsVector4f := FDiffuseColor.Color;
    param['SpecularColor'].AsVector4f := FSpecularColor.Color;
    param['SpecPower'].AsVector1f := FSpecularPower;
    param['LightIntensity'].AsVector1f := FLightPower;
    param['MainTexture'].AsTexture2D[0] := FMainTexture;
  end;

  procedure TgxCustomGLSLLatticeShader.DoInitialize
    (var rci: TgxRenderContextInfo; Sender: TObject);
  begin
    with VertexProgram.Code do
    begin
      clear;
      Add('varying vec3 Normal; ');
      Add('varying vec3 LightVector; ');
      Add('varying vec3 CameraVector; ');
      Add('varying vec2 Texcoord; ');
      Add(' ');
      Add(' ');
      Add('void main(void) ');
      Add('{ ');
      Add('  gl_Position = ftransform(); ');
      Add('  Texcoord = gl_MultiTexCoord0.xy; ');
      Add('  Normal = normalize(gl_NormalMatrix * gl_Normal); ');
      Add('  vec3 p = (gl_ModelViewMatrix * gl_Vertex).xyz; ');
      Add('  LightVector = normalize(gl_LightSource[0].position.xyz - p); ');
      Add('  CameraVector = normalize(p); ');
      Add('} ');
    end;

    with FragmentProgram.Code do
    begin
      clear;
      Add('  uniform vec2  Scale; ');
      Add('  uniform vec2  Threshold; ');
      Add(' ');
      Add('uniform vec4 AmbientColor; ');
      Add('uniform vec4 DiffuseColor; ');
      Add('uniform vec4 SpecularColor; ');
      Add(' ');
      Add('uniform float LightIntensity; ');
      Add('uniform float SpecPower; ');
      Add('uniform sampler2D MainTexture; ');
      Add(' ');
      Add('varying vec3 Normal; ');
      Add('varying vec3 LightVector; ');
      Add('varying vec3 CameraVector; ');
      Add('varying vec2 Texcoord; ');
      Add(' ');
      Add('void main(void) ');
      Add('{ ');
      Add('    float ss = fract(Texcoord[0] * Scale.s); ');
      Add('    float tt = fract(Texcoord[1] * Scale.t); ');
      Add(' ');
      Add('    if ((ss > Threshold.s) && (tt > Threshold.t)) discard; ');
      Add(' ');
      Add('  vec4 TextureContrib = texture2D(MainTexture, Texcoord); ');
      Add('  vec4 DiffuseContrib = clamp(DiffuseColor * dot(LightVector, Normal), 0.0, 1.0); ');
      Add(' ');
      Add('  vec3 reflect_vec = reflect(CameraVector, -Normal); ');
      Add('  float Temp = dot(reflect_vec, LightVector); ');
      Add('  vec4 SpecContrib = SpecularColor * clamp(pow(Temp, SpecPower), 0.0, 0.95); ');
      Add(' ');
      Add('  gl_FragColor = TextureContrib * LightIntensity * (AmbientColor + DiffuseContrib) + LightIntensity * SpecContrib; ');
      Add('} ');
    end;
    inherited;
  end;

  function TgxCustomGLSLLatticeShader.GetMaterialLibrary
    : TgxAbstractMaterialLibrary;
  begin
    Result := FMaterialLibrary;
  end;

  procedure TgxCustomGLSLLatticeShader.SetMaterialLibrary
    (const Value: TgxAbstractMaterialLibrary);
  begin
    if FMaterialLibrary <> nil then
      FMaterialLibrary.RemoveFreeNotification(self);
    FMaterialLibrary := Value;
    if (FMaterialLibrary <> nil) and
      (FMaterialLibrary is TgxAbstractMaterialLibrary) then
      FMaterialLibrary.FreeNotification(self);
  end;

  procedure TgxCustomGLSLLatticeShader.SetMainTexTexture
    (const Value: TgxTexture);
  begin
    if FMainTexture = Value then
      Exit;
    FMainTexture := Value;
    NotifyChange(self)
  end;

  function TgxCustomGLSLLatticeShader.GetMainTexName: TgxLibMaterialName;
  begin
    Result := TgxMaterialLibrary(FMaterialLibrary)
      .GetNameOfTexture(FMainTexture);
    if Result = '' then
      Result := FMainTexName;
  end;

  procedure TgxCustomGLSLLatticeShader.SetMainTexName
    (const Value: TgxLibMaterialName);
  begin
    // Assert(not(assigned(FMaterialLibrary)),'You must set Material Library Before');
    if FMainTexName = Value then
      Exit;
    FMainTexName := Value;

    FMainTexture := TgxMaterialLibrary(FMaterialLibrary)
      .TextureByName(FMainTexName);
    NotifyChange(self);
  end;

  procedure TgxCustomGLSLLatticeShader.SetDiffuseColor(AValue: TgxColor);
  begin
    FDiffuseColor.DirectColor := AValue.Color;
  end;

  procedure TgxCustomGLSLLatticeShader.SetAmbientColor(AValue: TgxColor);
  begin
    FAmbientColor.DirectColor := AValue.Color;
  end;

  procedure TgxCustomGLSLLatticeShader.SetSpecularColor(AValue: TgxColor);
  begin
    FSpecularColor.DirectColor := AValue.Color;
  end;

  procedure TgxCustomGLSLLatticeShader.Notification(AComponent: TComponent;
    Operation: TOperation);
  var
    Index: Integer;
  begin
    inherited;
    if Operation = opRemove then
      if AComponent = FMaterialLibrary then
        if FMaterialLibrary <> nil then
        begin

          if FMainTexture <> nil then
          begin
            Index := TgxMaterialLibrary(FMaterialLibrary)
              .Materials.GetTextureIndex(FMainTexture);
            if Index <> -1 then
              SetMainTexTexture(nil);
          end;
          FMaterialLibrary := nil;
        end;
  end;

(*************************************************
   TgxCustomGLSLSemShader
 ************************************************)

  constructor TgxCustomGLSLSemShader.Create(AOwner: TComponent);
  begin
    inherited;
    with VertexProgram.Code do
    begin
      clear;
      Add('varying vec3 viewVec; ');
      Add('varying vec3 normal; ');
      Add('varying vec3 lightVec; ');

      Add('void main() { ');
      Add('  vec4 p = gl_ModelViewMatrix * gl_Vertex; ');
      Add('  vec4 lightPos = gl_LightSource[0].position;');
      Add('  lightVec = vec3(lightPos - p); ');
      Add('  viewVec = -vec3(p); ');
      Add('  normal = normalize(gl_NormalMatrix * gl_Normal ); ');
      Add('  gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex; ');
      Add('} ');
    end;

    with FragmentProgram.Code do
    begin
      clear;
      Add('uniform vec4 AmbientColor; ');
      Add('uniform vec4 SpecularColor; ');
      Add('uniform float DiffuseIntensity; ');
      Add('uniform float AmbientIntensity; ');
      Add('uniform float SpecularIntensity; ');

      Add('uniform sampler2D MainTexture; ');

      Add('varying vec3 viewVec; ');
      Add('varying vec3 normal; ');
      Add('varying vec3 lightVec; ');

      Add('void main() { ');
      Add('  vec3 V = normalize(viewVec); ');
      Add('  vec3 r = reflect( V, normal ); ');
      Add('  float m = 2.0 * sqrt( pow( r.x, 2.0 ) + pow( r.y, 2.0 ) + pow( r.z + 1.0, 2.0 ) ); ');
      Add('  vec2 vN = r.xy / m + 0.5; ');
      Add('  vec4 DiffuseColor;    ');
      Add('  DiffuseColor = texture2D( MainTexture, vN ); //.rgb; ');
      // Simple Lighting
      Add('  vec3 L = normalize(lightVec); ');
      Add('  vec3 halfAngle = normalize(L + V); ');
      Add('  float NdotL = dot(L, normal); ');
      Add('  float NdotH = clamp(dot(halfAngle, normal), 0.0, 1.0); ');
      Add('  // "Half-Lambert" technique for more pleasing diffuse term ');
      Add('  float diffuse = DiffuseColor*(0.5 * NdotL + 0.5); ');
      Add('  float specular = pow(NdotH, 64.0); ');

      Add('  vec4 FinalColour = AmbientColor*AmbientIntensity + ');
      Add('                     DiffuseColor*diffuse*DiffuseIntensity + ');
      Add('                     SpecularColor*specular*SpecularIntensity; ');

      Add('  gl_FragColor = FinalColour; //vec4( FinalColour, 1.0 ); ');
      Add('} ');
    end;

    FAmbientColor := TgxColor.Create(self);
    // FDiffuseColor := TgxColor.Create(Self);
    FSpecularColor := TgxColor.Create(self);

    // setup initial parameters
    FAmbientColor.SetColor(0.15, 0.15, 0.15, 1.0);
    // FDiffuseColor.SetColor(1, 1, 1, 1);
    FSpecularColor.SetColor(1.0, 1.0, 1.0, 1.0);
    FAmbientFactor := 0.8;
    FDiffuseFactor := 0.9;
    FSpecularFactor := 0.8;
  end;

  destructor TgxCustomGLSLSemShader.Destroy;
  begin
    FAmbientColor.Destroy;
    // FDiffuseColor.Destroy;
    FSpecularColor.Destroy;
    inherited;
  end;

  procedure TgxCustomGLSLSemShader.DoApply(var rci: TgxRenderContextInfo;
    Sender: TObject);
  begin
    GetGXSLProg.UseProgramObject;
    // Param['DiffuseColor'].AsVector4f := FDiffuseColor.Color;
    param['AmbientColor'].AsVector4f := FAmbientColor.Color;
    param['SpecularColor'].AsVector4f := FSpecularColor.Color;
    param['AmbientIntensity'].AsVector1f := FAmbientFactor;
    param['DiffuseIntensity'].AsVector1f := FDiffuseFactor;
    param['SpecularIntensity'].AsVector1f := FSpecularFactor;

    // Param['SpecPower'].AsVector1f := FSpecularPower;
    // Param['LightIntensity'].AsVector1f := FLightPower;

    param['MainTexture'].AsTexture2D[0] := FMainTexture;

  end;

  function TgxCustomGLSLSemShader.DoUnApply
    (var rci: TgxRenderContextInfo): Boolean;
  begin
    glActiveTexture(GL_TEXTURE0_ARB);
    GetGXSLProg.EndUseProgramObject;
    Result := False;
  end;

  function TgxCustomGLSLSemShader.GetMaterialLibrary
    : TgxAbstractMaterialLibrary;
  begin
    Result := FMaterialLibrary;
  end;

  procedure TgxCustomGLSLSemShader.SetMaterialLibrary
    (const Value: TgxAbstractMaterialLibrary);
  begin
    if FMaterialLibrary <> nil then
      FMaterialLibrary.RemoveFreeNotification(self);
    FMaterialLibrary := Value;
    if (FMaterialLibrary <> nil) and
      (FMaterialLibrary is TgxAbstractMaterialLibrary) then
      FMaterialLibrary.FreeNotification(self);
  end;

  procedure TgxCustomGLSLSemShader.SetMainTexTexture(const Value: TgxTexture);
  begin
    if FMainTexture = Value then
      Exit;
    FMainTexture := Value;
    NotifyChange(self)
  end;

  function TgxCustomGLSLSemShader.GetMainTexName: TgxLibMaterialName;
  begin
    Result := TgxMaterialLibrary(FMaterialLibrary)
      .GetNameOfTexture(FMainTexture);
    if Result = '' then
      Result := FMainTexName;
  end;

  procedure TgxCustomGLSLSemShader.SetMainTexName
    (const Value: TgxLibMaterialName);
  begin
    // Assert(not(assigned(FMaterialLibrary)),'You must set Material Library Before');
    if FMainTexName = Value then
      Exit;
    FMainTexName := Value;

    FMainTexture := TgxMaterialLibrary(FMaterialLibrary)
      .TextureByName(FMainTexName);
    NotifyChange(self);
  end;

  // procedure TgxCustomGLSLSemShader.SetDiffuseColor(AValue: TgxColor);
  // begin
  // FDiffuseColor.DirectColor := AValue.Color;
  // end;

  procedure TgxCustomGLSLSemShader.SetAmbientColor(AValue: TgxColor);
  begin
    FAmbientColor.DirectColor := AValue.Color;
  end;

  procedure TgxCustomGLSLSemShader.SetSpecularColor(AValue: TgxColor);
  begin
    FSpecularColor.DirectColor := AValue.Color;
  end;

  procedure TgxCustomGLSLSemShader.Notification(AComponent: TComponent;
    Operation: TOperation);
  var
    Index: Integer;
  begin
    inherited;
    if Operation = opRemove then
      if AComponent = FMaterialLibrary then
        if FMaterialLibrary <> nil then
        begin

          if FMainTexture <> nil then
          begin
            Index := TgxMaterialLibrary(FMaterialLibrary)
              .Materials.GetTextureIndex(FMainTexture);
            if Index <> -1 then
              SetMainTexTexture(nil);
          end;

          FMaterialLibrary := nil;
        end;
  end;

(****************************************
 TgxCustomGLSLToonShader
****************************************)

constructor TgxCustomGLSLToonShader.Create(AOwner: TComponent);
begin
  inherited;
  with VertexProgram.Code do
  begin
    Clear;
    Add('varying vec3 vNormal; ');
    Add('varying vec3 LightVec; ');
    Add('varying vec3 ViewVec; ');
    Add(' ');
    Add('void main() ');
    Add('{ ');
    Add('  vec4 lightPos = gl_LightSource[0].position;');
    Add('  vec4 vert =  gl_ModelViewMatrix * gl_Vertex; ');
    Add('  vec3 normal = gl_NormalMatrix * gl_Normal; ');
    Add('  vNormal  = normalize(normal); ');
    Add('  LightVec = vec3(lightPos - vert); ');
    Add('  ViewVec = -vec3(vert); ');
    //Add('  gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex; ');
    Add('  gl_Position = ftransform(); ');
    Add('} ');
  end;

  with FragmentProgram.Code do
  begin
    Clear;
    Add('uniform vec4 HighlightColor; ');
    Add('uniform vec4 MidColor; ');
    Add('uniform vec4 LightenShadowColor; ');
    Add('uniform vec4 DarkenShadowColor; ');
    Add('uniform vec4 OutlineColor; ');
    Add('uniform float HighlightSize; '); // 0.95
    Add('uniform float MidSize; ');       // 0.5
    Add('uniform float ShadowSize; ');    // 0.25
    Add('uniform float OutlineWidth; ');
    Add('varying vec3 vNormal; ');
    Add('varying vec3 LightVec; ');
    Add('varying vec3 ViewVec; ');
    Add('void main() ');
    Add('{ ');
    Add('  vec3 n = normalize(vNormal); ');
    Add('  vec3 l = normalize(LightVec); ');
    Add('  vec3 v = normalize(ViewVec); ');
    Add('    float lambert = dot(l,n); ');
    Add('    vec4 colour = MidColor; ');
    Add('    if (lambert>HighlightSize) colour = HighlightColor; ');
    Add('    else if (lambert>MidSize) colour = MidColor; ');
    Add('    else if (lambert>ShadowSize) colour = LightenShadowColor; ');
    Add('    else if (lambert<ShadowSize) colour = DarkenShadowColor; ');
    Add('    if (dot(n,v)<OutlineWidth) colour = OutlineColor; ');
    Add('    gl_FragColor = colour; ');
    Add('} ');
  end;
  // Initial stuff.
  FHighLightColor := TgxColor.Create(self);
  FHighLightColor.SetColor(0.9,0.9,0.9,1.0);
  FMidColor := TgxColor.Create(self);
  FMidColor.SetColor(0.75,0.75,0.75,1.0);
  FLightenShadowColor := TgxColor.Create(self);
  FLightenShadowColor.SetColor(0.5,0.5,0.5,1.0);
  FDarkenShadowColor := TgxColor.Create(self);
  FDarkenShadowColor.SetColor(0.3,0.3,0.3,1.0);
  FOutlineColor := TgxColor.Create(self);
  FOutlineColor.SetColor(0,0,0,1.0);
  FHighlightSize := 0.95;
  FMidSize       := 0.50;
  FShadowSize    := 0.25;
  FOutlineWidth  := 0.25;
end;

destructor TgxCustomGLSLToonShader.Destroy;
begin
  FHighLightColor.Free;
  FMidColor.Free;
  FLightenShadowColor.Free;
  FDarkenShadowColor.Free;
  FOutlineColor.Free;
  inherited;
end;

procedure TgxCustomGLSLToonShader.DoApply(var rci: TgxRenderContextInfo;Sender: TObject);
begin
  GetGXSLProg.UseProgramObject;
  param['HighlightColor'].AsVector4f := FHighlightColor.Color;
  param['MidColor'].AsVector4f := FMidColor.Color;
  param['LightenShadowColor'].AsVector4f := FLightenShadowColor.Color;
  param['DarkenShadowColor'].AsVector4f := FDarkenShadowColor.Color;
  param['OutlineColor'].AsVector4f := FOutlineColor.Color;
  param['HighlightSize'].AsVector1f := FHighlightSize;
  param['MidSize'].AsVector1f := FMidSize;
  param['ShadowSize'].AsVector1f := FShadowSize;
  param['OutlineWidth'].AsVector1f := FOutlineWidth;
end;

function TgxCustomGLSLToonShader.DoUnApply(var rci: TgxRenderContextInfo): Boolean;
begin
  GetGXSLProg.EndUseProgramObject;
  Result := False;
end;

procedure TgxCustomGLSLToonShader.SetHighlightColor(AValue: TgxColor);
begin
  FHighlightColor.DirectColor := AValue.Color;
end;

procedure TgxCustomGLSLToonShader.SetMidColor(AValue: TgxColor);
begin
  FMidColor.DirectColor := AValue.Color;
end;

procedure TgxCustomGLSLToonShader.SetLightenShadowColor(AValue: TgxColor);
begin
  FLightenShadowColor.DirectColor := AValue.Color;
end;

procedure TgxCustomGLSLToonShader.SetDarkenShadowColor(AValue: TgxColor);
begin
  FDarkenShadowColor.DirectColor := AValue.Color;
end;

procedure TgxCustomGLSLToonShader.SetOutlineColor(AValue: TgxColor);
begin
  FOutlineColor.DirectColor := AValue.Color;
end;


(*************************************************
  TgxCustomGLSLVertexDisplacementShader
*************************************************)

constructor TgxCustomGLSLVertexDisplacementShader.Create(AOwner: TComponent);
begin
  inherited;
  with VertexProgram.Code do
  begin
    clear;
    Add('uniform float time; ');
    Add('uniform float NoiseFactor; ');
    Add('uniform float TurbulenceFactor; ');
    Add('uniform float NoiseScale; ');
    Add('uniform float NoisePeriod; ');
    Add('uniform float DisplacementScale; ');
    Add('uniform float TimeFactor; ');

    Add('varying vec3 viewVec; ');
    Add('varying vec3 normal; ');
    Add('varying vec3 lightVec; ');
    Add('varying vec2 vTexCoord; ');
    Add('varying float noise; ');

    //
    // GLSL textureless classic 3D noise "cnoise",
    // with an RSL-style periodic variant "pnoise".
    // Author:  Stefan Gustavson (stefan.gustavson@liu.se)
    // Version: 2011-10-11
    //
    // Many thanks to Ian McEwan of Ashima Arts for the
    // ideas for permutation and gradient selection.
    //
    // Copyright (c) 2011 Stefan Gustavson. All rights reserved.
    // Distributed under the MIT license. See LICENSE file.
    // https://github.com/ashima/webgl-noise
    //

    Add('vec3 mod289(vec3 x) ');
    Add('{ ');
    Add('  return x - floor(x * (1.0 / 289.0)) * 289.0; ');
    Add('} ');

    Add('vec4 mod289(vec4 x) ');
    Add('{ ');
    Add('  return x - floor(x * (1.0 / 289.0)) * 289.0; ');
    Add('} ');

    Add('vec4 permute(vec4 x) ');
    Add('{ ');
    Add('  return mod289(((x*34.0)+1.0)*x); ');
    Add('} ');

    Add('vec4 taylorInvSqrt(vec4 r) ');
    Add('{ ');
    Add('  return 1.79284291400159 - 0.85373472095314 * r; ');
    Add('} ');

    Add('vec3 fade(vec3 t) { ');
    Add('  return t*t*t*(t*(t*6.0-15.0)+10.0); ');
    Add('} ');

    // Classic Perlin noise, periodic variant
    Add('float pnoise(vec3 P, vec3 rep) ');
    Add('{ ');
    Add('  vec3 Pi0 = mod(floor(P), rep); // Integer part, modulo period ');
    Add('  vec3 Pi1 = mod(Pi0 + vec3(1.0), rep); // Integer part + 1, mod period ');
    Add('  Pi0 = mod289(Pi0); ');
    Add('  Pi1 = mod289(Pi1); ');
    Add('  vec3 Pf0 = fract(P); // Fractional part for interpolation ');
    Add('  vec3 Pf1 = Pf0 - vec3(1.0); // Fractional part - 1.0 ');
    Add('  vec4 ix = vec4(Pi0.x, Pi1.x, Pi0.x, Pi1.x); ');
    Add('  vec4 iy = vec4(Pi0.yy, Pi1.yy); ');
    Add('  vec4 iz0 = Pi0.zzzz; ');
    Add('  vec4 iz1 = Pi1.zzzz; ');

    Add('  vec4 ixy = permute(permute(ix) + iy); ');
    Add('  vec4 ixy0 = permute(ixy + iz0); ');
    Add('  vec4 ixy1 = permute(ixy + iz1); ');

    Add('  vec4 gx0 = ixy0 * (1.0 / 7.0); ');
    Add('  vec4 gy0 = fract(floor(gx0) * (1.0 / 7.0)) - 0.5; ');
    Add('  gx0 = fract(gx0); ');
    Add('  vec4 gz0 = vec4(0.5) - abs(gx0) - abs(gy0); ');
    Add('  vec4 sz0 = step(gz0, vec4(0.0)); ');
    Add('  gx0 -= sz0 * (step(0.0, gx0) - 0.5); ');
    Add('  gy0 -= sz0 * (step(0.0, gy0) - 0.5); ');
    Add('  vec4 gx1 = ixy1 * (1.0 / 7.0); ');
    Add('  vec4 gy1 = fract(floor(gx1) * (1.0 / 7.0)) - 0.5; ');
    Add('  gx1 = fract(gx1); ');
    Add('  vec4 gz1 = vec4(0.5) - abs(gx1) - abs(gy1); ');
    Add('  vec4 sz1 = step(gz1, vec4(0.0)); ');
    Add('  gx1 -= sz1 * (step(0.0, gx1) - 0.5); ');
    Add('  gy1 -= sz1 * (step(0.0, gy1) - 0.5); ');
    Add('  vec3 g000 = vec3(gx0.x,gy0.x,gz0.x); ');
    Add('  vec3 g100 = vec3(gx0.y,gy0.y,gz0.y); ');
    Add('  vec3 g010 = vec3(gx0.z,gy0.z,gz0.z); ');
    Add('  vec3 g110 = vec3(gx0.w,gy0.w,gz0.w); ');
    Add('  vec3 g001 = vec3(gx1.x,gy1.x,gz1.x); ');
    Add('  vec3 g101 = vec3(gx1.y,gy1.y,gz1.y); ');
    Add('  vec3 g011 = vec3(gx1.z,gy1.z,gz1.z); ');
    Add('  vec3 g111 = vec3(gx1.w,gy1.w,gz1.w); ');
    Add('  vec4 norm0 = taylorInvSqrt(vec4(dot(g000, g000), dot(g010, g010), dot(g100, g100), dot(g110, g110))); ');
    Add('  g000 *= norm0.x; ');
    Add('  g010 *= norm0.y; ');
    Add('  g100 *= norm0.z; ');
    Add('  g110 *= norm0.w; ');
    Add('  vec4 norm1 = taylorInvSqrt(vec4(dot(g001, g001), dot(g011, g011), dot(g101, g101), dot(g111, g111))); ');
    Add('  g001 *= norm1.x; ');
    Add('  g011 *= norm1.y; ');
    Add('  g101 *= norm1.z; ');
    Add('  g111 *= norm1.w; ');
    Add('  float n000 = dot(g000, Pf0); ');
    Add('  float n100 = dot(g100, vec3(Pf1.x, Pf0.yz)); ');
    Add('  float n010 = dot(g010, vec3(Pf0.x, Pf1.y, Pf0.z)); ');
    Add('  float n110 = dot(g110, vec3(Pf1.xy, Pf0.z)); ');
    Add('  float n001 = dot(g001, vec3(Pf0.xy, Pf1.z)); ');
    Add('  float n101 = dot(g101, vec3(Pf1.x, Pf0.y, Pf1.z)); ');
    Add('  float n011 = dot(g011, vec3(Pf0.x, Pf1.yz)); ');
    Add('  float n111 = dot(g111, Pf1); ');
    Add('  vec3 fade_xyz = fade(Pf0); ');
    Add('  vec4 n_z = mix(vec4(n000, n100, n010, n110), vec4(n001, n101, n011, n111), fade_xyz.z); ');
    Add('  vec2 n_yz = mix(n_z.xy, n_z.zw, fade_xyz.y); ');
    Add('  float n_xyz = mix(n_yz.x, n_yz.y, fade_xyz.x); ');
    Add('  return 2.2 * n_xyz; ');
    Add('} ');
    Add('float turbulence( vec3 p ) { ');
    Add('  float w = 100.0; ');
    Add('  float t = -.5; ');
    Add('  for (float f = 1.0 ; f <= 10.0 ; f++ ){ ');
    Add('      float power = pow( 2.0, f ); ');
    Add('      t += abs( pnoise( vec3( power * p ), vec3( 10.0, 10.0, 10.0 ) ) / power ); ');
    Add('  } ');
    Add('  return t; ');
    Add('} ');
    Add('void main() { ');      //96
    Add('  mat4 mWorld = gl_ModelViewMatrix; ');
    Add('  vec3 Normal = gl_NormalMatrix * gl_Normal; //gl_Normal; ');
    Add('  vec4 Position = gl_Vertex; ');
    Add('  vec4 vert =  gl_ModelViewMatrix * gl_Vertex; ');
    Add('  vec4 lightPos = gl_LightSource[0].position;');
    Add('  vTexCoord = gl_MultiTexCoord0; ');
    Add('  vec3 vNormal = normalize( Normal * mat3(mWorld )); ');
    Add('  time = TimeFactor*time; ');
    // add time to the noise parameters so it's animated
    Add('  noise = NoiseFactor* -0.10* turbulence( TurbulenceFactor * vNormal+time ); ');
    // get a 3d noise using the position, low frequency
    Add('  float b = (NoisePeriod*time)*pnoise( vec3((NoiseScale *time)* (Position.xyz + vec3(time ))), vec3(100) ); ');
    // compose both noises
    Add('  float displacement =( noise + b); ');
    Add('  vec4 newPosition =vec4((Position.xyz + DisplacementScale*(vec3(vNormal * displacement))),1.0); ');
    Add('  normal = vNormal; ');
    Add('  lightVec = vec3(lightPos - vert); ');
    Add('  viewVec = -vec3(vert); ');
    Add('  gl_Position = gl_ModelViewProjectionMatrix  * newPosition; ');
    Add('} ');
  end;

  with FragmentProgram.Code do
  begin
    clear;
    Add('uniform vec4 AmbientColor; ');
    Add('uniform vec4 SpecularColor; ');
    Add('uniform float DiffuseIntensity; ');
    Add('uniform float AmbientIntensity; ');
    Add('uniform float SpecularIntensity; ');
    Add('uniform sampler2D MainTexture; ');
    Add('varying vec3 viewVec; ');
    Add('varying vec3 normal; ');
    Add('varying vec3 lightVec; ');
    Add('varying float noise; ');
    Add('float random( vec3 scale, float seed ){ ');
    Add('  return fract( sin( dot( gl_FragCoord.xyz + seed, scale ) ) * 43758.5453 + seed ) ; ');
    Add('} ');
    Add('void main() { ');
    // get a random offset
    Add('  float r = 0.01 * random( vec3( 12.9898, 78.233, 151.7182 ), 0.0 ); ');
    // lookup vertically in the texture, using noise and offset
    // to get the right RGB colour
    Add('  vec2 tPos = vec2( 0, 1.0 - 1.3 * noise + r ); ');
    Add('  vec4 DiffuseColor;    ');
    Add('  DiffuseColor = texture2D( MainTexture, tPos ); ');
    // Simple Lighting
    Add('  vec3 L = normalize(lightVec); ');
    Add('  vec3 V = normalize(viewVec); ');
    Add('  vec3 halfAngle = normalize(L + V); ');
    Add('  float NdotL = dot(L, normal); ');
    Add('  float NdotH = clamp(dot(halfAngle, normal), 0.0, 1.0); ');
    Add('  // "Half-Lambert" technique for more pleasing diffuse term ');
    Add('  float diffuse = DiffuseColor*(0.5 * NdotL + 0.5); ');
    Add('  float specular = pow(NdotH, 64.0); ');
    Add('  vec4 FinalColour = AmbientColor*AmbientIntensity + ');
    Add('                     DiffuseColor*diffuse*DiffuseIntensity + ');
    Add('                     SpecularColor*specular*SpecularIntensity; ');
    Add('  gl_FragColor = FinalColour; ; ');
//    Add('  gl_FragColor = vec4(DiffuseColor,1.0); ');
    Add('} ');
  end;

  FAmbientColor := TgxColor.Create(Self);
  //FDiffuseColor := TgxColor.Create(Self);
  FSpecularColor := TgxColor.Create(Self);

  //setup initial parameters
  FAmbientColor.SetColor(0.15, 0.15, 0.15, 1.0);
  //FDiffuseColor.SetColor(1, 1, 1, 1);
  FSpecularColor.SetColor(1.0, 1.0, 1.0, 1.0);
  FAmbientFactor  := 0.8;
  FDiffuseFactor  :=0.9;
  FSpecularFactor :=0.8;
  FElapsedTime := 1.0;
  FNoise := 10.0;
  FDisplacementScale := 1.0;
  FNoiseScale := 0.05;
  FTurbulenceFactor := 0.5;
  FNoisePeriod := 5.0;
  FTimeFactor := 0.05;
end;

destructor TgxCustomGLSLVertexDisplacementShader.Destroy;
begin
  FAmbientColor.Destroy;
 // FDiffuseColor.Destroy;
  FSpecularColor.Destroy;
  inherited;
end;

procedure TgxCustomGLSLVertexDisplacementShader.DoApply(var rci: TgxRenderContextInfo; Sender: TObject);
begin
  GetGXSLProg.UseProgramObject;
//  Param['DiffuseColor'].AsVector4f := FDiffuseColor.Color;
  param['AmbientColor'].AsVector4f := FAmbientColor.Color;
  param['SpecularColor'].AsVector4f := FSpecularColor.Color;
  param['AmbientIntensity'].AsVector1f := FAmbientFactor;
  param['DiffuseIntensity'].AsVector1f := FDiffuseFactor;
  param['SpecularIntensity'].AsVector1f := FSpecularFactor;

  Param['time'].AsVector1f := FElapsedTime;
  Param['NoiseFactor'].AsVector1f := FNoise;
  Param['NoiseScale'].AsVector1f := FNoiseScale;
  Param['TurbulenceFactor'].AsVector1f := FTurbulenceFactor;
  Param['NoisePeriod'].AsVector1f := FNoisePeriod;
  Param['DisplacementScale'].AsVector1f := FDisplacementScale;
  Param['TimeFactor'].AsVector1f := FTimeFactor;
  Param['MainTexture'].AsTexture2D[0] := FMainTexture;
end;

function TgxCustomGLSLVertexDisplacementShader.DoUnApply(var rci: TgxRenderContextInfo): Boolean;
begin
  glActiveTexture(GL_TEXTURE0_ARB);
  GetGXSLProg.EndUseProgramObject;
  Result := False;
end;

function TgxCustomGLSLVertexDisplacementShader.GetMaterialLibrary: TgxAbstractMaterialLibrary;
begin
  Result := FMaterialLibrary;
end;

procedure TgxCustomGLSLVertexDisplacementShader.SetMaterialLibrary(const Value: TgxAbstractMaterialLibrary);
begin
  if FMaterialLibrary <> nil then FMaterialLibrary.RemoveFreeNotification(Self);
  FMaterialLibrary := Value;
  if (FMaterialLibrary <> nil)
    and (FMaterialLibrary is TgxAbstractMaterialLibrary) then
      FMaterialLibrary.FreeNotification(Self);
end;

procedure TgxCustomGLSLVertexDisplacementShader.SetMainTexTexture(const Value: TgxTexture);
begin
  if FMainTexture = Value then Exit;
  FMainTexture := Value;
  NotifyChange(Self)
end;

function TgxCustomGLSLVertexDisplacementShader.GetMainTexName: TgxLibMaterialName;
begin
  Result := TgxMaterialLibrary(FMaterialLibrary).GetNameOfTexture(FMainTexture);
  if Result = '' then Result := FMainTexName;
end;

procedure TgxCustomGLSLVertexDisplacementShader.SetMainTexName(const Value: TgxLibMaterialName);
begin
 // Assert(not(assigned(FMaterialLibrary)),'You must set Material Library Before');
  if FMainTexName = Value then Exit;
  FMainTexName  := Value;

  FMainTexture := TgxMaterialLibrary(FMaterialLibrary).TextureByName(FMainTexName);
  NotifyChange(Self);
end;


//procedure TgxCustomGLSLVertexDisplacementShader.SetDiffuseColor(AValue: TgxColor);
//begin
//  FDiffuseColor.DirectColor := AValue.Color;
//end;

procedure TgxCustomGLSLVertexDisplacementShader.SetAmbientColor(AValue: TgxColor);
begin
  FAmbientColor.DirectColor := AValue.Color;
end;

procedure TgxCustomGLSLVertexDisplacementShader.SetSpecularColor(AValue: TgxColor);
begin
  FSpecularColor.DirectColor := AValue.Color;
end;

procedure TgxCustomGLSLVertexDisplacementShader.Notification
  (AComponent: TComponent; Operation: TOperation);
var
  Index: Integer;
begin
  inherited;
  if Operation = opRemove then
    if AComponent = FMaterialLibrary then
      if FMaterialLibrary <> nil then
      begin

        if FMainTexture <> nil then
        begin
          Index := TgxMaterialLibrary(FMaterialLibrary)
            .Materials.GetTextureIndex(FMainTexture);
          if Index <> -1 then
            SetMainTexTexture(nil);
        end;

        FMaterialLibrary := nil;
      end;
end;


end.
