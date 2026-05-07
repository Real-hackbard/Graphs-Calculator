unit Unit1;

   {$D-}
   {$L-}
   {$C-}
   {$Q-}
   {$R-}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Express, OpenGL, XPMan, ComCtrls, Menus, Jpeg;

type TMyColor = Record
       R, G, B : glUByte;
     end;
type
  TForm1 = class(TForm)
    ColorDialog1: TColorDialog;
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    R2: TMenuItem;
    GraphColor2: TMenuItem;
    BackgroundColor1: TMenuItem;
    O2: TMenuItem;
    G2: TMenuItem;
    H1: TMenuItem;
    S1: TMenuItem;
    S2: TMenuItem;
    SaveDialog1: TSaveDialog;
    Q1: TMenuItem;
    N21: TMenuItem;
    N31: TMenuItem;
    N2: TMenuItem;
    Timer1: TTimer;
    A1: TMenuItem;
    Panel1: TPanel;
    N3: TMenuItem;
    X1: TMenuItem;
    Y1: TMenuItem;
    N4: TMenuItem;
    E1: TMenuItem;
    R1: TMenuItem;
    N1: TMenuItem;
    E2: TMenuItem;
    Timer2: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure R2Click(Sender: TObject);
    procedure Q1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure C2Click(Sender: TObject);
    procedure GraphColor2Click(Sender: TObject);
    procedure BackgroundColor1Click(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure G2Click(Sender: TObject);
    procedure S1Click(Sender: TObject);
    procedure S2Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure N31Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure A1Click(Sender: TObject);
    procedure E1Click(Sender: TObject);
    procedure R1Click(Sender: TObject);
    procedure E2Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { Private declarations }
    x, y : integer;
  public
    { Public declarations }
    rc : HGLRC;    // Rendering Context
    dc  : HDC;     // Device Context

    GraphColor : TMyColor;
    YRot, XRot : glFloat;
    Depth      : glFloat;
    Xcoord, Ycoord, Zcoord : Integer;
    MouseButton : Integer;

    xMin, xMax, yMin, yMax, zMin, zMax, xInc, yInc : glFloat;
    fx2D : Array of glFloat;
    fx3D : Array of Array of glFloat;

    abort : boolean;
    
    procedure InitGL;
    procedure glDraw;
    procedure getGraphData(newFunction : String);
    procedure Express;
  end;

var
  Form1: TForm1;
  frames : integer = 0;

implementation

uses Unit2, Unit3, Unit4;

{$R *.DFM}
procedure TForm1.Express;
var
  newFunction : String;
  Expression  : TExpress;
begin
  newFunction := Form2.ComboBox1.Text;
  newFunction :=lowercase(newFunction);

  try
    screen.cursor :=crHourglass;
    Expression := TExpress.create(self);
    Expression.Expression := newFunction;
    if not(Expression.Error) then
    begin
      getGraphData(newFunction);
      glDraw();    // Draw the scene
    end
    else
      //MessageDlg('Invalid function', mtError, [mbOK], 0)
  finally
    screen.cursor :=crDefault;
    Expression.Free;
  end;
end;

Function PanelToBmp(Panel:TPanel): TBitmap;
VAR
  bmp : TBitmap;
  Jpg: TJPEGImage;
  DC  : HDC;
Begin
  if frames = 360 then
  begin
    Beep;
    Form3.Close;
    Exit;
  end;

  bmp := TBitmap.Create;
  bmp.width := Panel.Width;
  bmp.Height := Panel.Height;
  DC := GetDc ( Panel.Handle );

  if Form4.CheckBox2.Checked = true then
  begin
    Bitblt(bmp.canvas.handle, 0, 0, Panel.Width, Panel.Height, Dc, 0, 0, NOTSRCCOPY);
  end else begin
    Bitblt(bmp.canvas.handle, 0, 0, Panel.Width, Panel.Height, Dc, 0, 0, SRCCOPY);
  end;

  Releasedc (Panel.handle,dc);

  case Form4.RadioGroup1.ItemIndex of
  0 : bmp.PixelFormat := pf8bit;
  1 : bmp.PixelFormat := pf24bit;
  2 : bmp.PixelFormat := pf32bit;
  end;

  if Form4.CheckBox1.Checked = true then
  begin
    bmp.TransparentColor := clBlack;
    bmp.Transparent := true;
  end;

  result := bmp;
  frames := frames + 1;
  Form3.ProgressBar1.Position := frames;

  case Form4.ComboBox1.ItemIndex of
  0 : begin
        bmp.SaveToFile(ExtractFilePath(Application.ExeName) +
                'Frames\' + IntToStr(frames) + '.bmp');
        Form3.Label3.Caption := IntToStr(frames) + '.bmp';
      end;

  1 : begin
        Jpg := TJPEGImage.Create;
        try
          Jpg.Assign(Bmp);

          if Form4.CheckBox1.Checked = true then
          begin
            Jpg.Transparent := true;
          end;

          Jpg.CompressionQuality := 100;
          Jpg.Compress;
          Jpg.SaveToFile(ExtractFilePath(Application.ExeName) +
                'Frames\' + IntToStr(frames) + '.jpg');
          Form3.Label3.Caption := IntToStr(frames) + '.jpg';
        finally
          Jpg.Free;
          Bmp.Free;
        end;
      end;
  end;

  Form3.Label4.Caption := IntToStr(frames);
End;

{------------------------------------------------------------------}
{  Function to draw the actual scene                               }
{------------------------------------------------------------------}
procedure TForm1.glDraw();
var
  X, Y : Integer;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);    // Clear The Screen And The Depth Buffer
  glLoadIdentity();                                       // Reset The View
  glTranslatef(0.0, 0.0, Depth);
  glRotatef(xRot, 1, 0, 0);
  glRotatef(-yRot, 0, 0, 1);

  // Draw the X, Y, Z axis
  if Form2.CheckBox4.Checked then
  begin
    glColor3ub(GraphColor.B, GraphColor.G, GraphColor.R);
    glBegin(GL_LINES);
      glVertex(2*xMin, (zMax+zMin)/2, (yMax+yMin)/2);
      glVertex(2*xMax, (zMax+zMin)/2, (yMax+yMin)/2);
      glVertex((xMax+xMin)/2, 2*zMin, (yMax+yMin)/2);
      glVertex((xMax+xMin)/2, 2*zMax, (yMax+yMin)/2);
      glVertex((xMax+xMin)/2, (zMax+zMin)/2, 2*yMin);
      glVertex((xMax+xMin)/2, (zMax+zMin)/2, 2*yMax);
    glEnd();
  end;

  glColor3ubv(@GraphColor);

  if Form2.RadioButton1.checked then
  begin
    glBegin(GL_QUADS);
      for X :=0 to High(fx2D)-1 do
      begin
        if not(Form2.CheckBox2.checked) then
          glColor3f(GraphColor.R*(zMax+fx2D[X])/zMax/256,
                    GraphColor.G*(zMax+fx2D[X])/zMax/256,
                    GraphColor.B*(zMax+fx2D[X])/zMax/256);
        glVertex3f(xMin+X*xInc, fx2D[X], 0.5);

        if Form2.CheckBox1.Checked then
          glColor3f(GraphColor.R*(zMax+fx2D[X+1])/zMax/256,
                    GraphColor.G*(zMax+fx2D[X+1])/zMax/256,
                    GraphColor.B*(zMax+fx2D[X+1])/zMax/256);
        glVertex3f(xMin+(X+1)*xInc, fx2D[X+1], 0.5);
        glVertex3f(xMin+(X+1)*xInc, fx2D[X+1], -0.5);

        if Form2.CheckBox1.Checked then
          glColor3f(GraphColor.R*(zMax+fx2D[X])/zMax/256,
                    GraphColor.G*(zMax+fx2D[X])/zMax/256,
                    GraphColor.B*(zMax+fx2D[X])/zMax/256);
        glVertex3f(xMin+X*xInc, fx2D[X], -0.5);
      end;
    glEnd();
  end
  else
  begin
    glBegin(GL_QUADS);
      for X :=0 to High(fx3D)-1 do
      begin
        for Y :=0 to High(fx3D[X])-1 do
        begin
          if not(Form2.CheckBox2.checked) then
            glColor3f(GraphColor.R*(zMax+fx3D[X, Y])/zMax/256,
                      GraphColor.G*(zMax+fx3D[X, Y])/zMax/256,
                      GraphColor.B*(zMax+fx3D[X, Y])/zMax/256);
          glVertex3f(xMin+X*xInc, fx3D[X, Y], yMin+Y*yInc);

          if Form2.CheckBox1.Checked then
            glColor3f(GraphColor.R*(zMax+fx3D[X+1, Y])/zMax/256,
                      GraphColor.G*(zMax+fx3D[X+1, Y])/zMax/256,
                      GraphColor.B*(zMax+fx3D[X+1, Y])/zMax/256);
          glVertex3f(xMin+(X+1)*xInc, fx3D[X+1, Y], yMin+Y*yInc);

          if Form2.CheckBox1.Checked then
            glColor3f(GraphColor.R*(zMax+fx3D[X+1, Y+1])/zMax/256,
                      GraphColor.G*(zMax+fx3D[X+1, Y+1])/zMax/256,
                      GraphColor.B*(zMax+fx3D[X+1, Y+1])/zMax/256);
          glVertex3f(xMin+(X+1)*xInc, fx3D[X+1, Y+1], yMin+(Y+1)*yInc);

          if Form2.CheckBox1.Checked then
            glColor3f(GraphColor.R*(zMax+fx3D[X, Y+1])/zMax/256,
                      GraphColor.G*(zMax+fx3D[X, Y+1])/zMax/256,
                      GraphColor.B*(zMax+fx3D[X, Y+1])/zMax/256);
          glVertex3f(xMin+X*xInc, fx3D[X, Y+1], yMin+(Y+1)*yInc);
        end;
      end;
    glEnd();
  end;
  SwapBuffers(DC);  // Display the scene
end;

{------------------------------------------------------------------}
{  Initialise the OpengGL variables                                }
{------------------------------------------------------------------}
procedure TForm1.InitGL;
begin
  glClearColor(1.0, 1.0, 1.0, 1.0);  // White Background
  glShadeModel(GL_SMOOTH);           // Enables Smooth Color Shading
  glClearDepth(1.0);                 // Depth Buffer Setup
  glEnable(GL_DEPTH_TEST);           // Enable Depth Buffer
  glDepthFunc(GL_LESS);		           // The Type Of Depth Test To Do
  glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);   //Realy Nice perspective calculations
end;

{------------------------------------------------------------------}
{  Form Create. Init openGL and local variables                    }
{------------------------------------------------------------------}
procedure TForm1.FormCreate(Sender: TObject);
var
  pfd : TPIXELFORMATDESCRIPTOR;
  pf  : Integer;
  Color : TColor;
begin
  DoubleBuffered := true;

  // OpenGL initial
  DecimalSeparator:='.';
  dc:=GetDC(Panel1.Handle);

  // PixelFormat
  pfd.nSize:=sizeof(pfd);
  pfd.nVersion:=1;
  pfd.dwFlags:=PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER or 0;
  pfd.iPixelType:=PFD_TYPE_RGBA;      // PFD_TYPE_RGBA or PFD_TYPEINDEX
  pfd.cColorBits:=32;

  pf :=ChoosePixelFormat(dc, @pfd);   // Returns format that most closely matches above pixel format
  SetPixelFormat(dc, pf, @pfd);

  rc :=wglCreateContext(dc);    // Rendering Context = window-glCreateContext
  wglMakeCurrent(dc,rc);        // Make the DC (Form1) the rendering Context

  Depth :=-3;
  GraphColor.R :=$88;
  GraphColor.G :=$60;
  GraphColor.B :=$10;
  setlength(fx2D, 0);
  setlength(fx3D, 0);
  InitGL;
  Color := clBlack;
  glClearColor(( Color AND $000000FF) / 255,
              (( Color AND $0000FF00) DIV 256) / 255,
              (( Color AND $00FF0000) DIV 65536) / 255, 1);

  Xcoord := 0;
  Ycoord := 0;
  Zcoord := 0;
  x := 0;
  y := 0;
end;

{---------------------------------------------}
{--- Resize scene when window resizes      ---}
{---------------------------------------------}
procedure TForm1.FormResize(Sender: TObject);
begin
{
  glViewport(0, 0, Panel1.Width, Panel1.Height);  // Set the viewport for the OpenGL window
  glMatrixMode(GL_PROJECTION);                    // Change Matrix Mode to Projection
  glLoadIdentity();                               // Reset View
  gluPerspective(45.0, Panel1.Width/Panel1.Height, 0.1, 500.0);  // Do the perspective calculations. Last value = max clipping depth

  glMatrixMode(GL_MODELVIEW);                     // Return to the modelview matrix
  glDraw();                                       // Draw the scene
}  
end;

{-----------------------------------------------------------------------}
{---  following functions control the scene rotation                 ---}
{-----------------------------------------------------------------------}
procedure TForm1.Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if MouseButton = 1 then
  begin
    xRot := xRot + (Y - Ycoord)/2;  // moving up and down = rot around X-axis
    yRot := yRot + (X - Xcoord)/2;
    Xcoord := X;
    Ycoord := Y;
    glDraw;
  end;
  if MouseButton = 2 then
  begin
    Depth := Depth - (Y-ZCoord)/3;
    Zcoord := Y;
    glDraw;
  end;

  StatusBar1.Panels[3].Text := IntToStr(x);
  StatusBar1.Panels[5].Text := IntToStr(y);
  StatusBar1.Panels[7].Text := FloatToStr(Depth);
end;

procedure TForm1.Panel1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft  then
  begin
    MouseButton :=1;
    Xcoord := X;
    Ycoord := Y;
  end;
  if Button = mbRight then
  begin
    MouseButton :=2;
    Zcoord := Y;
  end;
end;                                                     

procedure TForm1.Panel1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  MouseButton :=0;
end;

{-------------------------------------------------}
{--- Builds an array of vertices from function ---}
{-------------------------------------------------}
procedure TForm1.getGraphData(newFunction : String);
var
  xStep, yStep : Integer;
  X, Y : Integer;
  Result : glFloat;
  Expression : TExpress;
begin
  xMin :=StrToFloat(Form2.minX.Text);
  xMax :=StrToFloat(Form2.maxX.Text);
  xInc :=StrToFloat(Form2.IncX.Text);
  yMin :=StrToFloat(Form2.minY.Text);
  yMax :=StrToFloat(Form2.maxY.Text);
  yInc :=StrToFloat(Form2.IncY.Text);
  zMin := 999999999;
  zMax :=-999999999;

  if (yMax - yMin) > (xMax - xMin) then
    Depth :=-2*(yMax - yMin)-1
  else
    Depth :=-2*(xMax - xMin)-1;

  Expression := TExpress.create(self);
  Expression.Expression := newFunction;
  try
    if Form2.RadioButton1.Checked then
    begin
      xStep :=Abs(Round((xMax - xMin)/xInc));
      SetLength(fx2D, xStep+1);
      try
        for X :=0 to xStep do
        begin
          //Expression.Expression := newFunction;
          Result :=Expression.theFunction(xMin+X*xInc, 0, 0);

          fx2D[X] :=Result;
          if Result < zMin then zMin :=Result;
          if Result > zMax then zMax :=Result;
        end;
      except
        on E:Exception do
        messageDlg(E.Message,mtError,[mbOk],0);
      end;
    end
    else
    begin
      xStep :=Abs(Round((xMax - xMin)/xInc));
      yStep :=Abs(Round((yMax - yMin)/yInc));
      SetLength(fx3D, xStep+1, yStep+1);
      try
        for X :=0 to xStep do
        begin
          for Y :=0 to yStep do
          begin
            //Expression.Expression := newFunction;
            Result :=Expression.theFunction(xMin+X*xInc, yMin+Y*yInc, 0);
            fx3D[X, Y] :=Result;
            if Result < zMin then zMin :=Result;
            if Result > zMax then zMax :=Result;
          end
        end;
      except
        on E:Exception do
        messageDlg(E.Message,mtError,[mbOk],0);
      end;
    end
  finally
    Expression.Free;
  end;
end;

{---------------------------------------------}
{--- Changes the background color          ---}
{---------------------------------------------}
procedure TForm1.FormShow(Sender: TObject);
begin
  Form2.ComboBox1.OnChange(sender);
  //C2.OnClick(self);
  Express;
end;

{---------------------------------------------}
{--- Refresh the scene if necesary         ---}
{---------------------------------------------}
procedure TForm1.R2Click(Sender: TObject);
begin
  glDraw();    // Draw the scene
end;

procedure TForm1.Q1Click(Sender: TObject);
begin
  Close();
end;

{---------------------------------------------}
{--- Release OpenGL when window closes     ---}
{---------------------------------------------}
procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Timer1.Enabled := false;

  // Cleanly exit the OpenGL context
  if RC <> 0 then
  begin
    wglMakeCurrent(0, 0);
    wglDeleteContext(RC);
    RC := 0;
  end;

  if DC <> 0 then
  begin
    ReleaseDC(Handle, DC);
    DC := 0;
  end;
end;

procedure TForm1.C2Click(Sender: TObject);

begin
 
end;

{---------------------------------------------}
{--- Changes the graph color               ---}
{---------------------------------------------}
procedure TForm1.GraphColor2Click(Sender: TObject);
var
  Color : TColor;
begin
  ColorDialog1.Color := Color;
  if ColorDialog1.Execute then
  begin
    Color :=ColorDialog1.Color;
    GraphColor.R := Color AND $000000FF;
    GraphColor.G :=(Color AND $0000FF00) DIV 256;
    GraphColor.B :=(Color AND $00FF0000) DIV 65536;
    glDraw();
  end;
end;

procedure TForm1.BackgroundColor1Click(Sender: TObject);
var
  Color : TColor;
begin
  ColorDialog1.Color := Color;
  if ColorDialog1.Execute then
  begin
    Color :=ColorDialog1.Color;
    glClearColor(( Color AND $000000FF) / 255,
                 (( Color AND $0000FF00) DIV 256) / 255,
                 (( Color AND $00FF0000) DIV 65536) / 255, 1);
    glDraw();
  end;
end;

procedure TForm1.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  glViewport(0, 0, Panel1.Width, Panel1.Height);  // Set the viewport for the OpenGL window
  glMatrixMode(GL_PROJECTION);                    // Change Matrix Mode to Projection
  glLoadIdentity();                               // Reset View
  gluPerspective(45.0, Panel1.Width/Panel1.Height, 0.1, 500.0);  // Do the perspective calculations. Last value = max clipping depth

  glMatrixMode(GL_MODELVIEW);                     // Return to the modelview matrix
  glDraw();

  StatusBar1.Panels[1].Text := IntToStr(Panel1.Width) + 'x' +
                               IntToStr(Panel1.Height);
end;

procedure TForm1.G2Click(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.S1Click(Sender: TObject);
begin
  Messagebox(form1.handle, 'All mathematical functions that can be applied.' +#13+#13+
  'Operators'+#13+
  '+ | - | * | / | ^  (power  i.e X^2)'+#13#13+
  'Standard Functions'+#13+
  'ABS | SQR | SQRT | EXP | LN | FR   (fractional part   i.e fr(x))'+#13#13+
  'Trig functions'+#13+
  'SIN | COS | TAN | SINH | COSH | TANH | ARCSIN | ARCCOS | COT'+#13#13+
  'Constants'+#13+
  'PI',
  'Available functions', MB_OK or MB_ICONINFORMATION);
end;

procedure TForm1.S2Click(Sender: TObject);
VAR
  bmp : TBitmap;
  Jpg: TJPEGImage;
  DC  : HDC;
Begin
  case Form4.ComboBox1.ItemIndex of
  0 : SaveDialog1.FilterIndex := 1;
  1 : SaveDialog1.FilterIndex := 2;
  end;

  if SaveDialog1.Execute then
  begin
    try
      bmp := TBitmap.Create;
      bmp.width := Panel1.Width;
      bmp.Height := Panel1.Height;
      DC := GetDc ( Panel1.Handle );

      if Form4.CheckBox2.Checked = true then
      begin
        Bitblt(bmp.canvas.handle, 0, 0, Panel1.Width, Panel1.Height, Dc, 0, 0, NOTSRCCOPY);
      end else begin
        Bitblt(bmp.canvas.handle, 0, 0, Panel1.Width, Panel1.Height, Dc, 0, 0, SRCCOPY);
      end;

      if Form4.CheckBox1.Checked = true then
      begin
        bmp.TransparentColor := clBlack;
        bmp.Transparent := true;
      end;

      case Form4.RadioGroup1.ItemIndex of
        0 : bmp.PixelFormat := pf8bit;
        1 : bmp.PixelFormat := pf24bit;
        2 : bmp.PixelFormat := pf32bit;
      end;

      case Form4.ComboBox1.ItemIndex of
        0 : bmp.SaveToFile(SaveDialog1.FileName + '.bmp');
        1 : begin
              Jpg := TJPEGImage.Create;
              try
                Jpg.Assign(Bmp);

                if Form4.CheckBox1.Checked = true then
                begin
                  Jpg.Transparent := true;
                end;

                Jpg.CompressionQuality := 100;
                Jpg.Compress;
                Jpg.SaveToFile(SaveDialog1.FileName + '.jpg');
              finally
                Jpg.Free;
              end;
            end;
      end;
    finally
      bmp.Free;
    end;
  end;
end;


procedure TForm1.N21Click(Sender: TObject);
begin
  Form2.RadioButton1.Checked := true;
end;

procedure TForm1.N31Click(Sender: TObject);
begin
  Form2.RadioButton2.Checked := true;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  // moving up and down = rot around X-axis
  if X1.Checked = true then xRot := xRot + (Y - Ycoord+1)/2;
  if Y1.Checked = true then yRot := yRot + (X - Xcoord+1)/2;

  Xcoord := X;
  Ycoord := Y;
  glDraw;
end;

procedure TForm1.A1Click(Sender: TObject);
begin
  Timer1.Enabled := not Timer1.Enabled;
end;

procedure TForm1.E1Click(Sender: TObject);
begin
  abort := false;
  x := 0;
  y := 0;
  xRot := 0;
  yRot := 0;
  Xcoord := X;
  Ycoord := Y;
  glDraw;
  Panel1.Update;
  frames := 0;
  A1.Checked := true;
  Form3.Show;
  Timer1.Enabled := true;
  Timer2.Enabled := true;
end;

procedure TForm1.R1Click(Sender: TObject);
begin
  x := 0;
  y := 0;
  xRot := 0;
  yRot := 0;
  Xcoord := X;
  Ycoord := Y;
  glDraw;
  Panel1.Update;
end;

procedure TForm1.E2Click(Sender: TObject);
begin
  Form4.Show;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  PanelToBmp(Panel1);

  if abort = true then
  begin
    Timer2.Enabled := false;
    Form3.Close;
    Exit;
  end;
end;

end.



