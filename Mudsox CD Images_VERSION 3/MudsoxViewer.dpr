program MudsoxViewer;

uses
  Forms,
  formMudsoxView in 'formMudsoxView.pas' {formMudsoxViewer},
  formMudsoxFullImage in 'formMudsoxFullImage.pas' {frmFullImage},
  procMudsoxImage in 'procMudsoxImage.pas',
  formEmail in 'formEmail.pas' {frmEmail},
  formNew in 'formNew.pas' {frmNew},
  procRoutines in 'procRoutines.pas',
  formPrint in 'formPrint.pas' {frmPrint},
  formHTML in 'formHTML.pas' {frmHTML},
  formMudsoxAbout in 'formMudsoxAbout.pas' {frmAbout};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TformMudsoxViewer, formMudsoxViewer);
  Application.Run;
end.
