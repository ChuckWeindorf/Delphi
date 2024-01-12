program MudsoxImageTest;

uses
  Forms,
  MudsoxImageTest1 in 'MudsoxImageTest1.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
