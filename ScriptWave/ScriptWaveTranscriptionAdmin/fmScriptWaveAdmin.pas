unit fmScriptWaveAdmin;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileCtrl, ComCtrls, pmScriptWaveShare, pmutilities,
  pmVariablesConstants, Grids, pmScriptWave_mudCryptor, Buttons, ExtCtrls, inifiles,
  DBGrids, DBCtrls, Db, DBTables, pmScriptWaveFTP_II, Gauges;

type
  TfrmScriptWaveTranscriptionAdmin = class(TForm)
    pagMain: TPageControl;
    tabAccounts: TTabSheet;
    tabEncryption: TTabSheet;
    edtFile: TEdit;
    lbla: TLabel;
    edtContent: TEdit;
    cmdLoad: TButton;
    btnSave: TButton;
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    tabPurge: TTabSheet;
    lblP1: TLabel;
    memProgress: TMemo;
    cmdPurge: TButton;
    Memo1: TMemo;
    btnCreateAccountFolders: TButton;
    lstAccounts: TListBox;
    grdPhysician: TStringGrid;
    grdAdmin: TStringGrid;
    grdTypist: TStringGrid;
    edtName: TEdit;
    edtLogin: TEdit;
    edtPassword: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnAddPhysician: TButton;
    btnSavePhysician: TButton;
    btnMovetoServer: TButton;
    btnAddAdmin: TButton;
    btnSaveAdmin: TButton;
    cmdAdd: TButton;
    cmdSaveTypist: TButton;
    btnPhysicianUpload: TButton;
    btnAdminUpload: TButton;
    btnTypistUpload: TButton;
    memUploading: TMemo;
    btnNewAccount: TButton;
    btnSaveAccount: TButton;
    Edit3: TEdit;
    cboAccount: TComboBox;
    tabAccountStatus: TTabSheet;
    pnlStatus: TPanel;
    Label5: TLabel;
    lblComments: TLabel;
    lblAssignedto: TLabel;
    lblAltName: TLabel;
    lblImportDate: TLabel;
    lblTypeDate: TLabel;
    lblCompleteDate: TLabel;
    lblReviewDate: TLabel;
    lblTransmitDate: TLabel;
    lblReceiveDate: TLabel;
    lblAssignDate: TLabel;
    edtDictationName: TEdit;
    memFileComments: TMemo;
    grdTranscribedFiles: TStringGrid;
    cboTypists: TComboBox;
    edtAltName: TEdit;
    edtImportDate: TEdit;
    edtTypedDate: TEdit;
    edtReviewDate: TEdit;
    edtCompleteDate: TEdit;
    edtAssignDate: TEdit;
    edtReceiveDate: TEdit;
    edtTransmitDate: TEdit;
    pnlAccount: TPanel;
    cboAcctList: TComboBox;
    Label6: TLabel;
    pnlWait: TPanel;
    treAll: TTreeView;
    tabControl: TTabSheet;
    pnlCtrl: TPanel;
    edtControl: TEdit;
    lstCtrls: TListBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    edtImport: TEdit;
    edtType: TEdit;
    edtReview: TEdit;
    edtComplete: TEdit;
    edtAssign: TEdit;
    edtReceive: TEdit;
    edtTransmit: TEdit;
    Label14: TLabel;
    edtAssignto: TEdit;
    btnRename: TButton;
    pnlProblem: TPanel;
    memDescription: TDBRichEdit;
    cboProbAccount: TDBComboBox;
    DBText1: TDBText;
    cboUser: TDBComboBox;
    cboCategories: TDBComboBox;
    DBText2: TDBText;
    btnMoreInfo: TButton;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    cmdNewProblem: TButton;
    tblProblems: TTable;
    dtsProblems: TDataSource;
    Label22: TLabel;
    lblRelatedFile: TDBText;
    grdRecent: TDBGrid;
    Label21: TLabel;
    cmdDeleteProblem: TButton;
    btnAttach: TButton;
    tabMessages: TTabSheet;
    treMessages: TTreeView;
    cmdDeleteMessage: TSpeedButton;
    cmdReplyMessage: TSpeedButton;
    cmdNewMessage: TSpeedButton;
    cmdMailIt: TSpeedButton;
    cmdCancelMail: TSpeedButton;
    lblToMessage: TLabel;
    lblFrom: TLabel;
    lblMailTime: TLabel;
    lblMailSubject: TLabel;
    lblMailMemo: TLabel;
    edtMessageTo: TEdit;
    edtFromMail: TEdit;
    edtDateTimeMail: TEdit;
    edtSubjectMail: TEdit;
    memMessage: TMemo;
    lstMessages: TFileListBox;
    cboMessageTo: TComboBox;
    cmdSendandReceive: TButton;
    pnlCommunicate2: TPanel;
    tabComplete: TTabSheet;
    edtMakeCpt: TEdit;
    lblComp: TLabel;
    edtPhys: TEdit;
    edtAcct: TEdit;
    Button5: TButton;
    Button6: TButton;
    procedure FormCreate(Sender: TObject);
    procedure cmdLoadClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure cmdPurgeClick(Sender: TObject);
    procedure lstAccountsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAddPhysicianClick(Sender: TObject);
    procedure btnAddAdminClick(Sender: TObject);
    procedure cmdAddClick(Sender: TObject);
    procedure btnSavePhysicianClick(Sender: TObject);
    procedure cmdSaveTypistClick(Sender: TObject);
    procedure btnSaveAdminClick(Sender: TObject);
    procedure btnPhysicianUploadClick(Sender: TObject);
    procedure btnAdminUploadClick(Sender: TObject);
    procedure btnTypistUploadClick(Sender: TObject);
    procedure btnCreateAccountFoldersClick(Sender: TObject);
    procedure btnMovetoServerClick(Sender: TObject);
    procedure btnNewAccountClick(Sender: TObject);
    procedure btnSaveAccountClick(Sender: TObject);
    procedure edtNameChange(Sender: TObject);
    procedure edtLoginChange(Sender: TObject);
    procedure edtPasswordChange(Sender: TObject);
    procedure cboAcctListChange(Sender: TObject);
    procedure treAllClick(Sender: TObject);
    procedure lstCtrlsClick(Sender: TObject);
    procedure btnRenameClick(Sender: TObject);
    procedure cmdNewProblemClick(Sender: TObject);
    procedure cmdDeleteProblemClick(Sender: TObject);
    procedure btnAttachClick(Sender: TObject);
    procedure cboProbAccountChange(Sender: TObject);
    procedure btnMoreInfoClick(Sender: TObject);
    procedure grdRecentCellClick(Column: TColumn);
    procedure cboUserChange(Sender: TObject);
    procedure cboCategoriesChange(Sender: TObject);
    procedure grdTranscribedFilesClick(Sender: TObject);
    procedure treMessagesClick(Sender: TObject);
    procedure cmdDeleteMessageClick(Sender: TObject);
    procedure cmdReplyMessageClick(Sender: TObject);
    procedure cmdNewMessageClick(Sender: TObject);
    procedure cmdMailItClick(Sender: TObject);
    procedure cmdCancelMailClick(Sender: TObject);
    procedure cmdSendandReceiveClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
    vstlAccounts: tstringlist;
    vstlEntityList: tstringlist;
    vstrAcctFolder: string;
    vbolLoad: boolean;
    vbolNoUp: boolean;
    vbolAllAccount: boolean;
    vMudComp: tcomScriptWaveCommunicator;
    procedure RefreshAccountList;
    procedure LoadPhysicians;
    procedure LoadAdmins;
    procedure LoadTypists;
    function GetAcctVal(const cintField: integer;
                        const cstrLine: string): string;
    procedure SaveAccountFile(const cstrType: string);
    procedure RefreshEntity;
    procedure SaveAcctVal(const cintField: integer;
                          const cstrValue: string;
                          const cintLine: integer);
    procedure LoadAndScanFilesINI;
    function MemoHash(const cstrMemo: string): string;
    procedure GetStatusAndDownloadFiles;
    procedure FindCommandDownloads(const cstrCntlFile: string);

    procedure SendAndReceiveMessages;
    procedure LoadMessages;
    function FindMessageFile(const cstrDateTime: string): string;
    function GetNodeByText(ATree : TTreeView;
                           AValue:String;
                           AVisible: Boolean): TTreeNode;
    procedure ResetAfterMessage;
    procedure StartCommunications;
    procedure EndCommunications;

  public
    { Public declarations }
    vTime: real;
  end;

