object Form1: TForm1
  Left = 435
  Top = 117
  Width = 388
  Height = 525
  Caption = 'ScriptWaveConnectTest'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 8
    Top = 4
    Width = 265
    Height = 21
    TabOrder = 0
    Text = 'Status'
  end
  object Memo1: TMemo
    Left = 0
    Top = 40
    Width = 380
    Height = 451
    Align = alBottom
    TabOrder = 1
  end
  object Timer1: TTimer
    Interval = 10000
    OnTimer = Timer1Timer
    Left = 328
  end
  object sftp: TElSimpleSFTPClient
    SSHAuthOrder = aoDefault
    Address = 'www.mudsox.com'
    ASCIIMode = False
    CompressionLevel = 6
    ForceCompression = False
    Password = 'ozzie2828'
    SftpBufferSize = 131072
    SocksAuthentication = saNoAuthentication
    SoftwareName = 'EldoS.SSHBlackbox.5'
    Username = 'mudsoxco'
    UseUTF8 = True
    Versions = [sbSFTP2, sbSFTP3, sbSFTP4, sbSFTP5, sbSFTP6]
    LocalPort = 0
    PipelineLength = 32
    DownloadBlockSize = 8192
    UploadBlockSize = 32768
    WebTunnelPort = 3128
    CertAuthMode = camAuto
    Left = 296
  end
end
