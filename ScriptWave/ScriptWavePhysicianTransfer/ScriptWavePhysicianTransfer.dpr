program ScriptWavePhysicianTransfer;

uses
  Forms,
  Windows,
  fmScriptWavePhysician in 'fmScriptWavePhysician.pas' {frmPhysicianMain},
  fmLogForm in '..\fmLogForm.pas' {frmLogFile},
  pmScriptWaveShare in '..\pmScriptWaveShare.pas',
  fmImportComment in '..\fmImportComment.pas' {frmImport},
  pmScriptWaveShareVariable in '..\pmScriptWaveShareVariable.pas',
  pmutilities in '..\pmutilities.pas',
  rpBasic in '..\rpBasic.pas' {rptReport: TQuickRep},
  pmVariablesConstants in '..\pmVariablesConstants.pas',
  pmScriptWave_mudCryptor in '..\pmScriptWave_mudCryptor.pas',
  pmScriptWaveFTP_II in '..\pmScriptWaveFTP_II.pas';

{$R *.RES}
var    vintMutex: integer;
begin
vintMutex := CreateMutex(nil, True, 'ScriptWavePhysicianTransfer');
try
if (vintMutex <> 0) and (GetLastError = 0) then
  begin
  Application.Initialize;
  Application.Title := 'ScriptWave';
  Application.CreateForm(TfrmPhysicianMain, frmPhysicianMain);
  Application.CreateForm(TfrmLogFile, frmLogFile);
  Application.CreateForm(TfrmImport, frmImport);
  Application.Run;
  end;
finally
   If vintMutex > 0 then
       CloseHandle(vintMutex);
   end;
end.
