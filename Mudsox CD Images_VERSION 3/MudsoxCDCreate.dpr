program MudsoxCDCreate;

uses
  Forms,
  formMudsoxCDCreate in 'formMudsoxCDCreate.pas' {formMudsoxCDCreator},
  procMudsoxImage in 'procMudsoxImage.pas',
  formAddCD in 'formAddCD.pas' {formAddNewCD},
  formMudsoxFullImage in 'formMudsoxFullImage.pas' {frmFullImage},
  MultiTWAIN in 'MultiTWAIN.pas',
  formMudsoxAbout in 'formMudsoxAbout.pas' {frmAbout},
  formCreateMain in 'formCreateMain.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TformMudsoxCDCreator, formMudsoxCDCreator);
  Application.Run;
end.
