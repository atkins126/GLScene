//
// The graphics platform GLScene https://github.com/glscene
//

// Define GLS for VCL or GXS for FMX
{$DEFINE USE_GLS}
{.$DEFINE USE_GXS}

//
// Additionnal support & dependencies
//

// Activate support Graphics32 library
// Can be found at https://github.com/graphics32
{.$DEFINE USE_GRAPHICS32}

// Activate support FastMath library
// Use https://github.com/neslib/FastMath
{.$DEFINE USE_FASTMATH}

// Activate support for some optimizations by disabling checks that occur very often
// Warning: it will disable some options (like ShowAxis and OptSaveGLStack)
{.$DEFINE USE_OPTIMIZATIONS}

// Activate assembly routines - Warning! Some components not working!!!
{.$DEFINE USE_ASM}

// Activate Logging
{.$DEFINE USE_LOGGING}

// Activate OpenGL debug mode
{.$DEFINE USE_OPENGL_DEBUG}

// Activate support of Windows
{.$DEFINE MSWINDOWS}

// Avtivate using depricated OpenGL code
{$DEFINE USE_DEPRECATED}

{$IFDEF MSWINDOWS}
  {$DEFINE SUPPORT_WGL}
{$ENDIF}

// Activate Multithread support
{.$DEFINE USE_MULTITHREAD}

// Enable service rendering context, which automatically activate USE_MULTITHREAD
// This work only on windows platform with modern compilers (XE2 and FPC or higher}
{.$DEFINE USE_SERVICE_CONTEXT}

{$IFDEF USE_SERVICE_CONTEXT}
  // Activate Multithread support
  {$DEFINE USE_MULTITHREAD}
{$ENDIF}


//
// Platform Specific
//

{$IFNDEF CROSSVCL}
  {$IFDEF LINUX}
    {$UNDEF SUPPORT_WGL}
    {$UNDEF USE_ASM}
    {$DEFINE UNIX}
    {$DEFINE SUPPORT_GLX}
    {$DEFINE X11_SUPPORT}
  {$ENDIF}
{$ENDIF}

// .NET
{$IFDEF CLR}
  {$UNDEF USE_ASM}
  {$UNSAFECODE ON}
{$ENDIF}