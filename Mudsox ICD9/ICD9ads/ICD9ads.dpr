program ICD9ads;

uses
  Forms,
  formICD9ads in 'formICD9ads.pas' {frm1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm1, frm1);
  Application.Run;
end.
