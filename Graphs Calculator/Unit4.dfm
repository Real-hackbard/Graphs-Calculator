object Form4: TForm4
  Left = 956
  Top = 179
  BorderStyle = bsDialog
  Caption = 'Export Options'
  ClientHeight = 237
  ClientWidth = 299
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
  object RadioGroup1: TRadioGroup
    Left = 16
    Top = 8
    Width = 121
    Height = 81
    Caption = ' Pixel Bit '
    ItemIndex = 1
    Items.Strings = (
      '8'
      '24'
      '32')
    TabOrder = 0
  end
  object CheckBox1: TCheckBox
    Left = 24
    Top = 112
    Width = 113
    Height = 17
    Caption = 'Transparent (Black)'
    TabOrder = 1
  end
  object CheckBox2: TCheckBox
    Left = 24
    Top = 136
    Width = 58
    Height = 17
    Caption = 'Negativ'
    TabOrder = 2
  end
  object GroupBox1: TGroupBox
    Left = 160
    Top = 8
    Width = 121
    Height = 81
    Caption = ' Format '
    TabOrder = 3
    object ComboBox1: TComboBox
      Left = 8
      Top = 48
      Width = 105
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'Bitmap'
      Items.Strings = (
        'Bitmap'
        'Jpg/Jpeg')
    end
  end
  object Button1: TButton
    Left = 200
    Top = 192
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 4
    OnClick = Button1Click
  end
end
