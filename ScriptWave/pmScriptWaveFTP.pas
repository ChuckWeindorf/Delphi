unit pmScriptWaveFTP;

interface                                                                          

uses Windows, classes, sysutils, comctrls,
     SBSimpleSftp, SBSSHConstants, SBSSHKeyStorage, SBSftpCommon,
     pmVariablesConstants, pmutilities, pmScriptWave_mudCryptor;
Type tCommunicateThread = class(Tthread)
  private
    vintProgress: longint;
    ftpThreadTransfer: TElSimpleSFTPClient;

  protected
   procedure Execute; override;
   function ThreadInitializeFTP: boolean;
   procedure ThreadShutdownFTP;
   function ThreadSendFile: boolean;
   function ThreadGetFile: boolean;
   function ThreadDirectoryListFTP: boolean;
   function ThreadDirectoryCreateFTP: boolean;
   function ThreadRenameFile: boolean;
   function ThreadDeleteFTPFile: boolean;
   procedure ftpThreadTransferWork(Sender: TObject; Total,
                                         Current: Int64; var Cancel: Boolean);
   procedure ftpThreadKeyValidate(Sender: TObject;
                                 ServerKey: TElSSHKey; var Validate: Boolean);
  public
    vintPercent: integer;
    vintFTPFileSize: longint;
    vstrFTPaction: string;
    vstrFTPfile: string;
    vstrFTPNoPath: string;
    vstrFTPfolder: string;
    vstrFTPfileOld: string;
    vstrFTPBase: string;
    vbolFTPThreadDone: boolean;
    vbolActionResult: boolean;
    procedure ThreadFTPsetup;
    function FileSize(const cstrFile: string): longint;
    function FileFinder(const cstrFile: string): integer;
    function Nopath(const cstrFile: string): string;
    function DeriveDirectory(const cstrFolder: string): string;
    constructor Create;
    destructor destroy;  override;
  end;

implementation

{------------------------------------------------------------------------------}
constructor tCommunicateThread.Create;
begin
  ThreadFTPsetup;
  FreeOnTerminate := false;
  inherited Create(True);
end;

destructor tCommunicateThread.destroy;
begin
  ftpThreadTransfer.free;
  ftpThreadTransfer:= nil;
  inherited Destroy;
end;

procedure tCommunicateThread.ThreadFTPsetup;
begin
If ftpThreadTransfer <> nil then
   begin
   ftpThreadTransfer.free;
   ftpThreadTransfer:= nil;
   end;
vstrFTPBase := '/ScriptWave/' + vstrTranscriptionistID + '/' ;
ftpThreadTransfer:= TElSimpleSFTPClient.create(nil);
ftpThreadTransfer.OnProgress:= ftpThreadTransferWork;
ftpThreadTransfer.OnKeyValidate:= ftpThreadKeyValidate;
ftpThreadTransfer.CompressionLevel := 9;
ftpThreadTransfer.socketTimeout:= 30000;
ftpThreadTransfer.UploadBlockSize:= 8192;
ftpThreadTransfer.UseInternalSocket:= true;
ftpThreadTransfer.AuthenticationTypes := SSH_AUTH_TYPE_PASSWORD;
end;

procedure tCommunicateThread.Execute;
begin
  while not terminated do
    begin
    try
      vbolActionResult:= true;
      If vstrFTPaction = 'Initialize' then
        vbolActionResult:= ThreadInitializeFTP
      else
      If vstrFTPaction = 'Shutdown' then
        ThreadShutdownFTP
      else
      If vstrFTPaction = 'Directory' then
        vbolActionResult:= ThreadDirectoryListFTP
      else
      If vstrFTPaction = 'CreateDirectory' then
        vbolActionResult:= ThreadDirectoryCreateFTP
      else
      If vstrFTPaction = 'Send' then
        begin
        vbolActionResult:= ThreadSendFile;
//        ThreadShutdownFTP;
        end
      else
      If vstrFTPaction = 'Get' then
        begin
        vbolActionResult:= ThreadGetFile;
//        ThreadShutdownFTP;
        end
      else
      If vstrFTPaction = 'Rename' then
        vbolActionResult:= ThreadRenameFile
      else
      If vstrFTPaction = 'Delete' then
        vbolActionResult:= ThreadDeleteFTPFile;
    finally
      vstrFTPaction:= '';
      vbolFTPThreadDone:= true;
      If not terminated then
         Suspend;
      end;
    If not vbolActionResult and
       (vstrFTPaction <> 'Delete') then
       ThreadFTPsetup;
    end;
end;

function tCommunicateThread.ThreadInitializeFTP: boolean;
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
   finally
     vstlFile.free;
     end;
//   ftpThreadTransfer.Password:= vstrPassword;
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

procedure tCommunicateThread.ThreadShutdownFTP;
begin
try
if ftpThreadTransfer.active then
   ftpThreadTransfer.close;
   except
   Logit('Cannot shut down the FTP connection');
   end;
end;

function tCommunicateThread.ThreadDirectoryListFTP: boolean;
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
        BuildList;
        except
          Result:= false;
          Logit('Cannot list dir in contents: ' + vstrFTPFolder);
          end;
      end;
    finally
      ftpThreadTransfer.CloseHandle(dirHandle);
      end;
  end
