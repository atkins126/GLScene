// ---------------------------------------------------------------------------

#include <vcl.h>
#include <tchar.h>
#pragma hdrstop

#include "fOceanC.h"
// ---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "GLS.BaseClasses"
#pragma link "GLS.Cadencer"
#pragma link "GLS.Coordinates"

#pragma link "Stage.OpenGLTokens"
#pragma link "GLS.Graph"
#pragma link "GLS.Material"
#pragma link "GLS.Objects"
#pragma link "GLS.Scene"
#pragma link "GLS.SimpleNavigation"
#pragma link "GLS.SkyDome"
#pragma link "GLSL.UserShader"
#pragma link "GLS.SceneViewer"
#pragma link "GLS.OpenGLAdapter"

#pragma resource "*.dfm"
TFormOcean *FormOcean;

// ---------------------------------------------------------------------------
__fastcall TFormOcean::TFormOcean(TComponent* Owner) : TForm(Owner) {
}

// ---------------------------------------------------------------------------
void __fastcall TFormOcean::FormCreate(TObject *Sender) {

	Path = GetCurrentAssetPath();
	// Loading noise texture
	SetCurrentDir(Path  + "\\texture");
	TGLTexture *tex = MatLib->LibMaterialByName("water")->Material->Texture;
	tex->Image->LoadFromFile("noise.bmp");

	// Creating and loading cubemap
	SetCurrentDir(Path  + "\\cubemap");
	// Load the cube map which is used both for environment and as reflection texture
	tex->ImageClassName = __classid(TGLCubeMapImage)->ClassName();
	TGLCubeMapImage *img = (TGLCubeMapImage*) tex->Image;
	// Load all 6 texture map components of the cube map
	// The 'PX', 'NX', etc. refer to 'positive X', 'negative X', etc.
	// and follow the RenderMan specs/conventions
	img->Picture[CmtPX]->LoadFromFile("cm_left.jpg");
	img->Picture[CmtNX]->LoadFromFile("cm_right.jpg");
	img->Picture[CmtPY]->LoadFromFile("cm_top.jpg");
	img->Picture[CmtNY]->LoadFromFile("cm_bottom.jpg");
	img->Picture[CmtPZ]->LoadFromFile("cm_back.jpg");
	img->Picture[CmtNZ]->LoadFromFile("cm_front.jpg");
}

// ---------------------------------------------------------------------------
void __fastcall TFormOcean::DOInitializeRender(TObject *Sender,
	TGLRenderContextInfo &rci) {
	if (!((GL_SHADER_OBJECT_ARB) && (GL_VERTEX_PROGRAM_ARB) &&
		(GL_VERTEX_SHADER_ARB) && (GL_FRAGMENT_SHADER_ARB))) {
		ShowMessage(
			"Your hardware does not support GLSL to execute this demo!");
	}

	if (DOInitialize->Tag != 0)
		exit;
	DOInitialize->Tag = 1;
	GLSceneViewer1->Buffer->RenderingContext->Deactivate();
	GLMemoryViewer1->RenderCubeMapTextures
		(MatLib->LibMaterialByName("cubeMap")->Material->Texture);
	GLSceneViewer1->Buffer->RenderingContext->Activate();

	// Loading shaders
	SetCurrentDir(Path  + "\\shader");
	TGLProgramHandle *programObject = new TGLProgramHandle(true);
	programObject->AddShader(__classid(TGLVertexShaderHandle),
		LoadAnsiStringFromFile("ocean_vp.glsl"), true);
	programObject->AddShader(__classid(TGLFragmentShaderHandle),
		LoadAnsiStringFromFile("ocean_fp.glsl"), true);

	if (!programObject->LinkProgram())
		throw Exception(programObject->InfoLog());

	programObject->UseProgramObject();
	programObject->Uniform1i["NormalMap"] = 0;
	programObject->Uniform1i["EnvironmentMap"] = 1;
	programObject->EndUseProgramObject();

	// initialize the heightmap
	rci.GLStates->TextureBinding[0][ttTexture2D] =
		MatLib->LibMaterialByName("water")->Material->Texture->Handle;

	// initialize the heightmap
	rci.GLStates->TextureBinding[1][ttTextureCube] =
		MatLib->LibMaterialByName("cubeMap")->Material->Texture->Handle;

	if (!programObject->ValidateProgram())
		throw Exception(programObject->InfoLog());
}

