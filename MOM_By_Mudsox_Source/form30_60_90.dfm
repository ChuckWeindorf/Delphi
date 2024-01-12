object frm30_60_90: Tfrm30_60_90
  Left = 511
  Top = 139
  Width = 495
  Height = 109
  Caption = '30 - 60 - 90 Day Accounting Report'
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
  object cmdPrint: TSpeedButton
    Left = 160
    Top = 32
    Width = 23
    Height = 22
    Hint = 'Print the 30, 60, or 90+ day report'
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
    OnClick = cmdPrintClick
  end
  object lbl1: TLabel
    Left = 8
    Top = 8
    Width = 451
    Height = 16
    Caption = 
      'Select the 30, 60 or 90+ day report for all patients with an out' +
      'standing balance'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object cbo30_60_90: TComboBox
    Left = 8
    Top = 32
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    Items.Strings = (
      '30 Days Overdue'
      '60 Days Overdue'
      '90 Days Overdue')
  end
  object tblAppointment: TTable
    DatabaseName = 'mmom_maindatabase'
    TableName = 'Appointment'
    Left = 416
    Top = 24
  end
  object tblAcctSummary: TTable
    DatabaseName = 'mmom_maindatabase'
    TableName = 'AcctSummary'
    Left = 448
    Top = 24
  end
  object tblEntity: TTable
    DatabaseName = 'mmom_maindatabase'
    TableName = 'Entity'
    Left = 384
    Top = 24
  end
  object tblApptBilling: TTable
    DatabaseName = 'mmom_maindatabase'
    TableName = 'ApptBilling'
    Left = 352
    Top = 24
  end
end
