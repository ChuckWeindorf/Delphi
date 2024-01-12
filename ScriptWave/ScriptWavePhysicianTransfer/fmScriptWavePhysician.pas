unit fmScriptWavePhysician;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, FileCtrl, 
  ExtCtrls, StdCtrls, ComCtrls, ToolWin, ImgList,
  TNShellNotifyIcon, Menus, jpeg, Grids, Gauges, ShellApi, MPlayer,
  Buttons, OleCtrls, SHDocVw,
  unaVCIDE, unaDspControls, unaClasses, unaTypes, unaUtils, comobj, outlook8,
  pmScriptWaveShare;

const                                            
  //
  // -- max buffer size --
  //
  //  maxSize	= 80000;
  maxSize	= 81300000;	// 81 MB

type
  TfrmPhysicianMain = class(TForm)
    pagMain: TPageControl;
    tabStatus: TTabSheet;
    tabPreferences: TTabSheet;
    lblPhysician: TLabel;
    edtPhysician: TEdit;
    lblPhysicianID: TLabel;
    edtPhysicianID: TEdit;
    shp2: TShape;
    lblTranscriptionFolder: TLabel;
    edtScanFolder: TEdit;
    lblReceiveFolder: TLabel;
    edtWordFolder: TEdit;
    chkAutomatic: TCheckBox;
    chkDeleteImport: TCheckBox;
    chkRenameImport: TCheckBox;
    lblTranscriptionist: TLabel;
    edtTranscriptionist: TEdit;
    lblTransID: TLabel;
    edtTranscriptionistID: TEdit;
    tmrMAIN: TTimer;
    shnShellNotify: TTNShellNotifyIcon;
    imgImagelist: TImageList;
    popTrayMenu: TPopupMenu;
    cmdShow: TMenuItem;
    cmdHide: TMenuItem;
    cmdShutdown: TMenuItem;
    tmrBlink: TTimer;
    tabMessages: TTabSheet;
    tabAlerts: TTabSheet;
    grdAlerts: TStringGrid;
    pnlCommands: TPanel;
    imgTranscription: TImage;
    imgDictation: TImage;
    imgMessages: TImage;
    pnlProgress: TPanel;
    barTransmit: TGauge;
    lblFileTransferName: TLabel;
    pnlAlerts: TPanel;
    imgMessages1: TImage;
    imgMessages2: TImage;
    imgDictation1: TImage;
    imgDictation2: TImage;
    imgTranscription2: TImage;
    imgTranscription1: TImage;
    edtDictationName: TEdit;
    memFileComments: TMemo;
    lblDictate: TLabel;
    lblImportDate: TLabel;
    edtImportDate: TEdit;
    lblTransmitDate: TLabel;
    edtTransmitDate: TEdit;
    lblReceiveDate: TLabel;
    edtReceiveDate: TEdit;
    lblAssignDate: TLabel;
    edtAssignDate: TEdit;
    lblTypeDate: TLabel;
    edtTypedDate: TEdit;
    lblReviewDate: TLabel;
    edtReviewDate: TEdit;
    edtCompleteDate: TEdit;
    lblCompleteDate: TLabel;
    grdTranscribedFiles: TStringGrid;
    lblComments: TLabel;
    medDictation: TMediaPlayer;
    lblPlay: TLabel;
    gagDictation: TGauge;
    cmdOpenDoc: TSpeedButton;
    lblAlert: TLabel;
    treMessages: TTreeView;
    edtSubjectMail: TEdit;
    memMessage: TMemo;
    edtFromMail: TEdit;
    edtDateTimeMail: TEdit;
    lblFrom: TLabel;
    lblMailTime: TLabel;
    lblMailSubject: TLabel;
    lblMailMemo: TLabel;
    lstMessages: TFileListBox;
    edtToMail: TEdit;
    lblToMessage: TLabel;
    pnlWait: TPanel;
    lstImportFiles: TFileListBox;
    tbrMain: TToolBar;
    cmdCommunicate: TSpeedButton;
    cmdViewLog: TSpeedButton;
    cmdSendLog: TSpeedButton;
    cmdExit: TSpeedButton;
    pnlSpace: TPanel;
    cmdNoAlerts: TSpeedButton;
    cmdNewMessage: TSpeedButton;
    cmdMailIt: TSpeedButton;
    cmdCancelMail: TSpeedButton;
    pnlSpl1: TPanel;
    lblAltName: TLabel;
    edtAltName: TEdit;
    cmdDeleteMessage: TSpeedButton;
    cmdReplyMessage: TSpeedButton;
    tabScriptWave: TTabSheet;
    webScriptWave: TWebBrowser;
    memCommProgress: TMemo;
    tabReports: TTabSheet;
    cboPhysicians: TComboBox;
    cboMonth: TComboBox;
    lblStep1: TLabel;
    lblStep2: TLabel;
    cmdPrint: TSpeedButton;
    lblPleaseWait: TLabel;
    shp1: TShape;
    shp3: TShape;
    chkPurgeOn: TCheckBox;
    cboPurgeMain: TComboBox;
    cboPurgeImport: TComboBox;
    lblPurgeN: TLabel;
    cboPurgeTranscription: TComboBox;
    lblMainP: TLabel;
    lblImportD: TLabel;
    lblPurgeT: TLabel;
    pnlRetry: TPanel;
    lblSpecial: TLabel;
    cmdDictationResend: TButton;
    cmdTransReReceive: TButton;
    cmdRestart: TButton;
    tabDictate: TTabSheet;
    pnlRecord: TPanel;
    lblMinutes: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    lblEncode: TLabel;
    c_trackBar_pos: TTrackBar;
    c_progressBar_memLoad: TProgressBar;
    c_btn_start: TButton;
    c_btn_stop: TButton;
    c_btn_play: TButton;
    c_btn_cut: TButton;
    btnSave: TButton;
    btnCancelRecord: TButton;
    cmdRecover1: TButton;
    cmdRecover2: TButton;
    pnlTest_Record: TPanel;
    pnlLame: TPanel;
    c_fftBand: TunadspFFTControl;
    c_progressBar_level: TProgressBar;
    lblVolOK: TLabel;
    linVol: TShape;
    lblVolumeLow: TLabel;
    lblLame: TLabel;
    waveOut: TunavclWaveOutDevice;
    wavReadWrite: TunavclWaveRiff;
    c_timer_main: TTimer;
    pnlEncoding: TPanel;
    Shape1: TShape;
    lblPswdOverride: TLabel;
    lblPswdNote: TLabel;
    edtChangePassword: TEdit;
    cmdChangePassword: TButton;
    lblTechSupport: TLabel;
    pnlSpacer2: TPanel;
    cmdHelp: TSpeedButton;
    pnlSpacer3: TPanel;
    Shape2: TShape;
    chkAutoPrint: TCheckBox;
    lblPrint: TLabel;
    edtPrintCommand: TEdit;
    pnlLeft: TPanel;
    pnlTop: TPanel;
    treAll: TTreeView;
    chkRecent: TCheckBox;
    Label1: TLabel;
    edtPrintParameter: TEdit;
    Label23: TLabel;
    Label25: TLabel;
    edtSearchWord: TEdit;
    Label26: TLabel;
    cboDocSearchPrefix: TComboBox;
    cmdSearch: TSpeedButton;
    lblSearching: TLabel;
    edtCountSearch: TEdit;
    Label24: TLabel;
    Label27: TLabel;
    lstSearchResults: TListBox;
    Shape4: TShape;
    pnlMessageComm: TPanel;
    Label14: TLabel;
    edtEmergencyIP: TEdit;
    cmdEmail: TSpeedButton;
    Label18: TLabel;
    flbBackups: TFileListBox;
    cmdGearplayer: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmrMAINTimer(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure cmdHideClick(Sender: TObject);
    procedure cmdShutdownClick(Sender: TObject);
    procedure shnShellNotifyDblClick(Sender: TObject;
      Button: TMouseButton);
    procedure cmdShowClick(Sender: TObject);
    procedure popTrayMenuPopup(Sender: TObject);
    procedure tmrBlinkTimer(Sender: TObject);
    procedure imgMessagesClick(Sender: TObject);
    procedure cmdShowLogClick(Sender: TObject);
    procedure cmdSendLogClick(Sender: TObject);
    procedure cmdCommunicate1Click(Sender: TObject);
    procedure cmdNoAlertsClick(Sender: TObject);
    procedure edtWordFolderChange(Sender: TObject);
    procedure chkDeleteImportClick(Sender: TObject);
    procedure chkRenameImportClick(Sender: TObject);
    procedure chkAutomaticClick(Sender: TObject);
    procedure imgDictationClick(Sender: TObject);
    procedure imgTranscriptionClick(Sender: TObject);
    procedure pagMainChange(Sender: TObject);
    procedure treAllClick(Sender: TObject);
    procedure cmdOpenDocClick(Sender: TObject);
    procedure grdAlertsDblClick(Sender: TObject);
    procedure grdAlertsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cmdNewMessageClick(Sender: TObject);
    procedure cmdCancelMailClick(Sender: TObject);
    procedure cmdMailitClick(Sender: TObject);
    procedure treMessagesClick(Sender: TObject);
    procedure cmdExitClick(Sender: TObject);
    procedure grdTranscribedFilesClick(Sender: TObject);
    procedure cmdDeleteMessageClick(Sender: TObject);
    procedure cmdReplyMessageClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure chkPurgeOnClick(Sender: TObject);
    procedure cboPurgeMainChange(Sender: TObject);
    procedure cboPurgeImportChange(Sender: TObject);
    procedure cboPurgeTranscriptionChange(Sender: TObject);
    procedure cmdRestartClick(Sender: TObject);
    procedure cmdDictationResendClick(Sender: TObject);
    procedure cmdTransReReceiveClick(Sender: TObject);
    procedure cmdRecover1Click(Sender: TObject);
    procedure cmdRecover2Click(Sender: TObject);
    procedure c_timer_mainTimer(Sender: TObject);
    procedure waveInDataAvailable(sender: unavclInOutPipe; data: Pointer;
      len: Cardinal);
    procedure waveOutFeedChunk(sender: unavclInOutPipe; data: Pointer;
      len: Cardinal);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelRecordClick(Sender: TObject);
    procedure c_trackBar_posChange(Sender: TObject);
    procedure c_btn_startClick(Sender: TObject);
    procedure c_btn_stopClick(Sender: TObject);
    procedure c_btn_playClick(Sender: TObject);
    procedure c_btn_cutClick(Sender: TObject);
    procedure pnlLameClick(Sender: TObject);
    procedure pnlTest_RecordClick(Sender: TObject);
    procedure cmdChangePasswordClick(Sender: TObject);
    procedure lblTechSupportClick(Sender: TObject);
    procedure cmdHelpClick(Sender: TObject);
    procedure edtScanFolderExit(Sender: TObject);
    procedure chkAutoPrintClick(Sender: TObject);
    procedure edtPrintCommandExit(Sender: TObject);
    procedure chkRecentClick(Sender: TObject);
    procedure edtPrintParameterExit(Sender: TObject);
    procedure edtSearchWordChange(Sender: TObject);
    procedure cmdSearchClick(Sender: TObject);
    procedure lstSearchResultsDblClick(Sender: TObject);
    procedure edtEmergencyIPExit(Sender: TObject);
    procedure cmdEmailClick(Sender: TObject);
    procedure flbBackupsDblClick(Sender: TObject);
    procedure cmdGearplayerClick(Sender: TObject);
  private
    { Private declarations }
    vbolOneTime: boolean;
    vbolAudioTest: boolean;
    vbolShutdown: boolean;
    vbolBlink: boolean;
    vbolBlinkDictation: boolean;
    vbolBlinkTranscription: boolean;
    vbolBlinkMessages: boolean;
    vbolImmediateCommunicate: boolean;
    vbolCommunicating: boolean;
    vbolNoDialog: boolean;
    vbolRestartIni: boolean;
    vintBlinkCount: integer;
    vintgrdRow: integer;
    vintgrdCol: integer;
    vreaMinutes: real;
    vreaPulseMinutes: real;
    vreaStartTime: real;
    vintAudioLevel: integer;
    vintTestTime: integer;
    vintBackupCount: integer;

    vtxtLock: TextFile;

    {--------------------------------------------------------------------------}
    {RECORDER STUFF}
    f_tbpTimer: bool;
    f_memBlock: pArray;
    f_memOffs: unsigned;
    f_memUsed: unsigned;
    waveIn2: TunavclWaveInDevice;
    procedure CreateWaveIn(const cbolMessage: boolean);
    {--------------------------------------------------------------------------}

    procedure LoopThroughFiles(const cstrMask: string);
    procedure SaveAlerts;
    procedure LoadAlerts;
    function FindFileReceiveSize(const cstrDirString: string): longint;
    procedure LoadAndScanFilesINI;
    procedure SendAndReceiveMessages;
    procedure LoadMessages;
    function FindMessageFile(const cstrDateTime: string): string;
    function GetNodeByText(ATree : TTreeView;
                           AValue:String;
                           AVisible: Boolean): TTreeNode;
    function MemoHash(const cstrMemo: string): string;
    function MemoUnHash(const cstrMemo: string): string;
    procedure ResetAfterMessage;
    Procedure WMEndSession(var Msg : TWMEndSession);
    message WM_ENDSESSION;
    procedure WMQueryEndSession(var Msg : TWMQueryEndSession);
    message WM_QueryEndSession;
    procedure WMDropFiles(var message: TWMDropFiles); message WM_DROPFILES;
    procedure SaveDictationCopy(const cstrFile: string);
    Procedure SalvageFile(const cstrFile: string);
    procedure StopRecord;
public
    { Public declarations }
  end;

var
  frmPhysicianMain: TfrmPhysicianMain;
  comScriptWaveComm: tcomScriptWaveCommunicator;

const cstrVersion : string = '181';

implementation

uses fmLogForm, fmImportComment, pmUtilities, rpBasic, pmVariablesConstants,
     Math, pmScriptWave_mudCryptor, pmScriptWaveFTP_II;

{$R *.DFM}


procedure TfrmPhysicianMain.FormCreate(Sender: TObject);
  var vstl: tstringlist;
begin
vintBlinkCount:= 0;
vbolBlink := false;
vbolNoDialog:= false;
vbolBlinkDictation := false;
vbolBlinkTranscription := false;
vbolBlinkMessages := false;
shnShellNotify.SetIconFromIconList(0);
comScriptWaveComm:= tcomScriptWaveCommunicator.create;
barTransmitS:= barTransmit;
If fileexists(extractfilepath(Application.ExeName) +
                                                 'ScriptWaveAccount_O.cry') then
    vstrSessionType:= 'Office'
else
    vstrSessionType:= 'Physician';
comScriptWaveComm.setup;
Logit('Starting software version ' + cstrVersion);

edtScanFolder.Text := vstrTransmitFolder;
edtWordFolder.Text := vstrReceiveFolder;
edtPhysician.text := vstrPhysician;
edtPhysicianID.text := vstrPhysicianID;
edtTranscriptionist.text := vstrTranscriptionist;
edtTranscriptionistID.text := vstrTranscriptionistID;
chkAutomatic.checked:= vbolAutomatic;
chkAutomaticClick(self);
chkRenameImport.checked:= vbolRenameImport;
chkDeleteImport.checked:= vbolDeleteImport;
chkAutoPrint.checked:= vbolAutoPrint;
{----------------------}
chkPurgeOn.checked:= vbolPurge;
cboPurgeMain.itemindex := cboPurgeMain.Items.IndexOf(vstrPurgeMaster);
cboPurgeImport.itemindex := cboPurgeImport.Items.IndexOf(vstrPurgeImport);
cboPurgeTranscription.itemindex :=
                    cboPurgeTranscription.Items.IndexOf(vstrPurgeTranscription);
edtPrintCommand.text:= vstrPrintCommand;
edtPrintParameter.text:= vstrPrintParameter;
{----------------------}

If vbolAutomatic then
   tmrMAIN.enabled := true;

If copy(edtScanFolder.text,length(edtScanFolder.text),1) <> '\' then
    edtScanFolder.text := edtScanFolder.text + '\';
//lstImportFiles.Directory:=edtScanFolder.text;     //3/10/2012
lstMessages.Directory:=vstrMessages;

grdAlerts.Cells[0,0]:= 'Alerts';
grdAlerts.Cells[1,0]:= 'Files / Documents / Messages';
LoadAlerts;
grdAlerts.Cells[0,1] := 'Start';
grdAlerts.cells[1,1] := datetimetostr(now);

frmPhysicianMain.caption :=frmPhysicianMain.caption + ' provided courtesy of ' +
                            vstrTranscriptionist;
LoadAndScanFilesINI;

forcedirectories(vstrAppBaseFolder + '\RecordTemp\');
flbBackups.ApplyFilePath(vstrAppBaseFolder + '\RecordTemp\');

If fileexists(vstrAppBaseFolder + 'lame.exe') then
  begin
  pnlTest_Record.visible:= true;
  pnlLame.visible:= false;
  end;
CreateWaveIn(false);
  
if vstrSessionType = 'Office' then
   begin
//   edtScanFolder.visible:= false;
//   lblTranscriptionFolder.visible:= false;
//   chkDeleteImport.Visible := false;
//   chkRenameImport.Visible := false;
   cboPhysicians.items.text := comScriptWaveComm.vstlOfficeDocs.text;
   cboPhysicians.items.add('All');
   end
else
   cboPhysicians.items.text:= vstrPhysicianID;
cboPhysicians.ItemIndex:= 0;
comScriptWaveComm.LoadArchiveMonths(cboMonth);
If cboMonth.Items.Count > 0 then
   cboMonth.ItemIndex:= 0;

comScriptWaveComm.LoadEmergency;

vreaStartTime:= now;
vstl:= tstringlist.create;
try
deletefile(vstrAppBaseFolder + 'lockfile.txt');
If fileexists(vstrAppBaseFolder + 'lockfile.txt') then
  begin
  Showmessage('Scriptwave is unable to delete the lock file.  This file tells '+
     'Scriptwave that program is already in use.  The version running now is ' +
     cstrVersion + '. Please logout of the other session to run ScriptWave.');
  end
else
  begin
  AssignFile(vtxtLock, vstrAppBaseFolder + 'lockfile.txt');
  Rewrite(vtxtLock);
  writeln(vtxtLock, 'ScriptWave version ' + cstrVersion + ' started: ' +
                                                            datetimetostr(now));
  CloseFile(vtxtLock);
  AssignFile(vtxtLock, vstrAppBaseFolder + 'lockfile.txt');
  Append(vtxtLock);
  write(vtxtLock, ' ');
  end;
  finally
  vstl.free;
  end;
DragAcceptFiles(self.handle,LongBool(True));
end;

{-----------------------------------------------------------------------------}
procedure TfrmPhysicianMain.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
If not vbolShutdown then
   begin
   frmPhysicianMain.visible := false;
   abort;
   end
else
  begin
  SaveAlerts;
  comScriptWaveComm.shutdown;
  comScriptWaveComm.free;
  comScriptWaveComm:= nil;
  try
  CloseFile(vtxtLock);
  except end;
  end;
end;

procedure TfrmPhysicianMain.SaveAlerts;
var vstlTemp: tstringlist;
    vintLoop: integer;
begin
If grdAlerts.rowcount > 1 then
  If grdAlerts.Cells[1,0] > '  A' then
    begin
    vstlTemp:= tstringlist.create();
    try
    for vintLoop := 1 to grdAlerts.rowcount - 1 do
        vstlTemp.Add(grdAlerts.Cells[0,vintLoop] + '||' +
                     grdAlerts.cells[1,vintLoop]);
  vstlTemp.savetofile(vstrAppBaseFolder + 'ScriptWaveAlerts.txt');
  finally
    vstlTemp.free;
    end;
  end;
end;

procedure TfrmPhysicianMain.LoadAlerts;
var vstlTemp: tstringlist;
    vintLoop: integer;
begin
If fileexists(vstrAppBaseFolder + 'ScriptWaveAlerts.txt') then
    begin
    vstlTemp:= tstringlist.create();
    try
    vstlTemp.loadfromfile(vstrAppBaseFolder + 'ScriptWaveAlerts.txt');
    for vintLoop := 1 to vstlTemp.count - 1 do
        begin
        grdAlerts.RowCount := grdAlerts.RowCount + 1;
        grdAlerts.Cells[0,vintLoop+1]:= copy(vstlTemp[vintLoop],1,
                                             pos('||', vstlTemp[vintLoop])-1);
        grdAlerts.cells[1,vintLoop+1]:= copy(vstlTemp[vintLoop],
                                           pos('||', vstlTemp[vintLoop])+2,999);
        end;
    finally
      vstlTemp.free;
      end;
    end;
end;

{Import a series of files from the default folder}
procedure TfrmPhysicianMain.LoopThroughFiles(const cstrMask: string);
  var vintLoop, vintLoop2, vintFileNumber: integer;
      vbolContinue: boolean;
      vstrFileName: string;

      function GetNewName: string;
         begin
         vbolContinue:= false;
         If (comScriptWaveComm.vstrMonth + '/' + comScriptWaveComm.vstrDay + '/'
              + comScriptWaveComm.vstrYear) = vstrLastImport then
           vintFileNumber:= vintLastImportSeq
         else
           vstrLastImport:= comScriptWaveComm.vstrMonth + '/' +
                            comScriptWaveComm.vstrDay + '/' +
                            comScriptWaveComm.vstrYear;
         repeat
           inc(vintFileNumber);
           vstrFileName:= edtPhysicianID.text + '_' + edtPhysician.text + '_'
            + comScriptWaveComm.vstrMonth + '_' + comScriptWaveComm.vstrDay + '_'
            + comScriptWaveComm.vstrYear + '_' + format('%.4d', [vintFileNumber])
            + '.' + copy(cstrMask,3,3);
           until not Fileexists(vstrMasterDoc + vstrFileName);
         Result:= vstrFileName;
         vintLastImportSeq:= vintFileNumber;
         comScriptWaveComm.SaveDefaults;
         end;

  begin
  lstImportFiles.enabled:= false;
  try                                                   //3/10/2012
  try                                                   //3/10/2012
  lstImportFiles.Directory := vstrTransmitFolder;       //3/10/2012
  lstImportFiles.Refresh;                               //3/10/2012
  lstImportFiles.mask := cstrMask;
  lstImportFiles.enabled:= true;
  vintFileNumber:= 0;
  if lstImportFiles.Items.Count > 0 then
    for vintLoop:= 0 to lstImportFiles.Items.Count - 1 do
      begin
      If copy(lstImportFiles.Items[vintLoop],1,7) = 'IMPORT_' then
      else
        begin
        vstrFileName := GetNewName;
        CopyFile(Pchar(edtScanFolder.text + lstImportFiles.Items[vintLoop]),
                        Pchar(vstrMasterDoc + vstrFileName), false);
        sleep(1000);                                                            //12/10/2006
        If not Fileexists(vstrMasterDoc + vstrFileName) then                    //12/10/2006
          begin                                                                 //12/10/2006
          Logit('Unable to copy from import to MastDoc ' + vstrFileName);       //12/10/2006
          break;                                                                //12/10/2006
          end;                                                                  //12/10/2006

        {----------------------------------------------------------------------}
        comScriptWaveComm.vstrCurrentFile:= vstrFileName;
        comScriptWaveComm.vstrFileImport:= comScriptWaveComm.vstrYear +
                                       comScriptWaveComm.vstrMonth +
                                       comScriptWaveComm.vstrday;
        comScriptWaveComm.vstrFileImportT:= FormatDateTime('hh:mm AM/PM',now);
        comScriptWaveComm.vstrFileTransmit:= '00000000';
        comScriptWaveComm.vstrFileReceived:= '00000000';
        comScriptWaveComm.vstrFileAssigned:= '00000000';
        comScriptWaveComm.vstrFileTyped:=    '00000000';
        comScriptWaveComm.vstrFileReviewed:= '00000000';
        comScriptWaveComm.vstrFileComplete:= '00000000';
        frmImport.edtNew.text := comScriptWaveComm.vstrCurrentFile;
        frmImport.edtOld.text := lstImportFiles.Items[vintLoop];
        frmImport.showmodal;
        comScriptWaveComm.vstrFileComments :=
                                         MemoUnHash(frmImport.memComments.text);
        for vintLoop2 := 1 to 50 do
            begin
            comScriptWaveComm.varrAttachedFiles[1, vintLoop2]:= '';
            comScriptWaveComm.varrAttachedFiles[2, vintLoop2]:= '';
            end;
        {----------------------------------------------------------------------}
        If comScriptWaveComm.InifilesWriteDetail(true) then
          Logit('Imported ' + vstrFileName
                                  + ' from ' +  lstImportFiles.Items[vintLoop])
        else
          begin
          Logit('Unable to import ' + vstrFileName
                                  + ' from ' +  lstImportFiles.Items[vintLoop]);
          ShowMessage('ScriptWave is having a problem importing the file. ' +
          'ScriptWave will restart and try again.');
          vbolRestartINI:= true;
          exit;
          end;
        {----------------------------------------------------------------------}

        If chkRenameImport.checked then
            begin                                                               //12/10/2006
            DeleteFile('IMPORT_' + lstImportFiles.items[vintLoop]);             //12/10/2006
            RenameFile(edtScanFolder.text + lstImportFiles.Items[vintLoop],
                         'IMPORT_' + lstImportFiles.items[vintLoop]);
            end                                                                 //12/10/2006
        else
        If chkDeleteImport.checked then
            DeleteFile(edtScanFolder.text + lstImportFiles.Items[vintLoop]);
        vbolImmediateCommunicate:= true;                                        //12/10/2006
        end;
      end;
      except                                           //3/10/2012
        lstImportFiles.enabled:= false;                //3/10/2012
        end;                                           //3/10/2012
      finally                                          //3/10/2012
        lstImportFiles.enabled:= false;                //3/10/2012
      end;                                             //3/10/2012
  end;

{--------------------------TIMER EVENTS----------------------------------------}

procedure TfrmPhysicianMain.tmrMAINTimer(Sender: TObject);
var
    vstrCntlFile: string;
    vstlTmp: tstringlist;
    vbolRestart: boolean;
    vstrWork: string;
    vintFileLoc: integer;
    {---------------------------------------------------------}
    Procedure FindCommandDownloads(const cstrCntlFile: string);
        var vintLoop, vintLoop2, vintDot, vintHold: integer;
            vstrHoldFile, vstrHoldAltFile: string;
        begin
        vstlTmp:= tstringlist.create;
        try
        vstlTmp.loadfromfile(vstrMasterDoc + cstrCntlFile);
        vintDot:= pos('.',cstrCntlFile);
        comScriptWaveComm.vstrCurrentFile:= copy(cstrCntlFile,3,vintDot + 1);
        If vstlTmp.count > 0 then
           for vintLoop2:= 1 to vstlTmp.count - 1 do
               If length(vstlTmp[vintLoop2]) = 0 then
                   Break
               else
               if vstlTmp[vintLoop2] = '<COMMENTS>' then
                   begin
                   If (vintLoop2 + 1 < vstlTmp.count) then
                      If vstlTmp[vintLoop2 + 1] > '  A' then
                         comScriptWaveComm.InifilesWriteOne
                                           ('Comments', vstlTmp[vintLoop2 + 1]);
                   Break;
                   end
               else
                   begin
                   lblFileTransferName.caption := 'Receiving: '
                                                           + vstlTmp[vintLoop2];
                   vintHold:= 0;
                   for vintLoop:= 0 to
                                   vstlDir.count - 1 do
                      If pos(vstlTmp[vintLoop2],
                            vstlDir[vintLoop]) > 0 then
                          vintHold := vintLoop;
                   vstrHoldAltFile:='';
                   If pos('///',vstlTmp[vintLoop2]) > 0 then
                     begin
                     vstrHoldAltFile:= copy(vstlTmp[vintLoop2],
                                            pos('///',vstlTmp[vintLoop2])+3,
                                            999);
                     vstrHoldFile:= copy(vstlTmp[vintLoop2],
                                            1,
                                            pos('///',vstlTmp[vintLoop2])-1);
                     end
                   else
                     vstrHoldFile:= copy(vstlTmp[vintLoop2],1,
                                                    length(vstlTmp[vintLoop2]));
                   memCommProgress.Lines.add(datetimetostr(now) +
                                                 ' Receiving: ' + vstrHoldFile);
                   comScriptWaveComm.Receive_uncrypt
                      (vstrMasterDoc + vstrHoldFile + '_cry',
                          FindFileReceiveSize(vstlDir[vintHold]), '/');
                   If length(vstrHoldAltFile) > 0 then
                      CopyFile(Pchar(vstrMasterDoc + vstrHoldFile),
                              Pchar(vstrReceiveFolder + vstrHoldAltFile), false)
                   else
                      CopyFile(Pchar(vstrMasterDoc + vstrHoldFile),
                                Pchar(vstrReceiveFolder + vstrHoldFile), false);
                   grdAlerts.RowCount := grdAlerts.RowCount + 1;
                   grdAlerts.Cells[0,grdAlerts.rowcount-1] := 'Received';
                   grdAlerts.cells[1,grdAlerts.rowcount-1] := vstrHoldFile;
                   comScriptWaveComm.InifilesWriteOne(copy(vstrHoldFile,
                                      pos('.',vstrHoldFile)-3,3), vstrHoldFile);
                   comScriptWaveComm.InifilesWriteOne(copy(vstrHoldFile,
                               pos('.',vstrHoldFile)-3,3)+'A', vstrHoldAltFile);
                   lblFileTransferName.caption := '';
                   if vbolAutoPrint then
                     begin
                     ShellExecute(Handle,'open',
                                  pchar(vstrPrintCommand),
                                  pchar(vstrPrintParameter + ' "' +
                                                vstrMasterDoc+vstrHoldFile+'"'),
                                  nil, SW_SHOWNORMAL) ;
                     sleep(3000);
                     end;
                   end;
        finally
           vstlTmp.free;
           end;
        end;
    {-----------------------}
     Procedure CheckForRecallFiles(const cstrControlFile: string);
       var vstrDelete: string;
       begin
       vstrDelete:= copy(cstrControlFile, cintFTPDirOffset+2,999);
       vstrDelete:= copy(vstrDelete,1,pos('.',vstrDelete)+3);
       If FileExists(vstrMasterDoc + vstrDelete) then
         begin
         Logit('Remove File: ' + vstrDelete);
         deletefile(vstrMasterDoc + vstrDelete);
         If FileExists(vstrMasterDoc + 'C_' +
                              copy(cstrControlFile,cintFTPDirOffset+2,999)) then
              deletefile(vstrMasterDoc + 'C_' +
                                  copy(cstrControlFile,cintFTPDirOffset+2,999));
         end;
         If comScriptWaveComm.iniFileControl.SectionExists(vstrDelete) then
           begin
           comScriptWaveComm.iniFileControl.EraseSection(vstrDelete);
           try
             comScriptWaveComm.iniFileControl.UpdateFile;
             except
             comScriptWaveComm.IniFiles_UpdateFile_Override;
             end;
           grdAlerts.RowCount := grdAlerts.RowCount + 1;
           grdAlerts.Cells[0,grdAlerts.rowcount-1] := 'Recalled';
           grdAlerts.cells[1,grdAlerts.rowcount-1] := vstrDelete;
           end;
       end;

    {--------------------------------------------------------------------------}
    Procedure CheckForImportFiles;
      begin
      LoopThroughFiles('*.msv');
      LoopThroughFiles('*.dvf');
      LoopThroughFiles('*.mp3');
      LoopThroughFiles('*.wav');
      LoopThroughFiles('*.dss');  
      LoopThroughFiles('*.dct');
      LoopThroughFiles('*.doc');
      end;
     {-------------------------------------------------------------------------}
     procedure CheckForUploads;
      var vintLoop: integer;
      begin
      comScriptWaveComm.vstlSearchIni.loadfromfile(vstrAppBaseFolder
                                                     + 'ScriptWaveFileControl.ini');
      for vintLoop:= 0 to comScriptWaveComm.vstlSearchIni.count - 1 do
       If comScriptWaveComm.vstlSearchIni[vintLoop] = 'TransmitDate=00000000' then
        begin
        vreaPulseMinutes := 0;
        comScriptWaveComm.vstrCurrentFile:=
          copy(comScriptWaveComm.vstlSearchIni[vintLoop-2],2,
                             length(comScriptWaveComm.vstlSearchIni[vintLoop-2])-2);
        lblFileTransferName.caption := 'Sending: '
                                                + comScriptWaveComm.vstrCurrentFile;
        memCommProgress.Lines.add(datetimetostr(now) +
                                  ' Sending: ' + comScriptWaveComm.vstrCurrentFile);
        if comScriptWaveComm.Crypt_Transmit
                         (vstrMasterDoc + comScriptWaveComm.vstrCurrentFile,'') then
           begin
           //write the control record for the file.
           comScriptWaveComm.InifilesWriteOne('TransmitDate',
                                           comScriptWaveComm.vstrYear +
                                           comScriptWaveComm.vstrMonth +
                                           comScriptWaveComm.vstrDay);
           comScriptWaveComm.InifilesWriteOne('TransmitDateT',
                                           FormatDateTime('hh:mm AM/PM',now));
           vstrCntlFile:= 'C_' + comScriptWaveComm.vstrCurrentFile +
                       '_' + vstrTranscriptionistID +
                       '_' + comScriptWaveComm.InifilesReadOne('ImportDate') +
                       '_' + comScriptWaveComm.InifilesReadOne('TransmitDate') +
                       '_' + comScriptWaveComm.InifilesReadOne('ReceiveDate') +
                       '_' + comScriptWaveComm.InifilesReadOne('AssignDate') +
                       '_' + comScriptWaveComm.InifilesReadOne('TypedDate') +
                       '_' + comScriptWaveComm.InifilesReadOne('ReviewedDate') +
                       '_' + comScriptWaveComm.InifilesReadOne('CompleteDate');
           vstlTmp:= tstringlist.create;
           try
           vstlTmp.text := '<FILES>' + #13#10 + '<COMMENTS>' + #13#10
                        + MemoUnHash(comScriptWaveComm.InifilesReadOne('Comments'));
           vstlTmp.savetofile(vstrAppBaseFolder + vstrCntlFile);
           finally
             vstlTmp.free;
             end;
           memCommProgress.Lines.add(datetimetostr(now) +
                                           ' Sending Command: ' + vstrCntlFile);
           If comScriptWaveComm.Crypt_Transmit
                          (vstrAppBaseFolder + vstrCntlFile,'') then
               begin
               //done with control records
               grdAlerts.RowCount := grdAlerts.RowCount + 1;
               grdAlerts.Cells[0,grdAlerts.rowcount-1] := 'Sent';
               grdAlerts.cells[1,grdAlerts.rowcount-1] :=
                                              comScriptWaveComm.vstrCurrentFile;
               comScriptWaveComm.SendPulse('T001',false);
               end
           else
               begin
               comScriptWaveComm.InifilesWriteOne('TransmitDate', '00000000');
               end;
           deletefile(vstrAppBaseFolder + vstrCntlFile);
           lblFileTransferName.caption := '';
           end;
        end;
      end;
     {----------------------------------------------------}
     function OfficeAdminMatch(const cstrID: string): boolean;
       var vintLoop: integer;
       begin
       Result:= false;
       If vstrSessionType = 'Office' then
          begin
          for vintLoop:= 0 to comScriptWaveComm.vstlOfficeDocs.count - 1 do
              If cstrID = comScriptWaveComm.vstlOfficeDocs[vintLoop] then
                 Result:= true;
          end;
       end;
     {----------------------------------------------------}
       function GetOfficeDownload(const cstrControl: string): boolean;
         var vstrWork: string;
         begin
         Result:= false;
         vstrWork:= copy(cstrControl,1,length(cstrControl)-4);
         If vstrSessionType = 'Office' then
            If not Fileexists(vstrMasterDoc + vstrWork) and
               not Fileexists(vstrMasterDoc +
                              copy(cstrControl,1,length(vstrWork)-8) +
                              '00000000') and
                 (copy(vstrWork,length(vstrWork)-16,8) <> '00000000') then
                   Result := true;
         end;
     {-------- END of loop to transmit new dictation files}
     procedure GetStatusAndDownloadFiles;
       var vintLoop: integer;
           vstrShortCommand: string;
       begin
       if comScriptWaveComm.DirectoryListFTP('') then
         begin
         for vintLoop:= 0 to vstlDir.count - 1 do
          begin
          If copy(vstlDir[vintLoop], cintFTPDirOffset,2) = 'CD' then
            CheckForRecallFiles(vstlDir[vintLoop])
          else
          If copy(vstlDir[vintLoop], cintFTPDirOffset,2) = 'C_' then
            begin
            if (copy(vstlDir[vintLoop],
                                  cintFTPDirOffset+2,4) = vstrPhysicianID) //and
                                             //(vstrSessionType = 'Physician'))
                 or OfficeAdminMatch(copy(vstlDir[vintLoop],
                                                     cintFTPDirOffset+2,4)) then
                begin
                {Get the correct dates into the ini file based on the Server}
                comScriptWaveComm.UpdateFileStatus
                              (copy(vstlDir[vintLoop], cintFTPDirOffset+2,999));
                {Is this file ready to download to the physician?}
                If ((comScriptWaveComm.vstrFileReviewed <> '00000000') and
                    (comScriptWaveComm.vstrFileComplete = '00000000') and
                    (vstrSessionType = 'Physician')) or
                       GetOfficeDownload(copy
                             (vstlDir[vintLoop], cintFTPDirOffset,999)) then
                    begin
                    memCommProgress.Lines.add(datetimetostr(now) +
                             ' Receiving Command: ' +
                               copy(vstlDir[vintLoop], cintFTPDirOffset,999));
                    If comScriptWaveComm.Receive_Uncrypt(vstrMasterDoc +
                       copy(vstlDir[vintLoop], cintFTPDirOffset,999),
                               FindFileReceiveSize(vstlDir[vintLoop]), '/') then
                      {Find all download files in the control file}
                      begin
                      vstrShortCommand:= copy(vstlDir[vintLoop],
                                                         cintFTPDirOffset,999);
                      vstrShortCommand:=
                            copy(vstrShortCommand,1,length(vstrShortCommand)-4);
                      FindCommandDownloads(vstrShortCommand);
//                      if vstrSessionType = 'Physician' then
                        if copy(vstlDir[vintLoop],
                                  cintFTPDirOffset+2,4) = vstrPhysicianID then
                        begin
                        comScriptWaveComm.InifilesWriteOne
                               ('CompleteDate', comScriptWaveComm.vstrYear +
                                                comScriptWaveComm.vstrMonth +
                                                comScriptWaveComm.vstrDay);
                        comScriptWaveComm.InifilesWriteOne('CompleteDateT',
                                             FormatDateTime('hh:mm AM/PM',now));
                        vstrWork := trim(copy(vstlDir[vintLoop],
                                                         cintFTPDirOffset,999));
                        vstrWork := copy(vstrWork,1,length(vstrWork)-12) +
                                             comScriptWaveComm.vstrYear +
                                             comScriptWaveComm.vstrMonth +
                                             comScriptWaveComm.vstrDay + '_cry';
                        comScriptWaveComm.RenameFile(copy(vstlDir[vintLoop],
                                                          cintFTPDirOffset,999),
                           vstrWork, '/');
                        end;
                      end
                    end;
                end;
              {Attempt to download audio file for admins}
              if (OfficeAdminMatch(copy(vstlDir[vintLoop],
                                                    cintFTPDirOffset+2,4))) then
                      begin
                      comScriptWaveComm.vstrCurrentFile:= copy(vstlDir[vintLoop],
                                                    cintFTPDirOffset+2,9999);
                      comScriptWaveComm.vstrCurrentFile:=
                                 copy(comScriptWaveComm.vstrCurrentFile,
                                 1,pos('.',comScriptWaveComm.vstrCurrentFile)+3);
                      vintFileLoc:= FileFinder(vstlDir[vintLoop]);
                      If (vintFileLoc <> -1) and not fileexists(vstrMasterDoc +
                                         comScriptWaveComm.vstrCurrentFile) then
                        begin
                        lblFileTransferName.caption := 'Receiving: ' +
                                              comScriptWaveComm.vstrCurrentFile;
                        comScriptWaveComm.Receive_UnCrypt(vstrMasterDoc +
                                     comScriptWaveComm.vstrCurrentFile + '_cry',
                              FindFileReceiveSize
                              (vstlDir[vintFileLoc]), '/')
                        end;
                      end;


            end;
          end;
         end;
       end;
       {----------------------------------------------------}
       procedure ChecktoUpdateSoftware;
         var vintLoop: integer;
         begin
           {CHECK SOFTWARE VERSION DOWNLOAD}
         If comScriptWaveComm.DirectoryListFTP('Software') then
          begin
          for vintLoop:= 0 to vstlDir.count - 1 do
            If copy(vstlDir[vintLoop],
                       cintFTPDirOffset,27) = 'ScriptWavePhysicianTransfer' then
              If cstrVersion <> copy(vstlDir[vintLoop],
                                                     cintFTPDirOffset+28,3) then
                begin
                lblFileTransferName.caption :=
                                       'Receiving: ScriptWavePhysicianTransfer';
                memCommProgress.Lines.add(datetimetostr(now) +
                                                         ' Receiving Software');
                If comScriptWaveComm.getfile(vstrAppBaseFolder +
                      copy(vstlDir[vintLoop], cintFTPDirOffset,31),
                          'Software',
                          FindFileReceiveSize(vstlDir[vintLoop])) then
                  begin
                  renamefile(vstrAppBaseFolder +
                    copy(vstlDir[vintLoop], cintFTPDirOffset,31),
                    vstrAppBaseFolder +
                    copy(vstlDir[vintLoop], cintFTPDirOffset,28) + 'new');
                   Logit('Received new software version ' +
                   copy(vstlDir[vintLoop], cintFTPDirOffset+29,3));
                  vbolRESTART:= true;
                  grdAlerts.RowCount := grdAlerts.RowCount + 1;
                  grdAlerts.Cells[0,grdAlerts.rowcount-1] := 'Received';
                  grdAlerts.cells[1,grdAlerts.rowcount-1] :=
                     'ScriptWavePhysicianTransfer version: ' +
                                 copy(vstlDir[vintLoop], cintFTPDirOffset+26,3);
                  lblFileTransferName.caption := '';
                  end;
                end;
          end;
         end;
       Procedure CheckForCommands;
          var vintLoop: integer;
         begin
         If comScriptWaveComm.DirectoryListFTP('Command') then
          for vintLoop:= 0 to vstlDir.count - 1 do
            begin
            If copy(vstlDir[vintLoop],
                                      cintFTPDirOffset,4) = vstrPhysicianID then
               begin
               If copy(vstlDir[vintLoop],
                                          cintFTPDirOffset+5,7) = 'SendLog' then
                    cmdSendLogClick(self)
               else
               If copy(vstlDir[vintLoop],
                                     cintFTPDirOffset+5,11) = 'SendFileIni' then
                  begin
                  comScriptWaveComm.Crypt_Transmit
                    (vstrAppBaseFolder + 'ScriptWaveFileControl.ini',
                      'ScriptWave');
                  comScriptWaveComm.renamefile('ScriptWaveFileControl.ini_cry',
                             vstrTranscriptionistID + '_' +
                             vstrPhysicianID + '_ScriptWaveFileControl.ini_cry',
                             'Support');
                  end
               else
               If copy(vstlDir[vintLoop],
                                     cintFTPDirOffset+5,11) = 'Download_P_' then
                  begin
                  comScriptWaveComm.GetFile
                    (vstrAppBaseFolder +
                              copy(vstlDir[vintLoop],
                                                      cintFTPDirOffset+16,999),
                     'Software', 1000000);
                  end;
               comScriptWaveComm.DeleteFTPFile(
                     copy(vstlDir[vintLoop],
                                              cintFTPDirOffset,999), 'Command');
               end;
            end;
         end;   
{------------------------------------------------------------------------------}
begin
application.processmessages;
{Do not communicate when on dictate tab}
If (pagMain.activePage = tabDictate) and
                                     ((pnlRecord.Visible = true)
                                   or (pnlEncoding.visible = true)) then exit;
tmrMain.enabled := false;
vbolRestart:= false;
vbolCommunicating := true;
vreaMinutes := vreaMinutes + 0.1;
vreaPulseMinutes := vreaPulseMinutes + 0.1;
If fileexists(vstrMasterDoc + 'SoxComm.cmd') then
   begin
   Deletefile(vstrMasterDoc + 'SoxComm.cmd');
//   frmPhysicianMain.visible:= true;
   application.processmessages;
   vbolImmediateCommunicate:= true;
   end;

{Every 5 minutes, open the pulse folder to maintain conntection}
If vreaPulseMinutes > 5 then
   begin
   comScriptWaveComm.DirectoryListFTP('Pulse');
   vreaPulseMinutes:= 0;
   If pos(vstrPhysicianID + '.go', vstlDir.text) > 0 then
      vbolImmediateCommunicate:= true;
   end;

try
{Load the ini for control of files to see if any have been imported but not
transmitted.}
{----------------}
comScriptWaveComm.vstrMonth := FormatDateTime('mm', date);
comScriptWaveComm.vstrDay := FormatDateTime('dd', date);
comScriptWaveComm.vstrYear := FormatDateTime('yyyy', date);
{----------------}
//if vstrSessionType = 'Office' then
//else
CheckForImportFiles;
{Attempting to read around immediate communicate while on dictate}
If vbolRestartINI then exit;
{----------------}
If not fileexists(vstrAppBaseFolder + 'ScriptWaveFileControl.ini') then exit;
{----------------}
If (vbolImmediateCommunicate) or (vreaMinutes > 59) then
  begin
  memCommProgress.Lines.clear;
  pnlWait.BringToFront;
  pnlSpace.visible:= false;
  pnlWait.Refresh;
  try
  {----------------}
  memCommProgress.Lines.add(datetimetostr(now) + ' Determine emergency?');
  If fileexists(vstrAppBaseFolder + 'emergency.ip') then
     comScriptWaveComm.CheckToUseEmergency;
  {----------------}
  memCommProgress.Lines.add(datetimetostr(now) + ' Checking Software Update');
  CheckToUpdateSoftware;
  {----------------}
//  if vstrSessionType = 'Office' then
//  else
//    begin
    memCommProgress.Lines.add(datetimetostr(now) + ' Checking Upload Files');
    CheckForUploads;
//    end;
  {----------------}
  memCommProgress.Lines.add(datetimetostr(now)+' Checking Status and Download');
  GetStatusAndDownloadFiles;
  {----------------}
  memCommProgress.Lines.add(datetimetostr(now) + ' Check Emergency IP');
  comScriptWaveComm.DownloadEmergencyIP;
  {----------------}
  memCommProgress.Lines.add(datetimetostr(now)+' Send/Receive Messages');
  SendandReceiveMessages;
  memCommProgress.Lines.add(datetimetostr(now)+' Load Message List');
  LoadMessages;
  {----------------}
  memCommProgress.Lines.add(datetimetostr(now)+' Checking for Commands');
  CheckForCommands;
  {----------------}
  memCommProgress.Lines.add(datetimetostr(now)+' Checking for Archive');
  comScriptWaveComm.ArchiveCompleteFiles;
  comScriptWaveComm.LoadArchiveMonths(cboMonth);
  If cboMonth.Items.Count > 0 then
     cboMonth.ItemIndex:= 0;
  {----------------}
  memCommProgress.Lines.add(datetimetostr(now) + ' Checking for File Purge');
  comScriptWaveComm.PurgeController;
  {----------------}
  memCommProgress.Lines.add(datetimetostr(now)+' Update Screen INI Files');
  LoadAndScanFilesINI;
  comScriptWaveComm.DeleteFTPfile(vstrPhysicianID + '.go', 'Pulse');
  {----------------}
  lblFileTransferName.caption := 'Last Communication at ' + datetimetostr(now);
  vreaMinutes := 0;
  finally
    memCommProgress.Lines.add(datetimetostr(now)+' Communications Done!!!');
    Sleep(2000);
    pnlWait.SendToBack;
    pnlSpace.visible:= true;
    end;
  end;
  
finally
 vbolImmediateCommunicate:= false;
// comScriptWaveComm.ShutdownFTP;
 If vbolAutomatic then
    tmrMAIN.Enabled:= true;
 vbolCommunicating := false;

// If comScriptWaveComm.TransferServer then
//   vbolRestart:= true;

 If vbolRestart or vbolRestartINI or ((now - vreaStartTime) > 1) then
    cmdRestartClick(Self);
 end;
end;

{------------------------------------------------------------------------------}
procedure TfrmPhysicianMain.FormPaint(Sender: TObject);
begin
If not vbolOneTime then
  begin
  vbolOneTime:=true;
  frmPhysicianMain.visible:= false;
  end;
end;

procedure TfrmPhysicianMain.cmdHideClick(Sender: TObject);
begin
frmPhysicianMain.Visible := false;
end;

procedure TfrmPhysicianMain.cmdShutdownClick(Sender: TObject);
begin
vbolShutdown:= true;
frmPhysicianMain.close;
end;

procedure TfrmPhysicianMain.shnShellNotifyDblClick(Sender: TObject;
  Button: TMouseButton);
begin
frmPhysicianMain.visible:= true;
end;

procedure TfrmPhysicianMain.cmdShowClick(Sender: TObject);
begin
frmPhysicianMain.visible:= true;
end;

procedure TfrmPhysicianMain.popTrayMenuPopup(Sender: TObject);
begin
If vbolCommunicating then
   begin
   cmdShow.Enabled := false;
   cmdHide.Enabled := false;
   cmdShutdown.Enabled := false;
   end
else
if frmPhysicianMain.Visible = false then
   begin
   cmdShow.Enabled := true;
   cmdHide.Enabled := false;
   cmdShutdown.Enabled := true;
   end
else
   begin
   cmdShow.Enabled := false;
   cmdHide.Enabled := true;
   cmdShutdown.Enabled := true;
   end;
end;
{------------------------------------------------------------------------------}
procedure TfrmPhysicianMain.tmrBlinkTimer(Sender: TObject);
var vintLoop: integer;
begin
inc(vintBlinkCount);
If vbolBlink then
  If vintBlinkCount = 4 then
    If vbolCommunicating then
      shnShellNotify.SetIconFromIconList(2)
    else
      shnShellNotify.SetIconFromIconList(1)
  else
      shnShellNotify.SetIconFromIconList(0)
else
  shnShellNotify.SetIconFromIconList(0);

If vbolBlinkDictation then
  If vintBlinkCount = 4 then
    imgDictation.picture := imgDictation2.Picture
  else
    imgDictation.picture := imgDictation1.Picture
else
  imgDictation.picture := imgDictation1.Picture;

If vbolBlinkTranscription then
  If vintBlinkCount = 4 then
    imgTranscription.picture := imgTranscription2.Picture
  else
    imgTranscription.picture := imgTranscription1.Picture
else
  imgTranscription.picture := imgTranscription1.Picture;

If vbolBlinkMessages then
  If vintBlinkCount = 4 then
    imgMessages.picture := imgMessages2.Picture
  else
    imgMessages.picture := imgMessages1.Picture
else
  imgMessages.picture := imgMessages1.Picture;

If vintBlinkCount = 4 then
   begin
   vintBlinkCount:= 0;
   vbolBlinkMessages:= false;
   vbolBlinkTranscription := false;
   vbolBlinkDictation := false;
   vbolBlink:= false;
   For vintLoop := 0 to grdAlerts.rowcount - 1 do
      If (grdAlerts.Cells[0,vintLoop] = 'Sent') or
         (grdAlerts.Cells[0,vintLoop] = 'Recalled') then
          vbolBlinkDictation:= true
      else
      If grdAlerts.Cells[0,vintLoop] = 'Received' then
          vbolBlinkTranscription:= true
      else
      If grdAlerts.Cells[0,vintLoop] = 'Message' then
          vbolBlinkMessages:= true;

   If vbolBlinkMessages or vbolBlinkDictation or vbolBlinkTranscription or
      vbolCommunicating then
      vbolBlink := true;
   end;
pnlCommands.repaint;
try
  If medDictation.tracks > 0 then
     gagDictation.Progress := medDictation.Position;
  except
  end;
end;

procedure TfrmPhysicianMain.imgMessagesClick(Sender: TObject);
begin
pagMain.ActivePage := tabmessages;
end;

procedure TfrmPhysicianMain.cmdShowLogClick(Sender: TObject);
begin
  If fileexists(vstrAppBaseFolder+ 'ScriptWave' + vstrSessionType + '.log') then
     frmLogFile.memLog.Lines.LoadFromFile(vstrAppBaseFolder
                                     + 'ScriptWave' + vstrSessionType + '.log');
  frmLogFile.showmodal;
end;

procedure TfrmPhysicianMain.cmdSendLogClick(Sender: TObject);
var vstrWork: string;
begin
  If fileexists(vstrAppBaseFolder+ 'ScriptWave' + vstrSessionType + '.log') then
     begin
     vstrWork :=  vstrMasterDoc + vstrTranscriptionistID + '_' +
              vstrPhysicianID + '_' + 'ScriptWave' + vstrSessionType + '.log';
     CopyFile(Pchar(vstrAppBaseFolder+ 'ScriptWave' + vstrSessionType + '.log'),
              Pchar(vstrWork), false);
     pnlWait.BringToFront;
     pnlSpace.visible:= false;
     pnlWait.Refresh;
     try
       comScriptWaveComm.Crypt_Transmit(vstrWork,'Support');
//       comScriptWaveComm.ShutdownFTP;
     finally
       pnlWait.SendToBack;
       pnlSpace.visible:= true;
       end;
     end;
end;

procedure TfrmPhysicianMain.cmdCommunicate1Click(Sender: TObject);
begin
if tmrMain.enabled or not vbolAutomatic then
  begin
  vbolImmediateCommunicate:= true;
  tmrMAINTimer(self);
  end;
end;

procedure TfrmPhysicianMain.cmdNoAlertsClick(Sender: TObject);
var vintLoop: integer;
begin
If grdAlerts.rowcount > 2 then
  begin
  for vintLoop := 2 to grdAlerts.rowcount do
    begin
    grdAlerts.Cells[0,vintLoop]:='';
    grdAlerts.Cells[1,vintLoop]:='';
    end;
  grdAlerts.rowcount := 2;
  end;
end;

function TfrmPhysicianMain.FindFileReceiveSize
                                         (const cstrDirString: string): longint;
begin
try
  Result:= strtoint(trim(copy(cstrDirString,1,10)));
  except
  Result:=0
  end;
end;

{Preferences recording}
procedure TfrmPhysicianMain.edtWordFolderChange(Sender: TObject);
begin
vstrReceiveFolder:= edtWordFolder.text;
comScriptWaveComm.SaveDefaults;
end;

procedure TfrmPhysicianMain.chkDeleteImportClick(Sender: TObject);
begin
if chkDeleteImport.checked = chkRenameImport.checked then
   chkRenameImport.checked := not chkDeleteImport.checked;
vbolDeleteImport:= chkDeleteImport.checked;
comScriptWaveComm.SaveDefaults;
end;

procedure TfrmPhysicianMain.chkRenameImportClick(Sender: TObject);
begin
if chkRenameImport.checked = chkDeleteImport.checked then
   chkDeleteImport.checked := not chkRenameImport.checked;
vbolRenameImport:= chkRenameImport.checked;
comScriptWaveComm.SaveDefaults;
end;

procedure TfrmPhysicianMain.chkAutomaticClick(Sender: TObject);
begin
vbolAutomatic:= chkAutomatic.checked;
if not vbolAutomatic then
    begin
    lblFileTransferName.caption :=
                    'Warning: Automatic Communication is off - see Preferences';
    tmrMAIN.enabled:= false;
    end
else
    begin
    lblFileTransferName.caption := '';
    tmrMAIN.enabled:= true;
    end;
comScriptWaveComm.SaveDefaults;
end;

procedure TfrmPhysicianMain.imgDictationClick(Sender: TObject);
begin
 pagMain.activepage := tabAlerts;
end;

procedure TfrmPhysicianMain.imgTranscriptionClick(Sender: TObject);
begin
 pagMain.activepage := tabAlerts;
end;

procedure TfrmPhysicianMain.pagMainChange(Sender: TObject);
begin
if pagMain.ActivePage = tabScriptWave then
    webScriptWave.Navigate
                  ('http://www.ScriptWave.net')
else
if pagMain.ActivePage = tabMessages then
    LoadMessages
else
If pagMain.ActivePage = tabPreferences then
    begin
    comScriptWaveComm.LoadEmergency;
    edtEmergencyIP.text:= vstrEmergencyIP;
    end;
end;

procedure TfrmPhysicianMain.LoadAndScanFilesINI;
var vintLoop, vintIndex: integer;
    vstrCategory, vstrWork, vstrHoldDate, vstrHoldNode: string;
    vstlTemp, vstlTemp2: tstringlist;
    trnFind: ttreenode;
     procedure LocateNodeString(const cstrNode: string);
        begin
        Try
          trnFind:=GetNodeByText(treAll,cstrNode,true);
          trnFind.Selected := true;
          except
          end;
        end;
begin
  comScriptWaveComm.vstlSearchIni.loadfromfile(vstrAppBaseFolder
                                                 + 'ScriptWaveFileControl.ini');
  vstlTemp:= tstringlist.create;
  vstlTemp2:= tstringlist.create;
  If treAll.Selected <> nil then
     vstrHoldNode:= treAll.Selected.Text
  else
     vstrHoldNode:= '';
  try
  vstlTemp2.text := 'Imported' + #13#10 + 'Transmitted' + #13#10 + 'Received' +
                    #13#10 + 'Assigned' + #13#10 + 'Typed' + #13#10 +
                    'Reviewed' + #13#10 + 'Completed';
  vstlTemp.SaveToFile(vstrAppBaseFolder + 'b.txt');
  treAll.loadfromfile(vstrAppBaseFolder + 'b.txt');
  deletefile(vstrAppBaseFolder + 'b.txt');

  for vintLoop := comScriptWaveComm.vstlSearchIni.count -  1 downto 0 do
     begin
     vstrWork:= comScriptWaveComm.vstlSearchIni[vintLoop];
     If (copy(vstrWork,1,2) = '[P' ) or
        (copy(vstrWork,1,2) = '[O' ) then
        begin
        try
        If (chkRecent.checked and
           (4 > date - strtodate(copy(vstrHoldDate,5,2) + '/' +
                                 copy(vstrHoldDate,7,2) + '/' +
                                 copy(vstrHoldDate,1,4)))) or
                                                    (not chkRecent.checked) then
           vstlTemp.add(vstrCategory + copy(vstrWork,2,length(vstrWork)-2));
           except
           end;
        vstrCategory:= '';
        end;
     If length(vstrCategory) = 0 then
        begin
        If copy(vstrWork,1,12) = 'ImportDate=2' then
           begin
           vstrCategory := '1';
           vstrHoldDate:= copy(vstrWork,pos('=',vstrWork)+1,999);
           end
        else
        If copy(vstrWork,1,14) = 'TransmitDate=2' then
           begin
           vstrCategory := '2';
           vstrHoldDate:= copy(vstrWork,pos('=',vstrWork)+1,999);
           end
        else
        If copy(vstrWork,1,13) = 'ReceiveDate=2' then
           begin
           vstrCategory := '3';
           vstrHoldDate:= copy(vstrWork,pos('=',vstrWork)+1,999);
           end
        else
        If copy(vstrWork,1,12) = 'AssignDate=2' then
           begin
           vstrCategory := '4';
           vstrHoldDate:= copy(vstrWork,pos('=',vstrWork)+1,999);
           end
        else
        If copy(vstrWork,1,11) = 'TypedDate=2' then
           begin
           vstrCategory := '5';
           vstrHoldDate:= copy(vstrWork,pos('=',vstrWork)+1,999);
           end
        else
        If copy(vstrWork,1,14) = 'ReviewedDate=2' then
           begin
           vstrCategory := '6';
           vstrHoldDate:= copy(vstrWork,pos('=',vstrWork)+1,999);
           end
        else
        If copy(vstrWork,1,14) = 'CompleteDate=2' then
           begin
           vstrCategory := '7';
           vstrHoldDate:= copy(vstrWork,pos('=',vstrWork)+1,999);
           end
        end;
    end;

  vstlTemp.sorted:= true;
  for vintLoop := vstlTemp.count - 1 downto 0 do
    begin
    vstrWork:= vstlTemp[vintLoop];
      If copy(vstrWork,1,1) = '1' then
          vstrCategory:= 'Imported'
      else
      If copy(vstrWork,1,1) = '2' then
          vstrCategory:= 'Transmitted'
      else
      If copy(vstrWork,1,1) = '3' then
          vstrCategory:= 'Received'
      else
      If copy(vstrWork,1,1) = '4' then
          vstrCategory:= 'Assigned'
      else
      If copy(vstrWork,1,1) = '5' then
          vstrCategory:= 'Typed'
      else
      If copy(vstrWork,1,1) = '6' then
          vstrCategory:= 'Reviewed'
      else
      If copy(vstrWork,1,1) = '7' then
          vstrCategory:= 'Completed';
     vintIndex:= vstlTemp2.IndexOf(vstrCategory) + 1;
     vstlTemp2.Insert(vintIndex, #09 +
                       copy(vstlTemp[vintLoop],2,length(vstlTemp[vintLoop])-1));
    end;

   vstlTemp2.savetofile(vstrAppBaseFolder + 'tv.txt');
   treAll.LoadFromFile(vstrAppBaseFolder + 'tv.txt');
   deletefile(vstrAppBaseFolder + 'tv.txt');
   If vstrHoldNode > '  A' then
      begin
      LocateNodeString(vstrHoldNode);
      treAllClick(Self);
      end;
   finally
     vstlTemp.free;
     vstlTemp2.free;
     end;
end;

function TfrmPhysicianMain.GetNodeByText(ATree : TTreeView;
                                         AValue:String;
                                         AVisible: Boolean): TTreeNode;
var
    Node: TTreeNode;
begin
  Result := nil;
  if ATree.Items.Count = 0 then Exit;
  Node := ATree.Items[0];
  while Node <> nil do
  begin
    if UpperCase(Node.Text) = UpperCase(AValue) then
    begin
      Result := Node;
      if AVisible then
        Result.MakeVisible;
      Break;
    end;
    Node := Node.GetNext;
  end;
end;

procedure TfrmPhysicianMain.treAllClick(Sender: TObject);
var vintLoop: integer;
   Function Dateslasher(const cstrDate: string): string;
     begin
     Result:=
       copy(cstrDate,5,2) + '/' + copy(cstrDate,7,2) + '/' + copy(cstrDate,1,4);
     end;
begin
cmdEmail.Enabled:= false;
If treAll.Selected = nil then exit;
If treAll.Selected.Level = 1 then
   begin
   comScriptWaveComm.vstrCurrentFile:= treAll.Selected.text;
   comScriptWaveComm.InifilesLoadDetail;
   edtDictationName.text := comScriptWaveComm.vstrCurrentFile;
   edtImportDate.text:= '';
   If comScriptWaveComm.vstrFileImport <> '00000000' then
     edtImportDate.text := Dateslasher(comScriptWaveComm.vstrFileImport) + ' ' +
                         comScriptWaveComm.vstrFileImportT;
   edtTransmitDate.text:= '';
   If comScriptWaveComm.vstrFileTransmit <> '00000000' then
     edtTransmitDate.text := Dateslasher(comScriptWaveComm.vstrFileTransmit) + ' ' +
                         comScriptWaveComm.vstrFileTransmitT;
   edtReceiveDate.text:= '';
   If comScriptWaveComm.vstrFileReceived <> '00000000' then
     edtReceiveDate.text := Dateslasher(comScriptWaveComm.vstrFileReceived) + ' ' +
                         comScriptWaveComm.vstrFileReceivedT;
   edtAssignDate.text:= '';
   If comScriptWaveComm.vstrFileAssigned <> '00000000' then
     edtAssignDate.text := Dateslasher(comScriptWaveComm.vstrFileAssigned) + ' ' +
                         comScriptWaveComm.vstrFileAssignedT;
   edtTypedDate.text:= '';
   If comScriptWaveComm.vstrFileTyped <> '00000000' then
     edtTypedDate.text := Dateslasher(comScriptWaveComm.vstrFileTyped) + ' ' +
                         comScriptWaveComm.vstrFileTypedT;
   edtReviewDate.text:= '';
   If comScriptWaveComm.vstrFileReviewed <> '00000000' then
     edtReviewDate.text := Dateslasher(comScriptWaveComm.vstrFileReviewed) + ' ' +
                         comScriptWaveComm.vstrFileReviewedT;
   edtCompleteDate.text:= '';
   If comScriptWaveComm.vstrFileComplete <> '00000000' then
     edtCompleteDate.text := Dateslasher(comScriptWaveComm.vstrFileComplete) + ' ' +
                         comScriptWaveComm.vstrFileCompleteT;
   medDictation.FileName := vstrMasterDoc + comScriptWaveComm.vstrCurrentFile;
   memFileComments.text:= MemoHash(comScriptWaveComm.vstrFileComments);
   cmdEmail.Enabled:= true;
   try
   medDictation.open;
   gagDictation.maxvalue := medDictation.Length;
     except
     end;
   grdTranscribedfiles.rowcount := 2;
   grdTranscribedfiles.cells[0,1] := '';
   grdTranscribedFiles.cells[0,0] := 'Transcribed files';
   cmdOpenDoc.enabled := false;
   for vintLoop := 1 to 50 do
     If comScriptWaveComm.varrAttachedFiles[1, vintLoop] > '  A' then
        begin
        grdTranscribedFiles.cells[0,grdTranscribedFiles.rowcount-1] :=
                               comScriptWaveComm.varrAttachedFiles[1, vintLoop];
        grdTranscribedFiles.rowcount:= grdTranscribedFiles.RowCount + 1;
        cmdOpenDoc.enabled := true;
        end;
   if grdTranscribedFiles.rowcount > 2 then
      grdTranscribedFiles.RowCount := grdTranscribedFiles.rowcount - 1;
   if grdTranscribedFiles.rowcount > 1 then
      edtAltName.text:= comScriptWaveComm.varrAttachedFiles[2, 1];
   end;
end;

procedure TfrmPhysicianMain.cmdOpenDocClick(Sender: TObject);
begin
try
if grdTranscribedFiles.row > 0 then
   if fileexists(vstrMasterDoc +
                     grdTranscribedFiles.cells[0,grdTranscribedFiles.Row]) then
       ShellExecute(0, 'open',
             PChar(vstrMasterDoc +
             grdTranscribedFiles.cells[0,grdTranscribedFiles.Row]),
             pchar(''), nil, SW_SHOWNORMAL);
   except
   Showmessage('Sorry, unable to open this file');
   end;
end;

function TfrmPhysicianMain.MemoHash(const cstrMemo: string): string;
 var vintLoop: integer;
     vstrWork: string;
begin
vintLoop := 1;
while vintLoop <= length(cstrMemo) do
   begin
   If copy(cstrMemo,vintLoop,2) = '||' then
      begin
      inc(vintLoop);
      vstrWork := vstrWork + #13#10;
      end
   else
       vstrWork := vstrWork + copy(cstrMemo,vintLoop,1);
   inc(vintLoop);
   Result:= vstrWork;
   end;
end;

function TfrmPhysicianMain.MemoUnHash(const cstrMemo: string): string;
 var vintLoop: integer;
     vstrWork: string;
begin
vintLoop := 1;
while vintLoop <= length(cstrMemo) do
   begin
   If copy(cstrMemo,vintLoop,2) = #13#10 then
      begin
      inc(vintLoop);
      vstrWork := vstrWork + '||';
      end
   else
       vstrWork := vstrWork + copy(cstrMemo,vintLoop,1);
   inc(vintLoop);
   end;
   Result:= vstrWork;
end;

procedure TfrmPhysicianMain.grdAlertsDblClick(Sender: TObject);
var vintLoop, vintCol, vintRow: integer;
begin
grdAlerts.MouseToCell(vintgrdCol, vintgrdRow, vintCol, vintRow);
If grdAlerts.RowCount > 2 then
  begin
  for vintLoop := vintRow to grdAlerts.Rowcount - 2 do
       begin
       grdAlerts.Cells[0,vintLoop] := grdAlerts.Cells[0,vintLoop+1];
       grdAlerts.Cells[1,vintLoop] := grdAlerts.Cells[1,vintLoop+1];
       end;
  grdAlerts.Cells[0,grdAlerts.rowcount-1] := '';
  grdAlerts.Cells[1,grdAlerts.rowcount-1] := '';
  grdAlerts.rowcount:= grdAlerts.rowcount-1;
  end;
end;

procedure TfrmPhysicianMain.grdAlertsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    vintgrdRow:= y;
    vintgrdCol:= x;
end;

{------------------------------------------------------------------------------}
procedure TfrmPhysicianMain.cmdNewMessageClick(Sender: TObject);
begin
cmdNewMessage.enabled := false;
cmdReplyMessage.enabled := false;
cmdDeleteMessage.enabled := false;
cmdMailIt.Enabled := true;
cmdCancelMail.enabled := true;
edtToMail.text := vstrTranscriptionist;
edtFromMail.text := vstrPhysician;
edtDateTimeMail.text := datetimetostr(now);
edtSubjectMail.readonly := false;
memMessage.readonly := false;
edtSubjectMail.text := '';
memMessage.lines.text := '';
lblTechSupport.visible:= true;
end;

procedure TfrmPhysicianMain.cmdCancelMailClick(Sender: TObject);
begin
ResetAfterMessage;
end;

procedure TfrmPhysicianMain.cmdMailitClick(Sender: TObject);
var vstlTemp: tstringlist;
begin
vreaPulseMinutes := 0;
If (length(edtSubjectMail.text) = 0) or (length(memMessage.lines.text) = 0) then
   begin
   Showmessage('Please make sure you have a Subject and Memo.');
   exit;
   end;
vstlTemp:= tstringlist.create();
try
   pnlMessageComm.visible:= true;
   application.processmessages;
   vstlTemp.Text := edtSubjectMail.text + #13#10 + memMessage.text;
   If edtToMail.text = 'Tech Support' then
     vstlTemp.savetofile(vstrMessages +
       vstrPhysicianID + '_Tech_' +
       floattostr(strtodatetime(edtDateTimeMail.text)))
   else
     vstlTemp.savetofile(vstrMessages +
       vstrPhysicianID + '_T001_' +
       floattostr(strtodatetime(edtDateTimeMail.text)));
   SendandReceiveMessages;
   If edtToMail.text = 'Tech Support' then
      comScriptWaveComm.SendPulse('Tech',false)
   else
      comScriptWaveComm.SendPulse('T001',false);
finally
   pnlMessageComm.visible:= false;
   vstlTemp.free;
   end;
ResetAfterMessage;
LoadMessages;
end;

procedure TfrmPhysicianMain.ResetAfterMessage;
begin
cmdNewMessage.enabled := true;
cmdMailIt.Enabled := false;
cmdCancelMail.enabled := false;
edtFromMail.text := '';
edtToMail.text := '';
edtDateTimeMail.text := '';
edtSubjectMail.readonly := true;
memMessage.readonly := true;
edtSubjectMail.text := '';
memMessage.lines.text := '';
lblTechSupport.visible:= false;
end;

procedure TfrmPhysicianMain.LoadMessages;
var vintLoop: integer;
    vstrWork, vstrHoldNode: string;
    trnFind : TTreeNode;
    vdatTemp: tdatetime;
    vstlSort, vstlSent, vstlSentA, vstlRec, vstlRecA, vstlPend: tstringlist;
     procedure LocateNodeString(const cstrNode: string);
        begin
        trnFind:=GetNodeByText(treMessages,cstrNode,true);
        trnFind.Selected := true;
        end;
begin
If treMessages.Selected <> nil then
   vstrHoldNode:= treMessages.Selected.Text
else
   vstrHoldNode:= '';
lstMessages.update;
treMessages.items.Clear;
{for vintLoop := treMessages.Items.Count - 1 downto 0 do
    if treMessages.Items[vintLoop].Level > 0 then
       treMessages.Items[vintLoop].Delete;}

vstlSort:= tstringlist.create();
vstlSent:= tstringlist.create();
vstlSentA:= tstringlist.create();
vstlRec:= tstringlist.create();
vstlRecA:= tstringlist.create();
vstlPend:= tstringlist.create();
vstlSort.sorted:=true;
try
{Find Sent, sort...}
for vintLoop:= 0 to lstMessages.Items.Count - 1 do
  if copy(lstMessages.Items[vintLoop],1,5) = 'Sent_' then
     vstlSort.add (copy(lstMessages.Items[vintLoop],16,999));
for vintLoop:= 0 to vstlSort.Count - 1 do
   begin
   vstrWork := vstlSort[vintLoop];
   if pos('_cry',vstrWork) > 0 then
   else
     begin
     vdatTemp:= strtofloat(vstrWork);
     If date > vdatTemp + 30 then
        vstlSentA.add(#09 + datetimetostr(vdatTemp))
//        LocateNodeString('Sent Archive')
     else
        vstlSent.add(#09 + datetimetostr(vdatTemp));
//        LocateNodeString('Sent');
//     treMessages.Items.AddChild(trnFind, datetimetostr(vdatTemp));
     end
   end;
vstlSort.clear;
{Find received}
for vintLoop:= 0 to lstMessages.Items.Count - 1 do
  if (copy(lstMessages.Items[vintLoop],6,4) = vstrPhysicianID)
     and (copy(lstMessages.Items[vintLoop],1,5) <> 'Sent_') then
     vstlSort.add (copy(lstMessages.Items[vintLoop],11,999));
for vintLoop:= 0 to vstlSort.Count - 1 do
   begin
   vstrWork := vstlSort[vintLoop];
   if pos('_cry',vstrWork) > 0 then
   else
     begin
     vdatTemp:= strtofloat(vstrWork);
     If date > vdatTemp + 30 then
        vstlRecA.add(#09 + datetimetostr(vdatTemp))
//        LocateNodeString('Received Archive')
     else
        vstlRec.add(#09 + datetimetostr(vdatTemp));
//        LocateNodeString('Received');
//     treMessages.Items.AddChild(trnFind, datetimetostr(vdatTemp));
     end
   end;
vstlSort.clear;
{Find pending}
for vintLoop:= 0 to lstMessages.Items.Count - 1 do
  if copy(lstMessages.Items[vintLoop],1,4) = vstrPhysicianID then
     vstlSort.add (copy(lstMessages.Items[vintLoop],11,999));
for vintLoop:= 0 to vstlSort.Count - 1 do
   begin
   vstrWork := vstlSort[vintLoop];
   if pos('_cry',vstrWork) > 0 then
   else
     begin
//     LocateNodeString('Pending transmission');
     vdatTemp:= strtofloat(vstrWork);
     vstlPend.add(#09 + datetimetostr(vdatTemp));
//     treMessages.Items.AddChild(trnFind, datetimetostr(vdatTemp));
     end
   end;
vstlRec.text:= 'Received' + #13#10 + vstlRec.text +
               'Sent' + #13#10 + vstlSent.text +
               'Pending transmission' + #13#10 + vstlPend.text +
               'Received archive' + #13#10 + vstlRecA.text +
               'Sent archive' + #13#10 + vstlSentA.text;
vstlRec.savetofile(vstrAppBaseFolder + 'm.txt');
treMessages.loadfromfile(vstrAppBaseFolder + 'm.txt');
treMessages.Refresh;
deletefile(vstrAppBaseFolder + 'm.txt');
If vstrHoldNode > '  A' then
   begin
   LocateNodeString(vstrHoldNode);
   treMessagesclick(self);
   end;

finally
  vstlSort.free;
  vstlSent.free;
  vstlSentA.free;
  vstlRec.free;
  vstlRecA.free;
  vstlPend.free;
  end;
end;

function TfrmPhysicianMain.FindMessageFile(const cstrDateTime: string): string;
   var vintLoop: integer;
   begin
   lstMessages.update;
   for vintLoop:= 0 to lstMessages.Items.count - 1 do
      If pos(cstrDateTime, lstMessages.Items[vintLoop]) > 0 then
        begin
        Result:= lstMessages.Items[vintLoop];
        break;
        end;
   end;

procedure TfrmPhysicianMain.treMessagesClick(Sender: TObject);
var vstlTemp: tstringlist;
    vintLoop: integer;
    vstrMessageFile: string;
begin
memMessage.lines.text := '';
cmdReplyMessage.enabled:= false;
If treMessages.Selected <> nil then
If treMessages.Selected.Level = 1 then
  begin
  vstlTemp:= tstringlist.create();
  try
    try
       vstrMessageFile:=
          FindMessageFile(floattostr(strtodatetime(treMessages.Selected.text)));
       vstlTemp.loadfromfile(vstrMessages + vstrMessageFile);
       except
       exit;
       end;
    if treMessages.Selected.Parent.Text = 'Received' then
         begin
         edtToMail.text:= vstrPhysician;
         If pos('Tech', vstrMessageFile) > 0 then
            edtFromMail.text:= 'Tech Support'
         else
            edtFromMail.text:= vstrTranscriptionist;
         cmdReplyMessage.enabled:= true;
         end
    else
         begin
         If pos('Tech', vstrMessageFile) > 0 then
            edtToMail.text:= 'Tech Support'
         else
            edtToMail.text:= vstrTranscriptionist;
         edtFromMail.text:= vstrPhysician;
         end;
  edtDateTimeMail.text:= treMessages.Selected.text;
  edtSubjectMail.text:= vstlTemp[0];
  for vintLoop := 1 to vstlTemp.count - 1 do
      memMessage.lines.add(vstlTemp[vintLoop]);
    finally
       vstlTemp.free;
       end;
  cmdDeleteMessage.enabled:= true;
  end
else
  begin
  ResetAfterMessage;
  cmdDeleteMessage.enabled:= false;
  cmdReplyMessage.enabled:= false;
  end;
end;

procedure TfrmPhysicianMain.cmdDeleteMessageClick(Sender: TObject);
begin
If treMessages.Selected.Level = 1 then
    begin
    if (treMessages.Selected.Parent.Text = 'Sent') or
       (treMessages.Selected.Parent.Text = 'Sent archive') then
         begin
         deletefile(vstrMessages + 'Sent_' + vstrPhysicianID +
               '_T001_' + floattostr(strtodatetime(treMessages.Selected.text)));
         deletefile(vstrMessages + 'Sent_' + vstrPhysicianID +
               '_Tech_' + floattostr(strtodatetime(treMessages.Selected.text)));
         end
    else
    if (treMessages.Selected.Parent.Text = 'Received') or
       (treMessages.Selected.Parent.Text = 'Received archive') then
         deletefile(vstrMessages + 'T001_' +
                   vstrPhysicianID + '_' +
                   floattostr(strtodatetime(treMessages.Selected.text)))
    else
         begin
         deletefile(vstrMessages + vstrPhysicianID + '_T001_' +
                   floattostr(strtodatetime(treMessages.Selected.text)));
         deletefile(vstrMessages + vstrPhysicianID + '_Tech_' +
                   floattostr(strtodatetime(treMessages.Selected.text)));
         end;

    cmdDeleteMessage.enabled:= false;
    cmdReplyMessage.enabled:= false;
    ResetAfterMessage;
    treMessages.items.Clear;
    LoadMessages;
    end;
end;

procedure TfrmPhysicianMain.cmdReplyMessageClick(Sender: TObject);
begin
cmdNewMessage.enabled := false;
cmdReplyMessage.enabled := false;
cmdDeleteMessage.enabled := false;
cmdMailIt.Enabled := true;
cmdCancelMail.enabled := true;
edtToMail.text := edtFromMail.text;
//edtToMail.text := vstrTranscriptionist;
edtFromMail.text := vstrPhysician;
edtDateTimeMail.text := datetimetostr(now);
edtSubjectMail.readonly := false;
memMessage.readonly := false;
if pos('Re: ', edtSubjectMail.text) = 0 then
  edtSubjectMail.text := 'Re: ' + edtSubjectMail.text;
memMessage.lines.text := #13#10
  + '=================================================='
                                               + #13#10 + memMessage.lines.text;
end;

Procedure TfrmPhysicianMain.SendandReceiveMessages;
var vintLoop: integer;
    vstrFile: string;
begin
{Receiving Messages}
comScriptWaveComm.DirectoryListFTP('Messages');
for vintLoop := 0 to vstlDir.count - 1 do
   begin
   vstrFile:= copy
             (vstlDir[vintLoop],cintFTPDirOffset,999);
   if copy(vstrFile,6,4) = vstrPhysicianID then
      begin
      Logit('Receiving Message ' + vstrFile);
      if comScriptWaveComm.Receive_UnCrypt(vstrMessages + vstrFile,
                        FindFileReceiveSize(vstlDir[vintLoop]), 'Messages') then
        begin
        comScriptWaveComm.Renamefile(vstrFile,
                                 'Received_' + vstrFile,
                                 'Messages');
        grdAlerts.RowCount := grdAlerts.RowCount + 1;
        grdAlerts.Cells[0,grdAlerts.RowCount - 1]:= 'Message';
        If copy(vstrFile,1,4) <> 'Tech' then
          grdAlerts.Cells[1,grdAlerts.RowCount - 1]:=
                            'New message received from ' + vstrTranscriptionist
        else
          grdAlerts.Cells[1,grdAlerts.RowCount - 1]:=
                                       'New message received from tech support';
        end;
      end;
   end;
{Sending Messages}
lstMessages.update;
for vintLoop := 0 to lstMessages.items.count - 1 do
   begin
   vstrFile := lstMessages.items[vintLoop];
   if (copy(vstrFile,1,4) = vstrPhysicianID) and
                                                (pos('_cry', vstrFile) = 0) then
      begin
      Logit('Sending Message ' + vstrFile);
      If copy(vstrFile,6,4) = 'Tech' then
        begin
        copyfile(pchar(vstrMessages + vstrFile),
                 pchar(vstrMessages + vstrTranscriptionistID + '_' + vstrFile),
                 false);
        If comScriptWaveComm.Crypt_Transmit(vstrMessages +
                          vstrTranscriptionistID + '_' +vstrFile,'Support') then
          Renamefile(vstrMessages + vstrFile, vstrMessages +  'Sent_' + vstrFile);
        deletefile(vstrMessages + vstrTranscriptionistID + '_' + vstrFile);
        end
      else
        If comScriptWaveComm.Crypt_Transmit(vstrMessages+vstrFile,'Messages') then
          Renamefile(vstrMessages + vstrFile, vstrMessages +  'Sent_' + vstrFile);
      end;
   end;

LoadMessages;
end;

procedure TfrmPhysicianMain.cmdExitClick(Sender: TObject);
begin
close;
end;


procedure TfrmPhysicianMain.WMQueryEndSession
           (var Msg : TWMQueryEndSession) ;
begin
shnShellNotify.Free;
msg.Result:= 1;
end;

procedure TfrmPhysicianMain.WMEndSession
           (var Msg : TWMEndSession) ;
begin
inherited;
vbolShutdown:= true;
frmPhysicianMain.close;
end;

procedure TfrmPhysicianMain.grdTranscribedFilesClick(Sender: TObject);
begin
edtAltName.text:= comScriptWaveComm.varrAttachedFiles
                                                   [2, grdTranscribedFiles.Row];
end;

procedure TfrmPhysicianMain.cmdPrintClick(Sender: TObject);
var vstlRpt: tstringlist;
    vintLoop, vintDictation, vintTrans: integer;
    vbolPrint, vbolHeader: boolean;
    vstrWork, vstrWork2, vstrHoldImport: string;

    function CheckForImportFile: boolean;
      var vintFile: integer;
      begin
      vstrHoldImport := '';
      Result:= false;
      If Copy(vstrWork,1,9) = 'Comments=' then
         begin
         vintFile := pos('File: ', vstrWork);
         If vintFile > 0 then
            begin
            vstrHoldImport := copy(vstrWork,vintFile + 6,999);
            If pos('||', vstrHoldImport) > 0 then
                vstrHoldImport:= copy(vstrHoldImport,1,
                                                  pos('||', vstrHoldImport)-1);
            Result:= true;
            end;
         end;
      end;

begin
If (length(cboMonth.text) = 0) and
   (length(cboPhysicians.text) = 0) then
   exit;
lblPleaseWait.visible:= true;
application.processmessages;
vstlRpt:= tstringlist.create;
try
  vintDictation:= 0;
  vintTrans:= 0;
  vstlRpt.LoadFromFile(vstrArchive + copy(cboMonth.Text,4,4) +
                                     copy(cboMonth.Text,1,2) + '.ini');
  vbolPrint:= false;
  vbolHeader:= false;
  rptReport:= trptReport.create(nil);
  try
  for vintLoop := 0 to vstlRpt.count - 1 do
     begin
     vstrWork := vstlRpt[vintLoop];
     If copy(vstrWork,1,1) = '[' then
       If (cboPhysicians.text = 'All') or
          (cboPhysicians.text = copy(vstrWork,2,4)) then
            begin
            vbolHeader:= false;
            vbolPrint:= true;
            rptReport.memReportDetail.Lines.Add
                (#13#10 + copy(vstrWork,2,length(vstrWork)-2));
            inc(vintDictation);
            end
       else
            vbolPrint:= false;
     If vbolPrint then
        begin
        If CheckForImportFile then
            rptReport.memReportDetail.Lines.Add('     Import File: ' +
                                                                vstrHoldImport);
        If (copy(vstrWork,1,1) = 'T') and (copy(vstrWork,4,1) = '=')then
            begin
            If vbolHeader then
              rptReport.memReportDetail.Lines.Add('               ' +
                 copy(vstrWork,5,999))
            else
              rptReport.memReportDetail.Lines.Add('     Word Doc: ' +
                 copy(vstrWork,5,999));
            vbolHeader:= true;
            inc(vintTrans);
            end;
        If (copy(vstrWork,1,1) = 'T') and (copy(vstrWork,5,1) = '=') and
           (length(copy(vstrWork,6,999)) > 2) then
            rptReport.memReportDetail.Lines.Add('               AKA: ' +
                 copy(vstrWork,6,999));
        If copy(vstrWork,1,11) = 'ImportDate=' then
            begin
            vstrWork2:= rptReport.memReportDetail.lines
                                      [rptReport.memReportDetail.lines.count-1];
            vstrWork2:= vstrWork2 + StringOfChar(' ', 62 - length(vstrWork2)) +
            copy(vstrWork,16,2)
            + '\' + copy(vstrWork,18,2)
            + '\' + copy(vstrWork,12,4);
            rptReport.memReportDetail.lines
                         [rptReport.memReportDetail.lines.count-1] := vstrWork2;
            end;
        If copy(vstrWork,1,13) = 'CompleteDate=' then
            begin
            vstrWork2:= rptReport.memReportDetail.lines
                                      [rptReport.memReportDetail.lines.count-1];
            vstrWork2:= vstrWork2 + StringOfChar(' ', 75 - length(vstrWork2)) +
            copy(vstrWork,18,2)
            + '\' + copy(vstrWork,20,2)
            + '\' + copy(vstrWork,14,4);
            rptReport.memReportDetail.lines
                         [rptReport.memReportDetail.lines.count-1] := vstrWork2;
            end;
        end;
     end;
  rptReport.lblCompany2.caption:= vstrTranscriptionist;
  rptReport.lblDictationTotal.caption := inttostr(vintDictation);
  rptReport.lblTransTotal.caption := inttostr(vintTrans);
  rptReport.lblTitle2.caption := cboMonth.Text;
  rptReport.Preview;
  application.processmessages;
    finally
    rptReport.destroy;
    rptReport:=nil;
    end;
finally
 lblPleaseWait.visible:= false;
 vstlRpt.free;
 end;
end;

procedure TfrmPhysicianMain.chkPurgeOnClick(Sender: TObject);
begin
vbolPurge:= chkPurgeOn.checked;
If not chkPurgeOn.checked then
   begin
   cboPurgeMain.itemindex:= 0;
   cboPurgeImport.itemindex:= 0;
   cboPurgeTranscription.itemindex:= 0;
   vstrPurgeMaster:= 'Never';
   vstrPurgeImport:= 'Never';
   vstrPurgeTranscription:= 'Never';
   end;
comScriptWaveComm.SaveDefaults;
end;

procedure TfrmPhysicianMain.cboPurgeMainChange(Sender: TObject);
begin
vstrPurgeMaster:= cboPurgeMain.text;
comScriptWaveComm.SaveDefaults;
end;

procedure TfrmPhysicianMain.cboPurgeImportChange(Sender: TObject);
begin
vstrPurgeImport:= cboPurgeImport.text;
comScriptWaveComm.SaveDefaults;
end;

procedure TfrmPhysicianMain.cboPurgeTranscriptionChange(Sender: TObject);
begin
vstrPurgeTranscription:= cboPurgeTranscription.text;
comScriptWaveComm.SaveDefaults;
end;

procedure TfrmPhysicianMain.cmdRestartClick(Sender: TObject);
var vstlRestart: tstringlist;
begin
vstlRestart:= tstringlist.create;
try
vstlRestart.savetofile(vstrMasterDoc + 'SoxComm.cmd');
  finally
  vstlRestart.free;
  end;
ShellExecute(Handle, 'open', pchar(vstrAppBaseFolder
                           + 'ScriptWaveProself.exe'), nil, nil, SW_SHOWNORMAL);
cmdShutdownClick(self);
end;

procedure TfrmPhysicianMain.cmdDictationResendClick(Sender: TObject);
begin
If fileexists(vstrMasterDoc + edtDictationName.Text) then
   begin
   comScriptWaveComm.InitializeFTP;
   pnlWait.BringToFront;
   pnlSpace.visible:= false;
   pnlWait.Refresh;
   try
     memCommProgress.Lines.clear;
     memCommProgress.Lines.add(datetimetostr(now) + ' Re-send File: '
                                                      + edtDictationName.Text );
     application.processmessages;
     Logit('Re-send File: ' + edtDictationName.Text);
     comScriptWaveComm.Crypt_Transmit(vstrMasterDoc + edtDictationName.Text,'');
     finally
      lblFileTransferName.caption := '';
      pnlWait.SendToBack;
      pnlSpace.visible:= true;
//      comScriptWaveComm.ShutdownFTP;
     end;
   end;
end;

procedure TfrmPhysicianMain.cmdTransReReceiveClick(Sender: TObject);
begin
   comScriptWaveComm.InitializeFTP;
   pnlWait.BringToFront;
   pnlSpace.visible:= false;
   pnlWait.Refresh;
   try
     memCommProgress.Lines.clear;
     memCommProgress.Lines.add(datetimetostr(now) + ' Re-receive File: ' +
                        grdTranscribedFiles.cells[0,grdTranscribedFiles.Row]);
     application.processmessages;
     Logit('Re-receive File: ' +
                          grdTranscribedFiles.cells[0,grdTranscribedFiles.Row]);
     comScriptWaveComm.Receive_uncrypt(vstrMasterDoc +
           grdTranscribedFiles.cells[0,grdTranscribedFiles.Row] + '_cry',
                                                                   2000000,'/');
     copyfile(pchar(vstrMasterDoc +
                          grdTranscribedFiles.cells[0,grdTranscribedFiles.Row]),
              pchar(vstrReceiveFolder + edtAltName.text),false);
     finally
      lblFileTransferName.caption := '';
      pnlWait.SendToBack;
      pnlSpace.visible:= true;
//      comScriptWaveComm.ShutdownFTP;
     end;
end;

{------------------------------------------------------------------------------}
//RECORDER STUFF

procedure TfrmPhysicianMain.waveOutFeedChunk(sender: unavclInOutPipe;
  data: Pointer; len: Cardinal);
var
  sz: unsigned;
begin
  //
  sz := min(f_memUsed - f_memOffs, len);
  if (0 < sz) then
    begin
    //
    waveOut.write(@f_memBlock[f_memOffs], sz);
    inc(f_memOffs, sz);
    //
    c_fftBand.fft.write(@f_memBlock[f_memOffs], sz);
    end
  else
    // stop playback
    StopRecord;
end;


procedure TfrmPhysicianMain.c_btn_startClick(Sender: TObject);
begin
  waveOut.close();
  try
  waveIn2.open();
    except
    CreateWaveIn(true);
    exit;
    end;
  f_memOffs := f_memUsed;
  if (not waveIn2.active) then
    CreateWaveIn(true)
  else
    begin
    c_trackBar_pos.enabled := false;
    c_btn_stop.enabled := true;
    c_btn_play.enabled := false;
    c_btn_start.enabled := false;
    c_btn_cut.enabled := false;
    vintTestTime:= 0;
    vintBackupCount:= 0;
    pnlTest_Record.Color := clYellow;
    pnlTest_Record.Caption:= 'RECORDING - RECORDING - RECORDING - RECORDING';
    end;
end;

procedure TfrmPhysicianMain.c_timer_mainTimer(Sender: TObject);
begin
try
  c_progressBar_memLoad.position := round((f_memUsed / maxsize) *
                                                            c_trackbar_pos.max);
  c_progressBar_level.position := waveIn2.waveInDevice.getVolume() div 100;
  if vbolAudioTest and (vintAudioLevel <  c_progressBar_level.position) then
    vintAudioLevel:= c_progressBar_level.position;
  {------------------------------------------}
  inc(vintBackupCount);
  If vintBackupCount = 1200 then
     SaveDictationCopy('Dictation1Backup.wav')
  else
  If vintBackupCount = 2400 then
     begin
     vintBackupCount := 0;
     SaveDictationCopy('Dictation2Backup.wav');
     end;
  {------------------------------------------}
  If vbolAudioTest then
     begin
     inc(vintTestTime);
     If vintTestTime > 35 then
       begin
       vbolAudioTest:= false;
       vintTestTime:= 0;
       StopRecord;
       If vintAudioLevel < 30 then
         begin
         mrealloc(f_memBlock);
         f_memOffs := 0;
         f_memUsed := 0;
         ShowMessage('The audio level of this recording is too low.  Please ' +
            'adjust your microphone or turn microphone boost on.  Try the ' +
            'test again');
         pnlTest_Record.caption:=
                              'CLICK AND SPEAK FOR 3 SECONDS TO TEST RECORDING';
         end
       else
         begin
         f_memOffs := 0;
         c_btn_playClick(Self);
         ShowMessage('Audio level is good - ready to record');
         pnlRecord.Visible:= true;
         f_memOffs := 0;
         f_memUsed := 0;
         pnlTest_Record.caption:= '';
         forcedirectories(vstrAppBaseFolder + '\RecordTemp');
         cmdRecover1.enabled:= true;
         cmdRecover2.enabled:= true;
         end;
       end;
     end;
  //
  f_tbpTimer := true;
  try
    c_trackBar_pos.position:= round((f_memOffs / maxsize) * c_trackbar_pos.max);
  finally
    f_tbpTimer := false;
  end;
except
  end;
end;

procedure TfrmPhysicianMain.SaveDictationCopy(const cstrFile: string);
  begin
    if (0 < f_memUsed) then
    begin
    DeleteFile(vstrAppBaseFolder + '\RecordTemp\' + cstrFile);
    try
      wavReadWrite.pcmFormat := waveIn2.pcmFormat;
      except
      CreateWaveIn(false);
      wavReadWrite.pcmFormat := waveIn2.pcmFormat;
      end;
    wavReadWrite.saveToFile(vstrAppBaseFolder + '\RecordTemp\' + cstrFile,
                                                         f_memBlock, f_memUsed);
    end;
  end;

procedure TfrmPhysicianMain.c_btn_stopClick(Sender: TObject);
begin
  StopRecord;
  try
  SaveDictationCopy('Dictation1Backup_' + floattostr(now) + '.wvb');
  flbBackups.ApplyFilePath(vstrAppBaseFolder + '\RecordTemp\');
  except end;
end;

procedure TfrmPhysicianMain.StopRecord;
begin  
  pnlTest_Record.Color := clBtnface;
  pnlTest_Record.Caption:= 'STOP  -  STOP  -  STOP  -  STOP  -  STOP';
  try
  waveIn2.close();
    except
    CreateWaveIn(false);
    end;
  waveOut.close();
  c_trackBar_pos.enabled := true;
  c_btn_stop.enabled := false;
  c_btn_play.enabled := true;
  c_btn_start.enabled := true;
  c_btn_cut.enabled := true;
end;

procedure TfrmPhysicianMain.waveInDataAvailable(sender: unavclInOutPipe;
  data: Pointer; len: Cardinal);
var
  sz: unsigned;
begin
  sz := min(maxSize - f_memOffs, len);
  //
  if (0 < sz) then
  // overwrite
      move(data^, f_memBlock[f_memOffs], sz);
  //
  // adjust offsets
  inc(f_memOffs, sz);
  //
  if (f_memUsed < f_memOffs) then
      f_memUsed := f_memOffs;
  //
  if (0 >= sz) then
    begin
    // stop recording/loading
    c_btn_stopClick(Self);
    // close file
    wavReadWrite.close();
    end;
end;

procedure TfrmPhysicianMain.c_btn_playClick(Sender: TObject);
begin
  try
  waveIn2.close();
    except
    CreateWaveIn(false);
    end;
  //
//  c_fftBand.fft.open();
  //
  waveOut.open();
  if (not waveOut.active) then
    //
    guiMessageBox(handle, waveOut.waveErrorAsString,
                  'Unable to open playback device', MB_OK or MB_ICONERROR)
  else
    begin
    //c_trackBar_pos.enabled := false;
    c_btn_start.enabled := false;
    c_btn_stop.enabled := true;
    c_btn_play.enabled := false;
    // start self-feeding cycle
    waveOut.waveOutDevice.flush();
    end;
end;

procedure TfrmPhysicianMain.c_btn_cutClick(Sender: TObject);
begin
  f_memUsed := f_memOffs;
end;

procedure TfrmPhysicianMain.c_trackBar_posChange(Sender: TObject);
var vintPoint: unsigned;
begin
  if (not f_tbpTimer) then begin
    //
    //f_memOffs := (c_trackBar_pos.position shl 17) and $FFFFFFFC;
    vintPoint := round(maxSize *
                            (c_trackbar_pos.position/c_trackbar_pos.max));
    f_memOffs:= 16* round((vintPoint/16));
    if (f_memOffs > f_memUsed) then
      f_memOffs := f_memUsed;
  end;
end;

procedure TfrmPhysicianMain.pnlTest_RecordClick(Sender: TObject);
begin
{Recorder -------------------------------------------------------------------}
If f_memBlock = nil then
  begin
  f_memBlock := malloc(maxSize);
  f_memOffs := 0;
  f_memUsed := 0;
  vbolAudioTest:= true;
  vintAudioLevel:= 0;
  vintTestTime:= 0;
  c_timer_main.enabled:= true;
  c_btn_startClick(self);
  end;
end;

procedure TfrmPhysicianMain.btnSaveClick(Sender: TObject);
  var vstrRealFile: string;
      SEInfo: TShellExecuteInfo;
      ExitCode: DWORD;
begin
  pnlEncoding.Visible:= true;
  pnlEncoding.BringToFront;
  try
  // stop wave processing (if any)
  c_timer_main.enabled:= false;
  c_btn_stopclick(Self);
  //
  // save the memory content
  if (0 < f_memUsed) then
    begin
    DeleteFile(vstrAppBaseFolder + '\RecordTemp\Current.wav');
    DeleteFile(vstrAppBaseFolder + '\RecordTemp\Current.mp3');
    try
    wavReadWrite.pcmFormat := waveIn2.pcmFormat;
      except
      CreateWaveIn(false);
      wavReadWrite.pcmFormat := waveIn2.pcmFormat;
      end;
    wavReadWrite.saveToFile(vstrAppBaseFolder + '\RecordTemp\Current.wav',
                                                         f_memBlock, f_memUsed);
    vstrRealFile:=
                 'ScriptWave_Recorder_' + inttostr(round(now * 10000)) + '.mp3';

   FillChar(SEInfo, SizeOf(SEInfo), 0) ;
   SEInfo.cbSize := SizeOf(TShellExecuteInfo) ;
   with SEInfo do
     begin
     fMask := SEE_MASK_NOCLOSEPROCESS;
     Wnd := Application.Handle;
     lpFile := PChar(vstrAppBaseFolder + '\lame.exe') ;
     lpParameters := PChar('-m m -V 4 ' +
                     vstrAppBaseFolder + '\RecordTemp\Current.wav ' +
                     vstrAppBaseFolder + '\RecordTemp\Current.mp3');
     lpDirectory := PChar(vstrAppBaseFolder) ;
     nShow := SW_HIDE;
     end;
    if ShellExecuteEx(@SEInfo) then
     begin
     repeat
       Application.ProcessMessages;
       GetExitCodeProcess(SEInfo.hProcess, ExitCode) ;
     until (ExitCode <> STILL_ACTIVE) or Application.Terminated;
     end
    else
       Showmessage('Unable to run LAME comversion to MP3');
    If Fileexists(vstrAppBaseFolder + '\RecordTemp\Current.mp3') then
      begin
      copyfile(pchar(vstrAppBaseFolder + '\RecordTemp\Current.mp3'),
               pchar(edtScanFolder.text + '\' + vstrRealFile),
               false);
      vbolNoDialog:= true;
      btnCancelRecord.click;
      vbolNoDialog:= false;
      end
    else
      Showmessage('Problem in saving dictation file.  Please try again.');
    end
  else
    showMessage
          ('There is no valid voice recording in memory - please record first');
  finally
  pnlEncoding.visible:= false;
  end;
end;

procedure TfrmPhysicianMain.btnCancelRecordClick(Sender: TObject);
begin
  if vbolNoDialog then
  else
    ShowMessage('Just in case, the current recording will be saved in Emergency'
            + ' backup #1');
  SaveDictationCopy('Dictation1Backup.wav');
  mrealloc(f_memBlock);
  f_memOffs := 0;
  f_memUsed := 0;
  pnlTest_Record.caption:= 'CLICK AND SPEAK FOR 3 SECONDS TO TEST RECORDING';
  pnlTest_Record.BringToFront;
  pnlTest_Record.refresh;
  pnlRecord.visible:= false;
  c_timer_main.Enabled:= false;
  cmdRecover1.enabled:= false;
  cmdRecover2.enabled:= false;
end;

procedure TfrmPhysicianMain.pnlLameClick(Sender: TObject);
begin
comScriptWaveComm.InitializeFTP;
If comScriptWaveComm.getfile(vstrAppBaseFolder + 'lame.exe',
                          'Software',
                          500000) then
  begin
  pnlTest_Record.visible:= true;
  pnlLame.visible:= false;
  end
else
  deletefile(vstrAppBaseFolder + 'lame.exe');
//comScriptWaveComm.shutdownftp;
end;

procedure TfrmPhysicianMain.cmdRecover1Click(Sender: TObject);
begin
SalvageFile('Dictation1Backup.wav');
end;

procedure TfrmPhysicianMain.cmdRecover2Click(Sender: TObject);
begin
SalvageFile('Dictation2Backup.wav');
end;

Procedure TfrmPhysicianMain.SalvageFile(const cstrFile: string);
begin
StopRecord;
wavReadWrite.fileName := vstrAppBaseFolder + '\RecordTemp\' + cstrFile;
wavReadWrite.isInput := true;
f_memOffs := 0;
f_memUsed := 0;
wavReadWrite.open();

try
  waveIn2.pcmFormat := wavReadWrite.waveStream.dstFormat;
  waveOut.pcmFormat := waveIn2.pcmFormat;
  except
  CreateWaveIn(false);
  waveIn2.pcmFormat := wavReadWrite.waveStream.dstFormat;
  waveOut.pcmFormat := waveIn2.pcmFormat;
  end;
end;

procedure TfrmPhysicianMain.cmdChangePasswordClick(Sender: TObject);
  var vstl: tstringlist;
begin
If length(edtChangePassword.text) > 0 then
  begin
//  vstrPassword:= edtChangePassword.text;
  vstl:= tstringlist.create;
  try
    vstl.LoadFromFile(vstrAppBaseFolder + 'ScriptWaveAccount_'
                                          + copy(vstrSessionType,1,1) + '.cry');
    vstl.text:= UnCryptorString(vstl[0]);
    vstl.text := copy(vstl.text,1,50)+ format('%-20s',[edtChangePassword.text])
                                                       + copy(vstl.text,71,999);
    vstl.text:= CryptorString(vstl[0]);
    vstl.savetofile(vstrAppBaseFolder + 'ScriptWaveAccount_'
                                          + copy(vstrSessionType,1,1) + '.cry');
    finally
      vstl.free;
    end;
  end;
end;

procedure TfrmPhysicianMain.lblTechSupportClick(Sender: TObject);
begin
edtToMail.text:= 'Tech Support';
end;

procedure TfrmPhysicianMain.cmdHelpClick(Sender: TObject);
var vstrLink: string;
begin
If pagMain.ActivePageIndex = 0 then
   vstrLink:= 'www.scriptwave.net/PhysicianHelp/status_of_work.html'
else
If pagMain.ActivePageIndex = 1 then
   vstrLink:= 'www.scriptwave.net/PhysicianHelp/alerts.html'
else
If pagMain.ActivePageIndex = 2 then
   vstrLink:= 'www.scriptwave.net/PhysicianHelp/messages.html'
else
If pagMain.ActivePageIndex = 3 then
   vstrLink:= 'www.scriptwave.net/TypistHelp/dictate.html'
else
If pagMain.ActivePageIndex = 4 then
   vstrLink:= 'www.scriptwave.net/PhysicianHelp/reports.html'
else
If pagMain.ActivePageIndex = 5 then
   vstrLink:= 'www.scriptwave.net/PhysicianHelp/preferences.html'
else
   vstrLink:= 'www.scriptwave.net/documentation.html';
webScriptWave.Navigate(vstrLink);
pagMain.ActivePageIndex:= 6;
end;

procedure TfrmPhysicianMain.edtScanFolderExit(Sender: TObject);
begin
//If (directoryexists(edtScanFolder.text)) and          //3/10/2012
if (length(edtScanFolder.text) > 2) then                //3/10/2012
  begin
  If copy(edtScanFolder.text,length(edtScanFolder.text),1) <> '\' then
     edtScanFolder.text := edtScanFolder.text + '\';
  vstrTransmitFolder:= edtScanFolder.text;
  comScriptWaveComm.SaveDefaults;
//  lstImportFiles.Directory := vstrTransmitFolder;     //3/10/2012
//  lstImportFiles.Refresh;                             //3/10/2012
  end;
end;

procedure TfrmPhysicianMain.chkAutoPrintClick(Sender: TObject);
begin
vbolAutoPrint:= chkAutoPrint.checked;
comScriptWaveComm.SaveDefaults;
end;

procedure TfrmPhysicianMain.edtPrintCommandExit(Sender: TObject);
begin
vstrPrintCommand:= edtPrintCommand.text;
comScriptWaveComm.SaveDefaults;
end;

procedure TfrmPhysicianMain.chkRecentClick(Sender: TObject);
begin
LoadAndScanFilesINI;
end;

procedure TfrmPhysicianMain.edtPrintParameterExit(Sender: TObject);
begin
vstrPrintParameter:= edtPrintParameter.text;
comScriptWaveComm.SaveDefaults;
end;

{Search Word Documents begin}
procedure TfrmPhysicianMain.edtSearchWordChange(Sender: TObject);
begin
If length(edtSearchWord.text) > 0 then
   cmdSearch.enabled:= true;
end;

procedure TfrmPhysicianMain.cmdSearchClick(Sender: TObject);
begin
lblSearching.visible:= true;
edtCountSearch.visible:= true;
try
comScriptWaveComm.SearchInFiles(
              edtSearchWord.text,
              cboDocSearchPrefix.Items[cboDocSearchPrefix.itemindex],
              lstSearchResults,
              edtCountSearch);
finally
   lblSearching.visible:= false;
   edtCountSearch.visible:= false;
   end;
end;

procedure TfrmPhysicianMain.lstSearchResultsDblClick(Sender: TObject);
begin
try
If lstSearchResults.ItemIndex > -1 then
   if fileexists(vstrMasterDoc +
                     lstSearchResults.items[lstSearchResults.ItemIndex]) then
       ShellExecute(0, 'open',
             PChar(vstrMasterDoc +
             lstSearchResults.items[lstSearchResults.ItemIndex]),
             pchar(''), nil, SW_SHOWNORMAL);
   except
   Showmessage('Sorry, unable to open this file');
   end;
end;
{Search Word Documents end}

procedure TfrmPhysicianMain.edtEmergencyIPExit(Sender: TObject);
begin
If length(edtEmergencyIP.text) > 11 then
  comScriptWaveComm.SaveEmergency(edtEmergencyIP.text);
end;


{This will be the routine to receive a file drop event, decrypt it, and shell
to execute the file.  This will allow encrypted files to be sent through email}
procedure TfrmPhysicianMain.WMDropFiles(var message: TWMDropFiles);
var FileName, vstrNewFile: String;
    NameLen: Integer;
//    Receiver: TControl;
begin
//  Receiver := Self; {if no control, files were dropped in the form's client area}
  { Now, get the number of files dropped... }
  FileName := '';
  { get the name's lenght of file[i] }
  NameLen := DragQueryFile(message.Drop, 0, nil, 0);
  inc(NameLen);
  SetLength(FileName, NameLen);
  { and finally get the filename }
  DragQueryFile(message.Drop, 0, PChar(FileName), NameLen);
  filename:= copy(filename,1,length(filename)-1);
  if lowercase(copy(FileName, length(FileName)-2, 3)) = 'cry' then
     begin
     vstrNewFile:= vstrFTP + Nopath(FileName);
     vstrNewFile:= copy(vstrNewfile,1,length(vstrNewfile)-4);
     UnCryptorFile(vstrNewFile, FileName);
     ShellExecute(0, 'open',
                  PChar(vstrNewFile),
                  pchar(''), nil, SW_SHOWNORMAL);
     end;
  { Since we're done with the files, finish the drag'n'drop operation }
  DragFinish(message.Drop);
  message.Result := 0;
end;

procedure TfrmPhysicianMain.cmdEmailClick(Sender: TObject);
var
  myOlApp, myItem, myAttachments: OleVariant;
begin
  CryptorFile(vstrMasterDoc + comScriptWaveComm.vstrCurrentFile,
              vstrFTP + comScriptWaveComm.vstrCurrentFile + '_cry');
  try
    myOlApp := CreateOLEObject('Outlook.Application');
    myItem := myOlApp.CreateItem(olMailItem);
    myItem.Subject := 'ScriptWave attached file';
    myAttachments := myItem.Attachments;
    myAttachments.Add(vstrFTP + comScriptWaveComm.vstrCurrentFile + '_cry',
                    olByValue, 1, 'ScriptWave File');
    myItem.Display;
    myItem := VarNull;
    myAttachments := VarNull;
    myOlApp := VarNull;
    except
    end;
end;

procedure TfrmPhysicianMain.flbBackupsDblClick(Sender: TObject);
begin
if not c_btn_stop.enabled then
 If flbBackups.ItemIndex > -1 then
  SalvageFile(flbBackups.Items[flbBackups.itemindex]);
end;

procedure TfrmPhysicianMain.CreateWaveIn(const cbolMessage: boolean);
begin
If cbolMessage then
   begin
   c_timer_main.enabled:= false;
   Showmessage('Unable to restart recording.  Program will try again when you '
              + 'hit record again');
   end;
If waveIn2 <> Nil then
  begin
  WaveIn2.Free;
  WaveIn2:= nil;
  end;
waveIn2:= TunavclWaveInDevice.create(nil);
waveIn2.calcVolume:= true;
waveIn2.pcm_numChannels:= 1;
waveIn2.pcm_samplesPerSec:= 11025;
waveIn2.onDataAvailable:= waveInDataAvailable;
waveIn2.addConsumer(c_fftBand.fft);
If cbolMessage then
  c_timer_main.enabled:= true;
end;

procedure TfrmPhysicianMain.cmdGearplayerClick(Sender: TObject);
begin
If fileexists(vstrMasterDoc + comScriptWaveComm.vstrCurrentFile) then
    ShellExecute(0, 'open',
       PChar(vstrMasterDoc + comScriptWaveComm.vstrCurrentFile),
       pchar(''),
       pchar(vstrMasterDoc), SW_SHOWNORMAL)
end;

end.

