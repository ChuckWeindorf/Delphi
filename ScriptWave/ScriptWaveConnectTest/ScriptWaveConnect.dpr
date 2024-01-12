program ScriptWaveConnect;

uses
  Forms,
  connect1 in 'connect1.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
