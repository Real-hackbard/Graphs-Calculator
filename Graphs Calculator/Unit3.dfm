object Form3: TForm3
  Left = 423
  Top = 304
  BorderStyle = bsDialog
  Caption = 'Create Frames'
  ClientHeight = 149
  ClientWidth = 394
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 16
    Top = 56
    Width = 369
    Height = 41
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 32
    Top = 16
    Width = 36
    Height = 11
    Caption = 'Frames :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Small Fonts'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 24
    Top = 32
    Width = 43
    Height = 11
    Caption = 'Progress :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Small Fonts'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 72
    Top = 16
    Width = 27
    Height = 11
    Caption = 'Label3'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -9
    Font.Name = 'Small Fonts'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 72
    Top = 32
    Width = 27
    Height = 11
    Caption = 'Label4'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -9
    Font.Name = 'Small Fonts'
    Font.Style = []
    ParentFont = False
  end
  object ProgressBar1: TProgressBar
    Left = 24
    Top = 66
    Width = 353
    Height = 17
    Max = 360
    TabOrder = 0
  end
  object Button1: TButton
    Left = 296
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Abort'
    TabOrder = 1
    OnClick = Button1Click
  end
end
