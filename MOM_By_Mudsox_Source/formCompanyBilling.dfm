object frmCompanyBilling: TfrmCompanyBilling
  Left = 261
  Top = 189
  Width = 640
  Height = 480
  Caption = 'Company Billing for Interpreters'
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
  object tblMain: TToolBar
    Left = 0
    Top = 0
    Width = 632
    Height = 30
    ButtonHeight = 25
    Caption = 'tblMain'
    TabOrder = 0
    object cmdNewRecord: TSpeedButton
      Left = 0
      Top = 2
      Width = 25
      Height = 25
      Hint = 'New invoice'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
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
      ParentShowHint = False
      ShowHint = True
      OnClick = cmdNewRecordClick
    end
    object cmdDeleteAppointment: TSpeedButton
      Left = 25
      Top = 2
      Width = 25
      Height = 25
      Hint = 'Delete invoice'
      Constraints.MaxWidth = 25
      Constraints.MinWidth = 25
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
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
      ParentShowHint = False
      ShowHint = True
      OnClick = cmdDeleteAppointmentClick
    end
    object spl1: TSplitter
      Left = 50
      Top = 2
      Width = 455
      Height = 25
      Cursor = crHSplit
      Constraints.MaxWidth = 455
      Constraints.MinWidth = 455
      MinSize = 111
    end
    object cmdPrintAppt: TSpeedButton
      Left = 505
      Top = 2
      Width = 25
      Height = 25
      Hint = 'Print this bill'
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
    object cmdSummary: TSpeedButton
      Left = 530
      Top = 2
      Width = 25
      Height = 25
      Hint = 'Print the summary report'
      Constraints.MaxWidth = 25
      Constraints.MinWidth = 25
      Enabled = False
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
      OnClick = cmdSummaryClick
    end
    object cmd30_60_90: TSpeedButton
      Left = 555
      Top = 2
      Width = 25
      Height = 25
      Hint = 'Print the unpaid 30-60-90 report'
      Constraints.MaxWidth = 25
      Constraints.MinWidth = 25
      Enabled = False
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
      OnClick = cmd30_60_90Click
    end
    object cmdCompanyUnpaid: TSpeedButton
      Left = 580
      Top = 2
      Width = 25
      Height = 25
      Hint = 'Print a company unpaid report'
      Constraints.MaxWidth = 25
      Constraints.MinWidth = 25
      Enabled = False
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
      OnClick = cmdCompanyUnpaidClick
    end
    object cmdexit: TSpeedButton
      Left = 605
      Top = 2
      Width = 25
      Height = 25
      Hint = 'Exit'
      Constraints.MaxWidth = 25
      Constraints.MinWidth = 25
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
  object pnlMain: TPanel
    Left = 0
    Top = 30
    Width = 632
    Height = 416
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object pnlLeft: TPanel
      Left = 0
      Top = 0
      Width = 177
      Height = 416
      Align = alLeft
      TabOrder = 0
      object radSearch: TRadioGroup
        Left = 1
        Top = 1
        Width = 175
        Height = 65
        Align = alTop
        Caption = 'Show this type of Invoice'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'Not Billed'
          'Billed (not Paid)'
          'Paid')
        ParentFont = False
        TabOrder = 0
        OnClick = radSearchClick
      end
      object grdInvoices: TDBGrid
        Left = 1
        Top = 66
        Width = 175
        Height = 349
        Align = alClient
        DataSource = dtsInvoices
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'EntityDescription'
            Width = 141
            Visible = True
          end>
      end
    end
    object pnlDetail: TPanel
      Left = 177
      Top = 0
      Width = 455
      Height = 416
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object pnlInvTop: TPanel
        Left = 0
        Top = 0
        Width = 455
        Height = 77
        Align = alTop
        TabOrder = 1
        object lbl_0001: TLabel
          Left = 24
          Top = 32
          Width = 61
          Height = 16
          Caption = 'Company:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lbl_0002: TLabel
          Left = 53
          Top = 55
          Width = 32
          Height = 16
          Caption = 'Date:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lbl_0005: TLabel
          Left = 39
          Top = 8
          Width = 46
          Height = 16
          Caption = 'Invoice:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lbl_20010: TLabel
          Left = 148
          Top = 8
          Width = 48
          Height = 16
          Caption = 'Amount:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lbl_20011: TLabel
          Left = 345
          Top = 8
          Width = 53
          Height = 16
          Caption = 'Balance:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lbl_20012: TLabel
          Left = 256
          Top = 8
          Width = 31
          Height = 16
          Caption = 'Paid:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object edtInvDate: TDBEdit
          Left = 88
          Top = 53
          Width = 73
          Height = 21
          DataField = 'BillDate'
          DataSource = dtsCompanyBill
          TabOrder = 5
        end
        object chkBilled: TDBCheckBox
          Left = 168
          Top = 53
          Width = 57
          Height = 17
          Caption = 'Billed'
          DataField = 'BillSent'
          DataSource = dtsCompanyBill
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object chkPaid: TDBCheckBox
          Left = 224
          Top = 53
          Width = 57
          Height = 17
          Caption = 'Paid'
          DataField = 'BillPaid'
          DataSource = dtsCompanyBill
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object cboCompany: TComboBox
          Left = 88
          Top = 29
          Width = 366
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          Sorted = True
          TabOrder = 4
          OnClick = cboCompanyClick
        end
        object edtInvoice: TDBEdit
          Left = 88
          Top = 5
          Width = 57
          Height = 21
          DataField = 'InvoiceNumber'
          DataSource = dtsCompanyBill
          ReadOnly = True
          TabOrder = 0
        end
        object edtAmount: TDBEdit
          Left = 197
          Top = 5
          Width = 55
          Height = 21
          DataField = 'BillTotalAmount'
          DataSource = dtsCompanyBill
          ReadOnly = True
          TabOrder = 1
        end
        object edtPaid: TDBEdit
          Left = 288
          Top = 5
          Width = 55
          Height = 21
          DataField = 'BillTotalPayment'
          DataSource = dtsCompanyBill
          TabOrder = 2
        end
        object edtBalance: TDBEdit
          Left = 399
          Top = 5
          Width = 55
          Height = 21
          DataField = 'BillTotalBalance'
          DataSource = dtsCompanyBill
          ReadOnly = True
          TabOrder = 3
        end
        object pnlDates: TPanel
          Left = 201
          Top = 25
          Width = 216
          Height = 75
          BevelOuter = bvNone
          TabOrder = 8
          Visible = False
          object cmdSummaryPreview: TSpeedButton
            Left = 157
            Top = 34
            Width = 25
            Height = 25
            Hint = 'Print the summary report'
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
            OnClick = cmdSummaryPreviewClick
          end
          object lbl_20002: TLabel
            Left = 14
            Top = 26
            Width = 64
            Height = 16
            Caption = 'From date:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object lbl_20003: TLabel
            Left = 28
            Top = 50
            Width = 50
            Height = 16
            Caption = 'To date:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object cmdNoReport: TSpeedButton
            Left = 182
            Top = 34
            Width = 25
            Height = 25
            Hint = 'Exit'
            Constraints.MaxWidth = 25
            Constraints.MinWidth = 25
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
            OnClick = cmdNoReportClick
          end
          object lbl_20001: TLabel
            Left = 8
            Top = 5
            Width = 204
            Height = 16
            Caption = 'Select the date range for the report'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object edtFromDate: TEdit
            Left = 80
            Top = 24
            Width = 73
            Height = 21
            TabOrder = 0
          end
          object edtToDate: TEdit
            Left = 80
            Top = 48
            Width = 73
            Height = 21
            TabOrder = 1
          end
        end
        object pnl30_60_90: TPanel
          Left = 9
          Top = 10
          Width = 216
          Height = 75
          BevelOuter = bvNone
          TabOrder = 9
          Visible = False
          object cmdPrint_30_60_90: TSpeedButton
            Left = 157
            Top = 34
            Width = 25
            Height = 25
            Hint = 'Print the 30, 60, 90 day report'
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
            OnClick = cmdPrint_30_60_90Click
          end
          object SpeedButton2: TSpeedButton
            Left = 182
            Top = 34
            Width = 25
            Height = 25
            Hint = 'Exit'
            Constraints.MaxWidth = 25
            Constraints.MinWidth = 25
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
            OnClick = SpeedButton2Click
          end
          object lbl1001: TLabel
            Left = 8
            Top = 5
            Width = 214
            Height = 16
            Caption = 'Select the Overdue Payment Report'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object radDays: TRadioGroup
            Left = 8
            Top = 28
            Width = 138
            Height = 33
            Caption = 'Days'
            Columns = 3
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemIndex = 0
            Items.Strings = (
              '30'
              '60'
              '90')
            ParentFont = False
            TabOrder = 0
          end
        end
      end
      object pnlFields: TPanel
        Left = 0
        Top = 217
        Width = 455
        Height = 199
        Align = alBottom
        TabOrder = 0
        object lbl_1001: TLabel
          Left = 19
          Top = 5
          Width = 66
          Height = 16
          Caption = 'Appt. Date:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lbl_1002: TLabel
          Left = 41
          Top = 29
          Width = 44
          Height = 16
          Caption = 'Patient:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lbl_1003: TLabel
          Left = 10
          Top = 53
          Width = 75
          Height = 16
          Caption = 'Patient line2:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lbl_1004: TLabel
          Left = 22
          Top = 77
          Width = 63
          Height = 16
          Caption = 'Interpreter:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lbl_1005: TLabel
          Left = 180
          Top = 5
          Width = 57
          Height = 16
          Caption = 'Bill hours:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lbl_1006: TLabel
          Left = 24
          Top = 101
          Width = 61
          Height = 16
          Caption = 'Physician:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object cmdNewDetail: TSpeedButton
          Left = 403
          Top = 2
          Width = 25
          Height = 25
          Hint = 'New detail line'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            0400000000000001000000000000000000001000000010000000000000000000
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
          ParentShowHint = False
          ShowHint = True
          OnClick = cmdNewDetailClick
        end
        object cmdDeleteDetail: TSpeedButton
          Left = 428
          Top = 2
          Width = 25
          Height = 25
          Hint = 'Delete detail line'
          Constraints.MaxWidth = 25
          Constraints.MinWidth = 25
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            0400000000000001000000000000000000001000000010000000000000000000
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
          ParentShowHint = False
          ShowHint = True
          OnClick = cmdDeleteDetailClick
        end
        object lbl_10010: TLabel
          Left = 2
          Top = 125
          Width = 83
          Height = 16
          Caption = 'OR Comment:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object cboInterpreter: TComboBox
          Left = 88
          Top = 75
          Width = 300
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          Sorted = True
          TabOrder = 4
          OnClick = cboInterpreterClick
        end
        object cboPhysician: TComboBox
          Left = 88
          Top = 99
          Width = 300
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          Sorted = True
          TabOrder = 5
          OnClick = cboPhysicianClick
        end
        object edtDate: TDBEdit
          Left = 88
          Top = 3
          Width = 81
          Height = 21
          DataField = 'BillApptDate'
          DataSource = dtsCompanyBillDetail
          TabOrder = 0
        end
        object edtPatient: TDBEdit
          Left = 88
          Top = 27
          Width = 300
          Height = 21
          DataField = 'BillPatient'
          DataSource = dtsCompanyBillDetail
          TabOrder = 2
        end
        object edtPatientComment: TDBEdit
          Left = 88
          Top = 51
          Width = 300
          Height = 21
          DataField = 'BillPatientComment'
          DataSource = dtsCompanyBillDetail
          TabOrder = 3
        end
        object edtTime: TDBEdit
          Left = 240
          Top = 3
          Width = 57
          Height = 21
          DataField = 'BillHours'
          DataSource = dtsCompanyBillDetail
          TabOrder = 1
        end
        object memComments: TDBMemo
          Left = 88
          Top = 123
          Width = 300
          Height = 74
          DataField = 'BillDetailComment'
          DataSource = dtsCompanyBillDetail
          TabOrder = 6
        end
      end
      object grddetails: TDBGrid
        Left = 0
        Top = 77
        Width = 455
        Height = 140
        Align = alClient
        DataSource = dtsCompanyBillDetail
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'BillApptDate'
            Title.Caption = 'Appt Date'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BillPatient'
            Title.Caption = 'Patient'
            Width = 368
            Visible = True
          end>
      end
    end
  end
  object qryInvoices: TQuery
    ParamCheck = False
    SQL.Strings = (
      'Select Entity.EntityDescription, CompanyBill.InvoiceNumber '
      'from CompanyBill left join entity'
      'on CompanyBill.Entity = Entity.Entity'
      'where'
      'BillSent = False'
      'order by Entity.EntityDescription, CompanyBill.InvoiceNumber')
    Left = 8
    Top = 136
  end
  object dtsInvoices: TDataSource
    DataSet = qryInvoices
    OnDataChange = dtsInvoicesDataChange
    Left = 40
    Top = 136
  end
  object qryCompanyBill: TQuery
    BeforePost = qryCompanyBillBeforePost
    DataSource = dtsInvoices
    RequestLive = True
    SQL.Strings = (
      'Select * '
      'from CompanyBill'
      'where'
      'InvoiceNumber = :InvoiceNumber')
    Left = 592
    Top = 152
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'InvoiceNumber'
        ParamType = ptUnknown
      end>
  end
  object dtsCompanyBill: TDataSource
    DataSet = qryCompanyBill
    Left = 600
    Top = 64
  end
  object qryCompanyBillDetail: TQuery
    DataSource = dtsCompanyBill
    RequestLive = True
    SQL.Strings = (
      'Select * '
      'from CompanyBillDetail'
      'where'
      'InvoiceNumber = :InvoiceNumber')
    Left = 569
    Top = 288
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'InvoiceNumber'
        ParamType = ptUnknown
      end>
  end
  object dtsCompanyBillDetail: TDataSource
    DataSet = qryCompanyBillDetail
    OnDataChange = dtsCompanyBillDetailDataChange
    Left = 601
    Top = 288
  end
  object qrySummaryReport: TQuery
    DataSource = dtsInvoices
    SQL.Strings = (
      'Select CompanyBill.InvoiceNumber,'
      '           CompanyBill.BillDate,'
      '           CompanyBill.BillTotalAmount,'
      '           CompanyBill.BillTotalBalance,'
      '           CompanyBill.BillTotalPayment, CompanyBill.BillPaid,'
      '           Entity.EntityDescription,'
      '           Insurance.Department '
      'from CompanyBill, Entity, Insurance'
      'where'
      '  CompanyBill.Entity = Entity.Entity'
      '  and CompanyBill.Entity = Insurance.Entity'
      '  and CompanyBill.BillSent = true'
      '  and CompanyBill.BillDate >= '
      '  and CompanyBill.BillDate <='
      ''
      'Order By'
      '  EntityDescription, Department, InvoiceNumber')
    Left = 592
    Top = 184
  end
  object Table1: TTable
    Left = 592
    Top = 352
  end
end
