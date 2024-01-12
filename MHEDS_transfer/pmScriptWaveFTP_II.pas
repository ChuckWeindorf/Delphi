unit pmScriptWaveFTP_II;

interface

uses forms, Windows, classes, sysutils, comctrls, Gauges,
     SBSimpleSftp, SBSSHConstants, SBSSHKeyStorage, SBSftpCommon,
     pmVariablesConstants, pmutilities, pmScriptWave_mudCryptor;

  {Communication event}
   procedure CallFTPUntilAnswer;

   {Create, setup shutdown functions}
   procedure ThreadFTPsetup;
   function ThreadInitializeFTP: boolean;
   procedure ThreadShutdownFTP;

   {Communications functions}
   function ThreadSendFile: boolean;
   function ThreadGetFile: boolean;
   function ThreadDirectoryListFTP: boolean;
   function ThreadDirectoryOpenFTP: boolean;
   function ThreadDirectoryCreateFTP: boolean;
   function ThreadRenameFile: boolean;
   function ThreadDeleteFTPFile: boolean;

   {Support Functions}
   function FileSize(const cstrFile: string): longint;
   function FileFinder(const cstrFile: string): integer;
   function Nopath(const cstrFile: string): string;
   function DeriveDirectory(const cstrFolder: string): string;
   function IsEmergencyReady: boolean;

   type
   TFTPEventHandlers = class // create a dummy class
      procedure ftpThreadTransferWork(Sender: TObject; Total,
                                         Current: Int64; var Cancel: Boolean);
      procedure ftpThreadKeyValidate(Sender: TObject;
                                 ServerKey: TElSSHKey; var Validate: Boolean);
   end;

   var
   vintProgress: longint;
   vintPercent: integer;
   vintFTPFileSize: longint;
   vstrFTPaction: string;
   vstrFTPfile: string;
   vstrFTPNoPath: string;
   vstrFTPfolder: string;
   vstrFTPfileOld: string;
   vstrFTPBase: string;
   vbolActionResult: boolean;
   vFTPEventHandler: TFTPEventHandlers;
   barTransmitS: TGauge;

implementation

{------------------------------------------------------------------------------}

procedure CallFTPUntilAnswer;
  begin
  try
    try
      vbolActionResult:= true;
      If vstrFTPaction = 'Initialize' then
        vbolActionResult:= ThreadInitializeFTP
      else
      If vstrFTPaction = 'Shutdown' then
        ThreadShutdownFTP
      else
      If vstrFTPaction = 'Pulse' then
        vbolActionResult:= ThreadDirectoryOpenFTP
      else
      If vstrFTPaction = 'Directory' then
        vbolActionResult:= ThreadDirectoryListFTP
      else
      If vstrFTPaction = 'CreateDirectory' then
        vbolActionResult:= ThreadDirectoryCreateFTP
      else
      If vstrFTPaction = 'Send' then
        vbolActionResult:= ThreadSendFile
      else
      If vstrFTPaction = 'Get' then
        vbolActionResult:= ThreadGetFile
      else
      If vstrFTPaction = 'Rename' then
        vbolActionResult:= ThreadRenameFile
      else
      If vstrFTPaction = 'Delete' then
        vbolActionResult:= ThreadDeleteFTPFile;
    except
      end;
    If not vbolActionResult and
       (vstrFTPaction <> 'Delete') then
       ThreadFTPsetup;
    finally
      vstrFTPaction:= '';
      end;

  application.processmessages;
end;


procedure ThreadFTPsetup;
begin
If ftpThreadTransfer <> nil then 
   begin
   ThreadShutdownFTP;
   ftpThreadTransfer.free;
   ftpThreadTransfer:= nil;
   end;
