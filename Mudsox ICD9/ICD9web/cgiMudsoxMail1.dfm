object webModuleMail: TwebModuleMail
  OldCreateOrder = False
  Actions = <
    item
      Default = True
      Name = 'actMail'
      OnAction = WebModule1actMailAction
    end>
  Left = 272
  Top = 114
  Height = 480
  Width = 696
  object smtpMail: TNMSMTP
    Port = 25
    ReportLevel = 0
    EncodeType = uuMime
    ClearParams = True
    SubType = mtPlain
    Charset = 'us-ascii'
    Left = 40
    Top = 40
  end
end
