unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;

type
  TForm3 = class(TForm)
    Bevel1: TBevel;
    ProgressBar1: TProgressBar;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FColorKey: TCOLOR;
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

const
  LWA_COLORKEY = 1;
  LWA_ALPHA     = 2;
  WS_EX_LAYERED = $80000;

implementation

uses Unit1;

{$R *.dfm}
function MakeWindowTransparent(Wnd: HWND; nAlpha: Integer = 10): Boolean;
type
  TSetLayeredWindowAttributes = function(hwnd: HWND; crKey: COLORREF; bAlpha: Byte;
    dwFlags: Longint): Longint;
  stdcall;
var
  hUser32: HMODULE;
  SetLayeredWindowAttributes: TSetLayeredWindowAttributes;
begin
  Result := False;
  hUser32 := GetModuleHandle('USER32.DLL');
  if hUser32 <> 0 then
  begin @SetLayeredWindowAttributes := GetProcAddress(hUser32, 'SetLayeredWindowAttributes');
    if @SetLayeredWindowAttributes <> nil then
    begin
      SetWindowLong(Wnd, GWL_EXSTYLE, GetWindowLong(Wnd, GWL_EXSTYLE) or WS_EX_LAYERED);
      SetLayeredWindowAttributes(Wnd, 0, Trunc((255 / 100) * (100 - nAlpha)), LWA_ALPHA);
      Result := True;
    end;
  end;
end;

function SetLayeredWindowAttributes(
  Wnd: hwnd;
  crKey: ColorRef;
  Alpha: Byte;
  dwFlags: DWORD): Boolean;
  stdcall; external 'user32.dll';

procedure TForm3.FormCreate(Sender: TObject);
begin
  SetWindowPos(Handle, HWND_TOPMOST, Left,Top, Width,Height,
             SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED);
  SetLayeredWindowAttributes(Handle, ColorToRGB(FColorKey), 220, LWA_ALPHA);
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  Form1.Abort := true;
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form1.Abort := true;
end;

end.
