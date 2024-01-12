object frmScriptWaveTranscriptionAdmin: TfrmScriptWaveTranscriptionAdmin
  Left = 407
  Top = 199
  Width = 1020
  Height = 654
  Caption = 'ScriptWave Transcription Administrator'
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
  object pagMain: TPageControl
    Left = 0
    Top = 0
    Width = 1004
    Height = 615
    ActivePage = tabAccountStatus
    Align = alClient
    TabOrder = 0
    object tabAccountStatus: TTabSheet
      Caption = 'Account Status'
      ImageIndex = 4
      object Label5: TLabel
        Left = 295
        Top = 45
        Width = 64
        Height = 13
        Caption = 'Dictation File:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblComments: TLabel
        Left = 307
        Top = 369
        Width = 52
        Height = 13
        Caption = 'Comments:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblAssignedto: TLabel
        Left = 297
        Top = 170
        Width = 62
        Height = 13
        Caption = 'Assigned To:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblAltName: TLabel
        Left = 313
        Top = 348
        Width = 46
        Height = 13
        Caption = 'Alt Name:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblImportDate: TLabel
        Left = 300
        Top = 70
        Width = 58
        Height = 13
        Caption = 'Import Date:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblTypeDate: TLabel
        Left = 534
        Top = 70
        Width = 53
        Height = 13
        Caption = 'Type Date:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCompleteDate: TLabel
        Left = 514
        Top = 118
        Width = 73
        Height = 13
        Caption = 'Complete Date:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblReviewDate: TLabel
        Left = 522
        Top = 94
        Width = 65
        Height = 13
        Caption = 'Review Date:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblTransmitDate: TLabel
        Left = 290
        Top = 94
        Width = 69
        Height = 13
        Caption = 'Transmit Date:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblReceiveDate: TLabel
        Left = 290
        Top = 118
        Width = 69
        Height = 13
        Caption = 'Receive Date:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblAssignDate: TLabel
        Left = 299
        Top = 141
        Width = 60
        Height = 13
        Caption = 'Assign Date:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label21: TLabel
        Left = 752
        Top = 466
        Width = 81
        Height = 13
        Caption = 'Recent Problems'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object pnlStatus: TPanel
        Left = 0
        Top = 0
        Width = 289
        Height = 475
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        object treAll: TTreeView
          Left = 0
          Top = 0
          Width = 289
          Height = 475
          Align = alClient
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Indent = 19
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnClick = treAllClick
          Items.Data = {
            07000000210000000000000000000000FFFFFFFFFFFFFFFF0000000000000000
            08496D706F72746564240000000000000000000000FFFFFFFFFFFFFFFF000000
            00000000000B5472616E736D6974746564210000000000000000000000FFFFFF
            FFFFFFFFFF000000000000000008526563656976656421000000000000000000
            0000FFFFFFFFFFFFFFFF00000000000000000841737369676E65641E00000000
            00000000000000FFFFFFFFFFFFFFFF0000000000000000055479706564210000
            000000000000000000FFFFFFFFFFFFFFFF000000000000000008526576696577
            6564220000000000000000000000FFFFFFFFFFFFFFFF00000000000000000943
            6F6D706C65746564}
        end
      end
      object edtDictationName: TEdit
        Left = 366
        Top = 41
        Width = 361
        Height = 21
        ReadOnly = True
        TabOrder = 1
      end
      object memFileComments: TMemo
        Left = 366
        Top = 370
        Width = 358
        Height = 107
        ReadOnly = True
        TabOrder = 2
      end
      object grdTranscribedFiles: TStringGrid
        Left = 366
        Top = 215
        Width = 358
        Height = 129
        ColCount = 1
        DefaultColWidth = 353
        DefaultRowHeight = 16
        FixedCols = 0
        RowCount = 2
        ScrollBars = ssVertical
        TabOrder = 3
        OnClick = grdTranscribedFilesClick
      end
      object cboTypists: TComboBox
        Left = 366
        Top = 167
        Width = 360
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 4
        Items.Strings = (
          'T001'
          'T002'
          'T003'
          'T004'
          'T005'
          'T006'
          'T007'
          'T008'
          'T009'
          'T010'
          'T011'
          'T012'
          'T013'
          'T014'
          'T015'
          'T016'
          'T017'
          'T018'
          'T019'
          'T020')
      end
      object edtAltName: TEdit
        Left = 366
        Top = 346
        Width = 361
        Height = 21
        ReadOnly = True
        TabOrder = 5
      end
      object edtImportDate: TEdit
        Left = 366
        Top = 67
        Width = 132
        Height = 21
        ReadOnly = True
        TabOrder = 6
      end
      object edtTypedDate: TEdit
        Left = 593
        Top = 67
        Width = 132
        Height = 21
        ReadOnly = True
        TabOrder = 7
      end
      object edtReviewDate: TEdit
        Left = 593
        Top = 91
        Width = 132
        Height = 21
        ReadOnly = True
        TabOrder = 8
      end
      object edtCompleteDate: TEdit
        Left = 593
        Top = 115
        Width = 132
        Height = 21
        ReadOnly = True
        TabOrder = 9
      end
      object edtAssignDate: TEdit
        Left = 366
        Top = 139
        Width = 132
        Height = 21
        ReadOnly = True
        TabOrder = 10
      end
      object edtReceiveDate: TEdit
        Left = 366
        Top = 115
        Width = 132
        Height = 21
        ReadOnly = True
        TabOrder = 11
      end
      object edtTransmitDate: TEdit
        Left = 366
        Top = 91
        Width = 132
        Height = 21
        ReadOnly = True
        TabOrder = 12
      end
      object pnlAccount: TPanel
        Left = 294
        Top = 0
        Width = 433
        Height = 38
        Color = clHighlight
        TabOrder = 13
        object Label6: TLabel
          Left = 8
          Top = 8
          Width = 130
          Height = 22
          Caption = 'View full account'
          Color = clHighlight
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -16
          Font.Name = 'Palatino Linotype'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
        object cboAcctList: TComboBox
          Left = 152
          Top = 8
          Width = 265
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnChange = cboAcctListChange
        end
      end
      object pnlProblem: TPanel
        Left = 728
        Top = 0
        Width = 276
        Height = 465
        TabOrder = 15
        object DBText1: TDBText
          Left = 59
          Top = 21
          Width = 65
          Height = 17
          DataField = 'ProblemNumber'
          DataSource = dtsProblems
        end
        object DBText2: TDBText
          Left = 182
          Top = 21
          Width = 65
          Height = 17
          DataField = 'ProblemDate'
          DataSource = dtsProblems
        end
        object Label15: TLabel
          Left = 6
          Top = 21
          Width = 51
          Height = 13
          Caption = 'Problem #:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label16: TLabel
          Left = 150
          Top = 21
          Width = 26
          Height = 13
          Caption = 'Date:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label17: TLabel
          Left = 6
          Top = 37
          Width = 40
          Height = 13
          Caption = 'Account'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label18: TLabel
          Left = 6
          Top = 85
          Width = 22
          Height = 13
          Caption = 'User'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label19: TLabel
          Left = 6
          Top = 128
          Width = 42
          Height = 13
          Caption = 'Category'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label20: TLabel
          Left = 6
          Top = 216
          Width = 53
          Height = 13
          Caption = 'Description'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label22: TLabel
          Left = 6
          Top = 176
          Width = 70
          Height = 13
          Caption = 'Relating to File'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblRelatedFile: TDBText
          Left = 8
          Top = 192
          Width = 53
          Height = 13
          AutoSize = True
          DataField = 'RelatedFile'
          DataSource = dtsProblems
        end
        object memDescription: TDBRichEdit
          Left = 1
          Top = 232
          Width = 274
          Height = 232
          Align = alBottom
          DataField = 'Description'
          DataSource = dtsProblems
          TabOrder = 0
        end
        object cboProbAccount: TDBComboBox
          Left = 6
          Top = 56
          Width = 265
          Height = 21
          Style = csDropDownList
          DataField = 'Account'
          DataSource = dtsProblems
          ItemHeight = 13
          Sorted = True
          TabOrder = 1
          OnChange = cboProbAccountChange
        end
        object cboUser: TDBComboBox
          Left = 6
          Top = 101
          Width = 265
          Height = 21
          Style = csDropDownList
          DataField = 'User'
          DataSource = dtsProblems
          ItemHeight = 13
          Sorted = True
          TabOrder = 2
          OnChange = cboUserChange
        end
        object cboCategories: TDBComboBox
          Left = 6
          Top = 144
          Width = 265
          Height = 21
          Style = csDropDownList
          DataField = 'Category'
          DataSource = dtsProblems
          ItemHeight = 13
          Sorted = True
          TabOrder = 3
          OnChange = cboCategoriesChange
        end
        object cmdNewProblem: TButton
          Left = 104
          Top = 2
          Width = 75
          Height = 15
          Caption = 'New Problem'
          TabOrder = 4
          OnClick = cmdNewProblemClick
        end
        object btnAttach: TButton
          Left = 153
          Top = 174
          Width = 107
          Height = 15
          Caption = 'Note current file'
          TabOrder = 5
          OnClick = btnAttachClick
        end
      end
      object btnMoreInfo: TButton
        Left = 454
        Top = 190
        Width = 157
        Height = 25
        Caption = 'Get more information on this file'
        TabOrder = 16
        OnClick = btnMoreInfoClick
      end
      object pnlWait: TPanel
        Left = 29
        Top = 160
        Width = 241
        Height = 177
        Caption = 'Please Wait - Communicating'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
        Visible = False
      end
      object grdRecent: TDBGrid
        Left = 0
        Top = 475
        Width = 996
        Height = 112
        Align = alBottom
        DataSource = dtsProblems
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 17
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnCellClick = grdRecentCellClick
        Columns = <
          item
            Expanded = False
            FieldName = 'ProblemNumber'
            Width = 42
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ProblemDate'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Account'
            Width = 163
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'User'
            Width = 164
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Category'
            Width = 197
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'RelatedFile'
            Width = 335
            Visible = True
          end>
      end
      object cmdDeleteProblem: TButton
        Left = 896
        Top = 466
        Width = 107
        Height = 15
        Caption = 'Delete this problem'
        TabOrder = 18
        OnClick = cmdDeleteProblemClick
      end
    end
    object tabControl: TTabSheet
      Caption = 'Control Files'
      ImageIndex = 4
      object pnlCtrl: TPanel
        Left = 0
        Top = 507
        Width = 996
        Height = 80
        Align = alBottom
        TabOrder = 0
        object Label7: TLabel
          Left = 179
          Top = 35
          Width = 58
          Height = 13
          Caption = 'Import Date:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label8: TLabel
          Left = 565
          Top = 35
          Width = 53
          Height = 13
          Caption = 'Type Date:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label9: TLabel
          Left = 745
          Top = 35
          Width = 73
          Height = 13
          Caption = 'Complete Date:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label10: TLabel
          Left = 657
          Top = 35
          Width = 65
          Height = 13
          Caption = 'Review Date:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label11: TLabel
          Left = 269
          Top = 35
          Width = 69
          Height = 13
          Caption = 'Transmit Date:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label12: TLabel
          Left = 365
          Top = 35
          Width = 69
          Height = 13
          Caption = 'Receive Date:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label13: TLabel
          Left = 466
          Top = 34
          Width = 60
          Height = 13
          Caption = 'Assign Date:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label14: TLabel
          Left = 56
          Top = 35
          Width = 62
          Height = 13
          Caption = 'Assigned To:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object edtControl: TEdit
          Left = 0
          Top = 8
          Width = 1001
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
        object edtImport: TEdit
          Left = 165
          Top = 48
          Width = 84
          Height = 21
          TabOrder = 1
        end
        object edtType: TEdit
          Left = 552
          Top = 48
          Width = 84
          Height = 21
          TabOrder = 2
        end
        object edtReview: TEdit
          Left = 648
          Top = 48
          Width = 84
          Height = 21
          TabOrder = 3
        end
        object edtComplete: TEdit
          Left = 744
          Top = 48
          Width = 84
          Height = 21
          TabOrder = 4
        end
        object edtAssign: TEdit
          Left = 453
          Top = 48
          Width = 84
          Height = 21
          TabOrder = 5
        end
        object edtReceive: TEdit
          Left = 357
          Top = 48
          Width = 84
          Height = 21
          TabOrder = 6
        end
        object edtTransmit: TEdit
          Left = 261
          Top = 48
          Width = 84
          Height = 21
          TabOrder = 7
        end
        object edtAssignto: TEdit
          Left = 45
          Top = 48
          Width = 84
          Height = 21
          TabOrder = 8
        end
        object btnRename: TButton
          Left = 848
          Top = 45
          Width = 145
          Height = 25
          Caption = 'Rename the Control File'
          TabOrder = 9
          OnClick = btnRenameClick
        end
      end
      object lstCtrls: TListBox
        Left = 0
        Top = 0
        Width = 996
        Height = 507
        Align = alClient
        ItemHeight = 13
        Sorted = True
        TabOrder = 1
        OnClick = lstCtrlsClick
      end
    end
    object tabMessages: TTabSheet
      Caption = 'Messages'
      ImageIndex = 5
      object cmdDeleteMessage: TSpeedButton
        Left = 256
        Top = 2
        Width = 26
        Height = 26
        Hint = 'Delete the highlighted message'
        Enabled = False
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
        OnClick = cmdDeleteMessageClick
      end
      object cmdReplyMessage: TSpeedButton
        Left = 256
        Top = 27
        Width = 26
        Height = 26
        Hint = 'Reply to the highlighted message'
        Enabled = False
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000010000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          555555FFFFFFFFFF5F5557777777777505555777777777757F55555555555555
          055555555555FF5575F555555550055030555555555775F7F7F55555550FB000
          005555555575577777F5555550FB0BF0F05555555755755757F555550FBFBF0F
          B05555557F55557557F555550BFBF0FB005555557F55575577F555500FBFBFB0
          305555577F555557F7F5550E0BFBFB003055557575F55577F7F550EEE0BFB0B0
          305557FF575F5757F7F5000EEE0BFBF03055777FF575FFF7F7F50000EEE00000
          30557777FF577777F7F500000E05555BB05577777F75555777F5500000555550
          3055577777555557F7F555000555555999555577755555577755}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = cmdReplyMessageClick
      end
      object cmdNewMessage: TSpeedButton
        Left = 293
        Top = 2
        Width = 25
        Height = 26
        Hint = 'Create a New Message'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000010000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
          000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
          00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
          F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
          0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
          FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
          FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
          0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
          00333377737FFFFF773333303300000003333337337777777333}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = cmdNewMessageClick
      end
      object cmdMailIt: TSpeedButton
        Left = 293
        Top = 27
        Width = 25
        Height = 26
        Hint = 'Send this Message'
        Enabled = False
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
        OnClick = cmdMailItClick
      end
      object cmdCancelMail: TSpeedButton
        Left = 293
        Top = 52
        Width = 25
        Height = 26
        Hint = 'Cancel this Message'
        Enabled = False
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000010000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
          3333333777333777FF3333993333339993333377FF3333377FF3399993333339
          993337777FF3333377F3393999333333993337F777FF333337FF993399933333
          399377F3777FF333377F993339993333399377F33777FF33377F993333999333
          399377F333777FF3377F993333399933399377F3333777FF377F993333339993
          399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
          99333773FF3333777733339993333339933333773FFFFFF77333333999999999
          3333333777333777333333333999993333333333377777333333}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = cmdCancelMailClick
      end
      object lblToMessage: TLabel
        Left = 327
        Top = 10
        Width = 51
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'To:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblFrom: TLabel
        Left = 327
        Top = 34
        Width = 51
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'From:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblMailTime: TLabel
        Left = 324
        Top = 58
        Width = 54
        Height = 13
        Caption = 'Date/Time:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblMailSubject: TLabel
        Left = 339
        Top = 82
        Width = 39
        Height = 13
        Caption = 'Subject:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblMailMemo: TLabel
        Left = 346
        Top = 107
        Width = 32
        Height = 13
        Caption = 'Memo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object treMessages: TTreeView
        Left = 0
        Top = 0
        Width = 249
        Height = 587
        Align = alLeft
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Indent = 19
        ParentFont = False
        TabOrder = 0
        OnClick = treMessagesClick
        Items.Data = {
          05000000210000000000000000000000FFFFFFFFFFFFFFFF0000000000000000
          0852656365697665641D0000000000000000000000FFFFFFFFFFFFFFFF000000
          00000000000453656E742D0000000000000000000000FFFFFFFFFFFFFFFF0000
          0000000000001450656E64696E67207472616E736D697373696F6E2900000000
          00000000000000FFFFFFFFFFFFFFFF0000000000000000105265636569766564
          2041726368697665250000000000000000000000FFFFFFFFFFFFFFFF00000000
          000000000C53656E742041726368697665}
      end
      object edtMessageTo: TEdit
        Left = 383
        Top = 7
        Width = 272
        Height = 21
        ReadOnly = True
        TabOrder = 1
      end
      object edtFromMail: TEdit
        Left = 383
        Top = 31
        Width = 272
        Height = 21
        ReadOnly = True
        TabOrder = 2
      end
      object edtDateTimeMail: TEdit
        Left = 383
        Top = 55
        Width = 272
        Height = 21
        ReadOnly = True
        TabOrder = 3
      end
      object edtSubjectMail: TEdit
        Left = 383
        Top = 79
        Width = 400
        Height = 21
        ReadOnly = True
        TabOrder = 4
      end
      object memMessage: TMemo
        Left = 383
        Top = 103
        Width = 400
        Height = 343
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 5
      end
      object lstMessages: TFileListBox
        Left = 840
        Top = 448
        Width = 145
        Height = 97
        ItemHeight = 13
        TabOrder = 6
        Visible = False
      end
      object cboMessageTo: TComboBox
        Left = 383
        Top = 7
        Width = 291
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 7
        Visible = False
      end
      object cmdSendandReceive: TButton
        Left = 256
        Top = 144
        Width = 121
        Height = 25
        Caption = 'Send and Receive'
        TabOrder = 8
        OnClick = cmdSendandReceiveClick
      end
      object pnlCommunicate2: TPanel
        Left = 5
        Top = 152
        Width = 241
        Height = 177
        Caption = 'Please Wait - Communicating'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        Visible = False
      end
    end
    object tabAccounts: TTabSheet
      Caption = 'Manage Accounts'
      object Label2: TLabel
        Left = 28
        Top = 42
        Width = 40
        Height = 16
        Caption = 'Name:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 32
        Top = 66
        Width = 36
        Height = 16
        Caption = 'Login:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 5
        Top = 90
        Width = 63
        Height = 16
        Caption = 'Password:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object btnNewAccount: TButton
        Left = 1
        Top = 8
        Width = 87
        Height = 25
        Caption = 'New Account'
        TabOrder = 19
        OnClick = btnNewAccountClick
      end
      object btnSaveAccount: TButton
        Left = 87
        Top = 8
        Width = 105
        Height = 25
        Caption = 'Save This Account'
        TabOrder = 20
        OnClick = btnSaveAccountClick
      end
      object btnCreateAccountFolders: TButton
        Left = 191
        Top = 8
        Width = 105
        Height = 25
        Caption = 'Create FTP Folders'
        TabOrder = 0
        OnClick = btnCreateAccountFoldersClick
      end
      object lstAccounts: TListBox
        Left = 8
        Top = 120
        Width = 281
        Height = 225
        ItemHeight = 13
        Sorted = True
        TabOrder = 1
        OnClick = lstAccountsClick
      end
      object grdPhysician: TStringGrid
        Left = 296
        Top = 40
        Width = 505
        Height = 233
        ColCount = 2
        DefaultRowHeight = 16
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        ScrollBars = ssVertical
        TabOrder = 2
        ColWidths = (
          55
          232)
      end
      object grdAdmin: TStringGrid
        Left = 296
        Top = 288
        Width = 505
        Height = 105
        ColCount = 3
        DefaultRowHeight = 16
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        ScrollBars = ssVertical
        TabOrder = 3
        ColWidths = (
          55
          233
          199)
      end
      object grdTypist: TStringGrid
        Left = 296
        Top = 408
        Width = 505
        Height = 105
        ColCount = 2
        DefaultRowHeight = 16
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        ScrollBars = ssVertical
        TabOrder = 4
        ColWidths = (
          55
          232)
      end
      object edtName: TEdit
        Left = 72
        Top = 40
        Width = 217
        Height = 21
        TabOrder = 5
        OnChange = edtNameChange
      end
      object edtLogin: TEdit
        Left = 72
        Top = 64
        Width = 113
        Height = 21
        TabOrder = 6
        OnChange = edtLoginChange
      end
      object edtPassword: TEdit
        Left = 72
        Top = 88
        Width = 113
        Height = 21
        TabOrder = 7
        OnChange = edtPasswordChange
      end
      object btnAddPhysician: TButton
        Left = 624
        Top = 24
        Width = 50
        Height = 17
        Caption = 'Add'
        TabOrder = 8
        OnClick = btnAddPhysicianClick
      end
      object btnSavePhysician: TButton
        Left = 680
        Top = 24
        Width = 50
        Height = 17
        Caption = 'Save'
        TabOrder = 9
        OnClick = btnSavePhysicianClick
      end
      object btnMovetoServer: TButton
        Left = 295
        Top = 8
        Width = 129
        Height = 25
        Caption = 'Move Account to Server'
        TabOrder = 10
        OnClick = btnMovetoServerClick
      end
      object btnAddAdmin: TButton
        Left = 624
        Top = 272
        Width = 50
        Height = 17
        Caption = 'Add'
        TabOrder = 11
        OnClick = btnAddAdminClick
      end
      object btnSaveAdmin: TButton
        Left = 680
        Top = 272
        Width = 50
        Height = 17
        Caption = 'Save'
        TabOrder = 12
        OnClick = btnSaveAdminClick
      end
      object cmdAdd: TButton
        Left = 624
        Top = 392
        Width = 50
        Height = 17
        Caption = 'Add'
        TabOrder = 13
        OnClick = cmdAddClick
      end
      object cmdSaveTypist: TButton
        Left = 680
        Top = 392
        Width = 50
        Height = 17
        Caption = 'Save'
        TabOrder = 14
        OnClick = cmdSaveTypistClick
      end
      object btnPhysicianUpload: TButton
        Left = 736
        Top = 24
        Width = 50
        Height = 17
        Caption = 'Upload'
        TabOrder = 15
        OnClick = btnPhysicianUploadClick
      end
      object btnAdminUpload: TButton
        Left = 736
        Top = 272
        Width = 50
        Height = 17
        Caption = 'Upload'
        TabOrder = 16
        OnClick = btnAdminUploadClick
      end
      object btnTypistUpload: TButton
        Left = 736
        Top = 392
        Width = 50
        Height = 17
        Caption = 'Upload'
        TabOrder = 17
        OnClick = btnTypistUploadClick
      end
      object memUploading: TMemo
        Left = 8
        Top = 352
        Width = 281
        Height = 161
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 18
      end
    end
    object tabPurge: TTabSheet
      Caption = 'Purge'
      ImageIndex = 2
      object lblP1: TLabel
        Left = 16
        Top = 9
        Width = 51
        Height = 16
        Caption = 'Account:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object memProgress: TMemo
        Left = 496
        Top = 0
        Width = 305
        Height = 233
        TabOrder = 0
      end
      object cmdPurge: TButton
        Left = 168
        Top = 6
        Width = 193
        Height = 25
        Caption = 'Purge aged content on one account'
        TabOrder = 1
        OnClick = cmdPurgeClick
      end
      object Memo1: TMemo
        Left = 0
        Top = 311
        Width = 996
        Height = 276
        Align = alBottom
        ReadOnly = True
        TabOrder = 2
        WordWrap = False
      end
      object cboAccount: TComboBox
        Left = 72
        Top = 8
        Width = 89
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 3
      end
    end
    object tabEncryption: TTabSheet
      Caption = 'Encryption'
      ImageIndex = 1
      object lbla: TLabel
        Left = 24
        Top = 8
        Width = 25
        Height = 16
        Caption = 'File:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 12
        Top = 40
        Width = 37
        Height = 16
        Caption = 'String:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object edtFile: TEdit
        Left = 56
        Top = 8
        Width = 385
        Height = 21
        TabOrder = 0
      end
      object edtContent: TEdit
        Left = 56
        Top = 40
        Width = 945
        Height = 21
        TabOrder = 1
      end
      object cmdLoad: TButton
        Left = 448
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Load'
        TabOrder = 2
        OnClick = cmdLoadClick
      end
      object btnSave: TButton
        Left = 528
        Top = 8
        Width = 81
        Height = 25
        Caption = 'Save'
        TabOrder = 3
        OnClick = btnSaveClick
      end
      object Button1: TButton
        Left = 448
        Top = 64
        Width = 161
        Height = 25
        Caption = 'Decrypt'
        TabOrder = 4
        OnClick = Button1Click
      end
      object Edit1: TEdit
        Left = 123
        Top = 66
        Width = 201
        Height = 21
        TabOrder = 5
        Text = 'c:\x\oz.mp3'
      end
      object Edit2: TEdit
        Left = 123
        Top = 90
        Width = 201
        Height = 21
        TabOrder = 6
        Text = 'c:\x\oz.mp3_cry'
      end
      object Button2: TButton
        Left = 3
        Top = 66
        Width = 113
        Height = 25
        Caption = 'nEncrypt'
        TabOrder = 7
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 339
        Top = 74
        Width = 75
        Height = 25
        Caption = 'nDecrypt'
        TabOrder = 8
        OnClick = Button3Click
      end
      object Edit3: TEdit
        Left = 64
        Top = 96
        Width = 49
        Height = 21
        TabOrder = 9
        Text = 'A000'
      end
    end
    object tabComplete: TTabSheet
      Caption = 'Complete'
      ImageIndex = 6
      object lblComp: TLabel
        Left = 64
        Top = 107
        Width = 47
        Height = 13
        Caption = 'Complete:'
      end
      object edtMakeCpt: TEdit
        Left = 120
        Top = 104
        Width = 73
        Height = 21
        MaxLength = 8
        TabOrder = 0
        Text = '20160626'
      end
      object edtPhys: TEdit
        Left = 120
        Top = 80
        Width = 73
        Height = 21
        MaxLength = 8
        TabOrder = 1
        Text = 'P032'
      end
      object edtAcct: TEdit
        Left = 120
        Top = 56
        Width = 73
        Height = 21
        MaxLength = 8
        TabOrder = 2
        Text = 'A001'
      end
      object Button5: TButton
        Left = 120
        Top = 24
        Width = 177
        Height = 25
        Caption = 'Change Reviewed to Complete'
        TabOrder = 3
        OnClick = Button4Click
      end
      object Button6: TButton
        Left = 400
        Top = 24
        Width = 75
        Height = 25
        Caption = 'FIX'
        TabOrder = 4
        OnClick = Button6Click
      end
    end
  end
  object tblProblems: TTable
    Active = True
    DatabaseName = '.\.'
    TableName = 'ScriptWaveProblems.DB'
    Left = 948
    Top = 584
  end
  object dtsProblems: TDataSource
    DataSet = tblProblems
    Left = 976
    Top = 584
  end
end
