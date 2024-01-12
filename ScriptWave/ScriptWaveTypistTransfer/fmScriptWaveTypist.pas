unit fmScriptWaveTypist;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, FileCtrl, 
  ExtCtrls, StdCtrls, ComCtrls, ToolWin, ImgList,
  TNShellNotifyIcon, Menus, jpeg, Grids, Gauges, ShellApi, MPlayer,                   
  Buttons, OleCtrls, SHDocVw,
  unaDspControls, unaVCIDE, unaTypes, unaUtils, unaClasses, CheckLst,
  comobj, outlook8, SBSimpleSftp;

const
  //
  // -- max buffer size --
  //
  //  maxSize	= 80000;
  maxSize	= 81300000;	// 81 MB

type
  TfrmTypistMain = class(TForm)
    pagMain: TPageControl;
    tabStatus: TTabSheet;
    tabPreferences: TTabSheet;
    lblTypist: TLabel;
    edtTypist: TEdit;
    lblTypistID: TLabel;
    edtTypistID: TEdit;
    lblTranscriptionist: TLabel;
    edtTranscriptionist: TEdit;
    Label1: TLabel;
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
    Label2: TLabel;
    grdTranscribedFiles: TStringGrid;
    lblComments: TLabel;
    medDictation: TMediaPlayer;
    gagDictation: TGauge;
    cmdOpenDoc: TSpeedButton;
    Label4: TLabel;
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
    cboTypists: TComboBox;
    lblAssignedto: TLabel;
    cmdImportDoc: TSpeedButton;
    dlgAddWord: TOpenDialog;
    cmdTypistComplete: TSpeedButton;
    lstMastDoc: TFileListBox;
    cmdReturnToDoc: TSpeedButton;
    cboMessageTo: TComboBox;
    edtMessageTo: TEdit;
    cmdGearplayer: TSpeedButton;
    pnlSpacer1: TPanel;
    pnlSpacer3: TPanel;
    lblAltName: TLabel;
    edtAltName: TEdit;
    tabFTP: TTabSheet;
    lblStep1: TLabel;
    Label5: TLabel;
    lblStep3: TLabel;
    cmdFTPnow: TSpeedButton;
    cboFTPrecipient: TComboBox;
    cmdFTPselect: TSpeedButton;
    memFTPHistory: TMemo;
    edtFTPFile: TEdit;
    cmdFTPClear: TSpeedButton;
    dlgAddFTP: TOpenDialog;
    cmdDeleteMessage: TSpeedButton;
    cmdReplyMessage: TSpeedButton;
    tabScriptWave: TTabSheet;
    webScriptWave: TWebBrowser;
    memCommProgress: TMemo;
    lblImportDate: TLabel;
    edtImportDate: TEdit;
    lblTypeDate: TLabel;
    edtTypedDate: TEdit;
    edtReviewDate: TEdit;
    edtCompleteDate: TEdit;
    lblCompleteDate: TLabel;
    lblReviewDate: TLabel;
    edtAssignDate: TEdit;
    edtReceiveDate: TEdit;
    edtTransmitDate: TEdit;
    lblTransmitDate: TLabel;
    lblReceiveDate: TLabel;
    lblAssignDate: TLabel;
    lblPlay: TLabel;
    tabReport: TTabSheet;
    lblStep1R: TLabel;
    lblStep3R: TLabel;
    cmdPrint: TSpeedButton;
    lblPleaseWait: TLabel;
    cboMonth: TComboBox;
    cboR_Typist: TComboBox;
    lblStep2R: TLabel;
    shp2: TShape;
    chkAutomatic: TCheckBox;
    shp3: TShape;
    edtScanFolder: TEdit;
    lblTranscriptionFolder: TLabel;
    chkDeleteImport: TCheckBox;
    chkRenameImport: TCheckBox;
    edtWordFolder: TEdit;
    lblReceiveFolder: TLabel;
    chkPurgeOn: TCheckBox;
    cboPurgeMain: TComboBox;
    cboPurgeImport: TComboBox;
    cboPurgeTranscription: TComboBox;
    lblPurgeN: TLabel;
    lblPurgeT: TLabel;
    lblImportD: TLabel;
    lblMainP: TLabel;
    Shape1: TShape;
    lblPlayer: TLabel;
    edtAudioPlayer: TEdit;
    cmdDelAttachment: TSpeedButton;
    cmdDictationDelete: TSpeedButton;
    pnlRetry: TPanel;
    cmdDictationResend: TButton;
    cmdDictationReReceive: TButton;
    cmdTransResend: TButton;
    cmdTransReReceive: TButton;
    lblSpecial: TLabel;
    cmdNewEntity: TButton;
    cmdRestart: TButton;
    imgLogo: TImage;
    tabDictate: TTabSheet;
    wavReadWrite: TunavclWaveRiff;
    waveOut: TunavclWaveOutDevice;
    pnlTest_Record: TPanel;
    c_progressBar_level: TProgressBar;
    pnlRecord: TPanel;
    lblMinutes: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    c_trackBar_pos: TTrackBar;
    c_progressBar_memLoad: TProgressBar;
    c_btn_start: TButton;
    c_btn_stop: TButton;
    c_btn_play: TButton;
    c_btn_cut: TButton;
    btnSave: TButton;
    btnCancelRecord: TButton;
    pnlLame: TPanel;
    lblLame: TLabel;
    lblEncode: TLabel;
    linVol: TShape;
    lblVolumeLow: TLabel;
    lblVolOK: TLabel;
    c_fftBand: TunadspFFTControl;
    cmdRecover1: TButton;
    cmdRecover2: TButton;
    pnlEncoding: TPanel;
    Shape2: TShape;
    Shape3: TShape;
    lblPswdOverride: TLabel;
    edtChangePassword: TEdit;
    lblPswdNote: TLabel;
    cmdChangePassword: TButton;
    cmdAddComment: TSpeedButton;
    lblSize: TLabel;
    lblFileSizeDisplay: TLabel;
    pnlSpacer2: TPanel;
    cmdHelp: TSpeedButton;
    pnlStatus: TPanel;
    treAll: TTreeView;
    pnmFilter: TPanel;
    cboStatusFilter: TComboBox;
    lblFilter: TLabel;
    tabICD9: TTabSheet;
    lblICD9: TLabel;
    c_timer_main: TTimer;
    chkRecent: TCheckBox;
    chkShowStat: TCheckBox;
    cmdAssignments: TSpeedButton;
    pnlAssignments: TPanel;
    chkAssigns: TCheckListBox;
    pnlHoldTop: TPanel;
    cmdAssignAll: TSpeedButton;
    cmdCancelAssign: TSpeedButton;
    lblTypists: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    lstTypists: TListBox;
    lstAssigned: TListBox;
    cmdRouteRule: TButton;
    pnlRouteRules: TPanel;
    cboPhysicianRouteRules: TComboBox;
    Label20: TLabel;
    lstRules: TListBox;
    Label21: TLabel;
    cmdNewRule: TSpeedButton;
    Shape4: TShape;
    lstSearchResults: TListBox;
    cmdSearch: TSpeedButton;
    lblRptGen: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    cboDocSearchPrefix: TComboBox;
    Label25: TLabel;
    edtSearchWord: TEdit;
    Label26: TLabel;
    Label27: TLabel;
    edtCountSearch: TEdit;
    lblSearching: TLabel;
    pnlMessageComm: TPanel;
    cboAdminRouteRules: TComboBox;
    Label12: TLabel;
    Label13: TLabel;
    cmdExitRules: TSpeedButton;
    cmdDeleteRule: TSpeedButton;
    Label14: TLabel;
    edtEmergencyIP: TEdit;
    cmdEmail: TSpeedButton;
    cmdEmailDoc: TSpeedButton;
    lstR_Physicians: TListBox;
    Label17: TLabel;
    flbBackups: TFileListBox;
    Label18: TLabel;
    Label19: TLabel;
    cmdMessagePurge: TButton;
    dteMessagePurge: TDateTimePicker;
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
    procedure cboTypistsChange(Sender: TObject);
    procedure cmdImportDocClick(Sender: TObject);
    procedure cmdTypistCompleteClick(Sender: TObject);
    procedure cmdReturnToDocClick(Sender: TObject);
    procedure cmdGearplayerClick(Sender: TObject);
    procedure edtAudioPlayerChange(Sender: TObject);
    procedure grdTranscribedFilesClick(Sender: TObject);
    procedure cboFTPrecipientChange(Sender: TObject);
    procedure cmdFTPnowClick(Sender: TObject);
    procedure cmdFTPClearClick(Sender: TObject);
    procedure cmdFTPselectClick(Sender: TObject);
    procedure cmdNewEntityClick(Sender: TObject);
    procedure edtAltNameKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdDeleteMessageClick(Sender: TObject);
    procedure cmdReplyMessageClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure chkPurgeOnClick(Sender: TObject);
    procedure cboPurgeMainChange(Sender: TObject);
    procedure cboPurgeImportChange(Sender: TObject);
    procedure cboPurgeTranscriptionChange(Sender: TObject);
    procedure cmdDelAttachmentClick(Sender: TObject);
    procedure cmdRestartClick(Sender: TObject);
    procedure cmdDictationDeleteClick(Sender: TObject);
    procedure edtDictationNameChange(Sender: TObject);
    procedure cmdDictationResendClick(Sender: TObject);
    procedure cmdTransResendClick(Sender: TObject);
    procedure cmdDictationReReceiveClick(Sender: TObject);
    procedure cmdTransReReceiveClick(Sender: TObject);
    procedure waveOutFeedChunk(sender: unavclInOutPipe; data: Pointer;
      len: Cardinal);
    procedure c_btn_startClick(Sender: TObject);
    procedure c_timer_mainTimer(Sender: TObject);
    procedure c_btn_stopClick(Sender: TObject);
    procedure waveInDataAvailable(sender: unavclInOutPipe; data: Pointer;
      len: Cardinal);
    procedure c_btn_playClick(Sender: TObject);
    procedure c_btn_cutClick(Sender: TObject);
    procedure c_trackBar_posChange(Sender: TObject);
    procedure pnlTest_RecordClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelRecordClick(Sender: TObject);
    procedure pnlLameClick(Sender: TObject);
    procedure cmdRecover1Click(Sender: TObject);
    procedure cmdRecover2Click(Sender: TObject);
    procedure cmdChangePasswordClick(Sender: TObject);
    procedure cmdAddCommentClick(Sender: TObject);
    procedure cmdHelpClick(Sender: TObject);
    procedure cboStatusFilterChange(Sender: TObject);
    procedure edtScanFolderExit(Sender: TObject);
    procedure chkRecentClick(Sender: TObject);
    procedure cmdAssignmentsClick(Sender: TObject);
    procedure cmdCancelAssignClick(Sender: TObject);
    procedure chkAssignsClick(Sender: TObject);
    procedure cmdAssignAllClick(Sender: TObject);
    procedure lstTypistsClick(Sender: TObject);
    procedure edtSearchWordChange(Sender: TObject);
    procedure cmdSearchClick(Sender: TObject);
    procedure lstSearchResultsDblClick(Sender: TObject);
    procedure cmdRouteRuleClick(Sender: TObject);
    procedure cmdExitRulesClick(Sender: TObject);
    procedure cmdDeleteRuleClick(Sender: TObject);
    procedure lstRulesClick(Sender: TObject);
    procedure cmdNewRuleClick(Sender: TObject);
    procedure edtEmergencyIPExit(Sender: TObject);
    procedure cmdEmailClick(Sender: TObject);
    procedure cmdEmailDocClick(Sender: TObject);
    procedure flbBackupsDblClick(Sender: TObject);
    procedure cmdMessagePurgeClick(Sender: TObject);
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
    vbolNoTreeRefresh: boolean;
    vbolRestartIni: boolean;
    vintBlinkCount: integer;
    vintgrdRow: integer;
    vintgrdCol: integer;
    vintAudioLevel: integer;
    vintTestTime: integer;
    vintBackupCount: integer;
    vreaMinutes: real;
    vreaPulseMinutes: real;
    vreaStartTime: real;
    vstrRouteName: string;

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
    procedure SendDocumentsToServer(const cstrType: string);
    procedure LoadMessages;
    function FindMessageFile(const cstrDateTime: string): string;
    function GetNodeByText(ATree : TTreeView;
                           AValue:String;
                           AVisible: Boolean): TTreeNode;
    function MemoHash(const cstrMemo: string): string;
    function MemoUnHash(const cstrMemo: string): string;
    procedure ResetAfterMessage;
    procedure EntityInit;
    Procedure WMEndSession(var Msg : TWMEndSession);
    message WM_ENDSESSION;
    procedure WMQueryEndSession(var Msg : TWMQueryEndSession);
    message WM_QueryEndSession;
    procedure WMDropFiles(var message: TWMDropFiles); message WM_DROPFILES;
    procedure SaveDictationCopy(const cstrFile: string);
    Procedure SalvageFile(const cstrFile: string);
    function BeginAssign: boolean;
    procedure AssignLoop;
    procedure EndAssign;
    procedure StopRecord;
public
    { Public declarations }
  end;

var
  frmTypistMain: TfrmTypistMain;

const cstrVersion : string = '186';

implementation    

uses fmLogForm, fmImportComment, pmScriptWaveShare, pmScriptWaveShareVariable,
  rpBasic, pmUtilities, pmVariablesConstants, Math, fmScriptWaveComment,
  pmScriptWave_mudCryptor, pmScriptWaveFTP_II;

{$R *.DFM}


procedure TfrmTypistMain.FormCreate(Sender: TObject);
var vintLoop: integer;
begin
vintBlinkCount:= 0;
vbolNoTreeRefresh:= false;
vbolBlink := false;
vbolNoDialog:= false;
vbolBlinkDictation := false;
vbolBlinkTranscription := false;
vbolBlinkMessages := false;
shnShellNotify.SetIconFromIconList(0);
comScriptWaveComm:= tcomScriptWaveCommunicator.create;
barTransmitS:= barTransmit;
{Session Sepcific code}
vstrSessionType:= 'Typist';
cboDocSearchPrefix.ItemIndex:=0;
{---------------------}
comScriptWaveComm.setup;

Logit('Starting software version ' + cstrVersion);

edtScanFolder.Text := vstrTransmitFolder;
edtWordFolder.Text := vstrReceiveFolder;
edtAudioPlayer.Text := vstrAudioPlayer;
edtTypist.text := vstrTypist;
edtTypistID.text := vstrTypistID;
edtTranscriptionist.text := vstrTranscriptionist;
edtTranscriptionistID.text := vstrTranscriptionistID;
chkAutomatic.checked:= vbolAutomatic;
chkAutomaticClick(self);
chkRenameImport.checked:= vbolRenameImport;
chkDeleteImport.checked:= vbolDeleteImport;
{----------------------}
chkPurgeOn.checked:= vbolPurge;
cboPurgeMain.itemindex := cboPurgeMain.Items.IndexOf(vstrPurgeMaster);
cboPurgeImport.itemindex := cboPurgeImport.Items.IndexOf(vstrPurgeImport);
cboPurgeTranscription.itemindex :=
                    cboPurgeTranscription.Items.IndexOf(vstrPurgeTranscription);
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

frmTypistMain.caption :=frmTypistMain.caption + ' Licensed By ' +
                            vstrTranscriptionist;
