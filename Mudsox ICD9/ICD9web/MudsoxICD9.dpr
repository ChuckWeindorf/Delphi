library MudsoxICD9;

uses
  WebBroker,
  ISAPIApp,
  wm001ICD9 in 'wm001ICD9.pas' {wmICD9: TWebModule},
  procICD9search in '..\procICD9search.pas',
  classICD9Search in '..\classICD9Search.pas';

{$R *.RES}

exports
  GetExtensionVersion,
  HttpExtensionProc,
  TerminateExtension;

begin
  Application.Initialize;
  Application.CreateForm(TwmICD9, wmICD9);
  Application.Run;
end.
