unit fmBackupPurge;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Gauges, FileCtrl;

type
  TfrmBackupPurge = class(TForm)
    pnlTop: TPanel;
    pnlLog: TPanel;
    memLog: TMemo;
    barTransmit: TGauge;
    lstFiles: TFileListBox;
    cmdBackup: TButton;
    cmdPurge: TButton;
    tmrbackup: TTimer;
    cmdLoadServer: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdPurgeClick(Sender: TObject);
    procedure cmdBackupClick(Sender: TObject);
    procedure tmrbackupTimer(Sender: TObject);
    procedure cmdLoadServerClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure purge;
    procedure backup;
  end;

var
  frmBackupPurge: TfrmBackupPurge;

implementation

uses pmScriptWaveShare,
     pmScriptWaveShareVariable,
     pmVariablesConstants,
     pmScriptWaveFTP_II,
     pmScriptWave_mudCryptor,
     pmutilities;

{$R *.DFM}

procedure TfrmBackupPurge.FormCreate(Sender: TObject);
begin
comScriptWaveComm:= tcomScriptWaveCommunicator.create;
barTransmitS:= barTransmit;
{Session Sepcific code}
vstrSessionType:= 'Admin';
{---------------------}
comScriptWaveComm.setup;
vstrTranscriptionistID:= 'A001';
pmScriptWaveFTP_II.vstrFTPBase := '/ScriptWave/A001/';
forcedirectories('.\TEMP');
comScriptWaveComm.DirectoryListFTP('');
end;

procedure TfrmBackupPurge.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
comScriptWaveComm.shutdown;
comScriptWaveComm.free;
end;

procedure TfrmBackupPurge.cmdBackupClick(Sender: TObject);
begin
tmrBackup.enabled:= false;
try
//vstrIP:= 'www.mudsox.com';
vstrIP:= '192.168.0.52';
vbolEmergencyNow:= true;
//memLog.lines.clear;
memLog.lines.add(timetostr(now) + ' Attempting to Backup Only connect');
If comScriptWaveComm.InitializeFTP then
  begin
  memLog.lines.add(timetostr(now) + ' Connected');
  Backup;
  end
else
  memLog.lines.add(timetostr(now) + ' Connection Failed');

comScriptWaveComm.ShutdownFTP;
memLog.lines.add(timetostr(now) + ' Complete');
finally
   tmrBackup.enabled:= true;
   end;
end;

procedure TfrmBackupPurge.cmdPurgeClick(Sender: TObject);
begin
tmrBackup.enabled:= false;
try
//vstrIP:= 'www.mudsox.com';
vstrIP:= '192.168.0.52';
vbolEmergencyNow:= true;
//memLog.lines.clear;
memLog.lines.add(timetostr(now) + ' Attempting to Purge Only connect');
If comScriptWaveComm.InitializeFTP then
  begin
  memLog.lines.add(timetostr(now) + ' Connected');
  Purge;
  end
else
  memLog.lines.add(timetostr(now) + ' Connection Failed');

comScriptWaveComm.ShutdownFTP;
memLog.lines.add(timetostr(now) + ' Complete');
finally
   tmrBackup.enabled:= true;
   end;
end;

procedure tfrmBackupPurge.backup;
var
  vintLoop, vintLoop2: integer;
  vstrWork: string;
  vbolDelete: boolean;
