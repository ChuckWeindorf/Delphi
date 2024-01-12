object frmPatientHistory: TfrmPatientHistory
  Left = 321
  Top = 149
  Width = 423
  Height = 359
  Caption = 'Patient History'
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
  object tbrPatient: TToolBar
    Left = 0
    Top = 0
    Width = 415
    Height = 31
    ButtonHeight = 25
    EdgeBorders = [ebLeft, ebTop, ebRight, ebBottom]
    TabOrder = 0
    object spl1: TSplitter
      Left = 0
      Top = 2
      Width = 310
      Height = 25
      Cursor = crHSplit
      Constraints.MaxWidth = 310
      Constraints.MinWidth = 310
    end
    object btnPrev: TSpeedButton
      Left = 310
      Top = 2
      Width = 25
      Height = 25
      Hint = 'Preview Patient'
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
      OnClick = btnPrevClick
    end
    object cmdexit: TSpeedButton
      Left = 335
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
    object cmdVideo: TSpeedButton
      Left = 360
      Top = 2
      Width = 25
      Height = 25
      Hint = 'Video help'
      Enabled = False
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
        033333FFFF77777773F330000077777770333777773FFFFFF733077777000000
        03337F3F3F777777733F0797A770003333007F737337773F3377077777778803
        30807F333333337FF73707888887880007707F3FFFF333777F37070000878807
        07807F777733337F7F3707888887880808807F333333337F7F37077777778800
        08807F333FFF337773F7088800088803308073FF777FFF733737300008000033
        33003777737777333377333080333333333333F7373333333333300803333333
        33333773733333333333088033333333333373F7F33333333333308033333333
        3333373733333333333333033333333333333373333333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
    end
    object cmdHelp: TSpeedButton
      Left = 385
      Top = 2
      Width = 25
      Height = 25
      Hint = 'Online help'
      Enabled = False
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333CCCCC33
        33333FFFF77777FFFFFFCCCCCC808CCCCCC3777777F7F777777F008888070888
        8003777777777777777F0F0770F7F0770F0373F33337F333337370FFFFF7FFFF
        F07337F33337F33337F370FFFB99FBFFF07337F33377F33337F330FFBF99BFBF
        F033373F337733333733370BFBF7FBFB0733337F333FF3337F33370FBF98BFBF
        0733337F3377FF337F333B0BFB990BFB03333373FF777FFF73333FB000B99000
        B33333377737777733333BFBFBFB99FBF33333333FF377F333333FBF99BF99BF
        B333333377F377F3333333FB99FB99FB3333333377FF77333333333FB9999FB3
        333333333777733333333333FBFBFB3333333333333333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
    end
  end
  object pnlTopGroup: TPanel
    Left = 0
    Top = 31
    Width = 415
    Height = 301
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object pnlPatientExtraInfo: TPanel
      Left = 0
      Top = 0
      Width = 415
      Height = 301
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      object pagPatientExtraInfo: TPageControl
        Left = 2
        Top = 2
        Width = 411
        Height = 297
        ActivePage = tabAppointments
        Align = alClient
        TabOrder = 0
        object tabAppointments: TTabSheet
          Caption = 'Appt.'
          object grdAppointment: TDBGrid
            Tag = 25
            Left = 0
            Top = 0
            Width = 403
            Height = 269
            Align = alClient
            Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'ApptDateTime'
                Title.Caption = 'Date'
                Width = 63
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ApptComplaint'
                Title.Caption = 'Complaint'
                Width = 294
                Visible = True
              end>
          end
        end
        object tabLab: TTabSheet
          Caption = 'Lab'
          object grdLab: TDBGrid
            Tag = 30
            Left = 0
            Top = 0
            Width = 403
            Height = 268
            Align = alClient
            Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'LabDate'
                Title.Caption = 'Date'
                Width = 63
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'LabProcedure'
                Title.Caption = 'Procedure'
                Width = 294
                Visible = True
              end>
          end
        end
        object tabCronic: TTabSheet
          Caption = 'Diag'
          object grdPatientCronic: TDBGrid
            Tag = 19
            Left = 0
            Top = 0
            Width = 403
            Height = 268
            Align = alClient
            Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'PatientChronicDate'
                Title.Caption = 'Date'
                Width = 63
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PatientAffliction'
                Title.Caption = 'Chronic Affliction'
                Width = 294
                Visible = True
              end>
          end
        end
        object tabMedication: TTabSheet
          Caption = 'Med.'
          object grdPrescription: TDBGrid
            Tag = 21
            Left = 0
            Top = 0
            Width = 403
            Height = 268
            Align = alClient
            Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'PrescriptionDate'
                Title.Caption = 'Date'
                Width = 63
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Prescription'
                Width = 294
                Visible = True
              end>
          end
        end
        object tabImmunization: TTabSheet
          Caption = 'Imune'
          object grdImmunization: TDBGrid
            Tag = 20
            Left = 0
            Top = 31
            Width = 403
            Height = 237
            Align = alClient
            Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'ImmunizationDate'
                Title.Caption = 'Date'
                Width = 63
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ImmunizationType'
                Title.Caption = 'Immunization Type'
                Width = 294
                Visible = True
              end>
          end
          object ToolBar1: TToolBar
            Left = 0
            Top = 0
            Width = 403
            Height = 31
            ButtonHeight = 25
            EdgeBorders = [ebLeft, ebTop, ebRight, ebBottom]
            TabOrder = 1
            object splI1: TSplitter
              Left = 0
              Top = 2
              Width = 352
              Height = 25
              Cursor = crHSplit
            end
            object cmdImmnuePrint: TSpeedButton
              Left = 352
              Top = 2
              Width = 25
              Height = 25
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
            end
          end
        end
        object tabReferal: TTabSheet
          Caption = 'Refer'
          object grdReferrals: TDBGrid
            Tag = 34
            Left = 0
            Top = 0
            Width = 403
            Height = 269
            Align = alClient
            Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'ReferralDate'
                Title.Caption = 'Date'
                Width = 63
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ReferralPhysician'
                Title.Caption = 'Physician'
                Width = 294
                Visible = True
              end>
          end
        end
      end
    end
  end
end