var
  frmScriptWaveTranscriptionAdmin: TfrmScriptWaveTranscriptionAdmin;

implementation

{$R *.DFM}

procedure TfrmScriptWaveTranscriptionAdmin.FormCreate(Sender: TObject);
begin
deletefile(vstrAppBaseFolder + 'ScriptwaveFileControl.ini');
vstrSessionType:= 'Admin';
//vstrIP:= 'www.scriptwave.net';
//vstrIP:= '71.74.103.49';
//vstrLogin:= 'root';
vstrConfigFile:= 'ScriptWaveAccount_A.cry';
vstrTranscriptionist:= 'Administrator';
vstrTranscriptionistID:=  'A999';
vstlAccounts:= tstringlist.create;
vstlAccounts.LoadFromFile('Accounts.txt');
vstlEntityList:= tstringlist.create;
startcommunications;
RefreshAccountList;
LoadAndScanFilesIni;
end;

procedure TfrmScriptWaveTranscriptionAdmin.startcommunications;
begin
vMudComp := tcomScriptWaveCommunicator.create;
vMudcomp.setup;
end;

procedure TfrmScriptWaveTranscriptionAdmin.EndCommunications;
begin
vMudcomp.shutdown;
vMudComp.free;
vMudComp:= nil;
end;

procedure TfrmScriptWaveTranscriptionAdmin.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
If tblProblems.State <> dsbrowse then
  tblProblems.post;
vstlAccounts.free;
vstlEntityList.free;
EndCommunications;
end;

procedure TfrmScriptWaveTranscriptionAdmin.RefreshAccountList;
var vintLoop: integer;
begin
vbolLoad:= true;
edtName.text := '';
edtLogin.text := '';
edtPassword.text := '';
lstAccounts.Items.clear;

for vintLoop := 0 to vstlAccounts.count - 1 do
  begin
  lstAccounts.Items.add(GetAcctVal(0,vstlAccounts[vintLoop]) + ' ' +
                        GetAcctVal(3,vstlAccounts[vintLoop]));
  cboAccount.Items.add(GetAcctVal(0,vstlAccounts[vintLoop]));
  cboAcctList.Items.add(GetAcctVal(0,vstlAccounts[vintLoop]) + ' ' +
                        GetAcctVal(3,vstlAccounts[vintLoop]));
  end;
cboProbAccount.items.text := cboacctlist.Items.Text;
cboCategories.items.loadfromfile(vstrAppBaseFolder + 'ProblemCategories.txt');
vbolLoad:= false;
end;

function TfrmScriptWaveTranscriptionAdmin.GetAcctVal(const cintField: integer;
                                               const cstrLine: string): string;
var vstrWork: string;
begin
vstrWork:= copy(cstrLine,pos('~' + inttostr(cintField) + '~', cstrLine)+3,999);
Result:= copy(vstrWork,1,pos('~',vstrWork)-1);
end;

procedure TfrmScriptWaveTranscriptionAdmin.SaveAcctVal(const cintField: integer;
                                                   const cstrValue: string;
                                                   const cintLine: integer);
var vstrWork, vstrWork2: string;
begin
vstrWork2:= vstlAccounts[cintLine];
vstrWork:= copy(vstrWork2,1, pos('~' + inttostr(cintField)+'~', vstrWork2) + 2)
           + cstrValue + copy(vstrWork2,pos('~' + inttostr(cintField+1) + '~',
             vstrWork2),999);
vstlAccounts[cintLine]:= vstrWork;
end;

procedure TfrmScriptWaveTranscriptionAdmin.lstAccountsClick(Sender: TObject);
begin
vbolLoad:= true;
edtName.text := GetAcctVal(3,vstlAccounts[lstAccounts.ItemIndex]);
edtLogin.text := GetAcctVal(1,vstlAccounts[lstAccounts.ItemIndex]);
edtPassword.text := GetAcctVal(2,vstlAccounts[lstAccounts.ItemIndex]);
vstrAcctFolder:= GetAcctVal(0,vstlAccounts[lstAccounts.ItemIndex]);

