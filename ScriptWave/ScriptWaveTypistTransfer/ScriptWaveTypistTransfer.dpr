program ScriptWaveTypistTransfer;

uses
  Forms,
  Windows,
  fmScriptWaveTypist in 'fmScriptWaveTypist.pas' {frmTypistMain},
  fmLogForm in '..\fmLogForm.pas' {frmLogFile},
  fmImportComment in '..\fmImportComment.pas' {frmImport},
  pmutilities in '..\pmutilities.pas',
  rpBasic in '..\rpBasic.pas' {rptReport: TQuickRep},
  pmVariablesConstants in '..\pmVariablesConstants.pas',
  pmScriptWaveShare in '..\pmScriptWaveShare.pas',
  fmScriptWaveComment in 'fmScriptWaveComment.pas' {frmAddComment},
  pmScriptWave_mudCryptor in '..\pmScriptWave_mudCryptor.pas',
  pmScriptWaveFTP_II in '..\pmScriptWaveFTP_II.pas',
  pmScriptWaveShareVariable in '..\pmScriptWaveShareVariable.pas';

{$R *.RES}
var    vintMutex: integer;
begin
vintMutex := CreateMutex(nil, True, 'ScriptWaveTypistTransfer');
try
if (vintMutex <> 0) and (GetLastError = 0) then
  begin
  Application.Initialize;
  Application.Title := 'ScriptWave Typist';
  Application.CreateForm(TfrmTypistMain, frmTypistMain);
  Application.CreateForm(TfrmImport, frmImport);
  Application.CreateForm(TfrmLogFile, frmLogFile);
  Application.CreateForm(TfrmAddComment, frmAddComment);
  Application.Run;
  end;
finally
   If vintMutex > 0 then
       CloseHandle(vintMutex);
   end;
end.