//If (date > strtodate(cstrCheckDate)) then
//  vstrFTPBase := cstrFTPSystemNew + vstrTranscriptionistID + '/'
//else
vstrFTPBase := cstrFTPSystem + vstrTranscriptionistID + '/' ;
ftpThreadTransfer:= TElSimpleSFTPClient.create(nil);
ftpThreadTransfer.OnProgress:= vFTPEventHandler.ftpThreadTransferWork;
ftpThreadTransfer.OnKeyValidate:= vFTPEventHandler.ftpThreadKeyValidate;
ftpThreadTransfer.CompressionLevel := 9;
ftpThreadTransfer.socketTimeout:= 30000;
ftpThreadTransfer.UploadBlockSize:= 8192;
ftpThreadTransfer.UseInternalSocket:= true;
ftpThreadTransfer.AuthenticationTypes := SSH_AUTH_TYPE_PASSWORD;
end;


function ThreadInitializeFTP: boolean;
  var vstlFile: tstringlist;
      vstrString: string;
begin
Result := true;
if not ftpThreadTransfer.active then
  begin
  ftpThreadTransfer.Address := vstrIP;
  ftpThreadTransfer.Username:= vstrLogin;
  {Get password}
  vstlFile:= tstringlist.create;
  try
  vstlFile.loadfromfile(vstrConfigFile);
  vstrString:= uncryptorstring(vstlFile[0]);
  ftpThreadTransfer.Password:= trim(copy(vstrString,51,20));
  If not vbolEmergencyNow then
     ftpThreadTransfer.Password:=
          uppercase(copy(ftpThreadTransfer.Password,1,1)) +
          copy(ftpThreadTransfer.Password,2,99) + '?';
  finally
    vstlFile.free;
    end;
  ftpThreadTransfer.Port := 22;
  try
  ftpThreadTransfer.Open;
  ftpThreadTransfer.Password:= '';
  except
    Result := false;
    Logit('FTP connection failure - check connection');
    end;
  end;
end;

procedure ThreadShutdownFTP;
begin
try
if ftpThreadTransfer.active then
   ftpThreadTransfer.close;
   except
   Logit('Cannot shut down the FTP connection');
   end;
end;

function ThreadDirectoryListFTP: boolean;
      var dirHandle: string;
      procedure BuildList;
           var Info : TElSftpFileInfo;
           vintLoop: integer;
           vlst: Tlist;
        begin
          vlst:= tlist.create;
          ftpThreadTransfer.ReadDirectory(dirHandle, vlst);
          try
            for vintLoop:= 0 to vlst.Count - 1 do
              begin
              Info := TElSftpFileInfo.Create;
              try
               TElSftpFileInfo(vlst.Items[vintLoop]).CopyTo(Info);
               TElSftpFileInfo(vlst.Items[vintLoop]).Free;
               vstlDir.add(format('%-10.0d',[Info.Attributes.size])+ Info.Name);
               vstlDirDateStamp.add(datetimetostr(Info.Attributes.mtime));
               finally
                 Info.free;
                 end;
              end;
            finally
              vlst.free;
              end;
        end;
begin
Result := True;
If ThreadInitializeFTP then
  begin
  try
    try
    dirHandle:= ftpThreadTransfer.OpenDirectory(DeriveDirectory(vstrFTPFolder));
      except
      Result:= false;
      Logit('Cannot change dir in directory list: ' + vstrFTPFolder);
      end;
    If Result then
      begin
      try
        vstlDir.clear;
        vstlDirDateStamp.clear;
        BuildList;
        except
          Result:= false;
          Logit('Cannot list dir in contents: ' + vstrFTPFolder);
          end;
      end;
    finally
      try
      ftpThreadTransfer.CloseHandle(dirHandle);
        except
        end;
      end;
  end
else
  Result:= false;
end;

function ThreadDirectoryOpenFTP: boolean;
  var dirHandle: string;
begin
Result := True;
If ThreadInitializeFTP then
  begin
  try
  try
    dirHandle:= ftpThreadTransfer.OpenDirectory(DeriveDirectory(vstrFTPFolder));
      except
      Result:= false;
      Logit('Cannot change dir in directory list: ' + vstrFTPFolder);
      end;
    finally
      ftpThreadTransfer.CloseHandle(dirHandle);
      end;
  end
else
  Result:= false;
