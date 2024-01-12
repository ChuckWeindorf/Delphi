unit pmScriptWaveShare;

interface
uses classes, StdCtrls, inifiles,
     pmScriptWaveFTP_II,
     pmVariablesConstants,
     pmScriptWave_mudCryptor;

Type tcomScriptWaveCommunicator = class(Tobject)
private
 Procedure PurgeLocalFiles(const cstrFilter: string;
                           const cintWeeks: integer;
                           const cstrFolder: string);
 Procedure PurgeMasterControl;

 public
 iniFileControl: tmeminifile;
 iniPreferences: tinifile;
 vstlSearchIni: tstringlist;
 vstlEntity: tstringlist;
 vstlOfficeDocs: tstringlist;

 vstrCurrentFile: string;
 vstrFileImport: string;
 vstrFileTransmit: string;
 vstrFileReceived: string;
 vstrFileAssigned: string;
 vstrFileTyped: string;
 vstrFileReviewed: string;
 vstrFileComplete: string;
 vstrFileImportT: string;
 vstrFileTransmitT: string;
 vstrFileReceivedT: string;
 vstrFileAssignedT: string;
 vstrFileTypedT: string;
 vstrFileReviewedT: string;
 vstrFileCompleteT: string;
 vstrFileAssignedTo: string;
 vstrFileComments: string;
 vstrFileSize: string;
 varrAttachedFiles: array [1..2, 1..50] of string;

 vreaLastTime: real;

 vstrMonth: string;
 vstrDay: string;
 vstrYear: string;

 procedure Setup;
 procedure SmallSetup;
 procedure Shutdown;
 procedure ShutdownFTP;
 {------------------------------------------------------------------}
 function Crypt_Transmit(const cstrFile: string;
                         const cstrFTPFolder: string): boolean;
 function Receive_Uncrypt(const cstrFile: string;
                          const cintFileSize: integer;
                          const cstrFTPFolder: string): boolean;
 {-----------------------------------------------------------------}
 function InitializeFTP: boolean;
 function SendFile(const cstrFile: string;
                   const cstrFTPFolder: string): boolean;
 function GetFile(const cstrFile: string;
                  const cstrFTPFolder: string;
                  const cintFileSize: longint): boolean;
 function DirectoryListFTP(const cstrFolder: string): boolean;
 function DirectoryPulseFTP(const cstrFolder: string): boolean;
 function DirectoryCreateFTP(const cstrFolder: string): boolean;
 function RenameFile(const cstrFileOld: string;
                     const cstrFileNew: string;
                     const cstrFTPFolder: string):boolean;
 function DeleteFTPFile(const cstrFile: string;
                     const cstrFTPFolder: string): boolean;
 function SendPulse(const cstrID: string;
                    const cbolAdmin: boolean): boolean;
 {------------------------------------------------------------------}
 function InifilesWriteDetail(const cbolComment:boolean): boolean;
 procedure InifilesWriteOne(const cstrKey: string;
                            const cstrVal: string);
 function InifilesReadOne(const cstrKey: string): string;
 procedure InifilesLoadDetail;
 procedure IniFiles_UpdateFile_Override;
 {------------------------------------------------------------------}
 procedure LoadDefaults;
 procedure SaveDefaults;
 {------------------------------------------------------------------}
 procedure GetAccountFile(const cstrFile: string);
 procedure SaveAccountFile;
 {------------------------------------------------------------------}
 function LoadEntityList(const cstrListType: string): string;
 function GetEntityName(const cstrEntity: string): string;
 {------------------------------------------------------------------}
 procedure UpdateFileStatus(const cstrControl: string);
 {------------------------------------------------------------------}
 procedure ArchiveCompleteFiles;
 procedure LoadArchiveMonths(var vstlItems: tcombobox);
 procedure PurgeController;
 {------------------------------------------------------------------}
 procedure SearchInFiles(const cstrWord: string;
                         const cstrMask: string;
                         var vlstBox: tlistbox;
                         var vedtCount: tedit);
 function ScanFile(const FileName: string;
                   const forString: string): boolean;
 procedure SaveEmergency(const cstrIP: string);
 procedure LoadEmergency;
 procedure DownloadEmergencyIP;
 procedure CheckToUseEmergency;
// function TransferServer: boolean;
 function FileLastModified(const TheFile: string): string;
 end;

implementation
uses Windows, forms, sysutils, comctrls, filectrl,
     dialogs, pmUtilities;

procedure tcomScriptWaveCommunicator.Setup;
begin
vstlDir:= tstringlist.create();
vstlDirDateStamp:= tstringlist.create();
vstlSearchIni:= tstringlist.create();
vstrAppBaseFolder := extractfilepath(Application.ExeName);
if copy(vstrAppBaseFolder,length(vstrAppbaseFolder),1) <> '\' then
      vstrAppBaseFolder:= vstrAppBaseFolder + '\';
mudCryptorSetup;
iniFileControl:=
            tmeminifile.create(vstrAppBaseFolder + 'ScriptWaveFileControl.ini');
iniFileControl.WriteString('Startup','DateTime',datetimetostr(now));
try
iniFileControl.UpdateFile;
  except
  IniFiles_UpdateFile_Override;
  end;
iniPreferences:= tinifile.create(vstrAppBaseFolder+'ScriptWavePreferences.ini');
LoadDefaults;
If vstrSessionType = 'Office' then
   begin
   vstlOfficeDocs:= tstringList.create();
   end;
GetAccountFile(vstrAppBaseFolder + 'ScriptWaveAccount_'
                                          + copy(vstrSessionType,1,1) + '.cry');