// ---------------------------------------------------------------------------
void __fastcall TFormOcean::GLUserShader1DoApply(TObject *Sender,
	TGLRenderContextInfo &rci)

{
	TGLVector camPos;

	programObject = new TGLProgramHandle();
	programObject->UseProgramObject();
	///  programObject->Uniform1f["Time"] = GLCadencer1->CurrentTime * 0.05;
	camPos = GLCamera->AbsolutePosition;
	///  programObject->Uniform4f["EyePos"] = camPos;
}

// ---------------------------------------------------------------------------
void __fastcall TFormOcean::GLUserShader1DoUnApply(TObject *Sender, int Pass,
	TGLRenderContextInfo &rci, bool &Continue) {
	programObject->EndUseProgramObject();
}
// ---------------------------------------------------------------------------

void __fastcall TFormOcean::GLSceneViewer1MouseMove(TObject *Sender,
	TShiftState Shift, int X, int Y) {
	if (Shift.Contains(ssLeft)) {
		GLCamera->MoveAroundTarget(my - Y, mx - X);
	}
	mx = X;
	my = Y;
}

// ---------------------------------------------------------------------------
void __fastcall TFormOcean::GLCadencer1Progress(TObject *Sender,
	const double deltaTime, const double newTime) {
	if ((dmx != 0) || (dmy != 0)) {
		GLCamera->MoveAroundTarget(dmy * 0.3, dmx * 0.3);
		dmx = 0;
		dmy = 0;
	}
	GLSceneViewer1->Invalidate();
}

// ---------------------------------------------------------------------------
void __fastcall TFormOcean::GLSceneViewer1MouseDown(TObject *Sender,
	TMouseButton Button, TShiftState Shift, int X, int Y) {
	mx = X;
	my = Y;
}

// ---------------------------------------------------------------------------
void __fastcall TFormOcean::GLHeightField1GetHeight(const float x, const float y,
	float &z, TVector4f &color, TTexPoint &texPoint) {
	z = 0;
}
// ---------------------------------------------------------------------------
const int cExtent = 200;

TGLVBOArrayBufferHandle *vbo;
int nbVerts;

void __fastcall TFormOcean::DOOceanPlaneRender(TObject *Sender,
	TGLRenderContextInfo &rci)

{
	int x, y;
	TGLTexPointList *v;
	bool cont;
	TGLExtensionsAndEntryPoints *GL;

	GLUserShader1DoApply(Sender, rci);
	GL = new TGLExtensionsAndEntryPoints();
	GL->EnableClientState(GL_VERTEX_ARRAY);

	if (!vbo) {
		v = new TGLTexPointList;

		v->Capacity = (cExtent + 1) * (cExtent + 1);
		y = -cExtent;
		while (y < cExtent) {
			x = -cExtent;
			while (x <= cExtent) {
				v->Add(y, x);
				v->Add(y + 2, x);
				x = x + 2;
			}
			y = y + 2;
			v->Add(y, cExtent);
			v->Add(y, -cExtent);
		}
		vbo = new TGLVBOArrayBufferHandle(true);
		vbo->Bind();
		vbo->BufferData(v->List, v->DataSize(), GL_STATIC_DRAW_ARB);
		nbVerts = v->Count;

		GL->VertexPointer(2, GL_FLOAT, 0, NULL);
		GL->DrawArrays(GL_QUAD_STRIP, 0, nbVerts);

		vbo->UnBind();

		delete v;
	}
	else {
		vbo->Bind();
		GL->VertexPointer(2, GL_FLOAT, 0, NULL);
		GL->DrawArrays(GL_TRIANGLE_STRIP, 0, nbVerts);
		vbo->UnBind();
	}
	GL->DisableClientState(GL_VERTEX_ARRAY);
	GLUserShader1DoUnApply(Sender, 0, rci, cont);
}

// ---------------------------------------------------------------------------
void __fastcall TFormOcean::GLSceneViewer1BeforeRender(TObject *Sender) {
	///  GLMemoryViewer1->Buffer->RenderingContext->ShareLists(GLSceneViewer1->Buffer->RenderingContext);
	///  GLMemoryViewer1->BeforeRender = NULL;
}
// ---------------------------------------------------------------------------
