program ScriptWaveInstaller;

uses
  Forms,
  fmInstaller in 'fmInstaller.pas' {frmActivation},
  pmVariablesConstants in '\\Mudsox2\OzzieData\DelphiCode\ScriptWave\pmVariablesConstants.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmActivation, frmActivation);
  Application.Run;
end.