else
  Result:= false;
end;

function tCommunicateThread.ThreadDirectoryCreateFTP: boolean;
begin
Result := True;
If ThreadInitializeFTP then
  begin
  try
    vstlDir.clear;
    ftpThreadTransfer.MakeDirectory(DeriveDirectory(vstrFTPFolder), nil);
    except
    Result:= false;
    Logit('Cannot create dir: ' + vstrFTPFolder);
    end;
  end
else
  Result:= false;
end;

function tCommunicateThread.ThreadSendFile: boolean;
      var vbolRetry, vbolTest: boolean;
          vintLoop: integer;
      function PutFTP: boolean;
        begin
        Result:= ThreadInitializeFTP;
        {Because of hanging in retransmit, attempt to write the delete the
        target file if it exists.}
        vstrFTPNoPath:= NoPath(vstrFTPFile);
        ThreadDeleteFTPFile;
        vintProgress:= FileSize(vstrFTPFile);
        If Result then
          begin
            try
            ftpThreadTransfer.UploadFile
            (vstrFTPFile, DeriveDirectory(vstrFTPFolder) + NoPath(vstrFTPFile));
            except
              Result := false;
              Logit('Cannot put file: ' + vstrFTPFile);
              vbolRetry:= true;
              end;
          end;
        end;
begin
vbolRetry:= false;
vbolFTPCompletion:= false;
for vintLoop:= 1 to 3 do
   begin
   vbolTest := putftp;
   If vbolFTPCompletion then
      begin
      vbolTest:= true;
      vbolRetry:= false;
      end;
//   If not vbolTest then
//      ThreadFTPsetup;
   if vbolRetry then
      sleep(5000)
   else
      break;
   end;
Result:= vbolTest;
vintPercent:= 0;
end;

function tCommunicateThread.ThreadRenameFile: boolean;
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

function tCommunicateThread.ThreadDeleteFTPFile: boolean;
begin
Result:= true;
If ThreadInitializeFTP then
  begin
  try
  ftpThreadTransfer.removefile(DeriveDirectory(vstrFTPFolder) +
                                                           NoPath(vstrFTPFile));
    except
    Result := false;
    //Logit('Cannot deletefile: ' + vstrFTPNoPath);
    end;
  end;
end;

function tCommunicateThread.ThreadGetFile: boolean;
      var vbolRetry, vbolTest: boolean;
          vintLoop: integer;
      function GetFTP: boolean;
         begin
         Result:= ThreadInitializeFTP;
         vintProgress:= vintFTPFileSize;
         If Result then
           try
             ftpThreadTransfer.DownloadFile(DeriveDirectory(vstrFTPFolder) +
                                               NoPath(vstrFTPFile),vstrFTPFile);
             except
             Result:= false;
             vbolRetry:= true;
             Logit('Cannot getfile: ' + vstrFTPFile);
             end;
         end;
begin
vbolRetry:= false;
vbolFTPCompletion:= false;
for vintLoop:= 1 to 3 do
   begin
   vbolTest:= getftp;
   If vbolFTPCompletion then
      begin
      vbolTest:= true;
      vbolRetry:= false;
      end;
//   If not vbolTest then
//      ThreadFTPsetup;
   if vbolRetry then
      sleep(5000)
   else
      break;
   end;
Result:= vbolTest;
vintPercent:= 0;
end;

procedure tCommunicateThread.ftpThreadKeyValidate(Sender: TObject;
                                   ServerKey: TElSSHKey; var Validate: Boolean);
begin
  Validate := true;
end;

procedure tCommunicateThread.ftpThreadTransferWork(Sender: TObject; Total,
                                           Current: Int64; var Cancel: Boolean);
begin
try
If vintProgress <> 0 then
   vintPercent := round((Current / vintProgress) * 100);
except
  end;
end;

function tCommunicateThread.Nopath(const cstrFile: string): string;
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
function tCommunicateThread.FileSize(const cstrFile: string): longint;
 var SRec: tsearchrec;
begin
Result:= 0;
if FindFirst(cstrFile,faAnyFile,SRec)=0 then
   begin
   Result := SRec.Size;
   FindClose(SRec);
   end;
end;

function tCommunicateThread.FileFinder(const cstrFile: string): integer;
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

function tCommunicateThread.DeriveDirectory(const cstrFolder: string): string;
begin
Result:= vstrFTPBase + cstrFolder;
If copy(result,length(result),1) <> '/' then
   Result:= Result + '/';
If copy(result,length(result)-1,2) = '//' then
   Result:= copy(result,1,length(result)-1);
If cstrFolder = 'Support' then
  Result:= '/ScriptWave/Support/'
else
If cstrFolder = 'Activation' then
  Result:= '/ScriptWave/Activation/'
else
If cstrFolder = 'Software' then
  If vstrTranscriptionistID = 'A000' then
     Result:= '/ScriptWave/AlphaSoftware/'
  else
  If vstrTranscriptionistID = 'A001' then
     Result:= '/ScriptWave/BetaSoftware/'
  else
     Result:= '/ScriptWave/Software/';
end;

{------------------------------------------------------------------------------}


end.
