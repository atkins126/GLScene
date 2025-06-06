//---------------------------------------------------------------------------

#ifndef fMainCH
#define fMainCH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <GLS.GeomObjects.hpp>
#include <GLS.Cadencer.hpp>
#include <GLS.SceneViewer.hpp>
#include <GLS.Objects.hpp>
#include <GLS.VectorFileObjects.hpp>
#include <GLS.Scene.hpp>
#include <ExtCtrls.hpp>
#include "GLS.BaseClasses.hpp"
#include "GLS.Coordinates.hpp"

#include "Stage.Utils.hpp"
#include "GLS.Scene.hpp"

//---------------------------------------------------------------------------
class TForm1:public TForm
{
__published:                   // IDE-managed Components
  TGLScene * GLScene1;
  TGLLightSource *GLLightSource1;
  TGLDummyCube *DummyCube1;
  TGLFreeForm *FreeForm1;
  TGLSphere *Sphere1;
  TGLArrowLine *ArrowLine1;
  TGLSceneViewer *GLSceneViewer2;
  TGLCamera *GLCamera2;
  TGLCadencer *GLCadencer1;
  TTimer *Timer1;
  TPanel *Panel1;
  TLabel *Label1;
  TLabel *Label2;
  TLabel *Label3;
  TLabel *Label5;
  TLabel *LABuild;
  TCheckBox *CheckBox1;
  TCheckBox *CBOctree;
  TLabel *Label4;
	TLabel *LabelFPS;
  void __fastcall GLSceneViewer2MouseDown(TObject * Sender, TMouseButton Button,
                                          TShiftState Shift, int X, int Y);
  void __fastcall GLSceneViewer2MouseMove(TObject * Sender, TShiftState Shift,
                                          int X, int Y);
  void __fastcall GLCadencer1Progress(TObject * Sender, const double deltaTime,
                                      const double newTime);
  void __fastcall Timer1Timer(TObject * Sender);
private:                       // User declarations
public:                        // User declarations
    __fastcall TForm1(TComponent * Owner);

  int mousex, mousey;
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
 
