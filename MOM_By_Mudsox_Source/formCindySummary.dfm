object frmCindySummary: TfrmCindySummary
  Left = 474
  Top = 177
  Width = 434
  Height = 526
  Caption = 'Patients with open balances'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 426
    Height = 31
    ButtonHeight = 25
    Caption = 'ToolBar1'
    TabOrder = 0
    object Splitter2: TSplitter
      Left = 0
      Top = 2
      Width = 200
      Height = 25
      Cursor = crHSplit
      Constraints.MaxWidth = 200
      Constraints.MinWidth = 200
      MinSize = 78
    end
    object cmdAccounting: TSpeedButton
      Left = 200
      Top = 2
      Width = 25
      Height = 25
      Hint = 'Accounting manager'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00337000000000
        73333337777777773F333308888888880333337F3F3F3FFF7F33330808089998
        0333337F737377737F333308888888880333337F3F3F3F3F7F33330808080808
        0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808
        0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808
        0333337F737373737F333308888888880333337F3FFFFFFF7F33330800000008
        0333337F7777777F7F333308000E0E080333337F7FFFFF7F7F33330800000008
        0333337F777777737F333308888888880333337F333333337F33330888888888
        03333373FFFFFFFF733333700000000073333337777777773333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = cmdAccountingClick
    end
    object cmdPatient: TSpeedButton
      Left = 225
      Top = 2
      Width = 25
      Height = 25
      Hint = 'View Patient'
      Constraints.MaxWidth = 25
      Constraints.MinWidth = 25
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033BBBBBBBBBB
        BB33337777777777777F33BB00BBBBBBBB33337F77333333F37F33BB0BBBBBB0
        BB33337F73F33337FF7F33BBB0BBBB000B33337F37FF3377737F33BBB00BB00B
        BB33337F377F3773337F33BBBB0B00BBBB33337F337F7733337F33BBBB000BBB
        BB33337F33777F33337F33EEEE000EEEEE33337F3F777FFF337F33EE0E80000E
        EE33337F73F77773337F33EEE0800EEEEE33337F37377F33337F33EEEE000EEE
        EE33337F33777F33337F33EEEEE00EEEEE33337F33377FF3337F33EEEEEE00EE
        EE33337F333377F3337F33EEEEEE00EEEE33337F33337733337F33EEEEEEEEEE
        EE33337FFFFFFFFFFF7F33EEEEEEEEEEEE333377777777777773}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = cmdPatientClick
    end
    object Splitter1: TSplitter
      Left = 250
      Top = 2
      Width = 125
      Height = 25
      Cursor = crHSplit
      Constraints.MaxWidth = 125
      Constraints.MinWidth = 125
      MinSize = 78
    end
    object cmdPrintAppt: TSpeedButton
      Left = 375
      Top = 2
      Width = 25
      Height = 25
      Hint = 'Print Appointment Summary'
      Constraints.MaxWidth = 25
      Constraints.MinWidth = 25
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
        8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
        8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
        8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = cmdPrintApptClick
    end
    object cmdexit: TSpeedButton
      Left = 400
      Top = 2
      Width = 25
      Height = 25
      Hint = 'Exit'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
        03333377777777777F333301111111110333337F333333337F33330111111111
        0333337F333333337F333301111111110333337F333333337F33330111111111
        0333337F333333337F333301111111110333337F333333337F33330111111111
        0333337F3333333F7F333301111111B10333337F333333737F33330111111111
        0333337F333333337F333301111111110333337F33FFFFF37F3333011EEEEE11
        0333337F377777F37F3333011EEEEE110333337F37FFF7F37F3333011EEEEE11
        0333337F377777337F333301111111110333337F333333337F33330111111111
        0333337FFFFFFFFF7F3333000000000003333377777777777333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = cmdexitClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 31
    Width = 426
    Height = 461
    Align = alClient
    TabOrder = 1
    object grdAnswers: TDBGrid
      Left = 1
      Top = 1
      Width = 424
      Height = 459
      Align = alClient
      DataSource = dtsOpenBills
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = cmdPatientClick
    end
  end
  object qryOpenBills: TQuery
    DatabaseName = 'mmom_maindatabase'
    SQL.Strings = (
      'Select Entity, EntityDescription, Patientbalance'
      'from Entity, Patient'
      'where'
      'Entity.Entity = Patient.Entity'
      'and PatientBalance > 0'
      'order by Entity')
    Left = 376
    Top = 112
    object qryOpenBillsEntity: TIntegerField
      FieldName = 'Entity'
      Origin = 'MMOM_MAINDATABASE."Entity.DB".Entity'
    end
    object qryOpenBillsEntityDescription: TStringField
      DisplayWidth = 40
      FieldName = 'EntityDescription'
      Origin = 'MMOM_MAINDATABASE."Entity.DB".EntityDescription'
      Size = 50
    end
    object qryOpenBillsPatientbalance: TCurrencyField
      FieldName = 'Patientbalance'
      Origin = 'MMOM_MAINDATABASE."Patient.DB".PatientBalance'
    end
  end
  object dtsOpenBills: TDataSource
    AutoEdit = False
    DataSet = qryOpenBills
    Left = 376
    Top = 143
  end
end
