object Form2: TForm2
  Left = 889
  Top = 191
  BorderStyle = bsDialog
  Caption = 'Calculate'
  ClientHeight = 396
  ClientWidth = 323
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 9
    Top = 257
    Width = 305
    Height = 128
    Caption = ' Range '
    TabOrder = 0
    object Label3: TLabel
      Left = 8
      Top = 23
      Width = 16
      Height = 13
      Caption = 'X : '
    end
    object Label4: TLabel
      Left = 86
      Top = 23
      Width = 9
      Height = 13
      Caption = 'to'
    end
    object Label1: TLabel
      Left = 8
      Top = 51
      Width = 16
      Height = 13
      Caption = 'Y : '
    end
    object Label5: TLabel
      Left = 86
      Top = 51
      Width = 9
      Height = 13
      Caption = 'to'
    end
    object Label7: TLabel
      Left = 176
      Top = 24
      Width = 58
      Height = 13
      Caption = 'Increments :'
    end
    object Label8: TLabel
      Left = 176
      Top = 51
      Width = 58
      Height = 13
      Caption = 'Increments :'
    end
    object minX: TEdit
      Left = 28
      Top = 20
      Width = 53
      Height = 21
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 7
      ParentFont = False
      TabOrder = 0
      Text = '-1.000'
      OnKeyPress = minXKeyPress
    end
    object maxX: TEdit
      Left = 102
      Top = 20
      Width = 53
      Height = 21
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 7
      ParentFont = False
      TabOrder = 1
      Text = '1.000'
      OnKeyPress = minXKeyPress
    end
    object minY: TEdit
      Left = 28
      Top = 48
      Width = 53
      Height = 21
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 7
      ParentFont = False
      TabOrder = 2
      Text = '-1.000'
      OnKeyPress = minXKeyPress
    end
    object maxY: TEdit
      Left = 102
      Top = 48
      Width = 53
      Height = 21
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 7
      ParentFont = False
      TabOrder = 3
      Text = '1.000'
      OnKeyPress = minXKeyPress
    end
    object incX: TEdit
      Left = 240
      Top = 20
      Width = 53
      Height = 21
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 4
      ParentFont = False
      TabOrder = 4
      Text = '0.1'
      OnKeyPress = minXKeyPress
    end
    object incY: TEdit
      Left = 240
      Top = 48
      Width = 53
      Height = 21
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 4
      ParentFont = False
      TabOrder = 5
      Text = '0.1'
      OnKeyPress = minXKeyPress
    end
    object Button1: TButton
      Left = 214
      Top = 87
      Width = 75
      Height = 25
      Caption = 'Calculate'
      TabOrder = 6
      TabStop = False
      OnClick = Button1Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 64
    Width = 305
    Height = 57
    Caption = ' Mathematics formula '
    TabOrder = 1
    object Label2: TLabel
      Left = 15
      Top = 24
      Width = 14
      Height = 13
      Caption = 'z ='
    end
    object ComboBox1: TComboBox
      Left = 40
      Top = 24
      Width = 249
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ItemIndex = 3
      ParentFont = False
      TabOrder = 0
      TabStop = False
      Text = 'cos(x + pi*sin(y))'
      OnChange = ComboBox1Change
      Items.Strings = (
        'x^2 + y^2 - 1'
        'cos(x + pi*sin(y))'
        'cos(pi*x)/2 + cos(pi*y)/2'
        'cos(x + pi*sin(y))'
        '10*Sin(sqrt((x*x)+(y*y)))/(sqrt((x*x)+(y*y)))'
        'sin(x + pi*cos(y))'
        'x^10 + y^150 - 1'
        'fr(pi*x-12)/10 + fr(pi*y+12)/10'
        'y+y/(x)-y+y'
        'sin(x*2^2) * sin(y*2^2)'
        'sin(pi*x)/2 * sin(pi*y)/2'
        'cos(x * pi*sin(y*2))')
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 8
    Width = 305
    Height = 49
    Caption = ' Mode '
    TabOrder = 2
    object RadioButton1: TRadioButton
      Left = 16
      Top = 24
      Width = 89
      Height = 17
      Caption = '2D  { y = f(x) }'
      TabOrder = 0
      OnClick = RadioButton1Click
    end
    object RadioButton2: TRadioButton
      Left = 144
      Top = 24
      Width = 113
      Height = 17
      Caption = '3D  { z = f(x,y) }'
      Checked = True
      TabOrder = 1
      TabStop = True
      OnClick = RadioButton2Click
    end
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 136
    Width = 305
    Height = 113
    Caption = ' Graphic '
    TabOrder = 3
    object CheckBox1: TCheckBox
      Left = 16
      Top = 32
      Width = 100
      Height = 17
      Caption = 'Smooth Shading'
      TabOrder = 0
      OnClick = CheckBox1Click
    end
    object CheckBox2: TCheckBox
      Left = 16
      Top = 56
      Width = 79
      Height = 17
      Caption = 'Flat Shaded'
      TabOrder = 1
      OnClick = CheckBox2Click
    end
    object CheckBox3: TCheckBox
      Left = 160
      Top = 32
      Width = 69
      Height = 17
      Caption = 'Wireframe'
      TabOrder = 2
      OnClick = CheckBox3Click
    end
    object CheckBox4: TCheckBox
      Left = 160
      Top = 56
      Width = 73
      Height = 17
      Caption = 'Show Axes'
      TabOrder = 3
      OnClick = CheckBox4Click
    end
    object CheckBox5: TCheckBox
      Left = 16
      Top = 80
      Width = 46
      Height = 17
      Caption = 'Point'
      TabOrder = 4
      OnClick = CheckBox5Click
    end
  end
end
