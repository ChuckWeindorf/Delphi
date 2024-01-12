program ICD9SearchHarness;

uses
  Forms,
  formICD9Search in 'formICD9Search.pas' {frmICD9Search},
  procICD9search in 'procICD9search.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmICD9Search, frmICD9Search);
  Application.Run;
end.
