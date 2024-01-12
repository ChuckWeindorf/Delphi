program ScriptWaveTranscriptionAdmin;

uses
  Forms,
  fmScriptWaveAdmin in 'fmScriptWaveAdmin.pas' {frmScriptWaveTranscriptionAdmin},
  pmScriptWaveShare in '..\pmScriptWaveShare.pas',
  pmutilities in '..\pmutilities.pas',
  pmVariablesConstants in '..\pmVariablesConstants.pas',
  pmScriptWave_mudCryptor in '..\pmScriptWave_mudCryptor.pas',
  pmScriptWaveFTP_II in '..\pmScriptWaveFTP_II.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmScriptWaveTranscriptionAdmin, frmScriptWaveTranscriptionAdmin);
  Application.Run;
end.