EntityInit;
LoadAndScanFilesINI;

If fileexists(vstrAppBaseFolder + 'lame.exe') then
  begin
  pnlTest_Record.visible:= true;
  pnlLame.visible:= false;
  end;
CreateWaveIn(false);

if vstrTypistID = 'T001' then
   begin
   cmdRouteRule.enabled:= true;
   for vintLoop:= 0 to comScriptWaveComm.vstlEntity.count - 1 do
     If (copy(comScriptWaveComm.vstlEntity[vintLoop],1,1) = 'P') or
        (copy(comScriptWaveComm.vstlEntity[vintLoop],1,1) = 'O') then
       lstR_Physicians.Items.Add(copy(comScriptWaveComm.vstlEntity[vintLoop],1,4))
     else
     If copy(comScriptWaveComm.vstlEntity[vintLoop],1,1) = 'T' then
       cboR_Typist.Items.Add(copy(comScriptWaveComm.vstlEntity[vintLoop],1,4));
   cboR_Typist.Items.Add('All');
   end
else
   begin
   cboR_Typist.items.text:= vstrTypistID;
   cmdDictationResend.enabled:= false;
   cmdTransRereceive.Enabled:= false;
   pnlLame.visible:= false;
   pnlTest_Record.visible:= false;
   c_fftBand.visible:= false;
   lblVolOK.visible:= false;
   lblVolumeLow.visible:= false;
   c_progressBar_level.visible:= false;
   linVol.visible:= false;
   cmdAssignments.visible:= false;
   end;

lstR_Physicians.items.add('All');
lstR_Physicians.ItemIndex:= -1;

cboR_Typist.ItemIndex:= 0;
comScriptWaveComm.LoadArchiveMonths(cboMonth);
If cboMonth.Items.Count > 0 then
   cboMonth.ItemIndex:= 0;

If edtAudioPlayer.text < '  A' then
   begin
   If fileexists('C:\Program Files (x86)\NCH Swift Sound\Scribe\scribe.exe') then
     begin
     edtAudioPlayer.text:= 'C:\Program Files (x86)\NCH Swift Sound\Scribe\scribe.exe';
     vstrAudioPlayer := edtAudioPlayer.Text;
     comScriptWaveComm.SaveDefaults;
     end;
   If fileexists('C:\Program Files\NCH Swift Sound\Scribe\scribe.exe') then
     begin
     edtAudioPlayer.text:= 'C:\Program Files\NCH Swift Sound\Scribe\scribe.exe';
     vstrAudioPlayer := edtAudioPlayer.Text;
     comScriptWaveComm.SaveDefaults;
     end;
   If fileexists('c:\program files\gearplayer\gearplayer.exe') then
     begin
     edtAudioPlayer.text:= 'c:\program files\gearplayer\gearplayer.exe';
     vstrAudioPlayer := edtAudioPlayer.Text;
     comScriptWaveComm.SaveDefaults;
     end;
   If fileexists('c:\Program Files (x86)\gearplayer\gearplayer.exe') then
     begin
     edtAudioPlayer.text:= 'c:\Program Files (x86)\gearplayer\gearplayer.exe';
     vstrAudioPlayer := edtAudioPlayer.Text;
     comScriptWaveComm.SaveDefaults;
     end;
   end;

