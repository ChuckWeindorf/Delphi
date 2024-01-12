object frmSchedPassword: TfrmSchedPassword
  Left = 418
  Top = 328
  BorderStyle = bsDialog
  Caption = 'Password Required'
  ClientHeight = 72
  ClientWidth = 331
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
  object edtPassword: TEdit
    Left = 72
    Top = 24
    Width = 185
    Height = 21
    Hint = 'Enter a valid password to this feature'
    ParentShowHint = False
    PasswordChar = '#'
    ShowHint = True
    TabOrder = 0
    OnKeyPress = edtPasswordKeyPress
  end
end
