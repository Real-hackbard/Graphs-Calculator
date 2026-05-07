object Form1: TForm1
  Left = 277
  Top = 143
  Width = 798
  Height = 580
  Caption = 'Graph Calculator'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCanResize = FormCanResize
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 502
    Width = 782
    Height = 19
    Panels = <
      item
        Text = 'Size : '
        Width = 35
      end
      item
        Width = 150
      end
      item
        Text = 'X-Pos :'
        Width = 50
      end
      item
        Width = 50
      end
      item
        Text = 'Y-Pos :'
        Width = 50
      end
      item
        Width = 50
      end
      item
        Text = 'Z-Pos :'
        Width = 50
      end
      item
        Width = 150
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 782
    Height = 502
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    FullRepaint = False
    TabOrder = 1
    OnMouseDown = Panel1MouseDown
    OnMouseMove = Panel1MouseMove
    OnMouseUp = Panel1MouseUp
  end
  object ColorDialog1: TColorDialog
    Options = [cdFullOpen, cdSolidColor, cdAnyColor]
    Left = 32
    Top = 40
  end
  object MainMenu1: TMainMenu
    Left = 64
    Top = 40
    object F1: TMenuItem
      Caption = 'File'
      object S2: TMenuItem
        Caption = 'Save'
        ShortCut = 16467
        OnClick = S2Click
      end
      object E1: TMenuItem
        Caption = 'Export Frames..'
        OnClick = E1Click
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Q1: TMenuItem
        Caption = 'Quit'
        ShortCut = 81
        OnClick = Q1Click
      end
    end
    object G1: TMenuItem
      Caption = 'Graph'
      object A1: TMenuItem
        AutoCheck = True
        Caption = 'Animate'
        ShortCut = 65
        OnClick = A1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object X1: TMenuItem
        AutoCheck = True
        Caption = 'X-Axis'
        Checked = True
        ShortCut = 88
      end
      object Y1: TMenuItem
        AutoCheck = True
        Caption = 'Y-Axis'
        Checked = True
        ShortCut = 89
      end
      object R1: TMenuItem
        Caption = 'Reset'
        ShortCut = 82
        OnClick = R1Click
      end
      object R2: TMenuItem
        Caption = 'Refresh'
        OnClick = R2Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object N31: TMenuItem
        AutoCheck = True
        Caption = '3D'
        Checked = True
        OnClick = N31Click
      end
      object N21: TMenuItem
        AutoCheck = True
        Caption = '2D'
        OnClick = N21Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object GraphColor2: TMenuItem
        Caption = 'Graph Color'
        ShortCut = 116
        OnClick = GraphColor2Click
      end
      object BackgroundColor1: TMenuItem
        Caption = 'Background Color'
        ShortCut = 117
        OnClick = BackgroundColor1Click
      end
    end
    object O2: TMenuItem
      Caption = 'Options'
      object G2: TMenuItem
        Caption = 'Calculate'
        ShortCut = 112
        OnClick = G2Click
      end
      object E2: TMenuItem
        Caption = 'Export'
        OnClick = E2Click
      end
    end
    object H1: TMenuItem
      Caption = 'Help'
      object S1: TMenuItem
        Caption = 'Available functions'
        OnClick = S1Click
      end
    end
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Bitmap (*.bmp)|*.bmp|Jpg/Jpeg (*.jpg)|*.jpg'
    Left = 96
    Top = 40
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 25
    OnTimer = Timer1Timer
    Left = 128
    Top = 40
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 25
    OnTimer = Timer2Timer
    Left = 160
    Top = 40
  end
end
