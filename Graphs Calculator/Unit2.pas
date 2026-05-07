unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OpenGL;

type
  TForm2 = class(TForm)
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    minX: TEdit;
    maxX: TEdit;
    minY: TEdit;
    maxY: TEdit;
    incX: TEdit;
    incY: TEdit;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    ComboBox1: TComboBox;
    GroupBox3: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    GroupBox4: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Button1: TButton;
    CheckBox5: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure minXKeyPress(Sender: TObject; var Key: Char);
    procedure CheckBox5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
begin
  SetWindowPos(Handle, HWND_TOPMOST, Left,Top, Width,Height,
             SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  Form1.Express;
end;

{---------------------------------------------}
{--- Changes to 2D graphs                  ---}
{---------------------------------------------}
procedure TForm2.RadioButton1Click(Sender: TObject);
begin
  Form2.Label2.Caption :='y =';
//    functionEdit.Text :='sin(pi*x)';
  Form1.N31.Checked := false;
  Form1.N21.Checked := true;
  Button1.OnClick(self);
end;

{---------------------------------------------}
{--- Changes to 3D graphs                  ---}
{---------------------------------------------}
procedure TForm2.RadioButton2Click(Sender: TObject);
begin
  Form2.Label2.Caption :='z =';
//    functionEdit.Text :='cos(2*pi*x)/4 + cos(2*pi*y)/4';
  Form1.N21.Checked := false;
  Form1.N31.Checked := true;
  Button1.OnClick(self);
end;

{-----------------------------------------------------}
{--- Check for valid function and create vertices  ---}
{-----------------------------------------------------}
procedure TForm2.ComboBox1Change(Sender: TObject);
begin
  { Converted all numbers with FormatFloat }
  case Form2.ComboBox1.itemindex of
    0 : begin
          //Form2.ComboBox1.Text := 'x^2 + y^2 - 1';
          Form2.minX.Text :=FormatFloat('0.00######', -1.000);
          Form2.maxX.Text :=FormatFloat('0.00######', 1.000);
          Form2.incX.Text :=FormatFloat('0.00######', 0.1);
          Form2.minY.Text :=FormatFloat('0.00######', -1.000);
          Form2.maxY.Text :=FormatFloat('0.00######', 1.000);
          Form2.incY.Text :=FormatFloat('0.00######', 0.1);
        end;
    1 : begin
          //Form2.ComboBox1.Text := 'cos(x + pi*sin(y))';
          Form2.minX.Text :=FormatFloat('0.00######', -1.000);
          Form2.maxX.Text :=FormatFloat('0.00######', 1.000);
          Form2.incX.Text :=FormatFloat('0.00######', 0.1);
          Form2.minY.Text :=FormatFloat('0.00######', -1.000);
          Form2.maxY.Text :=FormatFloat('0.00######', 1.000);
          Form2.incY.Text :=FormatFloat('0.00######', 0.1);
        end;
    2 : begin
          //Form2.ComboBox1.Text := 'cos(pi*x)/2 + cos(pi*y)/2';
          Form2.minX.Text :=FormatFloat('0.00######', -3.000);
          Form2.maxX.Text :=FormatFloat('0.00######', 3.000);
          Form2.incX.Text :=FormatFloat('0.00######', 0.1);
          Form2.minY.Text :=FormatFloat('0.00######', -3.000);
          Form2.maxY.Text :=FormatFloat('0.00######', 3.000);
          Form2.incY.Text :=FormatFloat('0.00######', 0.1);
          Form2.CheckBox1.Checked :=FALSE;
        end;
    3 : begin
          //Form2.ComboBox1.Text := 'cos(x + pi*sin(y))';
          Form2.minX.Text :=FormatFloat('0.00######', -6.000);
          Form2.maxX.Text :=FormatFloat('0.00######', 6.000);
          Form2.incX.Text :=FormatFloat('0.00######', 0.2);
          Form2.minY.Text :=FormatFloat('0.00######', -6.000);
          Form2.maxY.Text :=FormatFloat('0.00######', 6.000);
          Form2.incY.Text :=FormatFloat('0.00######', 0.2);
        end;
    4 : begin
          //Form2.ComboBox1.Text := '10*Sin(sqrt((x*x)+(y*y)))/(sqrt((x*x)+(y*y)))';
          Form2.minX.Text :=FormatFloat('0.00######', -20.000);
          Form2.maxX.Text :=FormatFloat('0.00######', 20.000);
          Form2.incX.Text :=FormatFloat('0.00######', 0.6);
          Form2.minY.Text :=FormatFloat('0.00######', -20.000);
          Form2.maxY.Text :=FormatFloat('0.00######', 20.000);
          Form2.incY.Text :=FormatFloat('0.00######', 0.6);
        end;
    5 : begin
          Form2.minX.Text :=FormatFloat('0.00######', -2.000);
          Form2.maxX.Text :=FormatFloat('0.00######', 2.000);
          Form2.incX.Text :=FormatFloat('0.00######', 0.2);
          Form2.minY.Text :=FormatFloat('0.00######', -2.000);
          Form2.maxY.Text :=FormatFloat('0.00######', 2.000);
          Form2.incY.Text :=FormatFloat('0.00######', 0.2);
        end;
    6 : begin
          Form2.minX.Text :=FormatFloat('0.00######', -1.000);
          Form2.maxX.Text :=FormatFloat('0.00######', 1.000);
          Form2.incX.Text :=FormatFloat('0.00######', 0.1);
          Form2.minY.Text :=FormatFloat('0.00######', -1.000);
          Form2.maxY.Text :=FormatFloat('0.00######', 1.000);
          Form2.incY.Text :=FormatFloat('0.00######', 0.1);
        end;
    7 : begin
          Form2.minX.Text :=FormatFloat('0.00######', -1.000);
          Form2.maxX.Text :=FormatFloat('0.00######', 1.000);
          Form2.incX.Text :=FormatFloat('0.00######', 0.1);
          Form2.minY.Text :=FormatFloat('0.00######', -1.000);
          Form2.maxY.Text :=FormatFloat('0.00######', 1.000);
          Form2.incY.Text :=FormatFloat('0.00######', 0.1);
        end;
    8 : begin
          Form2.minX.Text :=FormatFloat('0.00######', -30.000);
          Form2.maxX.Text :=FormatFloat('0.00######', 3.000);
          Form2.incX.Text :=FormatFloat('0.00######', 0.8);
          Form2.minY.Text :=FormatFloat('0.00######', -30.000);
          Form2.maxY.Text :=FormatFloat('0.00######', 30.000);
          Form2.incY.Text :=FormatFloat('0.00######', 0.6);
        end;
    9 : begin
          Form2.minX.Text :=FormatFloat('0.00######', -1.000);
          Form2.maxX.Text :=FormatFloat('0.00######', 1.000);
          Form2.incX.Text :=FormatFloat('0.00######', 0.1);
          Form2.minY.Text :=FormatFloat('0.00######', -1.000);
          Form2.maxY.Text :=FormatFloat('0.00######', 1.000);
          Form2.incY.Text :=FormatFloat('0.00######', 0.1);
        end;
    10 : begin
          Form2.minX.Text :=FormatFloat('0.00######', -3.000);
          Form2.maxX.Text :=FormatFloat('0.00######', 3.000);
          Form2.incX.Text :=FormatFloat('0.00######', 0.1);
          Form2.minY.Text :=FormatFloat('0.00######', -3.000);
          Form2.maxY.Text :=FormatFloat('0.00######', 3.000);
          Form2.incY.Text :=FormatFloat('0.00######', 0.1);
        end;
    11 : begin
          Form2.minX.Text :=FormatFloat('0.00######', -2.000);
          Form2.maxX.Text :=FormatFloat('0.00######', 2.000);
          Form2.incX.Text :=FormatFloat('0.00######', 0.1);
          Form2.minY.Text :=FormatFloat('0.00######', -2.000);
          Form2.maxY.Text :=FormatFloat('0.00######', 2.000);
          Form2.incY.Text :=FormatFloat('0.00######', 0.1);
        end;
  end;
  Form1.Express;
end;

{-----------------------------------------------------}
{--- Toggle between smooth and non-smooth gradient ---}
{-----------------------------------------------------}
procedure TForm2.CheckBox1Click(Sender: TObject);
begin
  Form1.glDraw();
end;

{-----------------------------------------------------}
{--- Toggle between gradient and flat shaded graph ---}
{-----------------------------------------------------}
procedure TForm2.CheckBox2Click(Sender: TObject);
begin
  Form1.glDraw();
end;

{-----------------------------------------------------}
{--- Toggle between solid and wireframe mode       ---}
{-----------------------------------------------------}
procedure TForm2.CheckBox3Click(Sender: TObject);
begin
  if CheckBox3.Checked then
    glPolygonmode(GL_FRONT_AND_BACK, GL_LINE)
  else
    glPolygonmode(GL_FRONT_AND_BACK, GL_FILL);
  Form1.glDraw();
end;

{-----------------------------------------------------}
{--- Toggle axis display on and off                ---}
{-----------------------------------------------------}
procedure TForm2.CheckBox4Click(Sender: TObject);
begin
  Form1.glDraw;
end;

procedure TForm2.minXKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in [#48..#57, #46, #08, '-']) then
    key := #0;
end;

procedure TForm2.CheckBox5Click(Sender: TObject);
begin
  if CheckBox5.Checked then
    glPolygonmode(GL_FRONT_AND_BACK, GL_POINT)
  else
    glPolygonmode(GL_FRONT_AND_BACK, GL_FILL);
  Form1.glDraw();
end;

end.
