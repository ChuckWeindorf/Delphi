program ScripWaveBackupPurge;

uses
  Forms,
  fmBackupPurge in 'fmBackupPurge.pas' {frmBackupPurge},
  pmScriptWaveShare in '..\pmScriptWaveShare.pas',
  pmScriptWaveFTP_II in '..\pmScriptWaveFTP_II.pas',
  pmScriptWaveShareVariable in '..\pmScriptWaveShareVariable.pas',
  pmVariablesConstants in '..\pmVariablesConstants.pas',
  pmutilities in '..\pmutilities.pas',
  pmScriptWave_mudCryptor in '..\pmScriptWave_mudCryptor.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmBackupPurge, frmBackupPurge);
  Application.Run;
end.
