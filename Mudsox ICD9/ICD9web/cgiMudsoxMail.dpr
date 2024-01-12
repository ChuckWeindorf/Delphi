program cgiMudsoxMail;

{$APPTYPE GUI}

uses
  WebBroker,
  CGIApp,
  cgiMudsoxMail1 in 'cgiMudsoxMail1.pas' {webModuleMail: TWebModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TwebModuleMail, webModuleMail);
  Application.Run;
end.
