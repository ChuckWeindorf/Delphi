object frmImport: TfrmImport
  Left = 318
  Top = 277
  Width = 556
  Height = 254
  BorderIcons = []
  Caption = 'Add comments to imported file'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblOld: TLabel
    Left = 4
    Top = 31
    Width = 136
    Height = 13
    Caption = 'File name from your recorder:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblNew: TLabel
    Left = 64
    Top = 7
    Width = 75
    Height = 13
    Caption = 'New File Name:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lbl1: TLabel
    Left = 0
    Top = 57
    Width = 100
    Height = 13
    Caption = 'Add Comments Here:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object cmdOK: TSpeedButton
    Left = 0
    Top = 0
    Width = 26
    Height = 26
    Hint = 'Save the comment and continue'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      0400000000000001000000000000000000001000000010000000000000000000
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
    ParentShowHint = False
    ShowHint = True
    OnClick = cmdOKClick
  end
  object lblPhysician: TLabel
    Left = 55
    Top = 7
    Width = 85
    Height = 13
    Caption = 'Which Physician?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object memComments: TMemo
    Left = 0
    Top = 77
    Width = 540
    Height = 139
    Align = alBottom
    TabOrder = 4
  end
  object edtNew: TEdit
    Left = 144
    Top = 4
    Width = 393
    Height = 21
    ReadOnly = True
    TabOrder = 1
  end
  object edtOld: TEdit
    Left = 144
    Top = 28
    Width = 393
    Height = 21
    ReadOnly = True
    TabOrder = 2
  end
  object cmdPriority: TButton
    Left = 144
    Top = 52
    Width = 113
    Height = 19
    Caption = 'Make this a Priority'
    TabOrder = 3
    OnClick = cmdPriorityClick
  end
  object cboPhysician: TComboBox
    Left = 144
    Top = 4
    Width = 393
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    Visible = False
  end
end
