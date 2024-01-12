object Form1: TForm1
  Left = 333
  Top = 106
  Width = 417
  Height = 249
  Caption = 'Thumb Convert'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object vlstAfiles: TFileListBox
    Left = 8
    Top = 8
    Width = 297
    Height = 185
    ItemHeight = 16
    Mask = '*.jpg'
    TabOrder = 0
  end
  object Button1: TButton
    Left = 312
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
end
