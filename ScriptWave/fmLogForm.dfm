object frmLogFile: TfrmLogFile
  Left = 172
  Top = 188
  Width = 800
  Height = 390
  Caption = 'View the log file'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object memLog: TRichEdit
    Left = 0
    Top = 0
    Width = 792
    Height = 356
    Align = alClient
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
end