vstrMasterDoc:= vstrAppBaseFolder + 'MasterDoc\';
vstrMessages:= vstrAppBaseFolder + 'Messages\';
vstrFTP:= vstrAppBaseFolder + 'FTP\';
vstrArchive:= vstrAppBaseFolder + 'Archive\';

if (vstrSessionType = 'Typist') or
   (vstrSessionType = 'Physician') or
   (vstrSessionType = 'Office') then
   begin
   ForceDirectories(vstrMasterDoc);
   ForceDirectories(vstrTransmitFolder);
   ForceDirectories(vstrReceiveFolder);
   ForceDirectories(vstrMessages);
   ForceDirectories(vstrFTP);
   ForceDirectories(vstrArchive);
   end;
If vstrSessionType = 'Typist' then
   begin
   vstlEntity:= tstringList.create();
   vstlEntity.loadfromfile(vstrAppBaseFolder + 'ScriptWaveEntity.txt');
   end;

vstrMonth := FormatDateTime('mm', date);
vstrDay := FormatDateTime('dd', date);
vstrYear := FormatDateTime('yyyy', date);
vreaLastTime:= now;
vbolFTP:= false;
ThreadFTPsetup;
end;

procedure tcomScriptWaveCommunicator.SmallSetup;
begin
vstlDir:= tstringlist.create();
vstlDirDateStamp:= tstringlist.create();
vstlSearchIni:= tstringlist.create();
mudCryptorSetup;
ThreadFTPsetup;
end;

procedure tcomScriptWaveCommunicator.ShutdownFTP;
begin
vstrFTPaction := 'Shutdown';
CallFTPUntilAnswer;
end;

procedure tcomScriptWaveCommunicator.shutdown;
begin
SaveDefaults;
mudCryptorShutdown;

If ftpThreadTransfer <> nil then
   begin
   ShutdownFTP;
   ftpThreadTransfer.free;
   ftpThreadTransfer:= nil;
   end;
   
vstlDir.free;
vstlDir:= nil;

vstlDirDateStamp.free;
vstlDirDateStamp:= nil;

iniFileControl.free;
iniPreferences.free;
vstlSearchIni.free;
vstlEntity.free;
vstlOfficeDocs.free;
end;

{------------------------------------------------------------------------------}
{Encrypt and Transmit a file}
function tcomScriptWaveCommunicator.Crypt_Transmit(const cstrFile: string;
                                           const cstrFTPFolder: string):boolean;
begin
try
Result:= CryptorFile(cstrFile, cstrFile + '_cry');
If not Result then
  begin
  Logit('Unable to encrypt file: ' + cstrFile);
  exit;
  end;
Result:= SendFile(cstrFile + '_cry', cstrFTPFolder);
If Result then
  begin
  deletefile(cstrFile + '_cry');
  Logit('Transmitted file: ' + cstrFile);
  end;
except
  result := false;
  end;
end;

{Receive Unencrypt}
function tcomScriptWaveCommunicator.Receive_UnCrypt(const cstrFile: string;
                                        const cintFileSize: integer;
                                        const cstrFTPFolder: string): boolean;
begin
try
Result:= InitializeFTP;
If Result then
  Result:= GetFile(cstrFile, cstrFTPFolder, cintFileSize);
If Result then
  begin
  UnCryptorFile(copy(cstrFile, 1, length(cstrFile)-4),cstrFile);
  deletefile(cstrFile);
  Logit('Received file: ' + cstrFile);
  end;
except
  result := false;
  end;
end;

{------------------------------------------------------------------------------}

