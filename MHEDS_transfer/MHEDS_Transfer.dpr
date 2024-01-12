program MHEDS_Transfer;

uses
  Forms,
  windows,
  MhedsTransfer1 in 'MhedsTransfer1.pas' {frmTransfer},
  pmScriptWave_mudCryptor in 'pmScriptWave_mudCryptor.pas',
  pmScriptWaveFTP_II in 'pmScriptWaveFTP_II.pas',
  pmScriptWaveShare in 'pmScriptWaveShare.pas',
  pmScriptWaveShareVariable in 'pmScriptWaveShareVariable.pas',
  pmutilities in 'pmutilities.pas',
  pmVariablesConstants in 'pmVariablesConstants.pas';

{$R *.RES}

  var    vintMutex: integer;
begin
sleep(2000);
vstrSessionType:= ParamStr(1);
vintMutex := CreateMutex(nil, True, 'MHEDS_Transfer');
try
if (vintMutex <> 0) then
  begin
  Application.Initialize;
  Application.Title := 'MHEDS_Transfer';
  Application.CreateForm(TfrmTransfer, frmTransfer);
  frmTransfer.vstrHH_folder:= '.\scans\';
  If ParamStr(2) > ' A' then
     frmTransfer.vstrHH_folder:= ParamStr(2);
  Application.Run;
  end;
finally
   If vintMutex > 0 then
       CloseHandle(vintMutex);
   end;
end.