If fileexists (vstrAppBaseFolder + vstrAcctFolder + '\' + vstrAcctFolder + '_entity') then
  begin
  vstlEntityList.LoadfromFile
                     (vstrAppBaseFolder + vstrAcctFolder + '\' + vstrAcctFolder + '_entity');
  LoadPhysicians;
  LoadAdmins;
  LoadTypists;
  end
else
 begin
 grdPhysician.rowcount:= 1;
 grdPhysician.cells[0,0]:='';
 grdPhysician.cells[1,0]:='';
 grdAdmin.rowcount:= 1;
 grdAdmin.cells[0,0]:='';
 grdAdmin.cells[1,0]:='';
 grdAdmin.cells[2,0]:='';
 grdTypist.rowcount:= 1;
 grdTypist.cells[0,0]:='';
 grdTypist.cells[1,0]:='';
 end;
vbolLoad:= false;
end;

procedure TfrmScriptWaveTranscriptionAdmin.LoadPhysicians;
var vintLoop: integer;
begin
grdPhysician.RowCount := 1;
for vintLoop := 0 to vstlEntityList.Count - 1 do
  begin
  If copy(vstlEntityList[vintLoop],1,1) = 'P' then
     begin
     grdPhysician.cells[0,grdPhysician.rowcount - 1] :=
                                             copy(vstlEntityList[vintLoop],1,4);
     grdPhysician.cells[1,grdPhysician.rowcount - 1] :=
                                           copy(vstlEntityList[vintLoop],6,999);
     grdPhysician.RowCount:= grdPhysician.RowCount + 1;
     end;
  end;
If grdPhysician.RowCount > 1 then
   grdPhysician.RowCount:= grdPhysician.RowCount - 1;
end;

procedure TfrmScriptWaveTranscriptionAdmin.LoadAdmins;
var vintLoop: integer;
    vstlO: tstringlist;
    vstrWork: string;
begin
vstlO:= tstringlist.create;
try
grdAdmin.RowCount := 1;
for vintLoop := 0 to vstlEntityList.Count - 1 do
  begin
  If copy(vstlEntityList[vintLoop],1,1) = 'O' then
     begin
     grdAdmin.cells[0,grdAdmin.rowcount - 1] :=
                                             copy(vstlEntityList[vintLoop],1,4);
     grdAdmin.cells[1,grdAdmin.rowcount - 1] :=
                                           copy(vstlEntityList[vintLoop],6,999);

     vstlO.LoadFromFile(vstrAppBaseFolder + vstrAcctFolder + '\' + vstrAcctFolder + '_' +
                                            copy(vstlEntityList[vintLoop],1,4));
     vstrWork:= UnCryptorString(vstlO[0]);
     grdAdmin.cells[2,grdAdmin.rowcount - 1] := copy(vstrWork,171,999);
     grdAdmin.RowCount:= grdAdmin.RowCount + 1;
     end;
  end;
If grdAdmin.RowCount > 1 then
   grdAdmin.RowCount:= grdAdmin.RowCount - 1;
  finally
  vstlO.free;
  end;
end;

procedure TfrmScriptWaveTranscriptionAdmin.LoadTypists;
var vintLoop: integer;
begin
grdTypist.RowCount := 1;
for vintLoop := 0 to vstlEntityList.Count - 1 do
  begin
  If copy(vstlEntityList[vintLoop],1,1) = 'T' then
     begin
     grdTypist.cells[0,grdTypist.rowcount - 1] :=
                                             copy(vstlEntityList[vintLoop],1,4);
     grdTypist.cells[1,grdTypist.rowcount - 1] :=
                                           copy(vstlEntityList[vintLoop],6,999);
     grdTypist.RowCount:= grdTypist.RowCount + 1;
     end;
  end;
If grdTypist.RowCount > 1 then
   grdTypist.RowCount:= grdTypist.RowCount - 1;
end;

procedure TfrmScriptWaveTranscriptionAdmin.btnAddPhysicianClick(
  Sender: TObject);
  var vintHold: integer;
begin
If grdPhysician.Cells[1,0] > '  A' then
   begin
   grdPhysician.RowCount := grdPhysician.RowCount + 1;
   vintHold:=
            strtoint(copy(grdPhysician.Cells[0,grdPhysician.RowCount-2],2,3))+1;
   grdPhysician.Cells[0,grdPhysician.RowCount-1]:=
                                             'P' + format('%.3d', [vintHold]);
   end
else
   grdPhysician.Cells[0,0]:= 'P001';
end;

procedure TfrmScriptWaveTranscriptionAdmin.btnAddAdminClick(Sender: TObject);
  var vintHold: integer;
begin
If grdAdmin.Cells[1,0] > '  A' then
   begin
   grdAdmin.RowCount := grdAdmin.RowCount + 1;
   vintHold:=
            strtoint(copy(grdAdmin.Cells[0,grdAdmin.RowCount-2],2,3))+1;
   grdAdmin.Cells[0,grdAdmin.RowCount-1]:= 'O' + format('%.3d', [vintHold]);
   end
else
   grdAdmin.Cells[0,0]:= 'O001';
end;

procedure TfrmScriptWaveTranscriptionAdmin.cmdAddClick(Sender: TObject);
  var vintHold: integer;
begin
If grdTypist.Cells[1,0] > '  A' then
   begin
   grdTypist.RowCount := grdTypist.RowCount + 1;
   vintHold:=
            strtoint(copy(grdTypist.Cells[0,grdTypist.RowCount-2],2,3))+1;
   grdTypist.Cells[0,grdTypist.RowCount-1]:= 'T' + format('%.3d', [vintHold]);
   end
else
   grdTypist.Cells[0,0]:= 'T001';
end;

procedure TfrmScriptWaveTranscriptionAdmin.SaveAccountFile(const cstrType: string);
var vstrString: string;
    vstlFile: tstringlist;
begin
vstlFile:= tstringlist.create;
try
vstrString:= format('%-30s',['www.mudsox.com']);
vstrString:= vstrString + format('%-20s',[edtLogin.text]);
vstrString:= vstrString + format('%-20s',[edtPassword.text]);
vstrString:= vstrString + format('%-40s',[edtName.text]);
vstrString:= vstrString + format('%-10s',[vstrAcctFolder]);
If (copy(cstrType,1,1) = 'P') then
  begin
  vstrString:= vstrString +
                       format('%-40s',[grdPhysician.cells[1,grdPhysician.row]]);
  vstrString:= vstrString + format('%-10s',[cstrType]);
  end
else
If (copy(cstrType,1,1) = 'T') then
  begin
  vstrString:= vstrString +
                       format('%-40s',[grdTypist.cells[1,grdTypist.row]]);
  vstrString:= vstrString + format('%-10s',[cstrType]);
  end
else
If (copy(cstrType,1,1) = 'O') then
  begin
  vstrString:= vstrString +
                       format('%-40s',[grdAdmin.cells[1,grdAdmin.row]]);
  vstrString:= vstrString + format('%-10s',[cstrType]);
  vstrString:= vstrString + format('%-40s',[grdAdmin.cells[2,grdAdmin.row]]);
  end;
{----------}
vstlFile.add(cryptorstring(vstrString));
vstlFile.Savetofile
               (vstrAppBaseFolder + vstrAcctFolder + '\' + vstrAcctFolder + '_' + cstrType);
finally
  vstlFile.free;
  end;
vbolNoUp:= true;
try
RefreshEntity;
finally
  vbolNoUp:= false;
  end;
end;

procedure TfrmScriptWaveTranscriptionAdmin.btnSavePhysicianClick(
  Sender: TObject);
begin
SaveAccountFile(grdPhysician.cells[0,grdPhysician.Row]);
end;

procedure TfrmScriptWaveTranscriptionAdmin.cmdSaveTypistClick(Sender: TObject);
begin
SaveAccountFile(grdTypist.cells[0,grdTypist.Row]);
end;

procedure TfrmScriptWaveTranscriptionAdmin.btnSaveAdminClick(Sender: TObject);
begin
SaveAccountFile(grdAdmin.cells[0,grdAdmin.Row]);
end;

procedure TfrmScriptWaveTranscriptionAdmin.btnPhysicianUploadClick(
  Sender: TObject);
begin
vstrTranscriptionistID :=  copy(lstAccounts.items[lstAccounts.ItemIndex],1,4);
pmScriptWaveFTP_II.vstrFTPBase:= cstrFTPSystem + vstrTranscriptionistID + '/';
try
If vMudComp.SendFile
   (vstrAppBaseFolder + vstrAcctFolder + '\' + vstrAcctFolder +
    '_' + grdPhysician.cells[0,grdPhysician.Row],'Activation') then
    begin
    memUploading.Lines.add('File sent successfully: '
                                      + grdPhysician.cells[0,grdPhysician.Row]);
    If not vbolAllAccount then
      RefreshEntity;
    exit;
    end;
Showmessage('Physician File not sent');
finally
  vMudComp.shutdownFTP;
  end;
end;

procedure TfrmScriptWaveTranscriptionAdmin.btnAdminUploadClick(
  Sender: TObject);
begin
vstrTranscriptionistID :=  copy(lstAccounts.items[lstAccounts.ItemIndex],1,4);
pmScriptWaveFTP_II.vstrFTPBase:= cstrFTPSystem + vstrTranscriptionistID + '/';
try
If vMudComp.SendFile
   (vstrAppBaseFolder + vstrAcctFolder + '\' + vstrAcctFolder +
    '_' + grdAdmin.cells[0,grdAdmin.Row],'Activation') then
    begin
    memUploading.Lines.add('File sent successfully: '
                                              + grdAdmin.cells[0,grdAdmin.Row]);
    If not vbolAllAccount then
      RefreshEntity;
    exit;
    end;
Showmessage('Admin File not sent');
finally
  vMudComp.shutdownFTP;
  end;
end;

procedure TfrmScriptWaveTranscriptionAdmin.btnTypistUploadClick(
  Sender: TObject);
begin
vstrTranscriptionistID :=  copy(lstAccounts.items[lstAccounts.ItemIndex],1,4);
pmScriptWaveFTP_II.vstrFTPBase:= cstrFTPSystem + vstrTranscriptionistID + '/';
try
If vMudComp.SendFile
   (vstrAppBaseFolder + vstrAcctFolder + '\' + vstrAcctFolder +
    '_' + grdTypist.cells[0,grdTypist.Row],'Activation') then
    begin
    memUploading.Lines.add('File sent successfully: '
                                            + grdTypist.cells[0,grdTypist.Row]);
    If not vbolAllAccount then
      RefreshEntity;
    exit;
    end;
Showmessage('Typist File not sent');
finally
  vMudComp.shutdownFTP;
  end;
end;

procedure TfrmScriptWaveTranscriptionAdmin.btnMovetoServerClick(
  Sender: TObject);
var vintLoop: integer;
begin
memUploading.Lines.clear;
vbolAllAccount:= true;
try
for vintLoop:= 0 to grdPhysician.RowCount - 1 do
  begin
  grdPhysician.row:= vintLoop;
  btnPhysicianUploadClick(self);
  end;
If grdAdmin.cells[0,0] > ' A' then
  for vintLoop:= 0 to grdAdmin.RowCount - 1 do
    begin
    grdAdmin.row:= vintLoop;
    btnAdminUploadClick(self);
    end;
for vintLoop:= 0 to grdTypist.RowCount - 1 do
  begin
  grdTypist.row:= vintLoop;
  btnTypistUploadClick(self);
  end;
finally
  vbolAllAccount:= false;
  end;
RefreshEntity;

vMudComp.shutdownFTP;
end;

procedure TfrmScriptWaveTranscriptionAdmin.btnCreateAccountFoldersClick(
  Sender: TObject);
begin
vstrTranscriptionistID :=  copy(lstAccounts.items[lstAccounts.ItemIndex],1,4);
pmScriptWaveFTP_II.vstrFTPBase:= cstrFTPSystem + vstrTranscriptionistID + '/';

If vMudcomp.DirectoryCreateFTP('') then
  If vMudcomp.DirectoryCreateFTP('Command') then
    If vMudcomp.DirectoryCreateFTP('FTP') then
      If vMudcomp.DirectoryCreateFTP('Messages') then
        If vMudcomp.DirectoryCreateFTP('Entity') then
          begin
          Showmessage('All folders created');
          exit;
          end;
Showmessage('Problem: Could not create folders');
end;

procedure TfrmScriptWaveTranscriptionAdmin.RefreshEntity;
var vstlEntityFile: tstringlist;
    vintLoop: integer;
begin
vstlEntityFile:= tstringlist.create;
try
for vintLoop:= 0 to grdPhysician.rowcount - 1 do
  vstlEntityFile.add(grdPhysician.cells[0,vintLoop] + ' ' +
                     grdPhysician.cells[1,vintLoop]);
for vintLoop:= 0 to grdAdmin.rowcount - 1 do
  If grdAdmin.cells[0,vintLoop] > '    A' then
  vstlEntityFile.add(grdAdmin.cells[0,vintLoop] + ' ' +
                     grdAdmin.cells[1,vintLoop]);
for vintLoop:= 0 to grdTypist.rowcount - 1 do
  vstlEntityFile.add(grdTypist.cells[0,vintLoop] + ' ' +
                     grdTypist.cells[1,vintLoop]);

vstlEntityFile.SavetoFile
        (vstrAppBaseFolder + vstrAcctFolder + '\' + vstrAcctFolder + '_entity');

copyfile(pchar(vstrAppBaseFolder + vstrAcctFolder + '\' + vstrAcctFolder +
    '_entity'),
    pchar(vstrAppBaseFolder + vstrAcctFolder + '\ScriptWaveEntity.txt'), false);

If vbolNoUp then exit;
If vMudComp.SendFile
   (vstrAppBaseFolder + vstrAcctFolder + '\ScriptWaveEntity.txt', 'Entity') then
    memUploading.Lines.add('Entity file sent successfully to Entity Folder')
else
  Showmessage('Entity File not sent');

If vMudComp.SendFile
   (vstrAppBaseFolder + vstrAcctFolder + '\' + vstrAcctFolder + '_entity', 'Activation') then
    memUploading.Lines.add('Entity file sent successfully to Activation Folder')
else
  Showmessage('Entity II File not sent');

finally
  vstlEntityFile.free;
  end;

end;

procedure TfrmScriptWaveTranscriptionAdmin.btnNewAccountClick(Sender: TObject);
var vstrWork: string;
    vintWork: integer;
begin
 vintWork := strtoint(copy(lstAccounts.items[lstAccounts.items.count - 1],2,3));
 inc(vintWork);
 vstrWork:= 'A' + format('%-.3d',[vintWork]);
 vstlAccounts.add('~0~' + vstrWork + '~1~~2~~3~~4~');
 forcedirectories(vstrAppBaseFolder + vstrWork);
 lstAccounts.items.add(vstrWork);
 lstAccounts.ItemIndex:= lstAccounts.Items.count - 1;
 lstAccountsClick(self);
end;

procedure TfrmScriptWaveTranscriptionAdmin.btnSaveAccountClick(
  Sender: TObject);
begin
vstlAccounts.savetofile(vstrAppBaseFolder + 'Accounts.txt');
end;

procedure TfrmScriptWaveTranscriptionAdmin.edtNameChange(Sender: TObject);
begin
If vbolLoad then exit;
SaveAcctVal(3,edtName.text,lstAccounts.itemindex);
lstAccounts.items[lstAccounts.itemindex]:=
   copy(lstAccounts.items[lstAccounts.itemindex],1,5) + ' ' + edtName.text;
end;

procedure TfrmScriptWaveTranscriptionAdmin.edtLoginChange(Sender: TObject);
begin
If vbolLoad then exit;
SaveAcctVal(1,edtLogin.text,lstAccounts.itemindex);
end;

procedure TfrmScriptWaveTranscriptionAdmin.edtPasswordChange(Sender: TObject);
begin
If vbolLoad then exit;
SaveAcctVal(2,edtPassword.text,lstAccounts.itemindex);
end;
{---------------------------  PURGE SECTION  --------------------------------}
procedure TfrmScriptWaveTranscriptionAdmin.cmdPurgeClick(Sender: TObject);
var vstlWork: tstringlist;
    vintLoop, vintLoop2, vintPurgeDate: integer;
    vstrWork, vstrWorkDate: string;
begin
memProgress.lines.Clear;
memProgress.lines.add('Start Purge: ' + datetimetostr(date));
vstlWork := tstringlist.create;
try
vstrTranscriptionistID := cboAccount.items[cboAccount.itemindex];
pmScriptWaveFTP_II.vstrFTPBase:= cstrFTPSystem + vstrTranscriptionistID + '/';
If vMudcomp.DirectoryListFTP('') then
   begin
   vintPurgeDate:= round(date - 7);
   memProgress.lines.add('Finding qualifying control files');
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
            vMudcomp.DeleteFTPFile(vstrWork, '');
            memo1.lines.add('Delete: ' + vstrWork);
            end;
     end;
   {Purge large dictation files as soon as they are "Typed"}
   memProgress.lines.add('Finding typed dictation files');
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
            vMudcomp.DeleteFTPFile(vstrWork, '');
            memo1.lines.add('Delete: ' + vstrWork);
            end;
     end;
   end;
   {Purge all received Messages}
If vMudcomp.DirectoryListFTP('Messages') then
   begin
   memProgress.lines.add('Finding qualifying Messages files');
   {Select files to be purged}
   for vintLoop := 0 to vstlDir.count - 1 do
     begin
     vstrWork:= copy(vstlDir[vintLoop], cintFTPDirOffset,999);
     If copy(vstrWork,1,8) = 'Received' then
        begin
        vMudcomp.DeleteFTPFile(vstrWork, 'Messages');
        memo1.lines.add('Deleted: ' + vstrWork);
        end;
     end;
   end;
   {Purge all received FTP}
If vMudcomp.DirectoryListFTP('FTP') then
   begin
   memProgress.lines.add('Finding qualifying FTP files');
   {Select files to be purged}
   for vintLoop := 0 to vstlDir.count - 1 do
     begin
     vstrWork:= copy(vstlDir[vintLoop], cintFTPDirOffset,999);
     If copy(vstrWork,1,8) = 'Received' then
        begin
        vMudcomp.DeleteFTPFile(vstrWork, 'FTP');
        memo1.lines.add('Delete: ' + vstrWork);
        end;
     end;
   end;
finally
  vstlWork.free;
  end;
end;

{-------------- Test Encrypt/Decrypt --------------------------}
procedure TfrmScriptWaveTranscriptionAdmin.cmdLoadClick(Sender: TObject);
var vstl: tstringlist;
begin

vstl:= tstringlist.create;
try
vstl.Loadfromfile(vstrAppBaseFolder + edtFile.text);
edtContent.text := UnCryptorString(vstl[0]);

finally
  vstl.free;
  end;
end;

procedure TfrmScriptWaveTranscriptionAdmin.btnSaveClick(Sender: TObject);
var vstl: tstringlist;
begin

vstl:= tstringlist.create;
try
vstl.text:= CryptorString(edtContent.text);
vstl.savetofile(vstrAppBaseFolder + edtFile.text);
finally
  vstl.free;
  end;
end;

procedure TfrmScriptWaveTranscriptionAdmin.Button1Click(Sender: TObject);
begin
oldUnCryptorFile
      (copy(edtFile.text,1,length(edtFile.text)-4),
       edtFile.text);
end;

procedure TfrmScriptWaveTranscriptionAdmin.Button2Click(Sender: TObject);
begin
vstrTranscriptionistID := edit3.text;
CryptorFile(edit1.text, edit2.text);
end;

procedure TfrmScriptWaveTranscriptionAdmin.Button3Click(Sender: TObject);
begin
vstrTranscriptionistID := edit3.text;
UnCryptorFile(edit1.text, edit2.text);
end;

procedure TfrmScriptWaveTranscriptionAdmin.LoadAndScanFilesINI;
var
     vintLoop, vintIndex: integer;
     vstrCategory, vstrWork: string;
     vstlTemp, vstlTemp2: tstringlist;
begin
  edtDictationName.text := '';
  edtImportDate.text :=  '';
  edtTransmitDate.text :=  '';
  edtReceiveDate.text :=  '';;
  edtAssignDate.text :=  '';
  edtTypedDate.text :=  '';
  edtReviewDate.text :=  '';
  edtCompleteDate.text :=  '';
  memFileComments.text:=  '';
  edtAltName.text:=  '';
  grdTranscribedfiles.rowcount := 2;
  grdTranscribedfiles.cells[0,1] := '';
  grdTranscribedFiles.cells[0,0] := 'Transcribed files';

  cboTypists.ItemIndex:= -1;

  vMudcomp.vstlSearchIni.loadfromfile(vstrAppBaseFolder
                                                 + 'ScriptWaveFileControl.ini');
  vstlTemp:= tstringlist.create;
  vstlTemp2:= tstringlist.create;
  try
  vstlTemp2.text := 'Imported' + #13#10 + 'Transmitted' + #13#10 + 'Received' +
                    #13#10 + 'Assigned' + #13#10 + 'Typed' + #13#10 +
                    'Reviewed' + #13#10 + 'Completed';
  vstlTemp.SaveToFile(vstrAppBaseFolder + 'b.txt');
  treAll.loadfromfile(vstrAppBaseFolder + 'b.txt');
  deletefile(vstrAppBaseFolder + 'b.txt');

  for vintLoop := vMudcomp.vstlSearchIni.count -  1 downto 0 do
     begin
     vstrWork:= vMudcomp.vstlSearchIni[vintLoop];
     If (copy(vstrWork,1,2) = '[P' ) or
        (copy(vstrWork,1,2) = '[O' ) then
        begin
        vstlTemp.add(vstrCategory + copy(vstrWork,2,length(vstrWork)-2));
        vstrCategory:= '';
        end;
     If length(vstrCategory) = 0 then
        begin
        If copy(vstrWork,1,12) = 'ImportDate=2' then
           vstrCategory := '1'
        else
        If copy(vstrWork,1,14) = 'TransmitDate=2' then
           vstrCategory := '2'
        else
        If copy(vstrWork,1,13) = 'ReceiveDate=2' then
           vstrCategory := '3'
        else
        If copy(vstrWork,1,12) = 'AssignDate=2' then
           vstrCategory := '4'
        else
        If copy(vstrWork,1,11) = 'TypedDate=2' then
           vstrCategory := '5'
        else
        If copy(vstrWork,1,14) = 'ReviewedDate=2' then
           vstrCategory := '6'
        else
        If copy(vstrWork,1,14) = 'CompleteDate=2' then
           vstrCategory := '7';
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
   finally
     vstlTemp.free;
     vstlTemp2.free;
     end;
end;

procedure TfrmScriptWaveTranscriptionAdmin.cboAcctListChange(
  Sender: TObject);
  var vstrWork: string;
      vintLoop: integer;
      vstlTemp: tstringlist;
begin
vMudcomp.iniFileControl.free;
deletefile(vstrAppBaseFolder + 'ScriptwaveFileControl.ini');
vMudcomp.iniFileControl:=
            tmeminifile.create(vstrAppBaseFolder + 'ScriptWaveFileControl.ini');
pnlWait.visible:= true;
application.processmessages;
try
vstrWork:= copy(cboAcctList.text,1,4);
vstrTranscriptionistID:= vstrWork;
pmScriptWaveFTP_II.vstrFTPBase := cstrFTPSystem + vstrTranscriptionistID + '/' ;
if vMudcomp.DirectoryListFTP('') then
    GetStatusAndDownloadFiles;
LoadAndScanFilesIni;
finally
  pnlWait.visible:= false;
  end;
lstCtrls.items.clear;
vstlTemp:= tstringlist.create;
for vintLoop:= 0 to vstlDir.count - 1 do
   If copy(vstlDir[vintLoop],cintFTPDirOffset,2) = 'C_' then
      vstlTemp.add(copy(vstlDir[vintLoop],cintFTPDirOffset,999));
vstlTemp.sorted:=true;
lstCtrls.items.text := vstlTemp.text;
vstlTemp.free;

vstlDir.Sorted := false;

vstrWork := copy(cboAcctList.items[cboAcctList.itemindex],1,4);
cboTypists.items.loadfromfile(vstrAppBaseFolder + vstrWork + '\ScriptWaveEntity.txt');
for vintLoop := 0 to cboTypists.items.count - 1 do
   cboTypists.items[vintLoop] := trim(cboTypists.items[vintLoop]);

end;

procedure TfrmScriptWaveTranscriptionAdmin.GetStatusAndDownloadFiles;
       var vintLoop: integer;
           vstrWork: string;
       begin
       for vintLoop:= 0 to vstlDir.count - 1 do
          begin
          vstrWork:= copy(vstlDir[vintLoop], cintFTPDirOffset,999);
          vstrWork:= copy(vstrWork,1,length(vstrWork)-4);
          If copy(vstlDir[vintLoop], cintFTPDirOffset,2) = 'C_' then
                vMudcomp.UpdateFileStatus
                 (copy(vstlDir[vintLoop], cintFTPDirOffset+2,999));
          end;
       end;

procedure TfrmScriptWaveTranscriptionAdmin.treAllClick(Sender: TObject);
var vintLoop: integer;
   Function Dateslasher(const cstrDate: string): string;
     begin
     Result:=
       copy(cstrDate,5,2) + '/' + copy(cstrDate,7,2) + '/' + copy(cstrDate,1,4);
     end;
   Procedure FindTypist;
     var vintLoop: integer;
     begin
     for vintLoop:= 0 to cboTypists.Items.Count - 1 do
        If vMudcomp.vstrFileAssignedTo =
                                       copy(cboTypists.Items[vintLoop],1,4) then
            begin
            cboTypists.ItemIndex := vintLoop;
            break;
            end;
     end;
begin
cboTypists.itemindex := -1;
If treAll.Selected.Level = 1 then
   begin
   vMudcomp.vstrCurrentFile:= treAll.Selected.text;
   vMudcomp.InifilesLoadDetail;
   edtDictationName.text := vMudcomp.vstrCurrentFile;
   edtImportDate.text:= '';
   If vMudcomp.vstrFileImport <> '00000000' then
     edtImportDate.text := Dateslasher(vMudcomp.vstrFileImport) + ' ' +
                         vMudcomp.vstrFileImportT;
   edtTransmitDate.text:= '';
   If vMudcomp.vstrFileTransmit <> '00000000' then
     edtTransmitDate.text := Dateslasher(vMudcomp.vstrFileTransmit)
                                    + ' ' + vMudcomp.vstrFileTransmitT;
   edtReceiveDate.text:= '';
   If vMudcomp.vstrFileReceived <> '00000000' then
     edtReceiveDate.text := Dateslasher(vMudcomp.vstrFileReceived)
                                    + ' ' + vMudcomp.vstrFileReceivedT;
   edtAssignDate.text:= '';
   If vMudcomp.vstrFileAssigned <> '00000000' then
     edtAssignDate.text := Dateslasher(vMudcomp.vstrFileAssigned)
                                    + ' ' + vMudcomp.vstrFileAssignedT;
   edtTypedDate.text:= '';
   If vMudcomp.vstrFileTyped <> '00000000' then
     edtTypedDate.text := Dateslasher(vMudcomp.vstrFileTyped) + ' ' +
                         vMudcomp.vstrFileTypedT;
   edtReviewDate.text:= '';
   If vMudcomp.vstrFileReviewed <> '00000000' then
     edtReviewDate.text := Dateslasher(vMudcomp.vstrFileReviewed)
                                    + ' ' + vMudcomp.vstrFileReviewedT;
   edtCompleteDate.text:= '';
   If vMudcomp.vstrFileComplete <> '00000000' then
     edtCompleteDate.text := Dateslasher(vMudcomp.vstrFileComplete)
                                    + ' ' + vMudcomp.vstrFileCompleteT;
   memFileComments.text:= MemoHash(vMudcomp.vstrFileComments);
   If length(vMudcomp.vstrFileAssignedTo) > 0 then
      FindTypist;
   grdTranscribedfiles.rowcount := 2;
   grdTranscribedfiles.cells[0,1] := '';
   grdTranscribedFiles.cells[0,0] := 'Transcribed files';
   edtAltName.readonly := true;
   for vintLoop := 1 to 50 do
     If vMudcomp.varrAttachedFiles[1, vintLoop] > '  A' then
        begin
        grdTranscribedFiles.cells[0,grdTranscribedFiles.rowcount-1] :=
                               vMudcomp.varrAttachedFiles[1, vintLoop];
        grdTranscribedFiles.rowcount:= grdTranscribedFiles.RowCount + 1;
        end;
   if grdTranscribedFiles.rowcount > 2 then
      grdTranscribedFiles.RowCount := grdTranscribedFiles.rowcount - 1;
   if grdTranscribedFiles.rowcount > 1 then
      begin
      edtAltName.text:= vMudcomp.varrAttachedFiles[2, 1];
      end;
   end;
   for vintLoop := 0 to lstCtrls.items.count - 1 do
      If pos(vMudcomp.vstrCurrentFile, lstCtrls.items[vintLoop]) > 0 then
        begin
        lstctrls.itemindex := vintLoop;
        lstctrlsclick(self);
        break;
        end;
end;

function TfrmScriptWaveTranscriptionAdmin.MemoHash(const cstrMemo: string): string;
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


procedure TfrmScriptWaveTranscriptionAdmin.lstCtrlsClick(Sender: TObject);
var vstrWork: string;
begin
edtControl.text := lstCtrls.Items[lstCtrls.Itemindex];
vstrWork := copy(edtControl.text, pos('.',edtControl.text)+5,999);
edtAssignto.text:= copy(vstrWork,1,4);
edtImport.text:= copy(vstrWork,6,8);
edtTransmit.text:= copy(vstrWork,15,8);
edtReceive.text:= copy(vstrWork,24,8);
edtAssign.text:= copy(vstrWork,33,8);
edtType.text:= copy(vstrWork,42,8);
edtReview.text:= copy(vstrWork,51,8);
edtComplete.text:= copy(vstrWork,60,8);
end;

procedure TfrmScriptWaveTranscriptionAdmin.btnRenameClick(Sender: TObject);
var vstrNewName: string;
begin
If length(edtAssignto.text) <> 4 then
   begin
   showmessage('Assign to must be 4 positions');
   exit;
   end;

If (length(edtimport.text) <> 8) or
   (length(edttransmit.text) <> 8) or
   (length(edtreceive.text) <> 8) or
   (length(edtassign.text) <> 8) or
   (length(edttype.text) <> 8) or
   (length(edtreview.text) <> 8) or
   (length(edtcomplete.text) <> 8) then
   begin
   showmessage('Dates must be 8 positions');
   exit;
   end;

If (edtimport.text = '00000000') or
   (edttransmit.text = '00000000') then
   begin
   showmessage('Import and Transmit must be dates');
   exit;
   end;

If ((edtreceive.text = '00000000') and
   (edtassign.text <> '00000000')) or
   ((edtassign.text = '00000000') and
   (edttype.text <> '00000000')) or
   ((edttype.text = '00000000') and
   (edtreview.text <> '00000000')) or
   ((edtreview.text = '00000000') and
   (edtcomplete.text <> '00000000')) then
   begin
   showmessage('00000000 cannot appear before a real date');
   exit;
   end;

If (edtimport.text <> '00000000') then
   try
   strtodate(copy(edtImport.text,5,2) + '/' + copy(edtImport.text,7,2) + '/' +
             copy(edtImport.text,1,4));
   except
   showmessage('Import date must be valid');
   exit;
   end;
If (edttransmit.text <> '00000000') then
   try
   strtodate(copy(edttransmit.text,5,2) + '/' + copy(edttransmit.text,7,2) + '/' +
             copy(edttransmit.text,1,4));
   except
   showmessage('Transmit date must be valid');
   exit;
   end;
If (edtreceive.text <> '00000000') then
   try
   strtodate(copy(edtreceive.text,5,2) + '/' + copy(edtreceive.text,7,2) + '/' +
             copy(edtreceive.text,1,4));
   except
   showmessage('Receive date must be valid');
   exit;
   end;
If (edtassign.text <> '00000000') then
   try
   strtodate(copy(edtassign.text,5,2) + '/' + copy(edtassign.text,7,2) + '/' +
             copy(edtassign.text,1,4));
   except
   showmessage('Assign date must be valid');
   exit;
   end;
If (edttype.text <> '00000000') then
   try
   strtodate(copy(edttype.text,5,2) + '/' + copy(edttype.text,7,2) + '/' +
             copy(edttype.text,1,4));
   except
   showmessage('Type date must be valid');
   exit;
   end;
If (edtreview.text <> '00000000') then
   try
   strtodate(copy(edtreview.text,5,2) + '/' + copy(edtreview.text,7,2) + '/' +
             copy(edtreview.text,1,4));
   except
   showmessage('Review date must be valid');
   exit;
   end;
If (edtcomplete.text <> '00000000') then
   try
   strtodate(copy(edtcomplete.text,5,2) + '/' + copy(edtcomplete.text,7,2) + '/' +
             copy(edtcomplete.text,1,4));
   except
   showmessage('Complete date must be valid');
   exit;
   end;

vstrNewName:= copy(edtControl.text, 1, pos('.',edtControl.text)+4) +
       edtAssignto.text + '_' + edtimport.text + '_' + edttransmit.text + '_' +
       edtreceive.text + '_' + edtassign.text + '_' + edttype.text + '_' +
       edtReview.text + '_' + edtComplete.text + '_cry';

vMudcomp.RenameFile(edtControl.text, vstrNewName, '');
cboAcctListChange(self);

edtControl.text := 'Control file has been renamed.  Check the Account Status tab to see result';
end;

procedure TfrmScriptWaveTranscriptionAdmin.cmdNewProblemClick(
  Sender: TObject);
  var vintHold: integer;
begin
tblProblems.Last;
vintHold:= tblProblems['ProblemNumber'];
tblProblems.insert;
tblProblems.FieldByName('ProblemNumber').asinteger := vintHold + 1;
tblProblems.FieldByName('ProblemDate').asdatetime := date;
tblProblems.Post;
cboProbAccount.ItemIndex := cboAcctList.itemindex;
cboProbAccount.refresh;
end;

procedure TfrmScriptWaveTranscriptionAdmin.cmdDeleteProblemClick(
  Sender: TObject);
begin
tblProblems.Delete;
end;

procedure TfrmScriptWaveTranscriptionAdmin.btnAttachClick(Sender: TObject);
begin
If tblProblems.state = dsBrowse then
   tblProblems.edit;
tblProblems.FieldByName('RelatedFile').asstring := vMudcomp.vstrCurrentFile;
tblProblems.post;
end;

procedure TfrmScriptWaveTranscriptionAdmin.cboProbAccountChange(
  Sender: TObject);
  var vstrWork: string;
      vintLoop: integer;
begin
try
vstrWork := copy(cboProbAccount.items[cboProbAccount.itemindex],1,4);
cboUser.items.loadfromfile(vstrAppBaseFolder + vstrWork + '\ScriptWaveEntity.txt');
for vintLoop := 0 to cboUser.items.count - 1 do
   cboUser.items[vintLoop] := trim(cboUser.items[vintLoop]);
tblProblems.refresh;
tblProblems.edit;
except
  cboUser.items.clear;
  end;
end;

procedure TfrmScriptWaveTranscriptionAdmin.btnMoreInfoClick(Sender: TObject);
var vstrWork: string;
begin
{Download, apply to control file, refresh}
vMudcomp.Receive_Uncrypt(lstctrls.items[lstctrls.itemindex],4000,'');
vstrWork:= copy(lstctrls.items[lstctrls.itemindex],1,
                                  length(lstctrls.items[lstctrls.itemindex])-4);
FindCommandDownloads(vstrWork);
deletefile(vstrWork);
treAllClick(self);
end;

procedure TfrmScriptWaveTranscriptionAdmin.grdRecentCellClick(
  Column: TColumn);
begin
try
cboProbAccountChange(self);
except
end;
end;

procedure TfrmScriptWaveTranscriptionAdmin.cboUserChange(Sender: TObject);
begin
try
tblProblems.refresh;
tblProblems.edit;
except end;
end;

procedure TfrmScriptWaveTranscriptionAdmin.cboCategoriesChange(
  Sender: TObject);
begin
try
tblProblems.refresh;
tblProblems.edit;
except end;
end;

Procedure TfrmScriptWaveTranscriptionAdmin.FindCommandDownloads
                                                   (const cstrCntlFile: string);
  var vintLoop2, vintDot: integer;
            vstrHoldFile, vstrHoldAltFile: string;
            vstlTmp: tstringlist;
  begin
  vstlTmp:= tstringlist.create;
  try
  vstlTmp.loadfromfile(cstrCntlFile);
  vintDot:= pos('.',cstrCntlFile);
  vMudcomp.vstrCurrentFile:= copy(cstrCntlFile,3,vintDot + 1);
  If vstlTmp.count > 0 then
     for vintLoop2:= 1 to vstlTmp.count - 1 do
         If length(vstlTmp[vintLoop2]) = 0 then
             Break
         else
         if vstlTmp[vintLoop2] = '<COMMENTS>' then
             begin
             If (vintLoop2 + 1 < vstlTmp.count) then
                If vstlTmp[vintLoop2 + 1] > '  A' then
                   vMudComp.InifilesWriteOne
                                     ('Comments', vstlTmp[vintLoop2 + 1]);
             Break;
             end
         else
             begin
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
             vMudComp.InifilesWriteOne(copy(vstrHoldFile,
                                pos('.',vstrHoldFile)-3,3), vstrHoldFile);
             vMudComp.InifilesWriteOne(copy(vstrHoldFile,
                         pos('.',vstrHoldFile)-3,3)+'A', vstrHoldAltFile);
             end;
  finally
     vstlTmp.free;
     end;
  end;
  procedure TfrmScriptWaveTranscriptionAdmin.grdTranscribedFilesClick(
  Sender: TObject);
begin
edtAltName.text:= vMudcomp.varrAttachedFiles[2, grdTranscribedFiles.Row];

end;


{------------------------------------------------------------------------------}
procedure TfrmScriptWaveTranscriptionAdmin.treMessagesClick(Sender: TObject);
var vstlTemp: tstringlist;
    vintLoop: integer;
    vstrMessageFile: string;
begin
memMessage.lines.text := '';
cmdReplyMessage.enabled:= false;
If treMessages.Selected = nil then exit;
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
    if (copy(treMessages.Selected.Parent.Text,1,4) = 'Sent') then
         begin
         edtMessageTo.text:= copy(vstrMessageFile,11,9);
         edtFromMail.text:= 'Technical Support';
         end
    else
    if (copy(treMessages.Selected.Parent.Text,1,4) = 'Pend') then
         begin
         edtMessageTo.text:= copy(vstrMessageFile,6,9);
         edtFromMail.text:= 'Technical Support';
         end
    else
    if copy(treMessages.Selected.Parent.Text,1,4) = 'Rece' then
         begin
         edtMessageTo.text:= 'Technical Support';
         edtFromMail.text:= copy(vstrMessageFile,1,9);
         cmdReplyMessage.enabled:= true;
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

Procedure TfrmScriptWaveTranscriptionAdmin.SendandReceiveMessages;
var vintLoop: integer;
    vstrFile: string;
begin
{Receiving Messages}
vMudcomp.DirectoryListFTP('Support');
for vintLoop := 0 to vstlDir.count - 1 do
   begin
   vstrFile:=
         copy(vstlDir[vintLoop],cintFTPDirOffset,999);
   if copy(vstrFile,11,4) = 'Tech' then
      begin
      Logit('Receiving Message ' + vstrFile);
      vstrTranscriptionistID:= copy(vstrFile,1,4);
      if vMudcomp.Receive_UnCrypt(vstrMessages + vstrFile, 1000,
                                                                'Support') then
        begin
        vMudcomp.Renamefile(vstrFile,
                           'Received_' + vstrFile,
                           'Support');
        end;
      end;
   end;

{Sending Messages}
lstMessages.update;
for vintLoop := 0 to lstMessages.items.count - 1 do
   begin
   vstrFile := lstMessages.items[vintLoop];
   if (copy(vstrFile,1,4) = 'Tech') and (pos('_cry', vstrFile) = 0) then
      begin
      Logit('Sending Message ' + vstrFile);
      vstrTranscriptionistID := copy(vstrFile,6,4);
      pmScriptWaveFTP_II.vstrFTPBase:=
                                 cstrFTPSystem + vstrTranscriptionistID + '/' ;
      copyfile(pchar(vstrMessages + vstrFile),
            pchar(vstrMessages + copy(vstrFile,1,5) + copy(vstrFile,11,999)),
            false);
      If vMudcomp.Crypt_Transmit(
          vstrMessages+copy(vstrFile,1,5)+copy(vstrFile,11,999),'Messages') then
          Renamefile(vstrMessages + vstrFile,
                     vstrMessages +  'Sent_' + vstrFile);
      deletefile(vstrMessages + copy(vstrFile,1,5) + copy(vstrFile,11,999));
      end
   end;

LoadMessages;
end;

procedure TfrmScriptWaveTranscriptionAdmin.LoadMessages;
var vintLoop: integer;
    vstrWork: string;
    trnFind : TTreeNode;
    vdatTemp: tdatetime;
    vstlSort: tstringlist;
     procedure LocateNodeString(const cstrNode: string);
        begin
        trnFind:=GetNodeByText(treMessages,cstrNode,true);
        trnFind.Selected := true;
        end;
begin
lstMessages.Directory:= vstrAppBaseFolder + 'Messages';
lstMessages.update;
for vintLoop := treMessages.Items.Count - 1 downto 0 do
    if treMessages.Items[vintLoop].Level > 0 then
       treMessages.Items[vintLoop].Delete;

vstlSort:= tstringlist.create();
vstlSort.sorted:=true;
try
{Find Sent, sort...}
for vintLoop:= 0 to lstMessages.Items.Count - 1 do
  if copy(lstMessages.Items[vintLoop],1,5) = 'Sent_' then
     vstlSort.add (copy(lstMessages.Items[vintLoop],21,999));
for vintLoop:= 0 to vstlSort.Count - 1 do
   begin
   vstrWork := vstlSort[vintLoop];
   if pos('_cry',vstrWork) > 0 then
   else
     begin
     vdatTemp:= strtofloat(vstrWork);
     If date > vdatTemp + 30 then
        LocateNodeString('Sent Archive')
     else
        LocateNodeString('Sent');
     treMessages.Items.AddChild(trnFind, datetimetostr(vdatTemp));
     end
   end;
vstlSort.clear;
{Find received}
for vintLoop:= 0 to lstMessages.Items.Count - 1 do
  if (copy(lstMessages.Items[vintLoop],11,4) = 'Tech')
     and (copy(lstMessages.Items[vintLoop],1,5) <> 'Sent_') then
     vstlSort.add (copy(lstMessages.Items[vintLoop],16,999));
for vintLoop:= 0 to vstlSort.Count - 1 do
   begin
   vstrWork := vstlSort[vintLoop];
   if pos('_cry',vstrWork) > 0 then
   else
     begin
     vdatTemp:= strtofloat(vstrWork);
     If date > vdatTemp + 30 then
        LocateNodeString('Received Archive')
     else
        LocateNodeString('Received');
     treMessages.Items.AddChild(trnFind, datetimetostr(vdatTemp));
     end
   end;
vstlSort.clear;
{Find pending}
for vintLoop:= 0 to lstMessages.Items.Count - 1 do
  if copy(lstMessages.Items[vintLoop],1,4) = 'Tech' then
     vstlSort.add (copy(lstMessages.Items[vintLoop],16,999));
for vintLoop:= 0 to vstlSort.Count - 1 do
   begin
   vstrWork := vstlSort[vintLoop];
   if pos('_cry',vstrWork) > 0 then
   else
     begin
     LocateNodeString('Pending transmission');
     vdatTemp:= strtofloat(vstrWork);
     treMessages.Items.AddChild(trnFind, datetimetostr(vdatTemp));
     end
   end;

finally
  vstlSort.free;
  end;
end;

function TfrmScriptWaveTranscriptionAdmin.FindMessageFile
                                           (const cstrDateTime: string): string;
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

function TfrmScriptWaveTranscriptionAdmin.GetNodeByText(ATree : TTreeView;
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

procedure TfrmScriptWaveTranscriptionAdmin.ResetAfterMessage;
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

procedure TfrmScriptWaveTranscriptionAdmin.cmdDeleteMessageClick(
  Sender: TObject);
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
    LoadMessages;
    end;
end;

procedure TfrmScriptWaveTranscriptionAdmin.cmdReplyMessageClick(
  Sender: TObject);
  var vintLoop: integer;
      vstrWork: string;
begin
cmdNewMessage.enabled := false;
cmdReplyMessage.enabled := false;
cmdDeleteMessage.enabled := false;
cmdMailIt.Enabled := true;
cmdCancelMail.enabled := true;
edtMessageTo.text := edtFromMail.text;

vstrWork := copy(edtMessageTo.text,1,4);
cboMessageTo.items.loadfromfile
                       (vstrAppBaseFolder + vstrWork + '\ScriptWaveEntity.txt');
for vintLoop := 0 to cboMessageTo.items.Count - 1 do
   begin
   cboMessageTo.Items[vintLoop]:= vstrWork + '_' + cboMessageTo.Items[vintLoop];
   If copy(cboMessageTo.Items[vintLoop],1,9) = copy(edtMessageTo.text,1,9) then
      cboMessageTo.ItemIndex := vintLoop;
   end;
edtFromMail.text := 'Technical Support';
edtDateTimeMail.text := datetimetostr(now);
edtSubjectMail.readonly := false;
memMessage.readonly := false;
if pos('Re: ', edtSubjectMail.text) = 0 then
  edtSubjectMail.text := 'Re: ' + edtSubjectMail.text;
memMessage.lines.text := #13#10
  + '=================================================='
                                               + #13#10 + memMessage.lines.text;
end;

procedure TfrmScriptWaveTranscriptionAdmin.cmdNewMessageClick(
  Sender: TObject);
  var vintLoop: integer;
      vstrWork: string;
begin
  cmdNewMessage.enabled := false;
  cmdMailIt.Enabled := true;
  cmdCancelMail.enabled := true;
  vstrWork := copy(cboProbAccount.items[cboAcctList.itemindex],1,4);
  cboMessageTo.items.loadfromfile(vstrAppBaseFolder + vstrWork + '\ScriptWaveEntity.txt');
  for vintLoop := 0 to cboMessageTo.items.Count - 1 do
     cboMessageTo.Items[vintLoop]:=
                                  vstrWork + '_' + cboMessageTo.Items[vintLoop];
  cboMessageTo.itemindex:= -1;
  cboMessageTo.visible:= true;
  edtMessageTo.visible:= false;
  edtMessageTo.Text := '';
  edtFromMail.text := 'Technical Support';
  edtDateTimeMail.text := datetimetostr(now);
  edtSubjectMail.readonly := false;
  memMessage.readonly := false;
  edtSubjectMail.text := '';
  memMessage.lines.text := '';
end;

procedure TfrmScriptWaveTranscriptionAdmin.cmdMailItClick(Sender: TObject);
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
   vstlTemp.Text := edtSubjectMail.text + #13#10 + memMessage.text;
   vstlTemp.savetofile(vstrMessages + 'Tech_' +
       copy(cboMessageTo.text,1,9) + '_' +
       floattostr(strtodatetime(edtDateTimeMail.text)));
finally
   vstlTemp.free;
   end;
ResetAfterMessage;
LoadMessages;
end;

procedure TfrmScriptWaveTranscriptionAdmin.cmdCancelMailClick(
  Sender: TObject);
begin
  ResetAfterMessage;
end;

procedure TfrmScriptWaveTranscriptionAdmin.cmdSendandReceiveClick(
  Sender: TObject);
begin
pnlCommunicate2.visible:= true;
SendandReceiveMessages;
pnlCommunicate2.visible:= false;
end;



procedure TfrmScriptWaveTranscriptionAdmin.Button4Click(Sender: TObject);
var
    vintLoop: integer;
    vstrWork, vstrOld, vstrRevDate, vstrCptDate: string;
begin
memProgress.lines.Clear;
memProgress.lines.add('Start Force Complete: ' + datetimetostr(date));
try
vstrTranscriptionistID := cboAccount.items[cboAccount.itemindex];
pmScriptWaveFTP_II.vstrFTPBase:= cstrFTPSystem + edtAcct.text + '/';
If vMudcomp.DirectoryListFTP('') then
   begin
   {Select files to be purged}
   for vintLoop := 0 to vstlDir.count - 1 do
     begin
     vstrOld:= copy(vstlDir[vintLoop], cintFTPDirOffset,999);
     vstrWork:= vstrOld;
     vstrRevDate:= copy(vstrOld, length(vstrOld)-20,8);
     vstrCptDate:= copy(vstrOld, length(vstrOld)-11,8);
     If (copy(vstrWork,1,2) = 'C_') and
        (copy(vstrWork,3,4) = edtPhys.text) and
        (vstrRevDate <> '00000000') and
        (vstrCptDate = '00000000') then
           begin
            vstrWork:= copy(vstrWork,1,length(vstrOld)-21) +
                       edtMakeCpt.text +
                       '_cry';
            vMudcomp.RenameFile(vstrOld, vstrWork, '');
            memo1.lines.add('Renamed: ' + vstrWork);
           end;
     end;
   end;

finally
  end;
end;

procedure TfrmScriptWaveTranscriptionAdmin.Button6Click(Sender: TObject);
var
    vintLoop: integer;
    vstrWork, vstrOld: string;
begin
memProgress.lines.Clear;
memProgress.lines.add('Start Force Complete: ' + datetimetostr(date));
try
vstrTranscriptionistID := cboAccount.items[cboAccount.itemindex];
pmScriptWaveFTP_II.vstrFTPBase:= cstrFTPSystem + edtAcct.text + '/';
If vMudcomp.DirectoryListFTP('') then
   begin
   {Select files to be purged}
   for vintLoop := 0 to vstlDir.count - 1 do
     begin
     vstrOld:= copy(vstlDir[vintLoop], cintFTPDirOffset,999);
     vstrWork:= vstrOld;
     If (copy(vstrWork,1,2) = 'C_') and
        (copy(vstrWork,3,4) = edtPhys.text)  then
           begin
            vstrWork:= copy(vstrWork,1,length(vstrOld)-12) +
                       edtMakeCpt.text + '_' + edtMakeCpt.text +
                       '_cry';
            vMudcomp.RenameFile(vstrOld, vstrWork, '');
            memo1.lines.add('Renamed: ' + vstrWork);
           end;
     end;
   end;

finally
  end;
end;

end.