procedure tcomScriptWaveCommunicator.LoadDefaults;
begin
vstrTransmitFolder:= iniPreferences.ReadString('Preferences', 'TransmitFolder',
                                      vstrAppBaseFolder + 'Dictation\');
vstrReceiveFolder:= iniPreferences.ReadString('Preferences', 'ReceiveFolder',
                                  vstrAppBaseFolder + 'Transcription\');
vstrAudioPlayer:= iniPreferences.ReadString('Preferences', 'AudioPlayer',
                                  'c:\program files\gearplayer\gearplayer.exe');
vstrReceiveFolder:= iniPreferences.ReadString('Preferences', 'ReceiveFolder',
                                  vstrAppBaseFolder + 'Transcription\');
vbolAutomatic:= iniPreferences.ReadBool('Preferences', 'AutomaticComm', true);
vbolDeleteImport:= iniPreferences.ReadBool
                                         ('Preferences', 'DeleteImport', false);
vbolRenameImport:= iniPreferences.ReadBool
                                          ('Preferences', 'RenameImport', true);
vbolPurge:= iniPreferences.ReadBool('Preferences', 'PurgeOn', false);
vstrPurgeMaster:= iniPreferences.ReadString('Preferences', 'PurgeMastDoc',
                                                                       'Never');
vstrPurgeImport:= iniPreferences.ReadString('Preferences', 'PurgeImport',
                                                                       'Never');
vstrPurgeTranscription:= iniPreferences.ReadString
                                 ('Preferences', 'PurgeTranscription', 'Never');
if copy(vstrTransmitFolder,length(vstrTransmitFolder),1) <> '\' then
      vstrTransmitFolder:= vstrTransmitFolder + '\';
if copy(vstrReceiveFolder,length(vstrReceiveFolder),1) <> '\' then
      vstrReceiveFolder:= vstrReceiveFolder + '\';
vstrLastImport:= iniPreferences.ReadString
                  ('Preferences', 'LastImport', datetostr(now));
vintLastImportSeq:= iniPreferences.ReadInteger
                  ('Preferences', 'LastImportSeq', 0);
vbolAutoPrint:= iniPreferences.ReadBool('Preferences', 'AutoPrint', false);
vstrPrintCommand:= iniPreferences.ReadString('Preferences', 'PrintCommand',
   '"C:\Program Files\Microsoft Office\Office\WINWORD.EXE"');
vstrPrintParameter:= iniPreferences.ReadString('Preferences', 'PrintParameter',
   '/mScriptWave');
end;

procedure tcomScriptWaveCommunicator.SaveDefaults;
begin
iniPreferences.WriteString('Preferences', 'TransmitFolder', vstrTransmitFolder);
iniPreferences.WriteString('Preferences', 'ReceiveFolder', vstrReceiveFolder);
iniPreferences.WriteString('Preferences', 'AudioPlayer', vstrAudioPlayer);
iniPreferences.WriteBool('Preferences', 'AutomaticComm', vbolAutomatic);
iniPreferences.WriteBool('Preferences', 'AutoPrint', vbolAutoPrint);
iniPreferences.WriteBool('Preferences', 'DeleteImport', vbolDeleteImport);
iniPreferences.WriteBool('Preferences', 'RenameImport', vbolRenameImport);
iniPreferences.WriteBool('Preferences', 'PurgeOn', vbolPurge);
iniPreferences.WriteString('Preferences', 'PurgeMastDoc', vstrPurgeMaster);
iniPreferences.WriteString('Preferences', 'PurgeImport', vstrPurgeImport);
iniPreferences.WriteString
                  ('Preferences', 'PurgeTranscription', vstrPurgeTranscription);
iniPreferences.WriteString
                  ('Preferences', 'LastImport', vstrLastImport);
iniPreferences.WriteString
                  ('Preferences', 'PrintCommand', vstrPrintCommand);
iniPreferences.WriteString
                  ('Preferences', 'PrintParameter', vstrPrintParameter);
iniPreferences.WriteInteger
                  ('Preferences', 'LastImportSeq', vintLastImportSeq);
end;

{------------------------------------------------------------------------------}
function tcomScriptWaveCommunicator.InitializeFTP: boolean;
begin
try
vstrFTPAction := 'Initialize';
CallFTPUntilAnswer;
Result := vbolActionResult;
except
  Result:= false;
  Logit('Failure in InitializeFTP');
  end;
end;

function tcomScriptWaveCommunicator.DirectoryPulseFTP
                                            (const cstrFolder: string): boolean;
begin
try
vstrFTPAction := 'Pulse';
vstrFTPfolder:= cstrFolder;
CallFTPUntilAnswer;
Result := vbolActionResult;
except
  Result:= false;
  Logit('Failure in DirectoryPulseFTP');
  end;
end;

function tcomScriptWaveCommunicator.DirectoryListFTP
                                            (const cstrFolder: string): boolean;
begin
try
vstrFTPAction := 'Directory';
vstrFTPfolder:= cstrFolder;
CallFTPUntilAnswer;
Result := vbolActionResult;
except
  Result:= false;
  Logit('Failure in DirectoryListFTP folder ' + cstrFolder);
  end;
end;

function tcomScriptWaveCommunicator.DirectoryCreateFTP
                                            (const cstrFolder: string): boolean;
begin
try
vstrFTPAction := 'CreateDirectory';
vstrFTPfolder:= cstrFolder;
CallFTPUntilAnswer;
Result := vbolActionResult;
except
  Result:= false;
  Logit('Failure in DirectoryCreateFTP');
  end;
end;

function tcomScriptWaveCommunicator.SendFile(const cstrFile: string;
                                          const cstrFTPFolder: string): boolean;
begin
try
vstrFTPAction := 'Send';
vstrFTPFile:= cstrFile;
vstrFTPfolder:= cstrFTPfolder;
CallFTPUntilAnswer;
Result := vbolActionResult;
except
  Result:= false;
  Logit('Failure in SendFile');
  end;
end;

function tcomScriptWaveCommunicator.RenameFile(const cstrFileOld: string;
                                           const cstrFileNew: string;
                                          const cstrFTPFolder: string): boolean;
begin
try
vstrFTPAction := 'Rename';
vstrFTPFile:= cstrFileNew;
vstrFTPFileOld:= cstrFileOld;
vstrFTPfolder:= cstrFTPfolder;
CallFTPUntilAnswer;
Result := vbolActionResult;
except
  Result:= false;
  Logit('Failure in RenameFile');
  end;
end;

function tcomScriptWaveCommunicator.DeleteFTPFile(const cstrFile: string;
                                          const cstrFTPFolder: string): boolean;
begin
try
vstrFTPAction := 'Delete';
vstrFTPFile:= cstrFile;
vstrFTPfolder:= cstrFTPfolder;
CallFTPUntilAnswer;
Result := vbolActionResult;
except
  Result:= false;
  Logit('Failure in DeleteFTPfile');
  end;
end;

function tcomScriptWaveCommunicator.GetFile(const cstrFile: string;
                                         const cstrFTPFolder: string;
                                         const cintFileSize: longint): boolean;
begin
try
vstrFTPAction := 'Get';
vstrFTPFile:= cstrFile;
vstrFTPfolder:= cstrFTPfolder;
vintFTPFileSize:= cintFileSize;
CallFTPUntilAnswer;
Result := vbolActionResult;
except
  Result:= false;
  Logit('Failure in GetFile');
  end;
end;

{------------------------------------------------------------------------------}
{Send a file to the Pulse folder on the server to let another workstation to
know to communicate immediately}
function tcomScriptWaveCommunicator.SendPulse(const cstrID: string;
                                             const cbolAdmin: boolean): boolean;
  var vstlFile, vstlAdmin: tstringlist;
      vintLoop: integer;
      vstrWork: string;
begin
Result:= true;
vstlFile:= tstringlist.Create;
vstlAdmin:= tstringlist.Create;
try
try
vstlFile.text:= ' ';
vstlFile.savetofile(vstrAppBaseFolder + cstrID + '.go');
sendfile(vstrAppBaseFolder + cstrID + '.go', 'Pulse');
deletefile(vstrAppBaseFolder + cstrID + '.go');
{Notify Admins when return doc to physician}
If cbolAdmin then
  begin
  vstlAdmin.loadfromfile(vstrAppBaseFolder + 'NotifyRules.txt');
  for vintLoop:= 0 to vstlAdmin.count - 1 do
    If pos(cstrID, vstlAdmin[vintLoop]) > 0 then
       begin
       vstrWork:= copy(vstlAdmin[vintLoop],pos('=',vstlAdmin[vintLoop])+1,4);
       vstlFile.savetofile(vstrAppBaseFolder + vstrWork + '.go');
       sendfile(vstrAppBaseFolder + vstrWork + '.go', 'Pulse');
       deletefile(vstrAppBaseFolder + vstrWork + '.go');
       end;
  end;
except
  Result:= false;
  end;
finally
  vstlFile.Free;
  vstlAdmin.Free;
  end;
end;

{------------------------------------------------------------------------------}
{INIFILES routines}

procedure tcomScriptWaveCommunicator.InifilesWriteOne(const cstrKey: string;
                                                  const cstrVal: string);
begin
iniFileControl.WriteString(vstrCurrentFile, cstrKey, cstrVal);
try
iniFileControl.UpdateFile;
  except
  IniFiles_UpdateFile_Override;
  end;
end;

function tcomScriptWaveCommunicator.InifilesReadOne(const cstrKey: string): string;
begin
Result:= iniFileControl.ReadString(vstrCurrentFile, cstrKey, '00000000');
end;

procedure tcomScriptWaveCommunicator.UpdateFileStatus(const cstrControl: string);
var vintDecimal, vintLoop: integer;
    vstrRemainder: string;
begin
for vintLoop := 1 to 50 do
  begin
  varrAttachedFiles[1, vintLoop]:= '';
  varrAttachedFiles[2, vintLoop]:= '';
  end;
vintDecimal:= pos('.',cstrControl);
vstrCurrentFile:= copy(cstrControl,1,vintDecimal + 3);
InifilesLoadDetail;
vstrRemainder:= copy(cstrControl,vintDecimal + 10,999);
vstrFileAssignedTo:= copy(cstrControl,vintDecimal + 5, 4);
If copy(vstrFileAssignedTo,1,1) = 'A' then
   vstrFileAssignedTo := '';
If vstrFileImport <> copy(vstrRemainder,1,8) then
   vstrFileImportT := FormatDateTime('hh:mm AM/PM',now);
vstrFileImport:= copy(vstrRemainder,1,8);
If vstrFileTransmit <> copy(vstrRemainder,10,8) then
   vstrFileTransmitT := FormatDateTime('hh:mm AM/PM',now);
vstrFileTransmit:= copy(vstrRemainder,10,8);
If vstrFileReceived <> copy(vstrRemainder,19,8) then
   vstrFileReceivedT := FormatDateTime('hh:mm AM/PM',now);
vstrFileReceived:= copy(vstrRemainder,19,8);
If vstrFileAssigned <> copy(vstrRemainder,28,8) then
   vstrFileAssignedT := FormatDateTime('hh:mm AM/PM',now);
vstrFileAssigned:= copy(vstrRemainder,28,8);
If vstrFileTyped <> copy(vstrRemainder,37,8) then
   vstrFileTypedT := FormatDateTime('hh:mm AM/PM',now);
vstrFileTyped:= copy(vstrRemainder,37,8);
If vstrFileReviewed <> copy(vstrRemainder,46,8) then
   vstrFileReviewedT := FormatDateTime('hh:mm AM/PM',now);
vstrFileReviewed:= copy(vstrRemainder,46,8);
If vstrFileComplete <> copy(vstrRemainder,55,8) then
   vstrFileCompleteT := FormatDateTime('hh:mm AM/PM',now);
vstrFileComplete:= copy(vstrRemainder,55,8);
InifilesWriteDetail(false);
end;

function tcomScriptWaveCommunicator.InifilesWriteDetail
                                           (const cbolComment:boolean): boolean;
var vintLoop: integer;
begin
Result:= true;
iniFileControl.WriteString(vstrCurrentFile, 'ImportDate', vstrFileImport);
iniFileControl.WriteString(vstrCurrentFile, 'TransmitDate', vstrFileTransmit);
iniFileControl.WriteString(vstrCurrentFile, 'ReceiveDate', vstrFileReceived);
iniFileControl.WriteString(vstrCurrentFile, 'AssignDate', vstrFileAssigned);
iniFileControl.WriteString(vstrCurrentFile, 'TypedDate', vstrFileTyped);
iniFileControl.WriteString(vstrCurrentFile, 'ReviewedDate', vstrFileReviewed);
iniFileControl.WriteString(vstrCurrentFile, 'CompleteDate', vstrFileComplete);
iniFileControl.WriteString(vstrCurrentFile, 'AssignedTo', vstrFileAssignedTo);
iniFileControl.WriteString(vstrCurrentFile, 'ImportDateT', vstrFileImportT);
iniFileControl.WriteString(vstrCurrentFile, 'TransmitDateT', vstrFileTransmitT);
iniFileControl.WriteString(vstrCurrentFile, 'ReceiveDateT', vstrFileReceivedT);
iniFileControl.WriteString(vstrCurrentFile, 'AssignDateT', vstrFileAssignedT);
iniFileControl.WriteString(vstrCurrentFile, 'TypedDateT', vstrFileTypedT);
iniFileControl.WriteString(vstrCurrentFile, 'ReviewedDateT', vstrFileReviewedT);
iniFileControl.WriteString(vstrCurrentFile, 'CompleteDateT', vstrFileCompleteT);
iniFileControl.WriteString(vstrCurrentFile, 'FileSize', vstrFileSize);
If cbolComment then
    iniFileControl.WriteString(vstrCurrentFile, 'Comments', vstrFileComments);
for vintLoop := 1 to 50 do
   If varrAttachedFiles[1, vintLoop] > '  A' then
     begin
     iniFileControl.WriteString(vstrCurrentFile,
                                'T' + format('%.2d', [vintLoop]),
                                varrAttachedFiles[1, vintLoop]);
     iniFileControl.WriteString(vstrCurrentFile,
                                'T' + format('%.2d', [vintLoop] ) + 'A',
                                varrAttachedFiles[2, vintLoop]);
     end;
try
iniFileControl.UpdateFile;
  except
  IniFiles_UpdateFile_Override;
  Result:= false;
  end;
end;

procedure tcomScriptWaveCommunicator.InifilesLoadDetail;
var vstlTemp: tstringlist;
    vintLoop: integer;
  Function GetIt(const cstrKey: string): string;
    var vintLoop2: integer;
        vbolFound: boolean;
    begin
    Result:= '';
    vbolFound:= false;
    for vintLoop2 := 0 to vstlTemp.count - 1 do
       If copy(vstlTemp[vintLoop2],1,length(cstrKey) + 1) = cstrKey + '=' then
          begin
          vbolFound := true;
          break;
          end;
    If vbolFound then
       Result := trim(copy(vstlTemp[vintLoop2],length(cstrKey) + 2,999))
    else
    If pos('DateT', cstrKey) > 0 then
       Result := '12:00 AM'
    else
    If pos('DateT', cstrKey) > 0 then
       Result := '00000000';
    end;
begin
vstlTemp:= tstringlist.create;
try
iniFileControl.ReadSectionValues(vstrCurrentFile, vstlTemp);
vstrFileImport:= GetIt('ImportDate');
vstrFileTransmit:= GetIt('TransmitDate');
vstrFileReceived:= GetIt('ReceiveDate');
vstrFileAssigned:=GetIt('AssignDate');
vstrFileTyped:=GetIt('TypedDate');
vstrFileReviewed:=GetIt('ReviewedDate');
vstrFileComplete:=GetIt('CompleteDate');
vstrFileImportT:=GetIt('ImportDateT');
vstrFileTransmitT:=GetIt('TransmitDateT');
vstrFileReceivedT:=GetIt('ReceiveDateT');
vstrFileAssignedT:=GetIt('AssignDateT');
vstrFileTypedT:=GetIt('TypedDateT');
vstrFileReviewedT:=GetIt('ReviewedDateT');
vstrFileCompleteT:=GetIt('CompleteDateT');
vstrFileAssignedTo:=GetIt('AssignedTo');
vstrFileSize:=GetIt('FileSize');
vstrFileComments:=GetIt('Comments');
for vintLoop := 1 to 50 do
 begin
 varrAttachedFiles[1, vintLoop] :=GetIt('T' + format('%.2d', [vintLoop]));
 varrAttachedFiles[2, vintLoop] :=GetIt('T' + format('%.2d', [vintLoop]) + 'A');
 end;
finally
 vstlTemp.free;
 end;
end;

{For XP Pro fail on UpdateFile, attempt to write the file through a stringlist}
procedure tcomScriptWaveCommunicator.IniFiles_UpdateFile_Override;
  var vstlT: tstringlist;
begin
{---------------------------}
Logit('ERROR: unable to save iniFileControl');
exit;
{---------------------------}
vstlT := tstringlist.create;
try
try
iniFileControl.getstrings(vstlT);
copyfile(Pchar(vstrAppBaseFolder + 'ScriptWaveFileControl.ini'),
         Pchar(vstrAppBaseFolder + 'ScriptWaveFileControl.bak'),false);
deletefile(vstrAppBaseFolder + 'ScriptWaveFileControl.ini');
vstlT.SavetoFile(vstrAppBaseFolder + 'ScriptWaveFileControl.ini');
except
    Showmessage('Warning: unable to save iniFileControl second time');
    end;
finally
  vstlT.free;
  end;

end;

{-----------------------------------------------------------------------------}
{Account information descramble and apply}
procedure tComScriptWaveCommunicator.GetAccountFile(const cstrFile: string);
var vstrString, vstrWork: string;
    vstlFile: tstringlist;
begin
vstlFile:= tstringlist.create;
try
vstrConfigFile:= cstrFile;
vstlFile.loadfromfile(cstrFile);
vstrString:= uncryptorstring(vstlFile[0]);
vstrIP:= trim(copy(vstrString,1,30));
vstrLogin:= trim(copy(vstrString,31,20));
//vstrPassword:= trim(copy(vstrString,51,20));
vstrTranscriptionist:= trim(copy(vstrString,71,40));
vstrTranscriptionistID:= trim(copy(vstrString,111,10));
If (vstrSessionType = 'Physician') or (vstrSessionType = 'Office') then
  begin
  vstrPhysician:= trim(copy(vstrString,121,40));
  vstrPhysicianID:= trim(copy(vstrString,161,10));
  end
else
 begin
  vstrTypist:= trim(copy(vstrString,121,40));
  vstrTypistID:= trim(copy(vstrString,161,10));
 end;
If vstrSessionType = 'Office' then
  begin
  vstrWork:= trim(copy(vstrString,171,100));
  while vstrWork > '  A' do
     begin
     vstlOfficeDocs.add(copy(vstrWork,1,4));
     vstrWork:= copy(vstrWork,5,100);
     end;
  end;
finally
  vstlFile.free;
  end;
end;

procedure tComScriptWaveCommunicator.SaveAccountFile;
var vstrString: string;
    vstlFile: tstringlist;
    vstrWork: string;
begin
vstlFile:= tstringlist.create;
try
vstrString:= format('%-30s',[vstrIP]);
vstrString:= vstrString + format('%-20s',[vstrLogin]);
vstrString:= vstrString + format('%-20s',[vstrPassword]);
vstrString:= vstrString + format('%-40s',[vstrTranscriptionist]);
vstrString:= vstrString + format('%-10s',[vstrTranscriptionistID]);
If (vstrSessionType = 'Physician') or (vstrSessionType = 'Office') then
  begin
  vstrString:= vstrString + format('%-40s',[vstrPhysician]);
  vstrString:= vstrString + format('%-10s',[vstrPhysicianID]);
  end
else
  begin
  vstrString:= vstrString + format('%-40s',[vstrTypist]);
  vstrString:= vstrString + format('%-10s',[vstrTypistID]);
  end;
If vstrSessionType = 'Office' then
  begin
  vstrWork:= trim(vstlOfficeDocs.text);
  while pos(#13#10, vstrWork) > 0 do
     vstrWork:= copy(vstrWork,1,pos(#13#10, vstrWork)-1) +
                copy(vstrWork,pos(#13#10, vstrWork)+2,999);
  vstrString:= vstrString + format('%-100s',[vstrWork]);
  end;
{----------}
vstlFile.add(cryptorstring(vstrString));
vstlFile.Savetofile
(vstrAppBaseFolder + 'ScriptWaveAccount_' + copy(vstrSessionType,1,1) + '.cry');
finally
  vstlFile.free;
  end;
end;

{------------------------------------------------------------------------------}
function tComScriptWaveCommunicator.LoadEntityList
                                            (const cstrListType: string):string;
var vintLoop: integer;
begin
Result := '';
for vintLoop:= 0 to vstlEntity.Count - 1 do
   If ((cstrListType = 'Typist') and
      (copy(vstlEntity[vintLoop],1,1) = 'T')) or
      ( (cstrListType = 'Physician') and
        ((copy(vstlEntity[vintLoop],1,1) = 'P') or
         (copy(vstlEntity[vintLoop],1,1) = 'O')) ) or
      ( (cstrListType = 'Admin') and
        (copy(vstlEntity[vintLoop],1,1) = 'O') ) or
      ( (cstrListType = 'PhysicianOnly') and
        (copy(vstlEntity[vintLoop],1,1) = 'P') ) or
      (cstrListType = 'All') then
        If length(Result) > 0 then
           Result := Result + #13#10 + trim(vstlEntity[vintLoop])
        else
           Result := trim(vstlEntity[vintLoop]);
end;

function tComScriptWaveCommunicator.GetEntityName(const cstrEntity: string): string;
  var vintLoop: integer;
  begin
  Result := '';
  for vintLoop:= 0 to vstlEntity.Count - 1 do
    If copy(vstlEntity[vintLoop],1,4) = cstrEntity then
       begin
       Result:= vstlEntity[vintLoop];
       break;
       end;
  end;

procedure tComScriptWaveCommunicator.ArchiveCompleteFiles;
var vstlMast, vstlTemp, vstlArch: tstringlist;
    vbolComplete: boolean;
    vstrYearMon: string;
    vintLoop: integer;
    procedure LoadAndAddArchive;
       begin
       vstlArch.clear;
       If fileexists(vstrArchive + vstrYearMon + '.ini') then
             vstlArch.loadfromfile(vstrArchive + vstrYearMon + '.ini');
       If pos(vstlTemp[0], vstlArch.text) = 0 then
           begin
           vstlArch.add(vstlTemp.text);
           vstlArch.savetofile(vstrArchive + vstrYearMon + '.ini');
           end;
       end;
begin
vstlMast:= tstringlist.create;
vstlTemp:= tstringlist.create;
vstlArch:= tstringlist.create;
try
vbolComplete := false;
vstlMast.loadfromfile(vstrAppBaseFolder + 'ScriptWaveFileControl.ini');
If vstlMast.count = 0 then exit;
vstlTemp.add(vstlMast[0]);
for vintLoop:= 1 to vstlMast.count - 1 do
   begin
   If copy(vstlMast[vintLoop],1,1) = '[' then
     begin
     If (vstlTemp.count > 0) and vbolComplete then
        LoadAndAddArchive;
     vbolComplete := false;
     vstlTemp.clear;
     end
   else
   If (copy(vstlMast[vintLoop],1,13) = 'CompleteDate=')
      and (copy(vstlMast[vintLoop],14,8) <> '00000000') then
      begin
      vstrYearMon:= copy(vstlMast[vintLoop],14,6);
      vbolComplete:= true;
      end;
   vstlTemp.add(vstlMast[vintLoop]);
   end;
If (vstlTemp.count > 0) and vbolComplete then
   LoadAndAddArchive;
finally
  vstlMast.free;
  vstlTemp.free;
  vstlArch.free;
  end;
end;

Procedure tComScriptWaveCommunicator.LoadArchiveMonths(var vstlItems: tcombobox);
var
  vsrcIni: TSearchRec;
begin
  vstlItems.Items.Clear;
  if FindFirst(vstrArchive + '*.ini', faAnyFile, vsrcIni) = 0 then
     begin
     If length(vsrcIni.Name) > 6 then
        vstlItems.items.add
                        (copy(vsrcIni.Name,5,2) + '/' + copy(vsrcIni.Name,1,4));
      while FindNext(vsrcIni) = 0 do
        If length(vsrcIni.Name) > 6 then
           vstlItems.items.add
                        (copy(vsrcIni.Name,5,2) + '/' + copy(vsrcIni.Name,1,4));
     end;
  FindClose(vsrcIni);
end;
{------------------------------------------------------------------------------}

{--------------- Purge routine ---------------}
procedure tComScriptWaveCommunicator.PurgeController;
begin
If not vbolPurge then
  exit;
{Generic folder sweeps}
If (vstrPurgeImport <> 'Never') and (length(vstrPurgeImport) > 10) then
  PurgeLocalFiles('IMPORT*.*',
                  strtointdef(trim(copy(vstrPurgeImport,7,2)), 16),
                  vstrTransmitFolder);

If (vstrPurgeTranscription <> 'Never') and
                                      (length(vstrPurgeTranscription) > 10) then
  PurgeLocalFiles('*.doc',
                  strtointdef(trim(copy(vstrPurgeTranscription,7,2)), 16),
                  vstrReceiveFolder);
If (vstrPurgeMaster <> 'Never') then
  PurgeMasterControl;
{---------------------}
end;

Procedure tcomScriptWaveCommunicator.PurgeLocalFiles(const cstrFilter: string;
                                                 const cintWeeks: integer;
                                                 const cstrFolder: string);
var
  vsrcIni: TSearchRec;

  Procedure TestandDelete;
    begin
    If (vsrcIni.Attr and faDirectory > 0) then
    else
     If (now - FileDateToDateTime(vsrcIni.time)) > (cintWeeks * 7) then
        begin
        Logit('Purge old content: ' + cstrFolder + vsrcIni.name);
        deletefile(cstrFolder + vsrcIni.name);
        end;
    end;
begin
  if FindFirst(cstrFolder + cstrFilter, faAnyFile, vsrcIni) = 0 then
     begin
     TestandDelete;
      while FindNext(vsrcIni) = 0 do
        TestandDelete;
     end;
  FindClose(vsrcIni);
end;

{---------- Master and Control File Purge -----------}
Procedure tcomScriptWaveCommunicator.PurgeMasterControl;
var vstlPurgeList: tstringlist;
    vstrHoldFile: string;
    vintLoop: integer;
    vsrcIni: TSearchRec;
   Procedure TestandDelete;
      var vintLoop2: integer;
      begin
      If (vsrcIni.Attr and faDirectory > 0) then
      else
        for vintLoop2 := 0 to vstlPurgeList.count - 1 do
          If pos(copy(
                 vstlPurgeList[vintLoop2],1,length(vstlPurgeList[vintLoop2])-4),
                 vsrcIni.name) > 0 then
            begin
            Logit('Purge old content: ' + vstrMasterDoc + vsrcIni.name);
            deletefile(vstrMasterDoc + vsrcIni.name);
            end;
      end;
begin
vstlPurgeList:= tstringlist.create;
try
vstlSearchIni.loadfromfile(vstrAppBaseFolder + 'ScriptWaveFileControl.ini');
for vintLoop := 0 to vstlSearchIni.count - 1 do
   begin
   if (copy(vstlSearchIni[vintLoop],1,2) = '[P') or
      (copy(vstlSearchIni[vintLoop],1,2) = '[O')then
      vstrHoldFile := copy(vstlSearchIni[vintLoop],2,
                      length(vstlSearchIni[vintLoop])-2);
   if copy(vstlSearchIni[vintLoop],1,13) = 'CompleteDate=' then
     if copy(vstlSearchIni[vintLoop],14,8) <> '00000000' then
       {today - completed date > days in the master purge}
       if now - strtodatetime(copy(vstlSearchIni[vintLoop],18,2) + '/' +
                                 copy(vstlSearchIni[vintLoop],20,2) + '/' +
                                 copy(vstlSearchIni[vintLoop],14,4))
                   > (strtointdef(trim(copy(vstrPurgeMaster,7,2)), 26) * 7) then
           vstlPurgeList.add(vstrHoldFile);
   end;

{Use the temporary list to remove all similar files}
  if FindFirst(vstrMasterDoc + '*.*', faAnyFile, vsrcIni) = 0 then
     begin
     TestandDelete;
      while FindNext(vsrcIni) = 0 do
        TestandDelete;
     end;
  FindClose(vsrcIni);

{Finally, remove all control file contents}
for vintLoop := 0 to vstlPurgeList.count - 1 do
    iniFileControl.EraseSection(vstlPurgeList[vintLoop]);
finally
  vstlPurgeList.free;
  end;
end;

{---------------------------------------------------------------------------}
//Find literals in files mechanism
procedure tcomScriptWaveCommunicator.SearchInFiles(const cstrWord: string;
                                                   const cstrMask: string;
                                                   var vlstBox: tlistbox;
                                                   var vedtCount: tedit);
var
  vsreSearchRec: TSearchRec;
  vstrWord: string;
  vintTotalFiles: integer;

  Procedure FileTest;
    begin
    vedtCount.text:= inttostr(vintTotalFiles);
    application.processmessages;
    inc(vintTotalFiles);
    If ScanFile(vstrMasterDoc + vsreSearchRec.name,
                vstrWord) then
       vlstBox.Items.Add(vsreSearchRec.name);
    end;
begin
vlstBox.items.clear;
vintTotalFiles:= 1;
vstrWord:= uppercase(cstrWord);
if FindFirst(vstrMasterDoc + cstrMask, 0, vsreSearchRec) = 0 then
  begin
  FileTest;
  while FindNext(vsreSearchRec) = 0 do
      FileTest;
  FindClose(vsreSearchRec);
  end;
 end;

function tcomScriptWaveCommunicator.ScanFile(const FileName: string;
                                             const forString: string): boolean;
const
  BufferSize = $8001;  { 32K+1 bytes }
var
  pBuf, pEnd, pScan, pPos: PChar;
  filesize: LongInt;
  bytesRemaining: LongInt;
  bytesToRead: Integer;
  F: file;
  SearchFor: PChar;
  oldMode: Word;
begin
  { assume failure }
  Result := false;
  if (Length(forString) = 0) or (Length(FileName) = 0) then Exit;
  SearchFor := nil;
  pBuf      := nil;
  { open file as binary, 1 byte recordsize }
  AssignFile(F, FileName);
  oldMode  := FileMode;
  FileMode := 0;    { read-only access }
  Reset(F, 1);
  FileMode := oldMode;
  try { allocate memory for buffer and pchar search string }
    SearchFor := StrAlloc(Length(forString) + 1);
    StrPCopy(SearchFor, forString);
    AnsiUpper(SearchFor);
    GetMem(pBuf, BufferSize);
    filesize       := System.Filesize(F);
    bytesRemaining := filesize;
    pPos           := nil;
    while bytesRemaining > 0 do
    begin
      { calc how many bytes to read this round }
      if bytesRemaining >= BufferSize then
        bytesToRead := Pred(BufferSize)
      else
        bytesToRead := bytesRemaining;
      { read a buffer full and zero-terminate the buffer }
      BlockRead(F, pBuf^, bytesToRead, bytesToRead);
      pEnd  := @pBuf[bytesToRead];
      pEnd^ := #0;
      pScan := pBuf;
      while pScan < pEnd do
      begin
        AnsiUpper(pScan);
        pPos := StrPos(pScan, SearchFor);  { search for substring }
        if pPos <> nil then
        begin { Found it! }
          Result := true;
          Break;
        end;
        pScan := StrEnd(pScan);
        Inc(pScan);
      end;
      if pPos <> nil then Break;
      bytesRemaining := bytesRemaining - bytesToRead;
      if bytesRemaining > 0 then
      begin
        Seek(F, FilePos(F) - Length(forString));
        bytesRemaining := bytesRemaining + Length(forString);
      end;
    end; { While }
  finally
    CloseFile(F);
    if SearchFor <> nil then StrDispose(SearchFor);
    if pBuf <> nil then FreeMem(pBuf, BufferSize);
  end;
end; { ScanFile }

procedure tcomScriptWaveCommunicator.SaveEmergency(const cstrIP: string);
var vstl: tstringlist;
begin
   vstl:= tstringlist.create;
   try
   vstl.text := vstrIP;
   vstl.savetofile(vstrAppBaseFolder + 'emergency.ip');
   vstrEmergencyIP:= cstrIP;
   finally
     vstl.free;
     end;
end;

procedure tcomScriptWaveCommunicator.LoadEmergency;
var vstl: tstringlist;
begin
If fileexists(vstrAppBaseFolder + 'emergency.ip') then
  begin
  vstl:= tstringlist.create;
  try
  vstl.loadfromfile(vstrAppBaseFolder + 'emergency.ip');
  vstrEmergencyIP:= vstl[0];
  finally
    vstl.free;
    end;
  end;
end;

procedure tcomScriptWaveCommunicator.DownloadEmergencyIP;
begin
If pos('emergency.ip', vstlDir.text) > 0 then
  If getfile(vstrAppBaseFolder + 'emergency.ip', '', 30) then
   LoadEmergency;
end;

procedure tcomScriptWaveCommunicator.CheckToUseEmergency;
begin
vbolEmergencyNow:= false;
If length(vstrEmergencyIP) > 10 then
  If IsEmergencyReady then
    begin
    ShutdownFTP;
    vstrIP:= vstrEmergencyIP;
    Logit('Using emergency server: ' + vstrEmergencyIP);
    vbolEmergencyNow:=true;
    end
  else
  If vstrIP = vstrEmergencyIP then
    begin
    ShutdownFTP;
    GetAccountFile(vstrAppBaseFolder + 'ScriptWaveAccount_'
                                          + copy(vstrSessionType,1,1) + '.cry');
    Logit('Switching back to production server: ' + vstrIP);
    end
end;

{function tcomScriptWaveCommunicator.TransferServer: boolean;
begin
Result:= false;
If (date > strtodate(cstrCheckDate)) and
    (vstrIP = 'www.scriptwave.net') then
    begin
    vstrIP:= 'www.mudsox.com';
    vstrLogin:= 'mudsoxco';
    vstrPassword:= 'ozzie2828';
    SaveAccountFile;
    result:= true;
    end;
end; }

function tcomScriptWaveCommunicator.FileLastModified
   (const TheFile: string): string;
var
  FileH : THandle;
  LocalFT : TFileTime;
  DosFT : DWORD;
  LastAccessedTime : TDateTime;
  FindData : TWin32FindData;
begin
  Result := '';
  FileH := FindFirstFile(PChar(TheFile), FindData) ;
//  if FileH <> INVALID_HANDLE_VALUE then begin
//   Windows.FindClose(Handle) ;
   if (FindData.dwFileAttributes AND
       FILE_ATTRIBUTE_DIRECTORY) = 0 then
    begin
     FileTimeToLocalFileTime
      (FindData.ftLastWriteTime,LocalFT) ;
     FileTimeToDosDateTime
      (LocalFT,LongRec(DosFT).Hi,LongRec(DosFT).Lo) ;
     LastAccessedTime := FileDateToDateTime(DosFT) ;
     Result := DateTimeToStr(LastAccessedTime) ;
    end;
end;
end.