begin
{BACKUP}
memLog.lines.add(timetostr(now) + ' Backup Start');
if comScriptWaveComm.DirectoryListFTP('') then
   begin
   for vintLoop := 0 to vstlDir.count - 1 do
     begin
     vstrWork:= copy(vstlDir[vintLoop], cintFTPDirOffset,999);
     If length(vstrWork) > 8 then
      If not fileexists('.\BACKUP\'+ vstrWork) then
       begin
       If comScriptWaveComm.GetFile('.\TEMP\'+ vstrWork,
                            '',strtoint(trim(copy(vstlDir[vintLoop],1,8)))) then
         begin
         copyfile(pchar('.\TEMP\'+vstrWork),pchar('.\BACKUP\'+vstrWork),false);
         memLog.Lines.Add(vstrWork);
         end
       else
         memLog.Lines.Add('Cannot Get: ' + vstrWork);
       deletefile('.\TEMP\'+ vstrWork);
       end;
     application.processmessages;
     end;
   lstFiles.directory:= vstrAppBaseFolder + 'BACKUP';
   for vintLoop2 := 0 to lstFiles.Items.Count - 1 do
     begin
     vbolDelete:= true;
     for vintLoop := 0 to vstlDir.count - 1 do
       begin
       vstrWork:= copy(vstlDir[vintLoop], cintFTPDirOffset,999);
       If vstrWork = lstFiles.Items[vintLoop2] then
         vbolDelete:= false;
       end;
     If vbolDelete then
       begin
       memLog.Lines.Add('Delete ' + lstFiles.Items[vintLoop2]);
       deletefile(vstrAppBaseFolder + 'BACKUP\' +  lstFiles.Items[vintLoop2]);
       end;
     application.processmessages;
     end;
   lstFiles.directory:= vstrAppBaseFolder;
   end;
{DONE BACKUP}
end;

procedure tfrmBackupPurge.purge;
var vstlWork: tstringlist;
    vintLoop, vintLoop2, vintPurgeDate: integer;
    vstrWork, vstrWorkDate: string;
begin
memLog.lines.add(timetostr(now) + ' Purge Start');
vstlWork := tstringlist.create;
comScriptWaveComm.DirectoryListFTP('');
try
If comScriptWaveComm.DirectoryListFTP('') then
   begin
   vintPurgeDate:= round(date - 7);
   memLog.lines.add('Finding qualifying control files');
   for vintLoop := 0 to vstlDir.count - 1 do
     begin
     vstrWork:= copy(vstlDir[vintLoop], cintFTPDirOffset,999);
     vstrWorkDate:= copy(vstrWork,length(vstrWork)-11,8);
     If (copy(vstrWork,1,2) = 'C_') and
        (vstrWorkDate <> '00000000') and
        (vintPurgeDate > strtodatetime(copy(vstrWorkDate,5,2) + '/' +
                                       copy(vstrWorkDate,7,2) + '/' +
                                       copy(vstrWorkDate,1,4))) then
           vstlWork.Add(copy(vstrWork,3,pos('.',vstrWork) - 3));
     end;
   {Select files to be purged}
   for vintLoop := 0 to vstlDir.count - 1 do
     begin
     vstrWork:= copy(vstlDir[vintLoop], cintFTPDirOffset,999);
     for vintLoop2 := 0 to vstlWork.count - 1 do
        If pos(vstlWork[vintLoop2], vstrWork) > 0 then
            begin
            comScriptWaveComm.DeleteFTPFile(vstrWork, '');
            memLog.lines.add('Delete: ' + vstrWork);
            end;
     end;
   {Purge large dictation files as soon as they are "Typed"}
   memLog.lines.add('Finding typed dictation files');
   vstlWork.clear;
   for vintLoop := 0 to vstlDir.count - 1 do
     begin
     vstrWork:= copy(vstlDir[vintLoop], cintFTPDirOffset,999);
     vstrWorkDate:= copy(vstrWork,length(vstrWork)-29,8);
     If (copy(vstrWork,1,2) = 'C_') and
        (vstrWorkDate <> '00000000') then
         vstlWork.Add(copy(vstrWork,3,pos('.',vstrWork) + 1));
     end;
   {Select files to be purged}
   for vintLoop := 0 to vstlDir.count - 1 do
     begin
     vstrWork:= copy(vstlDir[vintLoop], cintFTPDirOffset,999);
     for vintLoop2 := 0 to vstlWork.count - 1 do
        If vstlWork[vintLoop2] + '_cry' = vstrWork then
            begin
            {---------------------------------------------------------------}
            comScriptWaveComm.DeleteFTPFile(vstrWork, '');
            {---------------------------------------------------------------}
            memLog.lines.add('Delete: ' + vstrWork);
            end;
     end;
   end;
   {Purge all received Messages}
If comScriptWaveComm.DirectoryListFTP('Messages') then
   begin
   memLog.lines.add('Finding qualifying Messages files');
   {Select files to be purged}
   for vintLoop := 0 to vstlDir.count - 1 do
     begin
     vstrWork:= copy(vstlDir[vintLoop], cintFTPDirOffset,999);
     If copy(vstrWork,1,8) = 'Received' then
        begin
        comScriptWaveComm.DeleteFTPFile(vstrWork, 'Messages');
        memLog.lines.add('Deleted: ' + vstrWork);
        end;
     end;
   end;
   {Purge all received FTP}
If comScriptWaveComm.DirectoryListFTP('FTP') then
   begin
   memLog.lines.add('Finding qualifying FTP files');
   {Select files to be purged}
   for vintLoop := 0 to vstlDir.count - 1 do
     begin
     vstrWork:= copy(vstlDir[vintLoop], cintFTPDirOffset,999);
     If copy(vstrWork,1,8) = 'Received' then
        begin
        comScriptWaveComm.DeleteFTPFile(vstrWork, 'FTP');
        memLog.lines.add('Delete: ' + vstrWork);
        end;
     end;
   end;
finally
  vstlWork.free;
  end;
end;


procedure TfrmBackupPurge.tmrbackupTimer(Sender: TObject);
begin
cmdbackupclick(Self);
//cmdLoadServerClick(Self);
end;

procedure TfrmBackupPurge.cmdLoadServerClick(Sender: TObject);
var
  vintLoop, vintLoop2: integer;
  vstrWork: string;
  vbolDelete: boolean;
begin
tmrBackup.enabled:= false;
try
{Load Server}
memLog.lines.add(timetostr(now) + ' Load Backup Server Start');
comScriptWaveComm.LoadEmergency;
//vstrIP:=vstrEmergencyIP;
vstrIP:='192.168.0.52';
vbolEmergencyNow:= true;
If comScriptWaveComm.InitializeFTP then
 if comScriptWaveComm.DirectoryListFTP('') then
   begin
   for vintLoop := 0 to vstlDir.count - 1 do
     begin
     vstrWork:= copy(vstlDir[vintLoop], cintFTPDirOffset,999);
     If (length(vstrWork) > 8) and (vstrWork <> 'emergency.no') and
                                              (vstrWork <> 'emergency.yes') then
      If not fileexists('.\BACKUP\'+ vstrWork) then
       begin
       If comScriptWaveComm.DeleteFTPFile(vstrWork,'') then
         memLog.Lines.Add('Delete: ' + vstrWork)
       else
         memLog.Lines.Add('Cannot Delete: ' + vstrWork);
       end;
     application.processmessages;
     end;
  lstFiles.directory:= vstrAppBaseFolder + 'BACKUP';
   for vintLoop2 := 0 to lstFiles.Items.Count - 1 do
     begin
     vbolDelete:= true;
     for vintLoop := 0 to vstlDir.count - 1 do
       begin
       vstrWork:= copy(vstlDir[vintLoop], cintFTPDirOffset,999);
       If vstrWork = lstFiles.Items[vintLoop2] then
         vbolDelete:= false;
       end;
     If vbolDelete then
       begin
       If comScriptWaveComm.SendFile(vstrAppBaseFolder + 'BACKUP\' +
                                             lstFiles.Items[vintLoop2], '') then
         memLog.Lines.Add(lstFiles.Items[vintLoop2])
       else
         memLog.Lines.Add('Count not send: ' + lstFiles.Items[vintLoop2]);
//       deletefile(vstrAppBaseFolder + 'BACKUP\' +  lstFiles.Items[vintLoop2]);
       end;
     application.processmessages;
     end;
   lstFiles.directory:= vstrAppBaseFolder;
   end;
comScriptWaveComm.ShutdownFTP;
memLog.Lines.Add(timetostr(now) + ' Complete Backup Load');
{DONE BACKUP}
finally
   tmrBackup.enabled:= true;
   end;
end;

end.
