object frmProself: TfrmProself
  Left = 279
  Top = 126
  Width = 467
  Height = 70
  Caption = 'ScriptWave Proself'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 16
    Top = 8
    Width = 435
    Height = 20
    Caption = 'Updating/Restarting ScriptWave Software - Please Wait'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'Lucida Sans Unicode'
    Font.Style = []
    ParentFont = False
  end
  object tmrCopy: TTimer
    Interval = 5000
    OnTimer = tmrCopyTimer
    Left = 424
  end
end
