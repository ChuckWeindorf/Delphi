object frmTransfer: TfrmTransfer
  Left = -2
  Top = 619
  Width = 462
  Height = 127
  Caption = 'MHEDS Transfer Utility'
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
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object memLog: TMemo
    Left = 0
    Top = 0
    Width = 446
    Height = 89
    Align = alClient
    TabOrder = 0
  end
  object imgImagelist: TImageList
    Left = 15
    Top = 8
    Bitmap = {
      494C010103000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      000000000000000000000000000000000000F3F60500F3F60500F3F60500F3F6
      0500F3F60500F3F60500F3F60500F3F60500F3F60500F3F60500F3F60500F3F6
      0500F3F60500F3F60500F3F60500F3F6050001F8FB0001F8FB0001F8FB0001F8
      FB0001F8FB0001F8FB0001F8FB0001F8FB0001F8FB0001F8FB0001F8FB0001F8
      FB0001F8FB0001F8FB0001F8FB0001F8FB000505FD000505FD000505FD000505
      FD000505FD000505FD000505FD000505FD000505FD000505FD000505FD000505
      FD000505FD000505FD000505FD000505FD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F3F60500F3F60500F3F60500F3F6
      0500F3F60500F3F60500F3F60500F3F60500F3F60500F3F60500030303000303
      0300030303000303030003030300F3F6050001F8FB0001F8FB0001F8FB0001F8
      FB0001F8FB0001F8FB0001F8FB0001F8FB0001F8FB0001F8FB00030303000303
      030003030300030303000303030001F8FB000505FD000505FD000505FD000505
      FD000505FD000505FD000505FD000505FD000505FD000505FD00030303000303
      03000303030003030300030303000505FD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F3F60500F3F60500F3F60500F3F6
      0500F3F60500F3F60500F3F60500F3F60500F3F60500F3F6050003030300F3F6
      050003030300F3F6050003030300F3F6050001F8FB0001F8FB0001F8FB0001F8
      FB0001F8FB0001F8FB0001F8FB0001F8FB0001F8FB0001F8FB000303030001F8
      FB000303030001F8FB000303030001F8FB000505FD000505FD000505FD000505
      FD000505FD000505FD000505FD000505FD000505FD000505FD00030303000505
      FD00030303000505FD00030303000505FD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F3F60500F3F60500F3F60500F3F6
      0500F3F60500F3F60500F3F60500F3F60500F3F60500F3F6050003030300F3F6
      0500F3F60500F3F6050003030300F3F6050001F8FB0001F8FB0001F8FB0001F8
      FB0001F8FB0001F8FB0001F8FB0001F8FB0001F8FB0001F8FB000303030001F8
      FB0001F8FB0001F8FB000303030001F8FB000505FD000505FD000505FD000505
      FD000505FD000505FD000505FD000505FD000505FD000505FD00030303000505
      FD000505FD000505FD00030303000505FD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F3F60500F3F60500F3F60500F3F6
      0500F3F60500F3F60500F3F60500F3F60500F3F60500F3F6050003030300F3F6
      0500F3F60500F3F6050003030300F3F6050001F8FB0001F8FB0001F8FB0001F8
      FB0001F8FB0001F8FB0001F8FB0001F8FB0001F8FB0001F8FB000303030001F8
      FB0001F8FB0001F8FB000303030001F8FB000505FD000505FD000505FD000505
      FD000505FD000505FD000505FD000505FD000505FD000505FD00030303000505
      FD000505FD000505FD00030303000505FD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F3F60500F3F60500F3F60500F3F6
      0500F3F60500F3F60500F3F60500F3F60500F3F60500F3F6050003030300F3F6
      0500F3F60500F3F6050003030300F3F6050001F8FB0001F8FB0001F8FB0001F8
      FB0001F8FB0001F8FB0001F8FB0001F8FB0001F8FB0001F8FB000303030001F8
      FB0001F8FB0001F8FB000303030001F8FB000505FD000505FD000505FD000505
      FD000505FD000505FD000505FD000505FD000505FD000505FD00030303000505
      FD000505FD000505FD00030303000505FD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F3F60500F3F60500F3F60500F3F6
      0500F3F605000303030003030300030303000303030003030300F3F60500F3F6
      0500F3F60500F3F60500F3F60500F3F6050001F8FB0001F8FB0001F8FB0001F8
      FB0001F8FB00030303000303030003030300030303000303030001F8FB0001F8
      FB0001F8FB0001F8FB0001F8FB0001F8FB000505FD000505FD000505FD000505
      FD000505FD0003030300030303000303030003030300030303000505FD000505
      FD000505FD000505FD000505FD000505FD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F3F60500F3F60500F3F60500F3F6
      0500F3F6050003030300F3F60500F3F60500F3F60500F3F60500F3F60500F3F6
      0500F3F60500F3F60500F3F60500F3F6050001F8FB0001F8FB0001F8FB0001F8
      FB0001F8FB000303030001F8FB0001F8FB0001F8FB0001F8FB0001F8FB0001F8
      FB0001F8FB0001F8FB0001F8FB0001F8FB000505FD000505FD000505FD000505
      FD000505FD00030303000505FD000505FD000505FD000505FD000505FD000505
      FD000505FD000505FD000505FD000505FD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F3F60500F3F60500F3F60500F3F6
      0500F3F6050003030300F3F60500F3F60500F3F60500F3F60500F3F60500F3F6
      0500F3F60500F3F60500F3F60500F3F6050001F8FB0001F8FB0001F8FB0001F8
      FB0001F8FB000303030001F8FB0001F8FB0001F8FB0001F8FB0001F8FB0001F8
      FB0001F8FB0001F8FB0001F8FB0001F8FB000505FD000505FD000505FD000505
      FD000505FD00030303000505FD000505FD000505FD000505FD000505FD000505
      FD000505FD000505FD000505FD000505FD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F3F60500F3F60500F3F60500F3F6
      0500F3F6050003030300F3F60500F3F60500F3F60500F3F60500F3F60500F3F6
      0500F3F60500F3F60500F3F60500F3F6050001F8FB0001F8FB0001F8FB0001F8
      FB0001F8FB000303030001F8FB0001F8FB0001F8FB0001F8FB0001F8FB0001F8
      FB0001F8FB0001F8FB0001F8FB0001F8FB000505FD000505FD000505FD000505
      FD000505FD00030303000505FD000505FD000505FD000505FD000505FD000505
      FD000505FD000505FD000505FD000505FD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F3F60500F3F60500F3F60500F3F6
      0500F3F605000303030003030300030303000303030003030300F3F60500F3F6
      0500F3F60500F3F60500F3F60500F3F6050001F8FB0001F8FB0001F8FB0001F8
      FB0001F8FB00030303000303030003030300030303000303030001F8FB0001F8
      FB0001F8FB0001F8FB0001F8FB0001F8FB000505FD000505FD000505FD000505
      FD000505FD0003030300030303000303030003030300030303000505FD000505
      FD000505FD000505FD000505FD000505FD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000303030003030300030303000303
      030003030300F3F60500F3F60500F3F60500F3F60500F3F60500F3F60500F3F6
      0500F3F60500F3F60500F3F60500F3F605000303030003030300030303000303
      03000303030001F8FB0001F8FB0001F8FB0001F8FB0001F8FB0001F8FB0001F8
      FB0001F8FB0001F8FB0001F8FB0001F8FB000303030003030300030303000303
      0300030303000505FD000505FD000505FD000505FD000505FD000505FD000505
      FD000505FD000505FD000505FD000505FD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F3F60500F3F60500F3F60500F3F6
      050003030300F3F60500F3F60500F3F60500F3F60500F3F60500F3F60500F3F6
      0500F3F60500F3F60500F3F60500F3F6050001F8FB0001F8FB0001F8FB0001F8
      FB000303030001F8FB0001F8FB0001F8FB0001F8FB0001F8FB0001F8FB0001F8
      FB0001F8FB0001F8FB0001F8FB0001F8FB000505FD000505FD000505FD000505
      FD00030303000505FD000505FD000505FD000505FD000505FD000505FD000505
      FD000505FD000505FD000505FD000505FD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000303030003030300030303000303
      030003030300F3F60500F3F60500F3F60500F3F60500F3F60500F3F60500F3F6
      0500F3F60500F3F60500F3F60500F3F605000303030003030300030303000303
      03000303030001F8FB0001F8FB0001F8FB0001F8FB0001F8FB0001F8FB0001F8
      FB0001F8FB0001F8FB0001F8FB0001F8FB000303030003030300030303000303
      0300030303000505FD000505FD000505FD000505FD000505FD000505FD000505
      FD000505FD000505FD000505FD000505FD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000003030300F3F60500F3F60500F3F6
      0500F3F60500F3F60500F3F60500F3F60500F3F60500F3F60500F3F60500F3F6
      0500F3F60500F3F60500F3F60500F3F605000303030001F8FB0001F8FB0001F8
      FB0001F8FB0001F8FB0001F8FB0001F8FB0001F8FB0001F8FB0001F8FB0001F8
      FB0001F8FB0001F8FB0001F8FB0001F8FB00030303000505FD000505FD000505
      FD000505FD000505FD000505FD000505FD000505FD000505FD000505FD000505
      FD000505FD000505FD000505FD000505FD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000303030003030300030303000303
      030003030300F3F60500F3F60500F3F60500F3F60500F3F60500F3F60500F3F6
      0500F3F60500F3F60500F3F60500F3F605000303030003030300030303000303
      03000303030001F8FB0001F8FB0001F8FB0001F8FB0001F8FB0001F8FB0001F8
      FB0001F8FB0001F8FB0001F8FB0001F8FB000303030003030300030303000303
      0300030303000505FD000505FD000505FD000505FD000505FD000505FD000505
      FD000505FD000505FD000505FD000505FD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
  object shnShellNotify: TTNShellNotifyIcon
    Active = True
    Animate = False
    AnimateInterval = 5
    Hint = 'MHEDS file transfer'
    IconList = imgImagelist
    PopupMenu = popTrayMenu
    Version = '1.0.1'
    VersionDate = 'October 15, 2002'
    OnDblClick = shnShellNotifyDblClick
    Left = 75
    Top = 8
  end
  object tmrBlink: TTimer
    Interval = 500
    OnTimer = tmrBlinkTimer
    Left = 46
    Top = 8
  end
  object tmrMain: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = tmrMainTimer
    Left = 104
    Top = 8
  end
  object popTrayMenu: TPopupMenu
    OnPopup = popTrayMenuPopup
    Left = 135
    Top = 8
    object cmdClear: TMenuItem
      Caption = 'Clear Received Files'
      Enabled = False
      OnClick = cmdClearClick
    end
    object cmdShow: TMenuItem
      Caption = 'Show'
      OnClick = cmdShowClick
    end
    object cmdHide: TMenuItem
      Caption = 'Hide'
      OnClick = cmdHideClick
    end
    object cmdRestart: TMenuItem
      Caption = 'Restart'
      OnClick = cmdRestartClick
    end
    object cmdShutdown: TMenuItem
      Caption = 'Shutdown'
      OnClick = cmdShutdownClick
    end
  end
end
