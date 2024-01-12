object frm1: Tfrm1
  Left = 159
  Top = 134
  Width = 637
  Height = 321
  Caption = 'Mudsox Ad Manager'
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
  object tbr1: TToolBar
    Left = 0
    Top = 0
    Width = 629
    Height = 29
    ButtonHeight = 25
    Caption = 'tbr1'
    EdgeBorders = [ebTop, ebBottom]
    TabOrder = 0
    object cmdSave: TSpeedButton
      Left = 0
      Top = 2
      Width = 25
      Height = 25
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333FFFFFFFFFFFFF33000077777770033377777777777773F000007888888
        00037F3337F3FF37F37F00000780088800037F3337F77F37F37F000007800888
        00037F3337F77FF7F37F00000788888800037F3337777777337F000000000000
        00037F3FFFFFFFFFFF7F00000000000000037F77777777777F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF07037F7F33333333777F000FFFFFFFFF
        0003737FFFFFFFFF7F7330099999999900333777777777777733}
      NumGlyphs = 2
      OnClick = cmdSaveClick
    end
    object Splitter1: TSplitter
      Left = 25
      Top = 2
      Width = 293
      Height = 25
      Cursor = crHSplit
    end
    object cmdAdd: TSpeedButton
      Left = 318
      Top = 2
      Width = 25
      Height = 25
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
        333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
        0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333337F3FF3FFF7F333330F00F000F07333337F77377737F333330FFFFFFFF
        07333FF7F3FFFF3F7FFFBBB0F0000F0F0BB37777F7777373777F3BB0FFFFFFFF
        0BBB3777F3FF3FFF77773330F00F000003333337F773777773333330FFFF0FF0
        33333337F3FF7F37F3333330F08F0F0B33333337F7737F77FF333330FFFF003B
        B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
        3BB33773333773333773B333333B3333333B7333333733333337}
      NumGlyphs = 2
      OnClick = cmdAddClick
    end
    object cmdDelete: TSpeedButton
      Left = 343
      Top = 2
      Width = 25
      Height = 25
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333000000000
        3333333777777777F3333330F777777033333337F3F3F3F7F3333330F0808070
        33333337F7F7F7F7F3333330F080707033333337F7F7F7F7F3333330F0808070
        33333337F7F7F7F7F3333330F080707033333337F7F7F7F7F3333330F0808070
        333333F7F7F7F7F7F3F33030F080707030333737F7F7F7F7F7333300F0808070
        03333377F7F7F7F773333330F080707033333337F7F7F7F7F333333070707070
        33333337F7F7F7F7FF3333000000000003333377777777777F33330F88877777
        0333337FFFFFFFFF7F3333000000000003333377777777777333333330777033
        3333333337FFF7F3333333333000003333333333377777333333}
      NumGlyphs = 2
      OnClick = cmdDeleteClick
    end
  end
  object pnl1: TPanel
    Left = 0
    Top = 29
    Width = 629
    Height = 265
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object lbl1: TLabel
      Left = 253
      Top = 6
      Width = 60
      Height = 16
      Caption = 'Ad Name:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 268
      Top = 30
      Width = 45
      Height = 16
      Caption = 'Ad File:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lbl3: TLabel
      Left = 239
      Top = 54
      Width = 74
      Height = 16
      Caption = 'Ad Redirect:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lbl4: TLabel
      Left = 217
      Top = 78
      Width = 96
      Height = 16
      Caption = 'Ad Impressions:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lbl5: TLabel
      Left = 250
      Top = 126
      Width = 63
      Height = 16
      Caption = 'Ad Codes:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lbl6: TLabel
      Left = 247
      Top = 150
      Width = 66
      Height = 16
      Caption = 'Ad Search:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lbl7: TLabel
      Left = 265
      Top = 102
      Width = 49
      Height = 16
      Caption = 'Ad Text:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lst1: TListBox
      Left = 0
      Top = 0
      Width = 214
      Height = 265
      Align = alLeft
      ItemHeight = 13
      TabOrder = 0
      OnClick = lst1Click
    end
    object edtAd: TEdit
      Left = 317
      Top = 3
      Width = 308
      Height = 21
      TabOrder = 1
      OnChange = edtAdChange
    end
    object edtFileName: TEdit
      Left = 316
      Top = 27
      Width = 308
      Height = 21
      TabOrder = 2
      OnChange = edtFileNameChange
    end
    object edtRedirect: TEdit
      Left = 316
      Top = 51
      Width = 308
      Height = 21
      TabOrder = 3
      OnChange = edtRedirectChange
    end
    object edtImpress: TEdit
      Left = 316
      Top = 75
      Width = 61
      Height = 21
      TabOrder = 4
      OnChange = edtImpressChange
    end
    object edtOverride: TEdit
      Left = 316
      Top = 123
      Width = 309
      Height = 21
      TabOrder = 6
      OnChange = edtOverrideChange
    end
    object rad1: TRadioGroup
      Left = 316
      Top = 168
      Width = 168
      Height = 31
      Columns = 2
      Items.Strings = (
        'Small ad'
        'Large ad')
      TabOrder = 8
      OnClick = rad1Click
    end
    object rad2: TRadioGroup
      Left = 315
      Top = 199
      Width = 169
      Height = 31
      Columns = 2
      Items.Strings = (
        'Top'
        'Bottom')
      TabOrder = 9
      OnClick = rad2Click
    end
    object edtSearch: TEdit
      Left = 316
      Top = 147
      Width = 309
      Height = 21
      TabOrder = 7
      OnChange = edtSearchChange
    end
    object edtText: TEdit
      Left = 316
      Top = 99
      Width = 309
      Height = 21
      TabOrder = 5
      OnChange = edtTextChange
    end
    object rad3: TRadioGroup
      Left = 315
      Top = 231
      Width = 169
      Height = 31
      Columns = 2
      Items.Strings = (
        'Text Only'
        'Text and Ad')
      TabOrder = 10
      OnClick = rad3Click
    end
  end
end