forcedirectories(vstrAppBaseFolder + '\RecordTemp\');
flbBackups.ApplyFilePath(vstrAppBaseFolder + '\RecordTemp\');

If fileexists(edtAudioPlayer.text) then
   cmdGearplayer.visible := true;

comScriptWaveComm.LoadEmergency;
DragAcceptFiles(self.handle,LongBool(True));
vreaStartTime:= now;
end;

Procedure TfrmTypistMain.EntityInit;
begin
If vstrTypistID = 'T001' then
   begin
   cboTypists.visible:= true;
   lblAssignedTo.visible:= true;
   cboTypists.Items.Text := comScriptWaveComm.LoadEntityList('Typist');
   cboMessageTo.Items.Text := comScriptWaveComm.LoadEntityList('All');
   end
else
   cboMessageTo.Items.Text := comScriptWaveComm.LoadEntityList('Typist');

cboFTPRecipient.Items.Text := comScriptWaveComm.LoadEntityList('Typist');
cboFTPRecipient.items.delete(cboFTPRecipient.items.indexof
                                             (vstrTypistID + ' ' + vstrTypist));
cboFTPRecipient.items.add('Reference - All Typists');
cboMessageTo.Items.delete(cboMessageTo.items.indexof
                                             (vstrTypistID + ' ' + vstrTypist));
cboMessageTo.Items.Add('Technical Support');
cboStatusFilter.items.text :=
            'Show All' + #13#10 + comScriptWaveComm.LoadEntityList('All');
cboStatusFilter.ItemIndex := 0;
end;
{-----------------------------------------------------------------------------}
procedure TfrmTypistMain.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
If not vbolShutdown then
   begin
   frmTypistMain.visible := false;
   abort;
   end
else
  begin
  SaveAlerts;
  comScriptWaveComm.shutdown;
  comScriptWaveComm.free;
  comScriptWaveComm:= nil;
  end;
end;

procedure TfrmTypistMain.SaveAlerts;
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

procedure TfrmTypistMain.LoadAlerts;
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
procedure TfrmTypistMain.LoopThroughFiles(const cstrMask: string);
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
           vstrFileName:= copy(frmImport.cboPhysician.Text,1,4)
            + '_' + trim(copy(frmImport.cboPhysician.Text,6,99)) + '_A_'
            + comScriptWaveComm.vstrMonth + '_' + comScriptWaveComm.vstrDay+ '_'
            + comScriptWaveComm.vstrYear+ '_' + format('%.4d', [vintFileNumber])
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
  lstImportFiles.Update;

  vintFileNumber:= 0;
  if lstImportFiles.Items.Count > 0 then
    for vintLoop:= 0 to lstImportFiles.Items.Count - 1 do
      begin
      If copy(lstImportFiles.Items[vintLoop],1,7) = 'IMPORT_' then
      else
        begin
        frmImport.edtOld.text := lstImportFiles.Items[vintLoop];
        frmImport.showmodal;
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
            begin
            DeleteFile('IMPORT_' + lstImportFiles.items[vintLoop]);
            RenameFile(edtScanFolder.text + lstImportFiles.Items[vintLoop],
                         'IMPORT_' + lstImportFiles.items[vintLoop])
            end
        else
        If chkDeleteImport.checked then
            DeleteFile(edtScanFolder.text + lstImportFiles.Items[vintLoop]);
        vbolImmediateCommunicate:= true;
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

procedure TfrmTypistMain.tmrMAINTimer(Sender: TObject);
var
    vstrCntlFile: string;
    vstlTmp: tstringlist;
    vbolRestart: boolean;
    vstrWork: string;
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
                   memCommProgress.Lines.add(datetimetostr(now) +
                                           ' Receiving: ' + vstlTmp[vintLoop2]);
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
                   comScriptWaveComm.Receive_uncrypt
                          (vstrMasterDoc + vstrHoldFile + '_cry',
                           FindFileReceiveSize
                             (vstlDir[vintHold]),'/');
                   grdAlerts.RowCount := grdAlerts.RowCount + 1;
                   grdAlerts.Cells[0,grdAlerts.rowcount-1] := 'Received';
                   grdAlerts.cells[1,grdAlerts.rowcount-1] := vstrHoldFile;
                   comScriptWaveComm.InifilesWriteOne(copy(vstrHoldFile,
                                      pos('.',vstrHoldFile)-3,3), vstrHoldFile);
                   comScriptWaveComm.InifilesWriteOne(copy(vstrHoldFile,
                               pos('.',vstrHoldFile)-3,3)+'A', vstrHoldAltFile);
                   lblFileTransferName.caption := '';
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

     {-------- END of loop to transmit new dictation files}
     procedure GetStatusAndDownloadFiles;
       var vintLoop: integer;
           vstrWork: string;
       begin
       for vintLoop:= 0 to vstlDir.count - 1 do
          begin
          vstrWork:= copy(vstlDir[vintLoop], cintFTPDirOffset,999);
          vstrWork:= copy(vstrWork,1,length(vstrWork)-4);
          If copy(vstlDir[vintLoop], cintFTPDirOffset,2) = 'C_' then
            if not fileexists(vstrMasterDoc + vstrWork) then
                begin
                comScriptWaveComm.UpdateFileStatus
                 (copy(vstlDir[vintLoop], cintFTPDirOffset+2,999));
                If (comScriptWaveComm.vstrFileTyped <> '00000000') and
                   (comScriptWaveComm.vstrFileReviewed = '00000000') then
                    begin
                    memCommProgress.Lines.add(datetimetostr(now) +
                             ' Receiving Command: ' +
                               copy(vstlDir[vintLoop],
                               cintFTPDirOffset,999));
                    If comScriptWaveComm.Receive_Uncrypt(vstrMasterDoc +
                       copy(vstlDir[vintLoop], cintFTPDirOffset,999),
                        FindFileReceiveSize(vstlDir[vintLoop]), '/') then
                        FindCommandDownloads(vstrWork);
                    end;
                end;
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
    {--------------------------------------------------------------------------}
     procedure CheckForUploads;
      var vintLoop: integer;
      begin
      comScriptWaveComm.vstlSearchIni.loadfromfile(vstrAppBaseFolder
                                                 + 'ScriptWaveFileControl.ini');
      for vintLoop:= 0 to comScriptWaveComm.vstlSearchIni.count - 1 do
       If comScriptWaveComm.vstlSearchIni[vintLoop]='TransmitDate=00000000' then
        begin
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
           {Since the transcriptionist is importing, also mark as
            received by setting received date as trasnsmit date.}
           comScriptWaveComm.InifilesWriteOne('ReceiveDate',
                                           comScriptWaveComm.vstrYear +
                                           comScriptWaveComm.vstrMonth +
                                           comScriptWaveComm.vstrDay);
           comScriptWaveComm.InifilesWriteOne('ReceiveDateT',
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
           vstlTmp.savetofile(vstrMasterDoc + vstrCntlFile);
           finally
             vstlTmp.free;
             end;
           If comScriptWaveComm.Crypt_Transmit
                                          (vstrMasterDoc + vstrCntlFile,'') then
               begin
               grdAlerts.RowCount := grdAlerts.RowCount + 1;
               grdAlerts.Cells[0,grdAlerts.rowcount-1] := 'Sent';
               grdAlerts.cells[1,grdAlerts.rowcount-1] :=
                                              comScriptWaveComm.vstrCurrentFile;
               end
           else
               begin
               comScriptWaveComm.InifilesWriteOne('TransmitDate', '00000000');
               comScriptWaveComm.InifilesWriteOne('ReceiveDate', '00000000');
               deletefile(vstrMasterDoc + vstrCntlFile);
               end;
           lblFileTransferName.caption := '';
           end;
        end;
      end;
     {-------- END of loop to transmit new dictation files}
     {For the Administrator, download any file listed as Transmitted and not
      Received}
     procedure GetAdminDownloadFiles;
       var vintLoop, vintDot, vintFileLoc, vintComment: integer;
           vstrCurrentControlFile: string;
           vstlTemp: tstringlist;
       begin
         for vintLoop:= 0 to vstlDir.count - 1 do
          begin
          If copy(vstlDir[vintLoop], cintFTPDirOffset,2) = 'CD' then
            CheckForRecallFiles(vstlDir[vintLoop])
          else
          If copy(vstlDir[vintLoop], cintFTPDirOffset,2) = 'C_' then
                begin
                vstrCurrentControlFile :=
                     trim(copy(vstlDir[vintLoop], cintFTPDirOffset,999));
                {Get the correct dates into the ini file based on the Server}
                comScriptWaveComm.UpdateFileStatus
                                           (copy(vstrCurrentControlFile,3,999));
                {Is this file ready to download to the physician?}
                If (comScriptWaveComm.vstrFileTransmit <> '00000000') and
                   (comScriptWaveComm.vstrFileReceived = '00000000') then
                    begin
                    memCommProgress.Lines.add(datetimetostr(now)+
                                                     ' New Dictation download');
                    If comScriptWaveComm.Receive_UnCrypt(
                       vstrMasterDoc + vstrCurrentControlFile,
                         FindFileReceiveSize(vstlDir[vintLoop]), '/') then
                      {Find all download files in the control file}
                      begin
                      vintFileLoc:= FileFinder(vstlDir[vintLoop]);
                      If vintFileLoc <> -1 then
                      begin
                      lblFileTransferName.caption := 'Receiving: ' +
                                              comScriptWaveComm.vstrCurrentFile;
                      if comScriptWaveComm.Receive_UnCrypt(vstrMasterDoc +
                                     comScriptWaveComm.vstrCurrentFile + '_cry',
                        FindFileReceiveSize
                              (vstlDir[vintFileLoc]), '/') then
                        begin
                        grdAlerts.RowCount := grdAlerts.RowCount + 1;
                        grdAlerts.Cells[0,grdAlerts.rowcount-1] := 'Dictate';
                        grdAlerts.cells[1,grdAlerts.rowcount-1] :=
                                              comScriptWaveComm.vstrCurrentFile;
                        comScriptWaveComm.InifilesWriteOne
                                   ('ReceiveDate', comScriptWaveComm.vstrYear +
                                                   comScriptWaveComm.vstrMonth +
                                                     comScriptWaveComm.vstrDay);
                        comScriptWaveComm.InifilesWriteOne('ReceiveDateT',
                                             FormatDateTime('hh:mm AM/PM',now));
                        vstlTemp:= tstringlist.create();
                        try
                        vstlTemp.loadfromfile
                             (vstrMasterDoc + copy(vstrCurrentControlFile,1,
                                           length(vstrCurrentControlFile)-4));
                        vintComment:= vstlTemp.IndexOf('<COMMENTS>');
                        If (vintComment > -1) and
                                         (vintComment < vstlTemp.count - 1) then
                            comScriptWaveComm.InifilesWriteOne
                                           ('Comments',vstlTemp[vintComment+1]);
                          finally
                          vstlTemp.free;
                          end;
                        vstrWork:= vstrCurrentControlFile;
                        vintDot:= pos('.',vstrCurrentControlFile);
                        vstrWork := copy(vstrWork,1,vintDot + 27)+
                                               comScriptWaveComm.vstrYear +
                                               comScriptWaveComm.vstrMonth +
                                               comScriptWaveComm.vstrDay +
                                               copy(vstrWork,vintDot + 36,999);
                        comScriptWaveComm.RenameFile
                                  (vstrCurrentControlFile, vstrWork, '');
                        renameFile(vstrMasterDoc + copy(vstrCurrentControlFile,
                             1,length(vstrCurrentControlFile)-4),
                           vstrMasterDoc + copy(vstrWork,1,length(vstrWork)-4));
                        end;
                      end;
                      lblFileTransferName.caption:='';
                      end;
                    end;
                end;
          end;
       end;
     {For the Administrator, download any file listed as Transmitted and not
      Received}
     procedure GetTypistDownloadFiles;
       var vintLoop, {vintDot, }vintFileLoc, vintComment, vintDecimal: integer;
           vstrCurrentControlFile, vstrDictationFile, vstrAssignFile,
           vstrHoldReviewed: string;
           vstlTemp: tstringlist;
       begin
         for vintLoop:= 0 to vstlDir.count - 1 do
          begin
          If copy(vstlDir[vintLoop], cintFTPDirOffset,2) = 'CD' then
            CheckForRecallFiles(vstlDir[vintLoop])
          else
          If copy(vstlDir[vintLoop], cintFTPDirOffset,2) = 'C_' then
             begin
             vstrCurrentControlFile :=
                     trim(copy(vstlDir[vintLoop], cintFTPDirOffset,999));
             vintDecimal:= pos('.',vstrCurrentControlFile);
             {Get the correct dates into the ini file based on the Server}
             If(pos('_'+ vstrTypistID +'_', vstrCurrentControlFile) > 0) then
                begin
                {Check prior reviewed status}
                comScriptWaveComm.vstrCurrentFile:=
                                 copy(vstrCurrentControlFile,3,vintDecimal + 1);
                comScriptWaveComm.InifilesLoadDetail;
                vstrHoldReviewed:= comScriptWaveComm.vstrFileReviewed;

                comScriptWaveComm.UpdateFileStatus
                                           (copy(vstrCurrentControlFile,3,999));
                If (comScriptWaveComm.vstrFileReviewed <> '00000000') and
                   (vstrHoldReviewed = '00000000') then
                   begin
                   memCommProgress.Lines.add(datetimetostr(now)+
                                        ' Get Typist Corrections after Review');
                   If comScriptWaveComm.Receive_Uncrypt(
                      vstrMasterDoc + vstrCurrentControlFile,
                               FindFileReceiveSize(vstlDir[vintLoop]), '/') then
                      begin
                      FindCommandDownloads(copy(vstrCurrentControlFile,1,
                                             length(vstrCurrentControlFile)-4));
                      deletefile(vstrMasterDoc + copy(vstrCurrentControlFile,1,
                                             length(vstrCurrentControlFile)-4));
                      end;
                   end;

                {Is this file ready to download to the physician?}
                If (comScriptWaveComm.vstrFileAssigned <> '00000000') and
                  (comScriptWaveComm.vstrFileTyped = '00000000') and
                  (not fileexists(vstrMasterDoc +
                                        comScriptWaveComm.vstrCurrentFile)) then
                  begin
                    memCommProgress.Lines.add(datetimetostr(now)+
                                                         ' Get Typist Control');
                    If comScriptWaveComm.Receive_Uncrypt(
                       vstrMasterDoc + vstrCurrentControlFile,
                               FindFileReceiveSize(vstlDir[vintLoop]), '/') then
                      {Find all download files in the control file}
                      begin
                      vintFileLoc:= FileFinder(vstlDir[vintLoop]);
                      If vintFileLoc <> -1 then
                      begin
                      lblFileTransferName.caption := 'Receiving: ' +
                                              comScriptWaveComm.vstrCurrentFile;
                      if comScriptWaveComm.Receive_UnCrypt(vstrMasterDoc +
                                     comScriptWaveComm.vstrCurrentFile + '_cry',
                            FindFileReceiveSize(vstlDir[vintFileLoc]), '/') then
                        begin
                        grdAlerts.RowCount := grdAlerts.RowCount + 1;
                        grdAlerts.Cells[0,grdAlerts.rowcount-1] := 'Type';
                        grdAlerts.cells[1,grdAlerts.rowcount-1] :=
                                              comScriptWaveComm.vstrCurrentFile;
                        comScriptWaveComm.InifilesWriteOne
                                                   ('AssignedTo', vstrTypistID);
                        vstlTemp:= tstringlist.create();
                        try
                        vstrCurrentControlFile :=
                                              copy(vstrCurrentControlFile,1,
                                              length(vstrCurrentControlFile)-4);
                        vstlTemp.loadfromfile
                                       (vstrMasterDoc + vstrCurrentControlFile);
                        vintComment:= vstlTemp.IndexOf('<COMMENTS>');
                        If (vintComment > -1) and
                                         (vintComment < vstlTemp.count - 1) then
                            comScriptWaveComm.InifilesWriteOne
                                           ('Comments',vstlTemp[vintComment+1]);
                          finally
                          vstlTemp.free;
                          end;
                        end;
                      end;
                      lblFileTransferName.caption:='';
                      end;
                    end;
                end
             else
                {Check to see if file is no longer assigned}
                begin
                vstrCurrentControlFile := copy(vstrCurrentControlFile,1,
                                              length(vstrCurrentControlFile)-4);

                vstrDictationFile:= copy(vstrCurrentControlFile,3,
                                       pos('.', vstrCurrentControlFile) + 1);
                vstrAssignFile:= 'C_' + vstrDictationFile +
                     '_' + vstrTypistID + '_' +
                     copy(vstrCurrentControlFile,
                                       pos('.', vstrCurrentControlFile)+10,36) +
                     '00000000_00000000_00000000';
                If FileExists(vstrMasterDoc + vstrAssignFile) then
                   begin
                   deletefile(vstrMasterDoc + vstrAssignFile);
                   deletefile(vstrMasterDoc + vstrDictationFile);
                   comScriptWaveComm.iniFileControl.EraseSection
                                                            (vstrDictationFile);
                   try
                     comScriptWaveComm.iniFileControl.UpdateFile;
                     except
                       comScriptWaveComm.IniFiles_UpdateFile_Override;
                       end;
                   grdAlerts.RowCount := grdAlerts.RowCount + 1;
                   grdAlerts.Cells[0,grdAlerts.rowcount-1] := 'Reassigned';
                   grdAlerts.cells[1,grdAlerts.rowcount-1] := vstrDictationFile;
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
                          cintFTPDirOffset,24) = 'ScriptWaveTypistTransfer' then
              If cstrVersion <> copy(vstlDir[vintLoop],
                                                     cintFTPDirOffset+25,3) then
                begin
                lblFileTransferName.caption :=
                                          'Receiving: ScriptWaveTypistTransfer';
                memCommProgress.Lines.add(datetimetostr(now) +
                                                         ' Receiving Software');
                If comScriptWaveComm.getfile(vstrAppBaseFolder +
                      copy(vstlDir[vintLoop],
                          cintFTPDirOffset,28), 'Software',
                          FindFileReceiveSize
                             (vstlDir[vintLoop])) then
                  begin
                  renamefile(vstrAppBaseFolder +
                    copy(vstlDir[vintLoop], cintFTPDirOffset,28),
                      vstrAppBaseFolder +
                    copy(vstlDir[vintLoop], cintFTPDirOffset, 25) + 'new');
                   Logit('Received new software version ' +
                   copy(vstlDir[vintLoop], cintFTPDirOffset+25,3));
                  vbolRESTART:= true;
                  grdAlerts.RowCount := grdAlerts.RowCount + 1;
                  grdAlerts.Cells[0,grdAlerts.rowcount-1] := 'Received';
                  grdAlerts.cells[1,grdAlerts.rowcount-1] :=
                     'ScriptWaveTypistTransfer version: ' +
                   copy(vstlDir[vintLoop], cintFTPDirOffset+25,3);
                  lblFileTransferName.caption := '';
                  end;
                end;
          end;
         end;
       {----------------------------------------------------}
       procedure DownloadGenericFTP;
         var vintLoop: integer;
             vstrFTPFile, vstrFTPfileDecomp: string;
         begin
         If comScriptWaveComm.DirectoryListFTP('FTP') then
          begin
          for vintLoop:= 0 to vstlDir.count - 1 do
            begin
            vstrFTPfile:= copy(vstlDir[vintLoop], cintFTPDirOffset,999);
            vstrFTPfileDecomp:= copy(vstrFTPfile, 1,length(vstrFTPfile)-4);
            If copy(vstrFTPfile,1,4) = vstrTypistID then
              begin
              lblFileTransferName.caption:= 'Receiving Generic: ' +
                                      copy(vstrFTPfile,1,length(vstrFTPfile)-4);
              deletefile(vstrFTP + vstrFTPfile);
              Logit('Receiving Generic FTP file: ' + vstrFTPfile);
              if comScriptWaveComm.Receive_UnCrypt(vstrFTP + vstrFTPfile,
               FindFileReceiveSize(vstlDir[vintLoop]), 'FTP') then
                begin
                grdAlerts.RowCount := grdAlerts.RowCount + 1;
                grdAlerts.Cells[0,grdAlerts.rowcount-1] := 'FTP';
                grdAlerts.cells[1,grdAlerts.rowcount-1] :=
                                      copy(vstrFTPfile,1,length(vstrFTPfile)-4);
                comScriptWaveComm.RenameFile
                                (vstrFTPfile, 'Received_' + vstrFTPfile, 'FTP');

                end;
              lblFileTransferName.caption := '';
              end
            else
            If copy(vstrFTPfile,1,4) = 'Refe' then
             If (not fileexists(vstrFTP + vstrFTPfileDecomp)) or
                 ((fileexists(vstrFTP + vstrFTPfileDecomp)) and
                   (round(strtodatetime(comScriptWaveComm.FileLastModified
                                         (vstrFTP + vstrFTPfileDecomp))) <
                    (round(strtodatetime(vstlDirDateStamp[vintLoop]))))) then
              begin
              lblFileTransferName.caption:= 'Receiving Reference: ' +
                                      copy(vstrFTPfile,1,length(vstrFTPfile)-4);
              deletefile(vstrFTP + vstrFTPfile);
              Logit('Receiving Reference FTP file: ' + vstrFTPfile + ' ' +
                                                    vstlDirDateStamp[vintLoop]);
              if comScriptWaveComm.Receive_UnCrypt(vstrFTP + vstrFTPfile,
               FindFileReceiveSize(vstlDir[vintLoop]), 'FTP') then
                begin
                grdAlerts.RowCount := grdAlerts.RowCount + 1;
                grdAlerts.Cells[0,grdAlerts.rowcount-1] := 'FTP';
                grdAlerts.cells[1,grdAlerts.rowcount-1] :=
                                      copy(vstrFTPfile,1,length(vstrFTPfile)-4);
                end;
              lblFileTransferName.caption := '';
              end;
            end;
          end;
         end;
       {-----------------------------------------------------------------------}
       procedure EliminateOldControlFiles;
         var vintLoop, vintDot: integer;
             vstrCurrent, vstrHold: string;
         begin
         vstrHold:= comScriptWaveComm.vstrCurrentFile;
         lstMastDoc.Directory:= vstrMasterDoc;
         lstMastDoc.mask:= 'C_*.*';
         lstMastDoc.Update;
         {Eliminate old pre-assignment control files}
         for vintLoop:= lstMastDoc.Items.Count - 1 downto 0 do
            begin
            vstrCurrent:= lstMastDoc.items[vintLoop];
            vintDot := pos('.',vstrCurrent);
            comScriptWaveComm.vstrCurrentFile:= copy(vstrCurrent,3,vintDot+1);;
            If (copy(vstrCurrent,vintDot+4,2) = '_A') and
              (comScriptWaveComm.InifilesReadOne('AssignDate')<>'00000000') then
                 deletefile(vstrMasterDoc + vstrCurrent);
            end;
         comScriptWaveComm.vstrCurrentFile:= vstrHold;
         end;
       {-----------------------------------------------------------------------}
       Procedure CheckForCommands;
          var vintLoop: integer;
         begin
         If comScriptWaveComm.DirectoryListFTP('Command') then
          for vintLoop:= 0 to vstlDir.count - 1 do
            begin
            If copy(vstlDir[vintLoop], cintFTPDirOffset,4) = vstrTypistID then
               begin
               If copy(vstlDir[vintLoop], cintFTPDirOffset+5,7) = 'SendLog' then
                    cmdSendLogClick(self)
               else
               If copy(vstlDir[vintLoop],
                                     cintFTPDirOffset+5,11) = 'SendFileIni' then
                  begin
                  comScriptWaveComm.Crypt_Transmit(vstrAppBaseFolder +
                                     'ScriptWaveFileControl.ini', 'Support');
                  comScriptWaveComm.renamefile('ScriptWaveFileControl.ini_cry',
                    vstrTranscriptionistID + '_' + vstrTypistID +
                        '_ScriptWaveFileControl.ini_cry', 'Support');
                  end
               else
               If copy(vstlDir[vintLoop],
                                     cintFTPDirOffset+5,11) = 'Download_P_' then
                  begin
                  comScriptWaveComm.GetFile
                    (vstrAppBaseFolder + copy(vstlDir[vintLoop],
                                         cintFTPDirOffset+16,999),
                                         'Software', 1000000);
                  end;
               comScriptWaveComm.DeleteFTPFile(
                     copy(vstlDir[vintLoop], cintFTPDirOffset,999), 'Command');
               end;
            end;
         end;

{------------------------------------------------------------------------------}
begin
application.processmessages;
If pnlAssignments.Visible then exit;
{Do not communicate when on dictate tab or messages tab}
If (pagMain.activePage = tabDictate) and
                                     ((pnlRecord.Visible = true)
                                   or (pnlEncoding.visible = true)) then exit;
If (pagMain.activePage = tabMessages) and (frmTypistMain.visible) then exit;

tmrMain.enabled := false;
vbolRestart:= false;
vbolCommunicating := true;
vreaMinutes := vreaMinutes + 0.1;
vreaPulseMinutes := vreaPulseMinutes + 0.1;

If fileexists(vstrMasterDoc + 'SoxComm.cmd') then
   begin
   Deletefile(vstrMasterDoc + 'SoxComm.cmd');
//   frmTypistMain.visible:= true;
   application.processmessages;
   vbolImmediateCommunicate:= true;
   end;

{Every 5 minutes, open the pulse folder to maintain conntection}
If vreaPulseMinutes > 5 then
   begin
   comScriptWaveComm.DirectoryListFTP('Pulse');
   vreaPulseMinutes:= 0;
   If pos(vstrTypistID + '.go', vstlDir.text) > 0 then
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
CheckForImportFiles;
If vbolRestartINI then exit;
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
  memCommProgress.Lines.add(datetimetostr(now) + ' Checking Upload Files');
  CheckForUploads;
  {----------------}
  memCommProgress.Lines.add(datetimetostr(now)+' Checking Status and Download');
  if comScriptWaveComm.DirectoryListFTP('') then
     begin
     if vstrTypistID = 'T001' then
       begin
       GetAdminDownloadFiles;
       if comScriptWaveComm.DirectoryListFTP('') then
           GetStatusAndDownloadFiles;
       end
     else
       GetTypistDownloadFiles;
     {----------------}
     memCommProgress.Lines.add(datetimetostr(now) + ' Check Emergency IP');
     comScriptWaveComm.DownloadEmergencyIP;
     end;
  {----------------}
  memCommProgress.Lines.add(datetimetostr(now) + ' Send/Receive Messages');
  SendandReceiveMessages;
  memCommProgress.Lines.add(datetimetostr(now) + ' Load Message List');
  LoadMessages;
  {----------------}
  memCommProgress.Lines.add(datetimetostr(now) + ' Check FTP Files');
  DownloadGenericFTP;
  {----------------}
  memCommProgress.Lines.add(datetimetostr(now) + ' Checking for Commands');
  CheckForCommands;
  {----------------}
  memCommProgress.Lines.add(datetimetostr(now) + ' Checking for Archive');
  comScriptWaveComm.ArchiveCompleteFiles;
  comScriptWaveComm.LoadArchiveMonths(cboMonth);
  If cboMonth.Items.Count > 0 then
     cboMonth.ItemIndex:= 0;
  {----------------}
  memCommProgress.Lines.add(datetimetostr(now) + ' Checking for File Purge');
  comScriptWaveComm.PurgeController;
  {----------------}
  memCommProgress.Lines.add(datetimetostr(now) + ' Update Screen INI Files');
  cboStatusFilter.itemindex:= 0;
  LoadAndScanFilesINI;
  EliminateOldControlFiles;
  comScriptWaveComm.DeleteFTPfile(vstrTypistID + '.go', 'Pulse');
  {----------------}
  lblFileTransferName.caption := 'Last Communication at ' + datetimetostr(now);
  vreaMinutes := 0;
  finally
    memCommProgress.Lines.add(datetimetostr(now) + ' Communications Done!!!');
    Sleep(1000);
    pnlWait.SendToBack;
    pnlSpace.visible:= true;
    end;
  end;
  
finally
 vbolImmediateCommunicate:= false;
 If vbolAutomatic then
    tmrMAIN.Enabled:= true;
 vbolCommunicating := false;

// If comScriptWaveComm.TransferServer then
//   vbolRestart:= true;

 If vbolRestart or ((now - vreaStartTime) > 1) then
   cmdRestartClick(Self);
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmTypistMain.FormPaint(Sender: TObject);
begin
If not vbolOneTime then
  begin
  vbolOneTime:=true;
  frmTypistMain.visible:= false;
  end;
end;

procedure TfrmTypistMain.cmdHideClick(Sender: TObject);
begin
  frmTypistMain.Visible := false;
end;

procedure TfrmTypistMain.cmdShutdownClick(Sender: TObject);
begin
  vbolShutdown:= true;
//  comScriptWaveComm.ShutdownFTP;
  frmTypistMain.close;
end;

procedure TfrmTypistMain.shnShellNotifyDblClick(Sender: TObject;
  Button: TMouseButton);
begin
  frmTypistMain.visible:= true;
end;

procedure TfrmTypistMain.cmdShowClick(Sender: TObject);
begin
  frmTypistMain.visible:= true;
end;

procedure TfrmTypistMain.popTrayMenuPopup(Sender: TObject);
begin
If vbolCommunicating then
   begin
   cmdShow.Enabled := false;
   cmdHide.Enabled := false;
   cmdShutdown.Enabled := false;
   end
else
if frmTypistMain.Visible = false then
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
procedure TfrmTypistMain.tmrBlinkTimer(Sender: TObject);
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
         (grdAlerts.Cells[0,vintLoop] = 'Dictate') or
         (grdAlerts.Cells[0,vintLoop] = 'Reassigned') or
         (grdAlerts.Cells[0,vintLoop] = 'Recalled') or
         (grdAlerts.Cells[0,vintLoop] = 'Type') then
          vbolBlinkDictation:= true
      else
      If (grdAlerts.Cells[0,vintLoop] = 'Received') or
         (grdAlerts.Cells[0,vintLoop] = 'FTP') then
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

procedure TfrmTypistMain.imgMessagesClick(Sender: TObject);
begin
pagMain.ActivePage := tabmessages;
end;

procedure TfrmTypistMain.cmdShowLogClick(Sender: TObject);
begin
  If fileexists(vstrAppBaseFolder+ 'ScriptWave' + vstrSessionType + '.log') then
   frmLogFile.memLog.Lines.LoadFromFile(vstrAppBaseFolder
                                     + 'ScriptWave' + vstrSessionType + '.log');
  frmLogFile.showmodal;
end;

procedure TfrmTypistMain.cmdSendLogClick(Sender: TObject);
var vstrWork: string;
begin
  If fileexists(vstrAppBaseFolder+ 'ScriptWave' + vstrSessionType + '.log') then
     begin
     vstrWork :=  vstrMasterDoc + vstrTranscriptionistID + '_' +
              vstrTypistID + '_' + 'ScriptWave' + vstrSessionType + '.log';
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

procedure TfrmTypistMain.cmdCommunicate1Click(Sender: TObject);
begin
if tmrMain.enabled or not vbolAutomatic then
  begin
  vbolImmediateCommunicate:= true;
  tmrMAINTimer(self);
  end;
end;

procedure TfrmTypistMain.cmdNoAlertsClick(Sender: TObject);
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

function TfrmTypistMain.FindFileReceiveSize
                                         (const cstrDirString: string): longint;
begin
try
  Result:= strtoint(trim(copy(cstrDirString,1,10)));
  except
  Result:=0
  end;
end;

{Preferences recording}
procedure TfrmTypistMain.edtWordFolderChange(Sender: TObject);
begin
vstrReceiveFolder:= edtWordFolder.text;
comScriptWaveComm.SaveDefaults;
end;

procedure TfrmTypistMain.chkDeleteImportClick(Sender: TObject);
begin
if chkDeleteImport.checked = chkRenameImport.checked then
   chkRenameImport.checked := not chkDeleteImport.checked;
vbolDeleteImport:= chkDeleteImport.checked;
comScriptWaveComm.SaveDefaults;
end;

procedure TfrmTypistMain.chkRenameImportClick(Sender: TObject);
begin
if chkRenameImport.checked = chkDeleteImport.checked then
   chkDeleteImport.checked := not chkRenameImport.checked;
vbolRenameImport:= chkRenameImport.checked;
comScriptWaveComm.SaveDefaults;
end;

procedure TfrmTypistMain.chkAutomaticClick(Sender: TObject);
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

procedure TfrmTypistMain.imgDictationClick(Sender: TObject);
begin
 pagMain.activepage := tabAlerts;
end;

procedure TfrmTypistMain.imgTranscriptionClick(Sender: TObject);
begin
 pagMain.activepage := tabAlerts;
end;

procedure TfrmTypistMain.pagMainChange(Sender: TObject);
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

procedure TfrmTypistMain.LoadAndScanFilesINI;
var  vintLoop, vintIndex: integer;
     vstrCategory, vstrWork, vstrFile, vstrHoldDate, vstrTypist, vstrHoldNode,
                                                       vstrStatusFilter: string;
     vstlTemp, vstlTemp2: tstringlist;
     vbolTypist, vbolStat: boolean;
     trnFind: ttreenode;
     vintCat: array [1..7] of integer;
     procedure LocateNodeString(const cstrNode: string);
        begin
        Try
          trnFind:=GetNodeByText(treAll,cstrNode,true);
          trnFind.Selected := true;
          except
          end;
        end;
     function findcatindex: integer;
       var vintLoop: integer;
       begin
       Result:= 1;
       For vintLoop:= 0 to vstlTemp2.count - 1 do
         If pos(vstrCategory,vstlTemp2[vintLoop]) > 0 then
           begin
           Result:= vintLoop;
           break;
           end;
       end;
     procedure LabelCat(const cstrCat: string; const cintCat: integer);
       begin
       vstrCategory:= cstrCat;
       vintIndex:= FindCatIndex;
       vstlTemp2[vintIndex]:= vstrCategory + ' (' +
                                             inttostr(vintCat[cintCat]) + ')';
       end;
begin
  for vintLoop:= 1 to 7 do vintCat[vintLoop]:= 0;
  If vbolNoTreeRefresh then exit;
  cmdimportDoc.enabled := false;
  cmdOpenDoc.enabled:= false;
  cmdEmailDoc.enabled:= false;
  cmdDelAttachment.enabled:= false;
  cmdTypistComplete.enabled:= false;
  cmdReturnToDoc.enabled:= false;
  edtDictationName.text := '';
  edtImportDate.text :=  '';
  edtTransmitDate.text :=  '';
  edtReceiveDate.text :=  '';;
  edtAssignDate.text :=  '';
  edtTypedDate.text :=  '';
  edtReviewDate.text :=  '';
  edtCompleteDate.text :=  '';
  medDictation.FileName :=  '';
  memFileComments.text:=  '';
  edtAltName.text:=  '';
  grdTranscribedfiles.rowcount := 2;
  grdTranscribedfiles.cells[0,1] := '';
  grdTranscribedFiles.cells[0,0] := 'Transcribed files';

  cboTypists.ItemIndex:= -1;

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
  vbolTypist:= false;
  vbolStat:= false;
  vstrTypist:= copy(cboStatusFilter.items[cboStatusFilter.itemindex],1,4);
  vstrStatusFilter:= cboStatusFilter.items[cboStatusFilter.itemindex];

  for vintLoop := comScriptWaveComm.vstlSearchIni.count - 1 downto 0 do
     begin
     vstrWork:= comScriptWaveComm.vstlSearchIni[vintLoop];
     If (copy(vstrWork,1,2) = '[P' ) or
        (copy(vstrWork,1,2) = '[O' ) then
        begin
        vstrFile:= copy(vstrWork,2,length(vstrWork)-2);
        try
        If
           {First part is last 3 days check}
           ((chkRecent.checked and
            (vstrCategory <> '7')) or
           //(4 > date - strtodate(copy(vstrHoldDate,5,2) + '/' +
           //                      copy(vstrHoldDate,7,2) + '/' +
           //                      copy(vstrHoldDate,1,4)))) or
                                                    (not chkRecent.checked)) and
           {AND - is the filter logic}
           ((vstrStatusFilter = 'Show All') or
            (copy(vstrFile,1,4) = copy(vstrStatusFilter,1,4)) or
               vbolTypist)
            {Finally, the stat-only logic}
            and ((vbolStat and chkShowStat.checked) or
                                                  not chkShowStat.checked)  then
               begin
               vstlTemp.add(vstrCategory + vstrFile);
               end;
           except
           end;
        vbolTypist:= false;
        vbolStat:= false;
        vstrCategory:= '';
        end;
     If vstrWork = 'AssignedTo=' + vstrTypist then
        begin
        vbolTypist:= true;
        end;
     If copy(vstrWork,1,19) = 'Comments=IMPORTANT:' then
        vbolStat:= true;
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
    inc(vintCat[strtointdef(copy(vstrWork,1,1),1)]);
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
//     vintIndex:= FindCatIndex + 1;
     vintIndex:= vstlTemp2.IndexOf(vstrCategory) + 1;
     vstlTemp2.Insert(vintIndex, #09 +
                       copy(vstlTemp[vintLoop],2,length(vstlTemp[vintLoop])-1));
    end;
   LabelCat('Imported',1);
   LabelCat('Transmitted',2);
   LabelCat('Received',3);
   LabelCat('Assigned',4);
   LabelCat('Typed',5);
   LabelCat('Reviewed',6);
   LabelCat('Completed',7);
   vstlTemp2.savetofile(vstrAppBaseFolder + 'tv.txt');
   treAll.LoadFromFile(vstrAppBaseFolder + 'tv.txt');
   deletefile(vstrAppBaseFolder + 'tv.txt');
   If vstrHoldNode > '  A' then
      begin
      LocateNodeString(vstrHoldNode);
      treallclick(self);
      end;
   finally
     vstlTemp.free;
     vstlTemp2.free;
     end;
end;

function TfrmTypistMain.GetNodeByText(ATree : TTreeView;
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
    if pos(UpperCase(AValue), UpperCase(Node.Text)) > 0 then
    begin
      Result := Node;
      if AVisible then
        Result.MakeVisible;
      Break;
    end;
    Node := Node.GetNext;
  end;
end;

procedure TfrmTypistMain.treAllClick(Sender: TObject);
var vintLoop: integer;
    vfsrTemp: TSearchRec;
   Function Dateslasher(const cstrDate: string): string;
     begin
     Result:=
       copy(cstrDate,5,2) + '/' + copy(cstrDate,7,2) + '/' + copy(cstrDate,1,4);
     end;
   Procedure FindTypist;
     var vintLoop: integer;
     begin
     for vintLoop:= 0 to cboTypists.Items.Count - 1 do
        If comScriptWaveComm.vstrFileAssignedTo =
                                       copy(cboTypists.Items[vintLoop],1,4) then
            begin
            cboTypists.ItemIndex := vintLoop;
            break;
            end;
     end;
begin
cmdEmail.Enabled:= false;
cboTypists.itemindex := -1;
cmdImportDoc.enabled := false;
cmdOpenDoc.enabled:= false;
cmdEmailDoc.enabled:= false;
cmdTypistComplete.enabled:= false;
cmdReturnToDoc.enabled:= false;
cmdDelAttachment.enabled:= false;
cmdAddComment.enabled:= false;
lblFileSizeDisplay.caption := '';
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
     edtTransmitDate.text := Dateslasher(comScriptWaveComm.vstrFileTransmit)
                                    + ' ' + comScriptWaveComm.vstrFileTransmitT;
   edtReceiveDate.text:= '';
   If comScriptWaveComm.vstrFileReceived <> '00000000' then
     edtReceiveDate.text := Dateslasher(comScriptWaveComm.vstrFileReceived)
                                    + ' ' + comScriptWaveComm.vstrFileReceivedT;
   edtAssignDate.text:= '';
   If comScriptWaveComm.vstrFileAssigned <> '00000000' then
     edtAssignDate.text := Dateslasher(comScriptWaveComm.vstrFileAssigned)
                                    + ' ' + comScriptWaveComm.vstrFileAssignedT;
   edtTypedDate.text:= '';
   If comScriptWaveComm.vstrFileTyped <> '00000000' then
     edtTypedDate.text := Dateslasher(comScriptWaveComm.vstrFileTyped) + ' ' +
                         comScriptWaveComm.vstrFileTypedT;
   edtReviewDate.text:= '';
   If comScriptWaveComm.vstrFileReviewed <> '00000000' then
     edtReviewDate.text := Dateslasher(comScriptWaveComm.vstrFileReviewed)
                                    + ' ' + comScriptWaveComm.vstrFileReviewedT;
   edtCompleteDate.text:= '';
   If comScriptWaveComm.vstrFileComplete <> '00000000' then
     edtCompleteDate.text := Dateslasher(comScriptWaveComm.vstrFileComplete)
                                    + ' ' + comScriptWaveComm.vstrFileCompleteT;
   medDictation.FileName := vstrMasterDoc + comScriptWaveComm.vstrCurrentFile;
   memFileComments.text:= MemoHash(comScriptWaveComm.vstrFileComments);
   If length(comScriptWaveComm.vstrFileAssignedTo) > 0 then
      FindTypist;
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
   cmdEmailDoc.enabled := false;
   cmdDelAttachment.enabled:= false;
   edtAltName.readonly := true;
   if ((pos('Assigned',treAll.Selected.Parent.text)>0) and
                       (vstrTypistID = comScriptWaveComm.vstrFileAssignedTo)) or
      ((pos('Typed', treAll.Selected.Parent.text) > 0) and (vstrTypistID = 'T001')) then
       begin
       cmdImportDoc.enabled := true;
       edtAltName.readonly := false;
       end;
   if (pos('Received',treAll.Selected.Parent.text)>0) and (vstrTypistID= 'T001') then
       cmdAddComment.enabled := true;
   for vintLoop := 1 to 50 do
     If comScriptWaveComm.varrAttachedFiles[1, vintLoop] > '  A' then
        begin
        grdTranscribedFiles.cells[0,grdTranscribedFiles.rowcount-1] :=
                               comScriptWaveComm.varrAttachedFiles[1, vintLoop];
        grdTranscribedFiles.rowcount:= grdTranscribedFiles.RowCount + 1;
        cmdOpenDoc.enabled := true;
        cmdEmailDoc.enabled := true;
        if (pos('Assigned',treAll.Selected.Parent.text)>0) then
            cmdTypistComplete.enabled := true;
        if (pos('Typed',treAll.Selected.Parent.text)>0) and
           (vstrTypistID = 'T001') then
            cmdReturnToDoc.enabled := true;
        end;
   if grdTranscribedFiles.rowcount > 2 then
      grdTranscribedFiles.RowCount := grdTranscribedFiles.rowcount - 1;
   if grdTranscribedFiles.rowcount > 1 then
      begin
      edtAltName.text:= comScriptWaveComm.varrAttachedFiles[2, 1];
      end;
//   If length(comScriptWaveComm.vstrFileSize) > 0 then
//      lblFileSizeDisplay.caption := comScriptWaveComm.vstrFileSize
//   else
   If FindFirst(vstrMasterDoc + comScriptWaveComm.vstrCurrentFile,0,vfsrTemp)
                                                                        = 0 then
      begin
      comScriptWaveComm.vstrFileSize:= format('%-14.0n', [vfsrTemp.size+0.00]);
      lblFileSizeDisplay.caption := comScriptWaveComm.vstrFileSize;
      comScriptWaveComm.InifilesWriteOne('FileSize',
                                                comScriptWaveComm.vstrFileSize);
      end;
   end;
If cmdTypistComplete.enabled or cmdReturnToDoc.enabled then
   cmdDelAttachment.enabled := true;
end;

procedure TfrmTypistMain.cmdOpenDocClick(Sender: TObject);
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

function TfrmTypistMain.MemoHash(const cstrMemo: string): string;
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

function TfrmTypistMain.MemoUnHash(const cstrMemo: string): string;
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

procedure TfrmTypistMain.grdAlertsDblClick(Sender: TObject);
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

procedure TfrmTypistMain.grdAlertsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    vintgrdRow:= y;
    vintgrdCol:= x;
end;

{------------------------------------------------------------------------------}
procedure TfrmTypistMain.cmdNewMessageClick(Sender: TObject);
begin
  cmdNewMessage.enabled := false;
  cmdMailIt.Enabled := true;
  cmdCancelMail.enabled := true;
  cboMessageTo.itemindex:= -1;
  cboMessageTo.visible:= true;
  edtMessageTo.visible:= false;
  edtMessageTo.Text := '';
  edtFromMail.text := vstrTypistID + ' ' + vstrTypist;
  edtDateTimeMail.text := datetimetostr(now);
  edtSubjectMail.readonly := false;
  memMessage.readonly := false;
  edtSubjectMail.text := '';
  memMessage.lines.text := '';
end;

procedure TfrmTypistMain.cmdCancelMailClick(Sender: TObject);
begin
  ResetAfterMessage;
end;

procedure TfrmTypistMain.cmdMailitClick(Sender: TObject);
var vstlTemp: tstringlist;
begin
If (length(edtSubjectMail.text) = 0) or (length(memMessage.lines.text) = 0) or
   (length(cboMessageTo.text) = 0) then
   begin
   Showmessage('Please make sure you have a To Address, Subject and Memo.');
   exit;
   end;
vstlTemp:= tstringlist.create();
try
   pnlMessageComm.visible:= true;
   application.processmessages;
   vstlTemp.Text := edtSubjectMail.text + #13#10 + memMessage.text;
   vstlTemp.savetofile(vstrMessages +
       vstrTypistID + '_' +
       copy(cboMessageTo.text,1,4) + '_' +
       floattostr(strtodatetime(edtDateTimeMail.text)));
   SendandReceiveMessages;
   comScriptWaveComm.SendPulse(copy(cboMessageTo.text,1,4),false);
   finally
   vstlTemp.free;
   pnlMessageComm.visible:= false;
   end;
ResetAfterMessage;
try
  finally
  LoadMessages;
  end;
end;

procedure TfrmTypistMain.ResetAfterMessage;
begin
  cmdNewMessage.enabled := true;
  cmdMailIt.Enabled := false;
  cmdCancelMail.enabled := false;
  edtFromMail.text := '';
  cboMessageTo.ItemIndex:= -1;
  cboMessageTo.visible:= false;
  edtMessageTo.visible:= true;
  edtMessageTo.text:= '';
  edtDateTimeMail.text := '';
  edtSubjectMail.readonly := true;
  memMessage.readonly := true;
  edtSubjectMail.text := '';
  memMessage.lines.text := '';
end;

procedure TfrmTypistMain.LoadMessages;
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
  if (copy(lstMessages.Items[vintLoop],6,4) = vstrTypistID)
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
  if copy(lstMessages.Items[vintLoop],1,4) = vstrTypistID then
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

function TfrmTypistMain.FindMessageFile(const cstrDateTime: string): string;
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

procedure TfrmTypistMain.treMessagesClick(Sender: TObject);
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
    if pos('Sent', treMessages.Selected.Parent.Text) > 0 then
         begin
         If copy(vstrMessageFile,11,4) = 'Tech' then
            edtMessageTo.text:= 'Technical Support'
         else
            edtMessageTo.text:= comScriptWaveComm.GetEntityName
                                                   (copy(vstrMessageFile,11,4));
         edtFromMail.text:= vstrTypistID + ' ' + vstrTypist;
         end
    else
    if pos('Received', treMessages.Selected.Parent.Text) > 0 then
         begin
         edtMessageTo.text:= vstrTypistId + ' ' + vstrTypist;
         If copy(vstrMessageFile,1,4) = 'Tech' then
            edtFromMail.text:= 'Technical Support'
         else
            edtFromMail.text:= comScriptWaveComm.GetEntityName
                                                    (copy(vstrMessageFile,1,4));
         cmdReplyMessage.enabled:= true;
         end
    else
         begin
         If copy(vstrMessageFile,6,4) = 'Tech' then
            edtMessageTo.text:= 'Technical Support'
         else
            edtMessageTo.text:= comScriptWaveComm.GetEntityName
                                                    (copy(vstrMessageFile,6,4));
         edtFromMail.text:= vstrTypistID + ' ' + vstrTypist;
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

procedure TfrmTypistMain.cmdDeleteMessageClick(Sender: TObject);
var vstrMessageFile: string;
begin
If treMessages.Selected.Level = 1 then
    begin
    vstrMessageFile:=
          FindMessageFile(floattostr(strtodatetime(treMessages.Selected.text)));
    deletefile(vstrMessageFile);
    cmdDeleteMessage.enabled:= false;
    cmdReplyMessage.enabled:= false;
    ResetAfterMessage;
    treMessages.items.Clear;
    LoadMessages;
    end;
end;

procedure TfrmTypistMain.cmdReplyMessageClick(Sender: TObject);
begin
cmdNewMessage.enabled := false;
cmdReplyMessage.enabled := false;
cmdDeleteMessage.enabled := false;
cmdMailIt.Enabled := true;
cmdCancelMail.enabled := true;
edtMessageTo.text := edtFromMail.text;
If copy(edtFromMail.text,1,4) = 'Tech' then
  cboMessageTo.itemindex:=cboMessageTo.Items.Count - 1
else
  cboMessageTo.itemindex:= cboMessageTo.items.indexof(trim(edtFromMail.text));
edtFromMail.text := vstrTypistID + ' ' + vstrTypist;
edtDateTimeMail.text := datetimetostr(now);
edtSubjectMail.readonly := false;
memMessage.readonly := false;
if pos('Re: ', edtSubjectMail.text) = 0 then
  edtSubjectMail.text := 'Re: ' + edtSubjectMail.text;
memMessage.lines.text := #13#10
  + '=================================================='
                                               + #13#10 + memMessage.lines.text;
end;

Procedure TfrmTypistMain.SendandReceiveMessages;
var vintLoop: integer;
    vstrFile: string;
begin
{Receiving Messages}
comScriptWaveComm.DirectoryListFTP('Messages');
for vintLoop := 0 to vstlDir.count - 1 do
   begin
   vstrFile:=
         copy(vstlDir[vintLoop],cintFTPDirOffset,999);
   if copy(vstrFile,6,4) = vstrTypistID then
      begin
      Logit('Receiving Message ' + vstrFile);
      if comScriptWaveComm.Receive_UnCrypt(vstrMessages + vstrFile,
               FindFileReceiveSize(vstlDir[vintLoop]),
                          'Messages') then
        begin

        comScriptWaveComm.Renamefile({'/Messages/' + }vstrFile,
                                 'Received_' + vstrFile,
                                 'Messages');
        grdAlerts.RowCount := grdAlerts.RowCount + 1;
        grdAlerts.Cells[0,grdAlerts.RowCount - 1]:= 'Message';
        grdAlerts.Cells[1,grdAlerts.RowCount - 1]:= 'New message received from '
                                                         + copy(vstrFile,1,4);
        end;
      end;
   end;
{Sending Messages}
lstMessages.update;
for vintLoop := 0 to lstMessages.items.count - 1 do
   begin
   vstrFile := lstMessages.items[vintLoop];
   if (copy(vstrFile,1,4) = vstrTypistID) and (pos('_cry', vstrFile) = 0) then
      begin
      Logit('Sending Message ' + vstrFile);
      If copy(vstrFile,6,4) = 'Tech' then
        begin
        copyfile(pchar(vstrMessages + vstrFile),
                 pchar(vstrMessages + vstrTranscriptionistID + '_' + vstrFile),
                 false);
        If comScriptWaveComm.Crypt_Transmit(
             vstrMessages + vstrTranscriptionistID + '_' + vstrFile,'Support') then
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

procedure TfrmTypistMain.cmdExitClick(Sender: TObject);
begin
close;
end;

function tfrmTypistMain.BeginAssign: boolean;
  begin
     result:= true;
     pnlWait.BringToFront;
     pnlSpace.visible:= false;
     memCommProgress.Lines.clear;
     pnlWait.Refresh;
     If comScriptWaveComm.DirectoryListFTP('') then
     else
        begin
        Showmessage('Connection to the server is not available - try later');
        result:= false;
        exit;
        end;
  end;

procedure tfrmTypistMain.AssignLoop;
var vintLoop, vintDot: integer;
    vstrOldName, vstrNewName, vstrOldTypist: string;
  begin
  If (comScriptWaveComm.vstrFileAssigned = '00000000') and
     (comScriptWaveComm.vstrFileReceived <> '00000000') then
     begin
     memCommProgress.Lines.add(datetimetostr(now) + ' Assigning file: ' +
                                             comScriptWaveComm.vstrCurrentFile);
     comScriptWaveComm.vstrFileAssigned:= comScriptWaveComm.vstrYear +
                                      comScriptWaveComm.vstrMonth +
                                      comScriptWaveComm.vstrDay;
     comScriptWaveComm.InifilesWriteOne
                             ('AssignDate', comScriptWaveComm.vstrFileAssigned);
     comScriptWaveComm.InifilesWriteOne
                             ('AssignDateT', FormatDateTime('hh:mm AM/PM',now));
     comScriptWaveComm.InifilesWriteOne('AssignedTo',copy(cboTypists.text,1,4));
     {Need to connect and rename the control file to alert the Typist}
     for vintLoop := 0 to vstlDir.count-1 do
          begin
          if pos('C_' + comScriptWaveComm.vstrCurrentFile,
                           vstlDir[vintLoop]) > 0 then
            begin
            vstrOldName:= copy(vstlDir[vintLoop], cintFTPDirOffset,999);
            vintDot:= pos('.',vstrOldName);
            vstrNewName:= copy(vstrOldName,1,vintDot + 4) +
                          copy(cboTypists.text,1,4) +
                          copy(vstrOldName,vintDot + 9, 28) +
                          comScriptWaveComm.vstrFileAssigned +
                          copy(vstrOldName,vintDot + 45, 999);
            comScriptWaveComm.renamefile(vstrOldName, vstrNewName, '');
            If copy(cboTypists.text,1,4) = 'T001' then
               renamefile
                     (vstrMasterDoc + copy(vstrOldName,1,length(vstrOldName)-4),
                      vstrMasterDoc + copy(vstrNewName,1,length(vstrNewName)-4))
            else
               begin
               deletefile(vstrMasterDoc +
                                     copy(vstrOldName,1,length(vstrOldName)-4));
               comScriptWaveComm.SendPulse(copy(cboTypists.text,1,4),false);
               end;
            break;
            end;
          end;
     end
  else
  {Is this a re-assign for another Typist}
  If (comScriptWaveComm.vstrFileAssigned <> '00000000') and
     (comScriptWaveComm.vstrFileReceived <> '00000000') and
     (comScriptWaveComm.vstrFileTyped = '00000000') then
     begin
     memCommProgress.Lines.add(datetimetostr(now) + ' Re-Assigning file: ' +
                                             comScriptWaveComm.vstrCurrentFile);
     comScriptWaveComm.InifilesWriteOne('AssignedTo',copy(cboTypists.text,1,4));
     for vintLoop := 0 to vstlDir.count-1 do
          begin
          if pos('C_' + comScriptWaveComm.vstrCurrentFile,
                                                     vstlDir[vintLoop]) > 0 then
            begin
            vstrOldName:= copy(vstlDir[vintLoop], cintFTPDirOffset,999);
            vintDot:= pos('.',vstrOldName);
            vstrOldTypist:= copy(vstrOldName, vintDot + 5, 4);
            vstrNewName:= copy(vstrOldName,1,vintDot + 4) +
                          copy(cboTypists.text,1,4) +
                          copy(vstrOldName,vintDot + 9, 999);
            comScriptWaveComm.renamefile(vstrOldName, vstrNewName, '');
            If copy(cboTypists.text,1,4) = 'T001' then
               begin
               comScriptWaveComm.Receive_Uncrypt
                                        (vstrMasterDoc + vstrNewName, 1000, '');
               comScriptWaveComm.SendPulse(vstrOldTypist,false);
               end
            else
               begin
               deletefile(vstrMasterDoc
                                   + copy(vstrOldName,1,length(vstrOldName)-4));
               comScriptWaveComm.SendPulse(copy(cboTypists.text,1,4),false);
               If vstrOldTypist <> 'T001' then
                 comScriptWaveComm.SendPulse(vstrOldTypist,false);
               end;
//            comScriptWaveComm.shutdownftp;
            break;
            end;
          end;
     end;
  end;

procedure tfrmTypistMain.EndAssign;
  begin
     LoadAndScanFilesINI;
     pnlWait.SendToBack;
     pnlSpace.visible:= true;
     sleep(1000);
  end;

{Assign a file to a typist}
procedure TfrmTypistMain.cboTypistsChange(Sender: TObject);
begin
If vstrTypistID = 'T001' then
     {Assign}
  If ((comScriptWaveComm.vstrFileAssigned = '00000000') and
     (comScriptWaveComm.vstrFileReceived <> '00000000'))
     {ReAssign}
   or (comScriptWaveComm.vstrFileAssigned <> '00000000') and
      (comScriptWaveComm.vstrFileReceived <> '00000000') and
      (comScriptWaveComm.vstrFileTyped = '00000000') then
      begin
      try
      If BeginAssign then
        AssignLoop;
      finally
        EndAssign;
        end;
      end;
end;

procedure TfrmTypistMain.cmdImportDocClick(Sender: TObject);
var vintLoop, vintLoop2: integer;
    vstrNewName: string;
    vstrHoldName1, vstrHoldName2: string;
    vstlFiles: tstringlist;
begin
dlgAddWord.InitialDir:= edtWordFolder.text;
dlgAddWord.filename := '';
dlgAddWord.Execute;

If dlgAddWord.Files.count = 0 then
   exit;

vstlFiles:= tstringlist.create;
try
vstlFiles.text:= dlgAddWord.files.text;
vstlFiles.sorted:= true;
dlgAddWord.files.text:= vstlFiles.text;
finally
   vstlFiles.free;
   end;

for vintLoop2 := 0 to dlgAddWord.Files.count-1 do
  begin
  vstrHoldName1 := copy(comScriptWaveComm.vstrCurrentFile, 1,
                      length(comScriptWaveComm.vstrCurrentFile)-4);
  vstrHoldName2 := copy(dlgAddWord.files[vintLoop2],
                      length(dlgAddWord.files[vintLoop2])-3,4);
  vintLoop := 1;
  vstrNewName:= vstrHoldName1 + '_T' + format('%.2d', [vintLoop]) + vstrHoldName2;
  if length(dlgAddWord.files[vintLoop2]) > 0 then
    begin
    while fileexists(vstrMasterDoc + vstrNewName) do
      begin
      inc(vintLoop);
      vstrNewName:= vstrHoldName1 + '_T' + format('%.2d', [vintLoop]) + vstrHoldName2;
      end;

    CopyFile(Pchar(dlgAddWord.files[vintLoop2]),
                                     Pchar(vstrMasterDoc + vstrNewName), false);
    If grdTranscribedFiles.Cells[0,1] > '  A' then
        grdTranscribedFiles.RowCount := grdTranscribedFiles.RowCount + 1
    else
        grdTranscribedFiles.RowCount:= 2;
    grdTranscribedFiles.Cells[0,grdTranscribedFiles.RowCount-1]:= vstrNewName;
    comScriptWaveComm.varrAttachedFiles[1, grdTranscribedFiles.RowCount-1]:=
                                                                    vstrNewName;
    comScriptWaveComm.varrAttachedFiles[2, grdTranscribedFiles.RowCount-1]:=
                                   ExtractFileName(dlgAddWord.files[vintLoop2]);
    comScriptWaveComm.InifilesWriteDetail(false);
    end;
  end;
cmdTypistComplete.enabled := true;
cmdDelAttachment.enabled := true;
cmdOpenDoc.enabled:= true;
cmdEmailDoc.enabled:= true;
grdTranscribedFilesClick(self);
end;

procedure TfrmTypistMain.cmdTypistCompleteClick(Sender: TObject);
begin
  if MessageDlg('This command will close the Dictation file and return all ' +
  'documents for review.  Are you sure?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
     SendDocumentsToServer('Typist');
end;

procedure TfrmTypistMain.cmdReturnToDocClick(Sender: TObject);
begin
if MessageDlg('This command will close the Dictation file and send all ' +
  'documents to the Physician.  Are you sure?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   SendDocumentsToServer('Physician');
end;


procedure TfrmTypistMain.SendDocumentsToServer(const cstrType: string);
   var vstlTemp: tstringlist;
       vintLoop: integer;
       vstrNewName, vstrAltName: string;
begin
 vreaMinutes := 0;
 vreaPulseMinutes := 0;
 tmrMain.enabled:= false;
 vbolCommunicating := true;
 pnlWait.BringToFront;
 pnlSpace.visible:= false;
 memCommProgress.Lines.clear;
 pnlWait.Refresh;
 try
  lstMastDoc.Directory:= vstrMasterDoc;
  lstMastDoc.Mask:= 'C_' + comScriptWaveComm.vstrCurrentFile + '_T*';
  lstMastDoc.Update;
  vstlTemp := tstringlist.create;
   try
   vstlTemp.add('<FILES>');
   for vintLoop:= 1 to grdTranscribedFiles.rowcount - 1 do
      begin
      vstlTemp.add(grdTranscribedFiles.cells[0,vintLoop]);
      vstrAltName := comScriptWaveComm.InifilesReadOne
                                       ('T' + format('%.2d', [vintLoop]) + 'A');
      If vstrAltName > '  A' then
          vstlTemp[vstlTemp.count-1]:=
                               vstlTemp[vstlTemp.count-1] + '///' + vstrAltName;
      lblFileTransferName.caption := 'Sending: '
                                        + grdTranscribedFiles.cells[0,vintLoop];
      memCommProgress.Lines.add(datetimetostr(now) + ' Typing Completed: ' +
                                         grdTranscribedFiles.cells[0,vintLoop]);
      If not comScriptWaveComm.Crypt_Transmit
               (vstrMasterDoc + grdTranscribedFiles.cells[0,vintLoop] ,'/') then
         begin
         Showmessage('Problem in Communications - see log');
//         comScriptWaveComm.ShutdownFTP;
         exit;
         end;
      lblFileTransferName.caption:='';
      end;
   vstlTemp.text := vstlTemp.text + '<COMMENTS>' + #13#10 +
                                             comScriptWaveComm.vstrFileComments;
   vstlTemp.savetofile(vstrMasterDoc + lstMastDoc.items[0]);
   finally
     vstlTemp.free;
     end;
   If not comScriptWaveComm.Crypt_Transmit
                                    (vstrMasterDoc+lstMastDoc.items[0],'/') then
      begin
      Showmessage('Problem in Send Control file - see log');
//      comScriptWaveComm.ShutdownFTP;
      exit;
      end;

   If cstrType = 'Typist' then
       vstrNewName:= copy(lstMastDoc.items[0],1,length(lstMastDoc.items[0])-26)+
          comScriptWaveComm.vstrYear +
          comScriptWaveComm.vstrMonth +
          comScriptWaveComm.vstrDay +
          copy(lstMastDoc.items[0], length(lstMastDoc.items[0])-17,999) + '_cry'
   else
       vstrNewName:= copy(lstMastDoc.items[0],1,length(lstMastDoc.items[0])-17)+
          comScriptWaveComm.vstrYear +
          comScriptWaveComm.vstrMonth +
          comScriptWaveComm.vstrDay +
          copy(lstMastDoc.items[0], length(lstMastDoc.items[0])-8,999) + '_cry';

   If not comScriptWaveComm.RenameFile(lstMastDoc.items[0] + '_cry'
                                                          ,vstrNewName, '') then
      begin
      Showmessage('Problem in Rename Control file - see log');
//      comScriptWaveComm.ShutdownFTP;
      exit;
      end;
   If cstrType = 'Typist' then
     begin
     If vstrTypistID = 'T001' then
       RenameFile(vstrMasterDoc + lstMastDoc.items[0],
                  vstrMasterDoc + copy(vstrNewName,1,length(vstrNewName)-4))
     else
       begin
       deletefile(vstrMasterDoc + lstMastDoc.items[0]);
       comScriptWaveComm.SendPulse('T001',false);
       end;
     comScriptWaveComm.vstrFileTyped:= comScriptWaveComm.vstrYear +
                                      comScriptWaveComm.vstrMonth +
                                      comScriptWaveComm.vstrDay;
     comScriptWaveComm.InifilesWriteOne
                                 ('TypedDate', comScriptWaveComm.vstrFileTyped);
     comScriptWaveComm.InifilesWriteOne('TypedDateT',
                                             FormatDateTime('hh:mm AM/PM',now));
     end
   else
   If cstrType = 'Physician' then
     begin
     deletefile(vstrMasterDoc + lstMastDoc.items[0]);
     comScriptWaveComm.vstrFileReviewed:= comScriptWaveComm.vstrYear +
                                      comScriptWaveComm.vstrMonth +
                                      comScriptWaveComm.vstrDay;
     comScriptWaveComm.InifilesWriteOne
                           ('ReviewedDate', comScriptWaveComm.vstrFileReviewed);
     comScriptWaveComm.InifilesWriteOne('ReviewedDateT',
                                             FormatDateTime('hh:mm AM/PM',now));
     comScriptWaveComm.SendPulse
                             (copy(comScriptWaveComm.vstrCurrentFile,1,4),true);
     end;
   LoadAndScanFilesINI;
   finally
     pnlWait.SendToBack;
     pnlSpace.visible:= true;
     tmrMain.enabled:= true;
     vbolCommunicating := false;
//     comScriptWaveComm.ShutdownFTP;
    end;
end;

procedure TfrmTypistMain.WMQueryEndSession
           (var Msg : TWMQueryEndSession) ;
begin
shnShellNotify.Free;
msg.Result:= 1;
end;

procedure TfrmTypistMain.WMEndSession
           (var Msg : TWMEndSession) ;
begin
inherited;
vbolShutdown:= true;
frmTypistMain.close;
end;

procedure TfrmTypistMain.cmdGearplayerClick(Sender: TObject);
begin
  If pos('.doc', edtDictationName.text) > 0 then
    ShellExecute(0, 'open',
       PChar(vstrMasterDoc + edtDictationName.text),
       pchar(''),
       pchar(vstrMasterDoc), SW_SHOWNORMAL)
  else
    ShellExecute(0, 'open',
       PChar(vstrAudioPlayer),
       pchar('"' + vstrMasterDoc + edtDictationName.text + '"'),
       pchar('"' + vstrMasterDoc + '"'), SW_SHOWNORMAL);
end;

procedure TfrmTypistMain.edtAudioPlayerChange(Sender: TObject);
begin
vstrAudioPlayer := edtAudioPlayer.Text;
If fileexists(edtAudioPlayer.text) then
   begin
   cmdGearplayer.visible := true;
   comScriptWaveComm.SaveDefaults;
   end
else
   cmdGearplayer.visible:= false;
end;

procedure TfrmTypistMain.grdTranscribedFilesClick(Sender: TObject);
begin
edtAltName.text:=comScriptWaveComm.varrAttachedFiles[2,grdTranscribedFiles.Row];
end;

procedure TfrmTypistMain.cboFTPrecipientChange(Sender: TObject);
begin
if cboFTPrecipient.Text > '   A' then
    cmdFTPSelect.enabled:= true;
end;

procedure TfrmTypistMain.cmdFTPnowClick(Sender: TObject);
var vstrNewName, vstrHoldName: string;
begin
  vbolFTP := true;
  vbolCommunicating := true;
  vreaMinutes := 0;
  vreaPulseMinutes := 0;
  pnlWait.BringToFront;
  pnlSpace.visible:= false;
  pnlWait.Refresh;
 try
 If copy(cboFTPRecipient.text,1,4) = 'Refe' then
  vstrNewName:= vstrFTP + 'sending_Reference_'
                        + nopath(edtFTPFile.text)
 else
  vstrNewName:= vstrFTP + 'sending_' + copy(cboFTPRecipient.text,1,4) + '_'
                        + nopath(edtFTPFile.text);
  CopyFile(Pchar(edtFTPFile.text), Pchar(vstrNewName), false);

  memFTPHistory.lines.add('FTP file sent as: ' + vstrNewName);
  memFTPHistory.lines.add('Communications started for FTP');
  lblFileTransferName.caption := 'Sending: ' + vstrNewName;
  if comScriptWaveComm.Crypt_Transmit(vstrNewName, 'FTP') then
     begin
     vstrHoldName:= vstrNewName;
     vstrNewName := nopath(vstrNewName) + '_cry';
     comScriptWaveComm.DeleteFTPfile
                       ('Reference_' + nopath(edtFTPFile.text) + '_cry', 'FTP');
     if comScriptWaveComm.renamefile
                            (vstrNewName, copy(vstrNewName, 9, 999), 'FTP') then
        begin
        memFTPHistory.lines.add('FTP Communications Successful.');
        If copy(cboFTPRecipient.text,1,4) <> 'Refe' then
           comScriptWaveComm.SendPulse(copy(cboFTPRecipient.text,1,4),false);
        end
     else
        memFTPHistory.lines.add('The FTP Transmission was NOT successful. ' +
                                                     'Please try again later.');
     end
  else
     memFTPHistory.lines.add('The FTP Transmission was NOT successful. ' +
                                                     'Please try again later.');
  deletefile(vstrHoldName);
  finally
    lblFileTransferName.caption := '';
    pnlWait.SendToBack;
    pnlSpace.visible:= true;
    vbolFTP := false;
    vbolCommunicating:= false;
    end;
end;

procedure TfrmTypistMain.cmdFTPClearClick(Sender: TObject);
begin
cboFTPrecipient.ItemIndex := -1;
edtFTPFile.text := '';
memFTPHistory.lines.clear;
cmdFTPSelect.enabled:= false;
cmdFTPnow.enabled:= false;
end;

procedure TfrmTypistMain.cmdFTPselectClick(Sender: TObject);
begin
  dlgAddFTP.InitialDir:= 'c:\ScriptWave\';
  dlgAddFTP.filename := '';
  dlgAddFTP.Execute;
  edtFTPfile.text := dlgAddFTP.filename;
  if edtFTPfile.text > '  A' then
     cmdFTPnow.enabled:= true;
end;

procedure TfrmTypistMain.cmdNewEntityClick(Sender: TObject);
begin
comScriptWaveComm.InitializeFTP;
pnlWait.BringToFront;
pnlSpace.visible:= false;
pnlWait.Refresh;
try
memCommProgress.Lines.clear;
memCommProgress.Lines.add
                      (datetimetostr(now) + ' Receiving: ScriptWaveEntity.txt');

If comScriptWaveComm.GetFile(vstrAppBaseFolder + 'ScriptWaveEntity.txt',
                                                        'Entity', 2000) then
  begin
  Logit('Receiving new Entity file');
  comScriptWaveComm.vstlEntity.loadfromfile
                                   (vstrAppBaseFolder + 'ScriptWaveEntity.txt');
  EntityInit;
  end
else
  Logit('Entity file not found');
finally
    lblFileTransferName.caption := '';
    pnlWait.SendToBack;
    pnlSpace.visible:= true;
//    comScriptWaveComm.ShutdownFTP;
  end;
end;

procedure TfrmTypistMain.edtAltNameKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
If grdTranscribedFiles.cells[0, grdTranscribedFiles.Row] > '   A' then
   begin
   comScriptWaveComm.varrAttachedFiles[2,grdTranscribedFiles.Row]:=
                                                                edtAltName.text;
   comScriptWaveComm.InifilesWriteOne
                   ('T' + format('%.2d', [grdTranscribedFiles.Row]) + 'A',
                                                               edtAltName.text);
   end
else
   edtAltName.text := '';
end;

procedure TfrmTypistMain.cmdPrintClick(Sender: TObject);
var vstlRpt: tstringlist;
    vintLoop, vintLoop4, vintDictation, vintTrans: integer;
    vbolPrint, vbolHeader: boolean;
    vstrWork, vstrWork2, vstrHoldImport, vstrPhysicians: string;

    procedure SweepThisFile(const cstrFile: string);
      var vintLoop3: integer;
          vbolDelete: boolean;
      begin
      vbolDelete:= false;
      vintLoop3 := 0;
      while vintLoop3 < vstlRpt.count do
        begin
        If cstrFile = vstlRpt[vintLoop3] then
           begin
           vbolDelete:= true;
           vstlRpt.Delete(vintLoop3);
           end
        else
        If copy(vstlRpt[vintLoop3],1,1) = '[' then
           begin
           vbolDelete:= false;
           inc(vintLoop3)
           end
        else
        If vbolDelete then
           vstlRpt.delete(vintLoop3)
        else
           inc(vintLoop3);
        end
      end;

    procedure RemoveOtherTypists;
      var vintLoop2: integer;
          vstrFile: string;
      begin
      vintLoop2:= 0;
      while vintLoop2 < vstlRpt.count do
         begin
         If (copy(vstlRpt[vintLoop2],1,11) = 'AssignedTo=') and
            (cboR_Typist.text <> copy(vstlRpt[vintLoop2],12,4)) then
            begin
            SweepThisFile(vstrFile);
            vintLoop2:= -1;
            end
         else
         If copy(vstlRpt[vintLoop2],1,1) = '[' then
            vstrFile:= vstlRpt[vintLoop2];
         inc(vintLoop2);
         end;
      end;

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
If (length(cboMonth.text) = 0) or
   (lstR_Physicians.itemindex = -1) then
   exit;
lblPleaseWait.visible:= true;
application.processmessages;
vstlRpt:= tstringlist.create;
try
  vintDictation:= 0;
  vintTrans:= 0;
  vstlRpt.LoadFromFile(vstrArchive + copy(cboMonth.Text,4,4) +
                                     copy(cboMonth.Text,1,2) + '.ini');
  If cboR_Typist.text <> 'All' then
     RemoveOtherTypists;
  vbolPrint:= false;
  vbolHeader:= false;
  rptReport:= trptReport.create(nil);
  try
  for vintLoop := 0 to lstR_Physicians.items.count - 1 do
    If lstR_Physicians.Selected[vintLoop] then
     vstrPhysicians:= vstrPhysicians + lstR_Physicians.Items.Strings[vintLoop];
  for vintLoop := 0 to vstlRpt.count - 1 do
     begin
     vstrWork := vstlRpt[vintLoop];
     If copy(vstrWork,1,1) = '[' then
        if (pos(copy(vstrWork,2,4), vstrPhysicians) > 0) or
           (pos('All', vstrPhysicians) > 0) then
       //If (cboR_Physician.text = 'All') or
          //(cboR_Physicians.text = copy(vstrWork,2,4)) then
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
            vstrWork2:= vstrWork2 + StringOfChar(' ', 64 - length(vstrWork2)) +
            copy(vstrWork,16,2)
            + '\' + copy(vstrWork,18,2)
            + '\' + copy(vstrWork,12,4);
            rptReport.memReportDetail.lines
                         [rptReport.memReportDetail.lines.count-1] := vstrWork2;
            end;
        If copy(vstrWork,1,10) = 'TypedDate=' then
            begin
            vstrWork2:= rptReport.memReportDetail.lines
                                      [rptReport.memReportDetail.lines.count-1];
            vstrWork2:= vstrWork2 + StringOfChar(' ', 76 - length(vstrWork2)) +
            copy(vstrWork,15,2)
            + '\' + copy(vstrWork,17,2)
            + '\' + copy(vstrWork,11,4);
            rptReport.memReportDetail.lines
                         [rptReport.memReportDetail.lines.count-1] := vstrWork2;
            end;
        If copy(vstrWork,1,13) = 'ReviewedDate=' then
            begin
            vstrWork2:= rptReport.memReportDetail.lines
                                      [rptReport.memReportDetail.lines.count-1];
            vstrWork2:= vstrWork2 + StringOfChar(' ', 88 - length(vstrWork2)) +
            copy(vstrWork,18,2)
            + '\' + copy(vstrWork,20,2)
            + '\' + copy(vstrWork,14,4);
            rptReport.memReportDetail.lines
                         [rptReport.memReportDetail.lines.count-1] := vstrWork2;
            end;
        If (copy(vstrWork,1,9) = 'FileSize=') and
           (length(copy(vstrWork,10,999)) > 2) then
            rptReport.memReportDetail.Lines.Add('     Dictation File Size: ' +
                 copy(vstrWork,10,999));
        end;
     end;
  rptReport.lblTypist.enabled:= true;
  rptReport.lblTypistName.enabled:= true;

  If vstrTypistID = 'T001' then
    begin
    If cboR_Typist.text = 'All' then
      rptReport.lblTypistName.caption := 'All Typists'
    else
    for vintLoop4 := 0 to cboTypists.Items.count - 1 do
      If copy(cboR_Typist.text,1,4) = copy(cboTypists.items[vintLoop4],1,4) then
         rptReport.lblTypistName.caption:= cboTypists.items[vintLoop4];
    end
  else
    rptReport.lblTypistName.caption:= vstrTypistID + ' ' + vstrTypist;
  rptReport.lblCompany2.caption:= vstrTranscriptionist;
  rptReport.lblDictationTotal.caption := inttostr(vintDictation);
  rptReport.lblTransTotal.caption := inttostr(vintTrans);
  rptReport.lblTitle2.caption := cboMonth.Text;
  rptReport.Preview;
  application.ProcessMessages;
    finally
    rptReport.destroy;
    rptReport:=nil;
    end;
finally
 lblPleaseWait.visible:= false;
 vstlRpt.free;
 end;
end;

procedure TfrmTypistMain.chkPurgeOnClick(Sender: TObject);
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

procedure TfrmTypistMain.cboPurgeMainChange(Sender: TObject);
begin
vstrPurgeMaster:= cboPurgeMain.text;
comScriptWaveComm.SaveDefaults;
end;

procedure TfrmTypistMain.cboPurgeImportChange(Sender: TObject);
begin
vstrPurgeImport:= cboPurgeImport.text;
comScriptWaveComm.SaveDefaults;
end;

procedure TfrmTypistMain.cboPurgeTranscriptionChange(Sender: TObject);
begin
vstrPurgeTranscription:= cboPurgeTranscription.text;
comScriptWaveComm.SaveDefaults;
end;

procedure TfrmTypistMain.cmdDelAttachmentClick(Sender: TObject);
var vintLoop: integer;
begin
If (grdTranscribedFiles.RowCount =  1) and
   (grdTranscribedFiles.Cells[0,1] < '  A') then
   exit;

Deletefile(vstrMasterDoc + grdTranscribedFiles.Cells[0,grdTranscribedFiles.row]);

for vintLoop:= grdTranscribedFiles.row to grdTranscribedFiles.RowCount - 2 do
  begin
  grdTranscribedFiles.Cells[0,vintLoop]:=
                                        grdTranscribedFiles.Cells[0,vintLoop+1];
  comScriptWaveComm.varrAttachedFiles[1,vintLoop]:=
                              comScriptWaveComm.varrAttachedFiles[1,vintLoop+1];
  comScriptWaveComm.varrAttachedFiles[2,vintLoop]:=
                              comScriptWaveComm.varrAttachedFiles[2,vintLoop+1];
  end;

grdTranscribedFiles.Cells[0,grdTranscribedFiles.RowCount - 1]:= '';
comScriptWaveComm.varrAttachedFiles[1,grdTranscribedFiles.RowCount - 1]:= '';
comScriptWaveComm.varrAttachedFiles[2,grdTranscribedFiles.RowCount - 1]:= '';

comScriptWaveComm.InifilesWriteDetail(false);
comScriptWaveComm.iniFileControl.DeleteKey(comScriptWaveComm.vstrCurrentFile,
                      'T' + format('%.2d', [grdTranscribedFiles.RowCount - 1]));
comScriptWaveComm.iniFileControl.DeleteKey(comScriptWaveComm.vstrCurrentFile,
                'T' + format('%.2d', [grdTranscribedFiles.RowCount - 1]) + 'A');
try
comScriptWaveComm.iniFileControl.UpdateFile;
  except
  comScriptWaveComm.IniFiles_UpdateFile_Override;
  end;

grdTranscribedFiles.RowCount:= grdTranscribedFiles.RowCount - 1;

If grdTranscribedFiles.Cells[0,1] > '  A' then
else
   begin
   cmdDelAttachment.enabled := false;
   cmdTypistComplete.enabled:= false;
   edtAltName.text := '';
   end;
end;

{System is having problems - shutdown and trigger communication after restart}
procedure TfrmTypistMain.cmdRestartClick(Sender: TObject);
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

procedure TfrmTypistMain.cmdDictationDeleteClick(Sender: TObject);
 var vintLoop: integer;
     vstrOldName: string;
     vstrNewName: string;
begin
  if MessageDlg('This is a permanent delete request from your system and ' +
                'from the physician''s system.  Continue?',
                 mtConfirmation, [mbYes, mbNo], 0) = mrNo then
     exit;
try
  medDictation.Close;
  except
  end; 
comScriptWaveComm.InitializeFTP;
pnlWait.BringToFront;
pnlSpace.visible:= false;
pnlWait.Refresh;
try
memCommProgress.Lines.clear;
memCommProgress.Lines.add(datetimetostr(now) + ' Remove File: '
                        + comScriptWaveComm.vstrCurrentFile);
application.processmessages;
Logit('Remove File: ' + comScriptWaveComm.vstrCurrentFile);
If FileExists(vstrMasterDoc + comScriptWaveComm.vstrCurrentFile) then
   deletefile(vstrMasterDoc + comScriptWaveComm.vstrCurrentFile);

If comScriptWaveComm.DirectoryListFTP('') then
  begin
  for vintLoop := 0 to vstlDir.count-1 do
     begin
     if pos('C_' + comScriptWaveComm.vstrCurrentFile,vstlDir[vintLoop]) > 0 then
            begin
            vstrOldName:= copy(vstlDir[vintLoop], cintFTPDirOffset,999);
            vstrNewName:= 'CD' + copy(vstlDir[vintLoop],
                                                        cintFTPDirOffset+2,999);
            comScriptWaveComm.renamefile(vstrOldName, vstrNewName, '');
            comScriptWaveComm.DeleteFTPfile
                               (comScriptWaveComm.vstrCurrentFile + '_cry', '');
//            comScriptWaveComm.shutdownftp;
            If FileExists(vstrMasterDoc +
                                 copy(vstrOldName,1,length(vstrOldName)-4)) then
              deletefile(vstrMasterDoc +
                                     copy(vstrOldName,1,length(vstrOldName)-4));
            break;
            end;
     end;
  end;
If comScriptWaveComm.iniFileControl.SectionExists
                                        (comScriptWaveComm.vstrCurrentFile) then
   begin
   comScriptWaveComm.iniFileControl.EraseSection
                                            (comScriptWaveComm.vstrCurrentFile);
   try
     comScriptWaveComm.iniFileControl.UpdateFile;
     except
       comScriptWaveComm.IniFiles_UpdateFile_Override;
       end;
   end;
finally
    lblFileTransferName.caption := '';
    pnlWait.SendToBack;
    pnlSpace.visible:= true;
//    comScriptWaveComm.ShutdownFTP;
    LoadAndScanFilesINI;
  end;
end;

procedure TfrmTypistMain.edtDictationNameChange(Sender: TObject);
begin
cmdDictationDelete.enabled := false;
If (vstrTypistID = 'T001') and
   (edtDictationName.text > '  A') and
   (comScriptWaveComm.vstrFileReceived <> '00000000') and
   (comScriptWaveComm.vstrFileTyped = '00000000') then
   cmdDictationDelete.enabled := true;
end;

procedure TfrmTypistMain.cmdDictationResendClick(Sender: TObject);
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

procedure TfrmTypistMain.cmdTransResendClick(Sender: TObject);
begin
if grdTranscribedFiles.row > 0 then
 if fileexists(vstrMasterDoc +
                     grdTranscribedFiles.cells[0,grdTranscribedFiles.Row]) then
   begin
   comScriptWaveComm.InitializeFTP;
   pnlWait.BringToFront;
   pnlSpace.visible:= false;
   pnlWait.Refresh;
   try
     memCommProgress.Lines.clear;
     memCommProgress.Lines.add(datetimetostr(now) + ' Re-send File: ' +
                          grdTranscribedFiles.cells[0,grdTranscribedFiles.Row]);
     application.processmessages;
     Logit('Re-send File: '
                        + grdTranscribedFiles.cells[0,grdTranscribedFiles.Row]);
     comScriptWaveComm.Crypt_Transmit(vstrMasterDoc +
                       grdTranscribedFiles.cells[0,grdTranscribedFiles.Row],'');
     finally
      lblFileTransferName.caption := '';
      pnlWait.SendToBack;
      pnlSpace.visible:= true;
//      comScriptWaveComm.ShutdownFTP;
     end;
   end;
end;

procedure TfrmTypistMain.cmdDictationReReceiveClick(Sender: TObject);
begin
   medDictation.Close;
   comScriptWaveComm.InitializeFTP;
   pnlWait.BringToFront;
   pnlSpace.visible:= false;
   pnlWait.Refresh;
   try
     memCommProgress.Lines.clear;
     memCommProgress.Lines.add(datetimetostr(now) + ' Re-receive File: '
                                                      + edtDictationName.Text );
     application.processmessages;
     Logit('Re-receive File: ' + edtDictationName.Text);
     comScriptWaveComm.Receive_uncrypt
                          (vstrMasterDoc + edtDictationName.Text + '_cry',
                           2200000,'/');
     finally
      lblFileTransferName.caption := '';
      pnlWait.SendToBack;
      pnlSpace.visible:= true;
//      comScriptWaveComm.ShutdownFTP;
     end;
end;

procedure TfrmTypistMain.cmdTransReReceiveClick(Sender: TObject);
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
     finally
      lblFileTransferName.caption := '';
      pnlWait.SendToBack;
      pnlSpace.visible:= true;
//      comScriptWaveComm.ShutdownFTP;
     end;
end;



{------------------------------------------------------------------------------}
//RECORDER STUFF

procedure TfrmTypistMain.waveOutFeedChunk(sender: unavclInOutPipe;
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


procedure TfrmTypistMain.c_btn_startClick(Sender: TObject);
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

procedure TfrmTypistMain.c_timer_mainTimer(Sender: TObject);
begin
try
  c_progressBar_memLoad.position :=
                              round((f_memUsed / maxsize) * c_trackbar_pos.max);
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

procedure TfrmTypistMain.SaveDictationCopy(const cstrFile: string);
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

procedure TfrmTypistMain.c_btn_stopClick(Sender: TObject);
begin
  StopRecord;
  try
  SaveDictationCopy('Dictation1Backup_' + floattostr(now) + '.wvb');
  flbBackups.ApplyFilePath(vstrAppBaseFolder + '\RecordTemp\');
  except end;
end;

procedure TfrmTypistMain.StopRecord;
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

procedure TfrmTypistMain.waveInDataAvailable(sender: unavclInOutPipe;
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
    StopRecord;
    // close file
    wavReadWrite.close();
    end;
end;

procedure TfrmTypistMain.c_btn_playClick(Sender: TObject);
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

procedure TfrmTypistMain.c_btn_cutClick(Sender: TObject);
begin
  f_memUsed := f_memOffs;
end;

procedure TfrmTypistMain.c_trackBar_posChange(Sender: TObject);
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

procedure TfrmTypistMain.pnlTest_RecordClick(Sender: TObject);
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

procedure TfrmTypistMain.btnSaveClick(Sender: TObject);
  var vstrRealFile: string;
      SEInfo: TShellExecuteInfo;
      ExitCode: DWORD;
begin
  pnlEncoding.Visible:= true;
  pnlEncoding.BringToFront;
  try
  // stop wave processing (if any)
  StopRecord;
  c_timer_main.enabled:= false;
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
  Finally
  pnlEncoding.Visible:= false;
  end;
end;

procedure TfrmTypistMain.btnCancelRecordClick(Sender: TObject);
begin
  if vbolNoDialog then
  else
    ShowMessage('Just in case, the current recording will be saved in Emergency '
            + 'backup #1');
  SaveDictationCopy('Dictation1Backup.wav');
  mrealloc(f_memBlock);
  f_memOffs := 0;
  f_memUsed := 0;
  pnlTest_Record.caption:= 'CLICK AND SPEAK FOR 3 SECONDS TO TEST RECORDING';
  pnlTest_Record.bringtofront;
  pnlTest_Record.Refresh;
  pnlRecord.visible:= false;
  c_timer_main.Enabled:= false;
  cmdRecover1.enabled:= false;
  cmdRecover2.enabled:= false;
end;

procedure TfrmTypistMain.pnlLameClick(Sender: TObject);
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

procedure TfrmTypistMain.cmdRecover1Click(Sender: TObject);
begin
SalvageFile('Dictation1Backup.wav');
end;

procedure TfrmTypistMain.cmdRecover2Click(Sender: TObject);
begin
SalvageFile('Dictation2Backup.wav');
end;

Procedure TfrmTypistMain.SalvageFile(const cstrFile: string);
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

procedure TfrmTypistMain.cmdChangePasswordClick(Sender: TObject);
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
    vstl.text := copy(vstl.text,1,50) + format('%-20s',[edtChangePassword.text])
                 + copy(vstl.text,71,999);
    vstl.text:= CryptorString(vstl[0]);
    vstl.savetofile(vstrAppBaseFolder + 'ScriptWaveAccount_'
                                          + copy(vstrSessionType,1,1) + '.cry');
    finally
      vstl.free;
    end;
  end;
end;

procedure TfrmTypistMain.cmdAddCommentClick(Sender: TObject);
  var vstlTemp: tstringlist;
begin
{For received work, the lead typist can add comments.  The control file is
updated and uploaded to the server.}
frmAddComment.memFileComments.lines.text := '';
frmAddComment.showmodal;
If frmAddComment.memFileComments.lines.text > '' then
  begin
  vreaMinutes := 0;
  vreaPulseMinutes:= 0;
  tmrMain.enabled:= false;
  vbolCommunicating := true;
  pnlWait.BringToFront;
  pnlSpace.visible:= false;
  memCommProgress.Lines.clear;
  pnlWait.Refresh;
  {Add to iniFile}
  try
  comScriptWaveComm.vstrFileComments := comScriptWaveComm.vstrFileComments +
                             '=============================||' +
                             MemoUnHash(frmAddComment.memFileComments.text)
                             + '||';
  memFileComments.Lines.text := MemoHash(comScriptWaveComm.vstrFileComments);
  comScriptWaveComm.InifilesWriteDetail(true);
  {Add to command file and Transmit}
  lstMastDoc.Directory:= vstrMasterDoc;
  lstMastDoc.Mask:= 'C_' + comScriptWaveComm.vstrCurrentFile + '_A*';
  lstMastDoc.Update;
  vstlTemp := tstringlist.create;
   try
   vstlTemp.add('<FILES>');
   vstlTemp.text := vstlTemp.text + '<COMMENTS>' + #13#10 +
                                             comScriptWaveComm.vstrFileComments;
   vstlTemp.savetofile(vstrMasterDoc + lstMastDoc.items[0]);
   finally
     vstlTemp.free;
     end;
   lblFileTransferName.caption := 'Sending: ' + lstMastDoc.items[0];
   memCommProgress.Lines.add(datetimetostr(now) + ' Update Comment: ' +
                             vstrMasterDoc+lstMastDoc.items[0]);
   If not comScriptWaveComm.Crypt_Transmit
                                    (vstrMasterDoc+lstMastDoc.items[0],'/') then
      begin
      Showmessage('Problem in Send Control file - see log');
//      comScriptWaveComm.ShutdownFTP;
      exit;
      end;
//   comScriptWaveComm.ShutdownFTP;
   finally
     pnlWait.SendToBack;
     pnlSpace.visible:= true;
     tmrMain.enabled:= true;
     vbolCommunicating := false;
     lblFileTransferName.caption := '';
     end;
  end;

end;

procedure TfrmTypistMain.cmdHelpClick(Sender: TObject);
var vstrLink: string;
begin
If pagMain.ActivePageIndex = 0 then
   vstrLink:= 'www.scriptwave.net/TypistHelp/status_of_work.html'
else
If pagMain.ActivePageIndex = 1 then
   vstrLink:= 'www.scriptwave.net/TypistHelp/alerts.html'
else
If pagMain.ActivePageIndex = 2 then
   vstrLink:= 'www.scriptwave.net/TypistHelp/messages.html'
else
If pagMain.ActivePageIndex = 3 then
   vstrLink:= 'www.scriptwave.net/TypistHelp/ftp.html'
else
If pagMain.ActivePageIndex = 4 then
   vstrLink:= 'www.scriptwave.net/TypistHelp/dictate.html'
else
If pagMain.ActivePageIndex = 5 then
   vstrLink:= 'www.scriptwave.net/TypistHelp/reports.html'
else
If pagMain.ActivePageIndex = 6 then
   vstrLink:= 'www.scriptwave.net/TypistHelp/preferences.html'
else
   vstrLink:= 'www.scriptwave.net/documentation.html';
webScriptWave.Navigate(vstrLink);
pagMain.ActivePageIndex:= 7;
end;

procedure TfrmTypistMain.cboStatusFilterChange(Sender: TObject);
begin
LoadAndScanFilesINI;
end;

procedure TfrmTypistMain.edtScanFolderExit(Sender: TObject);
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

procedure TfrmTypistMain.chkRecentClick(Sender: TObject);
begin
LoadAndScanFilesINI;
end;

procedure TfrmTypistMain.cmdAssignmentsClick(Sender: TObject);
var vintLoop, vintTempID: integer;
    vbolStart, vbolAssigned: boolean;
    trnFind: ttreenode;
    vstrMeg: string;
begin
vbolNoTreeRefresh:= true;
try
If cboTypists.itemindex <> -1 then
   vintTempID:= cboTypists.itemindex
else
   vintTempID:= 0;
chkRecent.checked:= false;
chkShowStat.checked:= false;
cboStatusFilter.itemindex:= 0;
finally
  vbolNoTreeRefresh:= false;
  end;
chkAssigns.Items.clear;
lstAssigned.Items.clear;
pnlAssignments.left := 0;
pnlAssignments.top := 0;
lstTypists.items.text := cboTypists.Items.Text;
pnlAssignments.visible:= true;
LoadAndScanFilesINI;
vbolStart:= false;
vbolAssigned:= false;
for vintLoop:= 0 to treAll.Items.Count - 1 do
   begin
   If pos('Received', treAll.items[vintLoop].text) > 0 then
      vbolStart:= true
   else
   If pos('Typed', treAll.items[vintLoop].text) > 0 then
      break
   else
   If pos('Assigned', treAll.items[vintLoop].text) > 0 then
      vbolAssigned:= true
   else
   if vbolStart then
      begin
      trnFind:=GetNodeByText(treAll,treAll.items[vintLoop].text,true);
      trnFind.selected:= true;
      treAllClick(self);
      try
        vstrMeg:= trim(lblFileSizeDisplay.caption);
        while pos(',', vstrMeg) > 0 do
           vstrMeg:= copy(vstrMeg,1,pos(',', vstrMeg)-1) +
                     copy(vstrMeg,pos(',', vstrMeg)+1,999);
        vstrMeg := trim(format('%-5.2n', [strtoint(vstrMeg) / 1000000]));
        except
          vstrMeg:= '???';
          end;
      chkAssigns.items.Add(treAll.items[vintLoop].text + ' ('  +
                           vstrMeg + ')');
      If vbolAssigned then
        lstAssigned.items.Add(cboTypists.Items[cboTypists.itemindex])
      else
        lstAssigned.items.Add('');
      end;
   end;
  lstTypists.ItemIndex:= vintTempID;
  lstTypistsClick(self);
end;

procedure TfrmTypistMain.cmdCancelAssignClick(Sender: TObject);
begin
pnlAssignments.visible:= false;
end;

procedure TfrmTypistMain.chkAssignsClick(Sender: TObject);
begin
If lstTypists.ItemIndex = -1 then
   exit;
If chkAssigns.ItemIndex = -1 then
   exit;

If chkAssigns.checked[chkAssigns.ItemIndex] then
   lstAssigned.Items[chkAssigns.ItemIndex]:=
                                         lstTypists.items[lstTypists.itemindex]
else
   lstAssigned.Items[chkAssigns.ItemIndex]:='';
end;

procedure TfrmTypistMain.cmdAssignAllClick(Sender: TObject);
   var vintLoop: integer;
       trnFind: ttreenode;
       vbolFirst: boolean;
begin
vbolFirst:= true;
try
for vintLoop:= 0 to chkAssigns.Items.count - 1 do
  If lstAssigned.items[vintLoop] > '  A' then
    begin
    trnFind:=GetNodeByText(treAll,
      copy(chkAssigns.items[vintLoop],1,pos('(', chkAssigns.items[vintLoop])-2),
      true);
    trnFind.selected:= true;
    treAllClick(self);
    If lstAssigned.items[vintLoop] <>
                                   (cboTypists.Items[cboTypists.itemindex]) then
       begin
       cboTypists.itemindex:=
                          cboTypists.Items.IndexOf(lstAssigned.items[vintLoop]);
       If vbolFirst then
          begin
          vbolFirst := false;
          If not BeginAssign then exit;
          end;
       AssignLoop;
       end;
    end;
finally
  EndAssign;
  pnlAssignments.visible:= false;
  end;

end;

procedure TfrmTypistMain.lstTypistsClick(Sender: TObject);
  var vintLoop: integer;
begin
for vintLoop:= 0 to chkAssigns.items.count - 1 do
  If lstTypists.items[lstTypists.ItemIndex] =
                                    lstAssigned.items[vintLoop] then
     chkAssigns.checked[vintLoop] := true
  else
     chkAssigns.checked[vintLoop] := false;
end;

procedure TfrmTypistMain.edtSearchWordChange(Sender: TObject);
begin
If length(edtSearchWord.text) > 0 then
   cmdSearch.enabled:= true;
end;

procedure TfrmTypistMain.cmdSearchClick(Sender: TObject);
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

procedure TfrmTypistMain.lstSearchResultsDblClick(Sender: TObject);
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

procedure TfrmTypistMain.cmdRouteRuleClick(Sender: TObject);
begin
pnlRouteRules.left :=0;
pnlRouteRules.top :=0;
pnlRouteRules.visible:= true;
cboPhysicianRouteRules.Items.text :=
                              comScriptWaveComm.LoadEntityList('PhysicianOnly');
cboAdminRouteRules.Items.Text := comScriptWaveComm.LoadEntityList('Admin');
If fileexists(vstrAppBaseFolder + 'NotifyRules.txt') then
   lstRules.items.loadfromfile(vstrAppBaseFolder + 'NotifyRules.txt');
end;

procedure TfrmTypistMain.cmdExitRulesClick(Sender: TObject);
begin
pnlRouteRules.visible:= false;
lstRules.items.savetofile(vstrAppBaseFolder + 'NotifyRules.txt');
end;

procedure TfrmTypistMain.cmdDeleteRuleClick(Sender: TObject);
begin
if lstRules.itemindex <> -1 then
   lstRules.Items.Delete(lstRules.itemindex);
end;

procedure TfrmTypistMain.lstRulesClick(Sender: TObject);
begin
If lstRules.ItemIndex = -1 then
   vstrRouteName:= ''
else
   vstrRouteName:= lstRules.items[lstRules.itemindex];
end;

procedure TfrmTypistMain.cmdNewRuleClick(Sender: TObject);
begin
If (cboPhysicianRouteRules.ItemIndex <> -1) and
   (cboAdminRouteRules.itemindex <> -1) then
   begin
   vstrRouteName :=
        cboPhysicianRouteRules.items[cboPhysicianRouteRules.ItemIndex] + '=' +
        cboAdminRouteRules.items[cboAdminRouteRules.ItemIndex];
   If lstRules.items.indexof(vstrRouteName) = -1 then
      lstRules.items.add(vstrRouteName);
   end;
end;

procedure TfrmTypistMain.edtEmergencyIPExit(Sender: TObject);
begin
If length(edtEmergencyIP.text) > 11 then
  comScriptWaveComm.SaveEmergency(edtEmergencyIP.text);
end;


{This will be the routine to receive a file drop event, decrypt it, and shell
to execute the file.  This will allow encrypted files to be sent through email}
procedure TfrmTypistMain.WMDropFiles(var message: TWMDropFiles);
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
  { Since we're done with the files, finnish the drag'n'drop operation }
  DragFinish(message.Drop);
  message.Result := 0;
end;


procedure TfrmTypistMain.cmdEmailClick(Sender: TObject);
var
  myOlApp, myItem, myAttachments: OleVariant;
begin
  CryptorFile(vstrMasterDoc + comScriptWaveComm.vstrCurrentFile,
              vstrFTP + comScriptWaveComm.vstrCurrentFile + '_cry');
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
end;

procedure TfrmTypistMain.cmdEmailDocClick(Sender: TObject);
var
  myOlApp, myItem, myAttachments: OleVariant;
  vstrWork: string;
begin
  vstrWork:= comScriptWaveComm.varrAttachedFiles[1,grdTranscribedFiles.Row];
  If length(vstrWork) = 0 then exit;
  CryptorFile(vstrMasterDoc + vstrWork,
              vstrFTP + vstrWork + '_cry');
  try
    myOlApp := CreateOLEObject('Outlook.Application');
    myItem := myOlApp.CreateItem(olMailItem);
    myItem.Subject := 'ScriptWave attached file';
    myAttachments := myItem.Attachments;
    myAttachments.Add(vstrFTP + vstrWork + '_cry',
                    olByValue, 1, 'ScriptWave File');
    myItem.Display;
    myItem := VarNull;
    myAttachments := VarNull;
    myOlApp := VarNull;
    except
    end;
end;

procedure TfrmTypistMain.flbBackupsDblClick(Sender: TObject);
begin
if not c_btn_stop.enabled then
 If flbBackups.ItemIndex > -1 then
  SalvageFile(flbBackups.Items[flbBackups.itemindex]);
end;


procedure TfrmTypistMain.CreateWaveIn(const cbolMessage: boolean);
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

procedure TfrmTypistMain.cmdMessagePurgeClick(Sender: TObject);
 var
  SR: TSearchRec;
  modifiedTime : TDateTime;
begin
try
  if dteMessagePurge.DateTime > date - 30 then
     showmessage('Purge date must be over 30 days in the past')
  else
     begin
     if FindFirst(lstMessages.Directory + '\*.*', faAnyFile, SR) = 0 then
       repeat
         if (sr.name <> '.') and (sr.name <> '..') then
           begin
           modifiedTime := FileDateToDateTime(sr.Time);
           If modifiedTime < dteMessagePurge.DateTime then
             deletefile(lstMessages.Directory + '\' + sr.name);
           end
       until FindNext(SR) <> 0;
       FindClose(SR);
     end;
ResetAfterMessage;
treMessages.items.Clear;
LoadMessages;
except
  end;
end;

end.