end;

function ThreadDirectoryCreateFTP: boolean;
begin
Result := True;
If ThreadInitializeFTP then
  begin
  try
    vstlDir.clear;
    vstlDirDateStamp.clear;
    ftpThreadTransfer.MakeDirectory(DeriveDirectory(vstrFTPFolder), nil);
    except
    Result:= false;
    Logit('Cannot create dir: ' + vstrFTPFolder);
    end;
  end
else
  Result:= false;
end;

function ThreadSendFile: boolean;
begin
Result:= ThreadInitializeFTP;
If Result then
   begin
   try
     vstrFTPNoPath:= NoPath(vstrFTPFile);
     ThreadDeleteFTPFile;
     vintProgress:= FileSize(vstrFTPFile);
     ftpThreadTransfer.UploadFile
            (vstrFTPFile, DeriveDirectory(vstrFTPFolder) + NoPath(vstrFTPFile));
     except
     Result := false;
     Logit('Cannot put file: ' + vstrFTPFile);
     end;
   end;
vintPercent:= 0;
barTransmitS.Progress:= 0;
end;

function ThreadRenameFile: boolean;
begin
Result:= true;
If ThreadInitializeFTP then
  begin
  try
  ftpThreadTransfer.renamefile(DeriveDirectory(vstrFTPFolder)+ vstrFTPFileOld,
                                 DeriveDirectory(vstrFTPFolder) + vstrFTPFile);
    except
    Result := false;
    Logit('Cannot renamefile: ' + vstrFTPfileold + ' to ' + vstrFTPFile);
    end;
  end;
end;

function ThreadDeleteFTPFile: boolean;
begin
Result:= true;
If ThreadInitializeFTP then
  begin
  try
  ftpThreadTransfer.removefile(DeriveDirectory(vstrFTPFolder) +
                                                           NoPath(vstrFTPFile));
    except
    Result := false;
    end;
  end;
end;

function ThreadGetFile: boolean;
begin
Result:= ThreadInitializeFTP;
If Result then
   try
   vintProgress:= vintFTPFileSize;
   ftpThreadTransfer.DownloadFile(DeriveDirectory(vstrFTPFolder) +
                                               NoPath(vstrFTPFile),vstrFTPFile);
     except
     Result:= false;
     Logit('Cannot getfile: ' + vstrFTPFile);
     end;
vintPercent:= 0;
barTransmitS.Progress:= 0;
end;


{------------------------------------------------------------------------------}
procedure TFTPEventHandlers.ftpThreadKeyValidate(Sender: TObject;
                                   ServerKey: TElSSHKey; var Validate: Boolean);
begin
  Validate := true;
end;

procedure TFTPEventHandlers.ftpThreadTransferWork(Sender: TObject; Total,
                                           Current: Int64; var Cancel: Boolean);
begin
try
If vintProgress <> 0 then
   vintPercent := round((Current / vintProgress) * 100);
If barTransmitS <> nil then
   barTransmitS.Progress:= vintPercent;
application.processmessages;
except
  end;
end;

