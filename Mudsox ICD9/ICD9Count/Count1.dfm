object Form1: TForm1
  Left = 192
  Top = 107
  Width = 696
  Height = 480
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 0
    Top = 0
    Width = 75
    Height = 25
    Caption = 'Load Prefix'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Panel1: TPanel
    Left = 400
    Top = 0
    Width = 288
    Height = 453
    Align = alRight
    Caption = 'Panel1'
    TabOrder = 1
    object Memo1: TMemo
      Left = 1
      Top = 1
      Width = 286
      Height = 451
      Align = alClient
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 81
    Top = 0
    Width = 319
    Height = 453
    Align = alRight
    Caption = 'Panel2'
    TabOrder = 2
    object Memo2: TMemo
      Left = 1
      Top = 1
      Width = 317
      Height = 451
      Align = alClient
      TabOrder = 0
    end
  end
  object Button2: TButton
    Left = 0
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Loop'
    TabOrder = 3
    OnClick = Button2Click
  end
end
