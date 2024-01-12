program ThumbCreate;

uses
  Forms,
  thumbcreate1 in 'thumbcreate1.pas' {Form1},
  procMudsoxImage in 'procMudsoxImage.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
