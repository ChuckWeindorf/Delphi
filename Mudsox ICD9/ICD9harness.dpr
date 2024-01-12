program ICD9harness;

uses
  Forms,
  formHarness in 'formHarness.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