{------------------------------------------------------------------------------}
function Nopath(const cstrFile: string): string;
var vintLoop : integer;
begin
Result:='';
for vintLoop:= length(cstrFile) downto 1 do
  begin
  If (copy(cstrFile,vintLoop,1) = '\') or (copy(cstrFile,vintLoop,1) = '/') then
     exit
  else
     Result:= copy(cstrFile,vintLoop,1) + Result;
  end;
end;

{File info}
function FileSize(const cstrFile: string): longint;
 var SRec: tsearchrec;
begin
Result:= 0;
if FindFirst(cstrFile,faAnyFile,SRec)=0 then
   begin
   Result := SRec.Size;
   FindClose(SRec);
   end;
end;

function FileFinder(const cstrFile: string): integer;
var vintLoop, vintDot: integer;
    vstrWorkFile: string;
begin
Result := -1;
vstrWorkFile:= trim(copy(cstrFile,cintFTPDirOffset+2,999));
vintDot:= (pos('.',vstrWorkFile));
vstrWorkFile:= copy(vstrWorkFile,1,vintDot+3)+ '_cry';

for vintLoop := 0 to vstlDir.Count - 1 do
   If vstrWorkFile =
       trim(copy(vstlDir[vintLoop],cintFTPDirOffset,999)) then
      begin
      Result:= vintLoop;
      break;
      end;

If Result = -1 then
      Logit('Cannot find the target receive file: ' + vstrWorkFile);
end;

function DeriveDirectory(const cstrFolder: string): string;
var vstrHoldSystem: string;
begin
Result:= vstrFTPBase + cstrFolder;
If copy(result,length(result),1) <> '/' then
   Result:= Result + '/';
If copy(result,length(result)-1,2) = '//' then
   Result:= copy(result,1,length(result)-1);
vstrHoldSystem:= cstrFTPSystem;
//If date > strtodate(cstrCheckDate) then
//   vstrHoldSystem:= cstrFTPSystemNew;
If cstrFolder = 'Support' then
  Result:= vstrHoldSystem + 'Support/'
else
If cstrFolder = 'Activation' then
  Result:= vstrHoldSystem + 'Activation/'
else
If cstrFolder = 'Software' then
  If vstrTranscriptionistID = 'A000' then
     Result:= vstrHoldSystem + 'AlphaSoftware/'
  else
  If vstrTranscriptionistID = 'A001' then
     Result:= vstrHoldSystem + 'BetaSoftware/'
  else
     Result:= vstrHoldSystem + 'Software/';
end;

{------------------------------------------------------------------------------}

function IsEmergencyReady: boolean;
  var vstlFile: tstringlist;
      vstrString: string;
      dirHandle: string;
      Info : TElSftpFileInfo;
      vlst: Tlist;
      vintLoop: integer;
begin
Result:= false;
ftpCheckEmergency:= TElSimpleSFTPClient.create(nil);
try
ftpCheckEmergency.OnKeyValidate:= vFTPEventHandler.ftpThreadKeyValidate;
ftpCheckEmergency.CompressionLevel := 9;
ftpCheckEmergency.socketTimeout:= 15000;
ftpCheckEmergency.UploadBlockSize:= 8192;
ftpCheckEmergency.UseInternalSocket:= true;
ftpCheckEmergency.AuthenticationTypes := SSH_AUTH_TYPE_PASSWORD;
ftpCheckEmergency.Address := vstrEmergencyIP;
ftpCheckEmergency.Username:= vstrLogin;
{Get password}
vstlFile:= tstringlist.create;
try
vstlFile.loadfromfile(vstrConfigFile);
vstrString:= uncryptorstring(vstlFile[0]);
ftpCheckEmergency.Password:= trim(copy(vstrString,51,20));
finally
  vstlFile.free;
  end;
ftpCheckEmergency.Port := 22;
try

ftpCheckEmergency.Open;
ftpCheckEmergency.Password:= '';

If ftpCheckEmergency.Active then
  begin
  vlst:= tlist.create;
  try
  dirHandle:= ftpCheckEmergency.OpenDirectory(DeriveDirectory(''));
  ftpCheckEmergency.ReadDirectory(dirHandle, vlst);
  for vintLoop:= 0 to vlst.Count - 1 do
    begin
    Info := TElSftpFileInfo.Create;
    try
      TElSftpFileInfo(vlst.Items[vintLoop]).CopyTo(Info);
      TElSftpFileInfo(vlst.Items[vintLoop]).Free;
      If Info.Name = 'emergency.yes' then
        begin
        Result:= true;
        break;
        end;
      finally
        Info.free;
        end;
    end;
  finally
    vlst.free;
    end;
  ftpCheckEmergency.Close;
  end;

  except
    Result:= false;
    try
      If ftpCheckEmergency.Active then ftpCheckEmergency.Close;
      except end;
    exit;
    end;

finally
  ftpCheckEmergency.free;
  ftpCheckEmergency:= nil;
  end;
end;

end.
