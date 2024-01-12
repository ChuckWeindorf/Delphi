object frmBackupPurge: TfrmBackupPurge
  Left = 217
  Top = 171
  Width = 997
  Height = 480
  Caption = 'Backup and Purge A001 Scriptwave'
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
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 981
    Height = 51
    Align = alTop
    TabOrder = 0
    object barTransmit: TGauge
      Left = 1
      Top = 30
      Width = 979
      Height = 20
      Align = alBottom
      ForeColor = clLime
      Progress = 0
    end
    object lstFiles: TFileListBox
      Left = 877
      Top = 1
      Width = 103
      Height = 29
      Align = alRight
      ItemHeight = 13
      TabOrder = 0
      Visible = False
    end
    object cmdBackup: TButton
      Left = 155
      Top = 3
      Width = 75
      Height = 25
      Caption = 'Backup Now'
      TabOrder = 1
      OnClick = cmdBackupClick
    end
    object cmdPurge: TButton
      Left = 251
      Top = 3
      Width = 75
      Height = 25
      Caption = 'Purge Now'
      TabOrder = 2
      OnClick = cmdPurgeClick
    end
    object cmdLoadServer: TButton
      Left = 347
      Top = 3
      Width = 121
      Height = 25
      Caption = 'Load Backup Server'
      Enabled = False
      TabOrder = 3
      OnClick = cmdLoadServerClick
    end
  end
  object pnlLog: TPanel
    Left = 0
    Top = 51
    Width = 981
    Height = 390
    Align = alClient
    TabOrder = 1
    object memLog: TMemo
      Left = 1
      Top = 1
      Width = 979
      Height = 388
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      WordWrap = False
    end
  end
  object tmrbackup: TTimer
    Interval = 900000
    OnTimer = tmrbackupTimer
    Left = 848
    Top = 1
  end
end
