program ICD9StressTest;

uses
  Forms,
  fomrICD9stressTest in 'fomrICD9stressTest.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
