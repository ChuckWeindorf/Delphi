object Form1: TForm1
  Left = 320
  Top = 120
  Width = 696
  Height = 534
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object WebBrowser1: TWebBrowser
    Left = 0
    Top = 105
    Width = 688
    Height = 402
    Align = alClient
    TabOrder = 0
    OnNavigateComplete2 = WebBrowser1NavigateComplete2
    ControlData = {
      4C0000001B4700008C2900000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 688
    Height = 105
    Align = alTop
    TabOrder = 1
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 161
      Height = 25
      Caption = 'Test All Specific Codes in Order'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 8
      Top = 56
      Width = 57
      Height = 25
      Caption = 'Stop'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Edit1: TEdit
      Left = 552
      Top = 8
      Width = 121
      Height = 21
      TabOrder = 2
      Text = 'Edit1'
    end
    object Edit2: TEdit
      Left = 552
      Top = 32
      Width = 121
      Height = 21
      TabOrder = 3
      Text = 'Edit2'
    end
    object Edit4: TEdit
      Left = 552
      Top = 56
      Width = 121
      Height = 21
      TabOrder = 4
      Text = 'Edit4'
    end
    object RadioGroup1: TRadioGroup
      Left = 472
      Top = 3
      Width = 65
      Height = 97
      Caption = 'SleepTime'
      ItemIndex = 0
      Items.Strings = (
        '0'
        '20'
        '50'
        '100'
        '200')
      TabOrder = 5
    end
  end
end
