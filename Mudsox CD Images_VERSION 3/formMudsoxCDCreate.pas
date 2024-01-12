unit formMudsoxCDCreate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Buttons, ToolWin, ComCtrls, Grids, StdCtrls, Mask,
  Menus, filectrl, procMudsoxImage, Gauges, fmxutils, Consts, formAddCD,
  formMudsoxFullImage, MultiTWAIN, jpeg, ImgList;

type
  TformMudsoxCDCreator = class(TForm)
    barMain: TToolBar;
    cmdCopyDisk: TSpeedButton;
    pnlMain: TPanel;
    pnlControl: TPanel;
    pnlKeyMain: TPanel;
    cmdViewCD: TSpeedButton;
    pnlCDList: TPanel;
    lbl11: TLabel;
    pnlKeyControl: TPanel;
    lbl10: TLabel;
    edtKeyword: TEdit;
    cmdKeyDelete: TSpeedButton;
    cmdKeyAdd: TSpeedButton;
    lbl12: TLabel;
    cmdFilePicture: TSpeedButton;
    lstCDList: TListBox;
    pnlKeyBack: TPanel;
    mnuMain: TMainMenu;
    mnuFile: TMenuItem;
    cmdNewCD: TSpeedButton;
    cmdDeletePicture: TSpeedButton;
    pnlRight: TPanel;
    pnlPicture: TPanel;
    imgCurrent: TImage;
    lstFiles: TFileListBox;
    pnlPictureInf: TPanel;
    lbl15: TLabel;
    memPictureDesc: TMemo;
    edtFileDate: TEdit;
    chkDelKeywords: TCheckBox;
    chkDelComments: TCheckBox;
    chkDelImages: TCheckBox;
    cmdEditPicture: TSpeedButton;
    pnlRefile: TPanel;
    cboRefiles: TComboBox;
    cmdUnfile: TSpeedButton;
    cmdTwain: TSpeedButton;
    mnuExit: TMenuItem;
    Edit1: TMenuItem;
    mnuEditPicture: TMenuItem;
    mnuDeletePicture: TMenuItem;
    mnuFilePicture: TMenuItem;
    mnuCopyDisk: TMenuItem;
    mnuTwain: TMenuItem;
    mnuNewCD: TMenuItem;
    Go1: TMenuItem;
    mnuViewCD: TMenuItem;
    Help1: TMenuItem;
    mnuHelp: TMenuItem;
    mnuAbout: TMenuItem;
    mnuKeyAdd: TMenuItem;
    mnuKeyDelete: TMenuItem;
    cmdHelp: TSpeedButton;
    mnuUnfile: TMenuItem;
    cmdAbout: TSpeedButton;
    lbl20: TLabel;
    lbl21: TLabel;
    pnlUnfiled: TPanel;
    ggeCopyPictures: TGauge;
    scbThumbs: TScrollBar;
    lstUnfiled: TFileListBox;
    trvKeywords: TTreeView;
    imgList: TImageList;
    cmdKeyAddChild: TSpeedButton;
    mnuKeyAddChild: TMenuItem;
    tmrShareware: TTimer;
    cmdRotate: TSpeedButton;
    mnuRotate: TMenuItem;
    spl1: TSplitter;
    pnlRename: TPanel;
    lbl28: TLabel;
    edtNewName: TEdit;
    Label1: TLabel;
    edtOverrideDate: TEdit;
    cmdOverrideDate: TButton;
    procedure lstCDListClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cmdKeyAddClick(Sender: TObject);
    procedure cmdKeyDeleteClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure cmdCopyDiskClick(Sender: TObject);
    procedure cmdDeletePictureClick(Sender: TObject);
    procedure cmdNewCDClick(Sender: TObject);
    procedure cmdEditPictureClick(Sender: TObject);
    procedure edtKeywordChange(Sender: TObject);
    procedure cmdFilePictureClick(Sender: TObject);
    procedure imgCurrentDblClick(Sender: TObject);
    procedure cmdViewCDClick(Sender: TObject);
    procedure cmdUnfileClick(Sender: TObject);
    procedure cboRefilesClick(Sender: TObject);
    procedure cmdTwainClick(Sender: TObject);
    procedure mnuExitClick(Sender: TObject);
    procedure cmdHelpClick(Sender: TObject);
    procedure cmdAboutClick(Sender: TObject);
    procedure edtKeywordKeyPress(Sender: TObject; var Key: Char);
    procedure pnlControlResize(Sender: TObject);
    procedure scbThumbsChange(Sender: TObject);
    procedure scbThumbsScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure trvKeywordsCollapsed(Sender: TObject; Node: TTreeNode);
    procedure trvKeywordsClick(Sender: TObject);
    procedure cmdKeyAddChildClick(Sender: TObject);
    procedure tmrSharewareTimer(Sender: TObject);
    procedure cmdRotateClick(Sender: TObject);
    procedure cmdOverrideDateClick(Sender: TObject);
  private
    varrThumbs: array [1..25] of timage;
    vstlKeywordList: Tstringlist;
    vstrBaseDir: string;
    vstrCurrentImageName, vstrCurrentBIGImageName: string;
    vbolExiting: boolean;
    procedure CheckButtonStates;
    procedure FindCDNames;
    procedure UpdateKeyINI;
    procedure MudsoxCopyFile(const FileName, DestName: TFileName);
    procedure RefreshThumbnailView;
    procedure imgThumbClick(Sender: TObject);
    procedure BuildKeywords;
    procedure RefreshColors;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formMudsoxCDCreator: TformMudsoxCDCreator;

implementation

uses formMudsoxAbout;

{$R *.DFM}

procedure TformMudsoxCDCreator.FormCreate(Sender: TObject);
var vintTop, vintLoop: integer;
begin
vintLoop:= pos('MUDSOXCDCREATE.EXE', UPPERCASE(application.ExeName));
vstrBaseDir:= copy(application.ExeName, 1, vintLoop-1);
vstlKeywordList:= Tstringlist.create;
ForceDirectories(vstrBaseDir + 'Pending_Images');
lstFiles.Mask := vstrBaseDir + '*.*';
lstFiles.FileType:= [ftDirectory];
lstFiles.Enabled:= true;
FindCDNames;
lstUnfiled.ApplyFilePath(vstrBaseDir + 'Pending_Images\');
lstUnfiled.Mask:= 'T*.jpg';
lstUnfiled.enabled:=true;
CheckButtonStates;
vintTop:=1;
for vintLoop:= 1 to 25 do
  begin
  varrThumbs[vintLoop]:= timage.create(nil);
     with varrThumbs[vintLoop] do
       begin
       parent:= pnlUnfiled;
       name:= 'imgThumb' + inttostr(vintLoop);
       tag:= vintLoop - 1;
       left:=1;
       top:=vintTop;
       width := 128;
       height:= 95;
       visible:= true;
       OnDblClick:= imgCurrentDblClick;
       OnClick:= imgThumbClick;                 
       vintTop:= vintTop + 100;
       end;
  end;
RefreshThumbnailView;
{$IFDEF TRIAL}
formMudsoxCDCreator.caption:=
      'Mudsox Image CD Creator - TRIAL VERSION - please purchase at mudsox.com';
{$ENDIF}
end;

procedure TformMudsoxCDCreator.imgThumbClick(Sender: TObject);
begin
Screen.Cursor := crHourglass;
try
If lstUnfiled.Items.count = 0 then
  exit;
vstrCurrentImageName:= copy(timage(sender).name, 2, 999) + '.jpg';
vstrCurrentBIGImageName:= copy(timage(sender).name, 3, 999) + '.jpg';
edtNewName.text:= vstrCurrentBIGImageName;
lstUnfiled.itemIndex:=lstUnfiled.Items.IndexOf(vstrCurrentImageName);
FillImageBox(timage(Sender),
             false,
             128,
             95,
             vstrCurrentImageName);
timage(sender).left := round((137 - timage(sender).width) / 2);
FillImageBox(imgCurrent,
             false,
             pnlPicture.width,
             pnlPicture.height,
             vstrCurrentBIGImageName);
edtFileDate.text := formatdatetime('mm/dd/yyyy hh:mm:ss ampm dddd',
                                             FileDateTime(lstUnfiled.FileName));
CheckButtonStates;
finally
  Screen.Cursor := crDefault;
  end
end;

procedure TformMudsoxCDCreator.FormDestroy(Sender: TObject);
  var vintLoop: integer;
  begin
  for vintLoop:= 1 to 25 do
    varrThumbs[vintLoop].free;
  vstlKeywordList.free;
  end;

procedure TformMudsoxCDCreator.FindCDNames;
var vintLoop: integer;
  begin
  lstFiles.update;
  lstCDList.clear;
  For vintLoop := 0 to lstFiles.Items.Count-1 do
    begin
    If (lstFiles.items[vintLoop] = '[.]') or
       (lstFiles.items[vintLoop] = '[..]') or
       (lstFiles.items[vintLoop] = '[Pending_Images]') then
    else
       lstCDlist.Items.add(copy(lstFiles.items[vintLoop],
                                        2, length(lstFiles.items[vintLoop])-2));
    end;
  end;

procedure TformMudsoxCDCreator.lstCDListClick(Sender: TObject);
begin
  screen.Cursor:= crHourglass;
  try
  vstlKeywordList.Clear;
  vstlKeywordList.LoadFromFile
         (vstrBaseDir + lstCDlist.items[lstCDlist.itemindex] + '\Keywords.lst');
  BuildKeywords;
  finally
    CheckButtonStates;
    screen.Cursor:=crdefault;
    end;
end;

procedure TformMudsoxCDCreator.BuildKeywords;
  var vintLoop, vintLevel: integer;
      vtndNode: ttreenode;
      varrLevels: array [1..9] of ttreenode;
  begin
  trvKeywords.visible:= false;
  trvKeywords.Items.Clear;
  for vintLoop:= 0 to vstlKeywordlist.count - 1 do
    begin
    vintLevel:= strtoint(copy(vstlKeywordlist[vintLoop], 1, 1));
    If vintLevel = 1 then
        vtndNode:= trvKeywords.Items.AddChild(nil,
                                       copy(vstlKeywordlist[vintLoop], 3, 999))
    Else
        begin
        vtndNode:= trvKeywords.Items.AddChild(varrLevels[vintLevel-1],
                                       copy(vstlKeywordlist[vintLoop], 3, 999));
        varrLevels[vintLevel-1].ImageIndex:= 0;
        varrLevels[vintLevel-1].SelectedIndex:= 0;
        end;
    vtndNode.ImageIndex:= 1;
    vtndNode.SelectedIndex:= 1;
    varrLevels[vintLevel]:= vtndNode;
    end;
  trvKeywords.visible:= true;
  end;

procedure TformMudsoxCDCreator.cmdKeyAddClick(Sender: TObject);
begin
If (edtKeyword.text > '  A') then
   begin
   trvKeywords.Items.Add(trvKeywords.Selected,edtKeyword.text);
   UpdateKeyINI;
   RefreshColors;
//   BuildKeywords;
   edtKeyword.text := '';
   CheckButtonStates;
   end;
end;

procedure TformMudsoxCDCreator.RefreshColors;
var vintLoop1: integer;
begin
for vintLoop1:= 0 to trvKeywords.items.count - 1 do
   if trvKeywords.Items[vintLoop1].HasChildren then
     trvKeywords.Items[vintLoop1].imageindex:= 0
   else
     trvKeywords.Items[vintLoop1].imageindex:= 1;
end;

procedure TformMudsoxCDCreator.cmdKeyDeleteClick(Sender: TObject);
begin
If trvKeywords.Selected <> nil then
   begin
   trvKeywords.Selected.Delete;
   UpdateKeyINI;
//   BuildKeywords;
   RefreshColors;
   CheckButtonStates;
   end;
end;

procedure TformMudsoxCDCreator.cmdKeyAddChildClick(Sender: TObject);
begin
If (edtKeyword.text > '  A') and
   (trvKeywords.Selected <> nil) then
   begin
   trvKeywords.Selected.ImageIndex:= 0;
   trvKeywords.Selected.SelectedIndex:= 0;
   trvKeywords.Items.AddChild(trvKeywords.Selected,edtKeyword.text);
   UpdateKeyINI;
//   BuildKeywords;
   RefreshColors;
   edtKeyword.text := '';
   CheckButtonStates;
   end;
end;

procedure TformMudsoxCDCreator.FormResize(Sender: TObject);
begin
If vbolExiting then
    exit;
If lstUnfiled.items.count > 0 then
  begin
  If lstUnfiled.itemindex = -1 then
       lstUnfiled.itemindex:= 0;
  vstrCurrentImageName:= lstUnfiled.FileName;
  imgThumbclick(varrThumbs[lstUnfiled.itemindex + 1]);
  end;
spl1.width:= formMudsoxCDCreator.width  - 209;
{Shareware Code}
{$IFDEF TRIAL}
tmrShareware.enabled:= true;
If date > strtodate('3/1/2001') then
  begin
  ShowMessage('The trial period on the creator has expired.  Please register!');
  cmdAboutClick(self);
  close;
  exit;
  end;
{$ENDIF}
end;

procedure TformMudsoxCDCreator.RefreshThumbnailView;
var vintLoop1: integer;
    vintPictures: longint;
    vstrName: string;
begin
If lstUnfiled.Items.Count = 0 then
    exit;
If lstUnfiled.itemindex = -1 then
    lstUnfiled.itemindex:=0;
vintPictures:= lstUnfiled.Items.count;
If vintPictures > 25 then
    vintPictures:= 25;
for vintLoop1 := 1 to vintPictures do
   begin
   with varrThumbs[vintLoop1] do
       begin
       vstrName:=lstUnfiled.items[vintLoop1 - 1];
       varrThumbs[vintLoop1].name :=
                                'i' + copy(vstrName, 1, pos('.', vstrName) - 1);
       FillImageBox(varrThumbs[vintLoop1],
          false,
          128,
          95,
          vstrBaseDir + 'pending_images\' + vstrName);
          varrThumbs[vintLoop1].left :=
                                round((137 - varrThumbs[vintLoop1].width) / 2);
       end;
   end;
pnlUnfiled.Height := (100 * vintPictures) + 1;
pnlControlResize(self);
end;

procedure TformMudsoxCDCreator.UpdateKeyINI;
  var vintLoop: integer;
begin
  screen.Cursor:= crHourglass;
  vstlKeywordList.Clear;
  for vintLoop:= 0 to trvKeywords.items.count - 1 do
     vstlKeywordList.add(inttostr(trvKeywords.items[vintLoop].level + 1)
                      + '~' + trvKeywords.items[vintLoop].text);
  vstlKeywordList.savetofile
         (vstrBaseDir + lstCDlist.items[lstCDlist.itemindex] + '\Keywords.lst');
  screen.Cursor:=crdefault;
end;

procedure TformMudsoxCDCreator.cmdCopyDiskClick(Sender: TObject);
var vintLoop: integer;
    vstrNewName, vstrNewNameT: string;
    vlstAfiles: tfilelistbox;
    vstrImpDir: string;
    vbolJPG: boolean;
    vimgJPEGbig: tJPEGImage;
    vimgBMP: tBitmap;
    vfilDest: integer;
    vdatFileDateTime: tdatetime;
    vsrcSearchRec: TSearchRec;
   procedure GetNewName;
      var vreaTime: real;
      begin
      vreaTime:= time;
      vstrNewName:= vstrBaseDir + 'Pending_Images\' +
                floattostr(int(FileDateTime
               (vstrImpDir + vlstAfiles.Items.Strings[vintloop]) * 100000000)) +
                floattostr(int(vreaTime * 1000000)) + '.jpg';
      vstrNewNameT:= vstrBaseDir + 'Pending_Images\' + 'T' +
                floattostr(int(FileDateTime(vstrImpDir +
                vlstAfiles.Items.Strings[vintloop]) * 100000000)) +
                floattostr(int(vreaTime * 1000000)) + '.jpg';
      end;
begin
formAddNewCD:= TformAddNewCD.Create(nil);
try
formAddNewCD.caption:=
                  'Import images from disk or diskette';
formAddNewCD.pnlImport.Visible:= true;
formAddNewCD.ShowAndProcess(vstrBaseDir);
vstrImpDir := formAddNewCD.vstrImpDir + '\';
vbolJPG:= formAddNewCD.vbolJPG;
finally
  formAddNewCD.release;
  end;
If length(vstrImpDir) = 0 then
   exit;
vlstAfiles := tfilelistbox.create(self);
try
Screen.Cursor := crHourglass;
with vlstAfiles do
    begin {question label}
      left := 1;
      name := 'vlstAfiles';
      parent := pnlCDList;
      top := 1;
      visible:= false;
      enabled:= false;
    end;
lstUnfiled.enabled := false;
If copy(vstrImpDir, length(vstrImpDir), 1) = '\' then
else
   vstrImpDir:= vstrImpDir + '\';
If vbolJPG then
  vlstAfiles.mask := vstrImpDir + '*.jpg'
else
  vlstAfiles.mask := vstrImpDir + '*.bmp';
vlstAfiles.enabled := true;
vlstAfiles.Refresh;
If vlstAfiles.items.count = 0 then
  begin
  Screen.Cursor := crDefault;
  exit;
  end;
ggeCopyPictures.maxvalue := vlstAfiles.Items.Count;
 For vintloop := 0 to (vlstAfiles.Items.Count - 1) do
  begin
  GetNewName;
  While FileExists(vstrNewName) do
    begin
    Sleep(200);
    GetNewName;
    end;
  vdatFileDateTime:= FileDateTime
                              (vstrImpDir + vlstAfiles.Items.Strings[vintloop]);
  vimgJPEGBIG:= tjpegImage.create;
  vimgBMP:= tBitmap.create;
  try
    If vbolJPG then
      begin
      vimgJPEGBIG.LoadFromFile(vstrImpDir + vlstAfiles.Items.Strings[vintloop]);
      vimgBMP.assign(vimgJPEGBIG);
      end
    else
      begin
      vimgBMP.LoadFromFile(vstrImpDir + vlstAfiles.Items.Strings[vintloop]);
      vimgJPEGBIG.assign(vimgBMP);
      end;
    vimgJPEGBIG.SaveToFile(vstrNewName);
    vfilDest:= FileOpen(vstrNewName, fmOpenWrite);
    FileSetDate(vfilDest, DateTimeToFileDate(vdatFileDateTime));
    FileClose(vfilDest);
    FindFirst(vstrNewName, faAnyFile, vsrcSearchRec);
    CreateThumb(vimgJPEGBIG,vdatFileDateTime,vstrNewNameT,vsrcSearchRec.Size);
    FindClose(vsrcSearchRec);
    ggeCopyPictures.progress := vintLoop + 1;
   finally
    vimgJPEGBIG.Free;
    vimgBMP.Free;
    end;
  end;
ggeCopyPictures.progress := 0;
lstUnfiled.update;
RefreshThumbnailView;
imgThumbclick(varrThumbs[1]);
finally
   Screen.Cursor := crDefault;
   lstUnfiled.enabled := true;
   lstUnfiled.update;
   vlstAfiles.free;
   end;
end;

{Modified Copy file from the FMXUTILS unit the works the way I want it to}
procedure TformMudsoxCDCreator.MudsoxCopyFile
                                          (const FileName, DestName: TFileName);
var
  CopyBuffer: Pointer; { buffer for copying }
  BytesCopied: Longint;
  Source, Dest: Integer; { handles }
  Destination: TFileName; { holder for expanded destination name }
  vdatFileDateTime: tdatetime;
const
  ChunkSize: Longint = 8192; { copy in 8K chunks }
begin
 vdatFileDateTime:= FileDateTime(FileName);
 Destination := ExpandFileName(DestName); { expand the destination path }
 GetMem(CopyBuffer, ChunkSize); { allocate the buffer }
 try
   Source := FileOpen(FileName, fmShareDenyNone); { open source file }
   if Source < 0 then raise EFOpenError.CreateFmt(SFOpenError, [FileName]);
   try
   Dest := FileCreate(Destination); { create output file; overwrite existing }
   if Dest < 0 then raise EFCreateError.CreateFmt(SFCreateError, [Destination]);
   try
      repeat
        BytesCopied := FileRead(Source, CopyBuffer^, ChunkSize); { read chunk }
        if BytesCopied > 0 then { if we read anything... }
          FileWrite(Dest, CopyBuffer^, BytesCopied); { ...write chunk }
      until BytesCopied < ChunkSize; { until we run out of chunks }
    finally
      FileSetDate(Dest, DateTimeToFileDate(vdatFileDateTime));
      FileClose(Dest); { close the destination file }
    end;
  finally
    FileClose(Source); { close the source file }
  end;
 finally
    FreeMem(CopyBuffer, ChunkSize); { free the buffer }
 end;
end;

procedure TformMudsoxCDCreator.cmdDeletePictureClick(Sender: TObject);
var vintItemIndex: integer;
begin
If mrOK = MessageDlg('Delete the image shown?', mtConfirmation,
                     [mbOk, mbCancel], 0) then
   begin
   vintItemIndex := lstUnfiled.ItemIndex;
   varrThumbs[lstUnfiled.itemindex + 1].picture:=nil;
   DeleteFile(lstUnfiled.Filename);
   DeleteFile(copy(lstUnfiled.Filename, 1, pos('T', lstUnfiled.Filename)-1)
             + copy(lstUnfiled.Filename, pos('T', lstUnfiled.Filename)+ 1, 999)
             );
   lstUnfiled.update;
   If lstUnfiled.items.count > 0 then
     begin
     If lstUnfiled.items.count = vintItemIndex then
        vintItemindex:= vintItemIndex - 1;
     lstUnfiled.itemindex:= vintItemIndex;
     RefreshThumbnailView;
     imgThumbclick(varrThumbs[lstUnfiled.itemindex + 1]);
     end
   else
     begin
     imgCurrent.picture := nil;
     edtFileDate.text:= '';
     end;
   CheckButtonStates;
   end;
end;

procedure TformMudsoxCDCreator.cmdNewCDClick(Sender: TObject);
begin
formAddNewCD:= TformAddNewCD.Create(nil);
try
formAddNewCD.caption:=
                  'Create a new picture folder on the disk drive';
formAddNewCD.pnlNewCD.Visible:= true;
formAddNewCD.ShowAndProcess(vstrBaseDir);
FindCDNames;
finally
  formAddNewCD.release;
  end;
end;

procedure TformMudsoxCDCreator.CheckButtonStates;
begin
If lstCDList.itemindex = -1 then
    begin
    cmdViewCD.Enabled:=false;
    cmdKeyAdd.Enabled:=false;
    cmdKeyDelete.Enabled:=false;
    mnuViewCD.Enabled:=false;
    mnuKeyAdd.Enabled:=false;
    mnuKeyDelete.Enabled:=false;
    end
else
    begin
    cmdViewCD.Enabled:=true;
    If (edtKeyword.text > '  A') then
        begin
        cmdKeyAdd.Enabled:= true;
        mnuKeyAdd.Enabled:= true;
        end
    else
        begin
        cmdKeyAdd.Enabled:= false;
        mnuKeyAdd.Enabled:= false;
        end;
    If (edtKeyword.text > '  A') and
       (trvKeywords.selected <> nil) then
        begin
        cmdKeyAddChild.Enabled:= true;
        mnuKeyAddChild.Enabled:= true;
        end
    else
        begin
        cmdKeyAddChild.Enabled:= false;
        mnuKeyAddChild.Enabled:= false;
        end;
    If trvkeywords.selected <> nil then
       begin
       cmdKeyDelete.Enabled:=true;
       mnuKeyDelete.Enabled:=true;
       end
    else
       begin
       cmdKeyDelete.Enabled:=false;
       mnuKeyDelete.Enabled:=false;
       end;
    mnuViewCD.Enabled:=true;
    mnuKeyAdd.Enabled:=true;
    end;

If (lstUnfiled.ItemIndex > -1) and (lstCDList.itemindex > -1) then
    begin
    cmdFilePicture.enabled := true;
    mnuFilePicture.enabled := true;
    end
else
    begin
    cmdFilePicture.enabled := false;
    mnuFilePicture.enabled := false;
    end;
If lstUnfiled.ItemIndex > -1 then
    begin
    cmdDeletePicture.enabled := true;
    cmdEditPicture.enabled:= true;
    cmdRotate.enabled:= true;
    mnuDeletePicture.enabled := true;
    mnuEditPicture.enabled:= true;
    mnuRotate.enabled:= true;
    end
else
    begin
    cmdDeletePicture.enabled := false;
    cmdEditPicture.enabled:= false;
    cmdRotate.enabled:= false;
    mnuDeletePicture.enabled := false;
    mnuEditPicture.enabled:= false;
    mnuRotate.enabled:= false;
    end;
If cboRefiles.Items.Count > 0 then
    begin
    cmdUnfile.enabled := true;
    mnuUnfile.enabled := true;
    end
else
    begin
    cmdUnfile.enabled := false;
    mnuUnfile.enabled := false;
    end;
end;

procedure TformMudsoxCDCreator.cmdEditPictureClick(Sender: TObject);
begin
ExecuteFile(lstUnfiled.filename,'','',0);
end;

procedure TformMudsoxCDCreator.edtKeywordChange(Sender: TObject);
begin
   CheckButtonStates;
end;

procedure TformMudsoxCDCreator.cmdFilePictureClick(Sender: TObject);
var
  vintLoop, vintLoop2, vintLoop3, vintTotal, vintHoldItem: integer;
  vstrDirectory, vstrNewDir, vstrKeywords, vstrWork, vstrBigFile: string;
  vstlTotal: tstringlist;
  vtxtPictures: textfile;
  varrLevels: array [1..9] of ttreenode;
  const
  cstrDlm1: string = '~|';
  cstrDlm2: string = '^|';
begin
  If pos('.jpg', edtNewName.text) > 0 then
  else
     begin
     ShowMessage('Please make sure the picture has .JPG on the end');
     exit;
     end;
  screen.Cursor:= crHourglass;
  vstlTotal:= tstringlist.create;
  try
  vintHoldItem := lstUnfiled.itemindex;
  vstlTotal.LoadFromFile
       (vstrBaseDir + lstCDlist.items[lstCDlist.itemindex] + '\ImageTotal.lst');
  vintTotal:= strtoint(vstlTotal[0]);
  vstrNewDir:= floattostr(int(vintTotal/300+1));
  vstrDirectory:= vstrBaseDir + lstCDList.Items[lstCDList.itemindex]
                                                         + '\IMG_' + vstrNewDir;
  ForceDirectories(vstrDirectory);
  If fileexists(vstrDirectory + '\T' + edtNewName.text) then
     begin
     ShowMessage('You already have a picture with this name - try again...');
     exit;
     end;

  MudsoxCopyFile(lstUnfiled.FileName,
                  vstrDirectory + '\T' + edtNewName.text);
                  //lstUnfiled.items[lstUnfiled.itemindex]);
  vstrBigFile:= copy(lstUnfiled.items[lstUnfiled.itemindex],2,999);
  MudsoxCopyFile(vstrBaseDir + 'pending_images\' + vstrBigFile,
                 vstrDirectory + '\' + edtNewName.text);
  cboRefiles.items.insert(0,vstrNewDir + '\' + edtNewName.text);
  cboRefiles.itemindex:= 0;
  inc(vintTotal);
  vstlTotal.clear;
  vstlTotal.add(inttostr(vintTotal));
  vstlTotal.add(lstCDList.Items[lstCDList.itemindex]);
  vstlTotal.SaveToFile
       (vstrBaseDir + lstCDlist.items[lstCDlist.itemindex] + '\ImageTotal.lst');
  for vintLoop2:= 0 to trvKeywords.items.Count - 1 do
    begin
    If trvKeywords.items[vintLoop2].imageindex = 2 then
       begin
       vstrWork:= inttostr(trvKeywords.items[vintLoop2].level + 1 ) + '~' +
                           trvKeywords.items[vintLoop2].text;
       for vintLoop3:= trvKeywords.items[vintLoop2].level downto 1 do
           vstrWork:= inttostr(vintLoop3) + '~' +
                      varrLevels[vintLoop3].text + vstrWork;
       vstrKeywords := vstrKeywords + vstrWork + cstrDlm2;
       end;
    varrLevels[trvKeywords.items[vintLoop2].level + 1]:=
                                                   trvKeywords.items[vintLoop2];
    end;
  AssignFile(vtxtPictures,
         vstrBaseDir + lstCDlist.items[lstCDlist.itemindex] + '\ImageList.lst');
  Append(vtxtPictures);
  Writeln(vtxtPictures, edtNewName.text + '=' + vstrNewDir + cstrDlm1
       + edtFileDate.Text + cstrDlm1 + memPictureDesc.text
       + cstrDlm1 + vstrKeywords);
  Flush(vtxtPictures);
  CloseFile(vtxtPictures);
  If chkDelKeywords.checked then
    begin
    For vintLoop:= 0 to trvKeywords.items.count - 1 do
      If trvKeywords.items[vintLoop].ImageIndex = 2 then
         begin
         trvKeywords.items[vintLoop].ImageIndex:= 1;
         trvKeywords.items[vintLoop].SelectedIndex:= 1;
         end;
    trvKeyWords.refresh;
    end;
  If chkDelComments.Checked then
      memPictureDesc.Text := '';
  If chkDelImages.checked then
     begin
     DeleteFile(lstUnfiled.filename);
     DeleteFile(vstrBaseDir + 'pending_images\' + vstrBigFile);
     lstUnfiled.update;
     imgCurrent.Picture:= nil;
     end;
  If lstUnfiled.items.count = vintHoldItem then
     vintHoldItem:= vintHoldItem - 1;
  If lstUnfiled.Items.count > 0 then
     begin
     lstUnfiled.itemindex:= vintHoldItem;
     RefreshThumbnailView;
     imgThumbclick(varrThumbs[lstUnfiled.itemindex + 1]);
     end
  else
     varrThumbs[1].picture:= nil;
  finally
     vstlTotal.free;
     CheckButtonStates;
     screen.Cursor:=crdefault;
     end;
end;

procedure TformMudsoxCDCreator.imgCurrentDblClick(Sender: TObject);
begin
application.Createform(tfrmFullImage, frmFullImage);
try
frmFullImage.caption := 'Full size picture';
FillImageBox(frmFullImage.imgFullImage,
                      true, 0, 0,
                      vstrCurrentBIGImageName);
frmFullImage.vintImgWidth:= screen.Width;
frmFullImage.vintImgHeight:= screen.Height;
frmFullImage.ShowModal;
finally
  frmFullImage.Release;
  frmFullImage:= nil;
  end;
end;

procedure TformMudsoxCDCreator.cmdViewCDClick(Sender: TObject);
begin
ExecuteFile(
      vstrBaseDir + lstCDlist.items[lstCDlist.itemindex] + '\MudsoxViewer.exe'
      ,'','',0);
end;

procedure TformMudsoxCDCreator.cmdUnfileClick(Sender: TObject);
var
  vintLoop: integer;
  vstrFile, vstrFromPath, vstrToPath: string;
  vstlPictures: tstringlist;
begin
  screen.Cursor:= crHourglass;
  vstlPictures:= tstringlist.create;
  try
  vstlPictures.LoadFromFile(vstrBaseDir +
                 lstCDlist.items[lstCDlist.itemindex] +
                 '\ImageList.lst');
  vstrFromPath:= vstrBaseDir + lstCDList.Items[lstCDList.itemindex]
                                + '\IMG_' + cboRefiles.text;
  vstrFile:= copy(cboRefiles.text, pos('\', cboRefiles.text) + 1, 999);
  vstrToPath:= vstrBaseDir + 'Pending_Images\' + vstrFile;
  MudsoxCopyFile(vstrFromPath, vstrToPath);  vstrFromPath:= vstrBaseDir + lstCDList.Items[lstCDList.itemindex]
                                + '\IMG_' + cboRefiles.text;
  vstrFile:= copy(cboRefiles.text, pos('\', cboRefiles.text) + 1, 999);
  vstrToPath:= vstrBaseDir + 'Pending_Images\T' + vstrFile;
  MudsoxCopyFile(vstrFromPath, vstrToPath);
  For vintLoop :=  0 to vstlPictures.count - 1 do
    If pos(vstrFile, vstlPictures[vintLoop]) > 0 then
         begin
         vstlPictures.Delete(vintLoop);
         break;
         end;
  DeleteFile(vstrFromPath);
  vstlPictures.SaveToFile(vstrBaseDir +
                 lstCDlist.items[lstCDlist.itemindex] +
                 '\ImageList.lst');
  cboRefiles.items.delete(cboRefiles.itemindex);
  cboRefiles.ItemIndex := 0;
  lstUnfiled.update;
  RefreshThumbnailView;
  imgThumbclick(varrThumbs[1]);
  finally
     CheckButtonStates;
     vstlPictures.Free;
     screen.Cursor:=crdefault;
     end;
end;

procedure TformMudsoxCDCreator.cboRefilesClick(Sender: TObject);
begin
vstrCurrentImageName:= vstrBaseDir + lstCDList.Items[lstCDList.itemindex]
                                + '\IMG_' + cboRefiles.text;
FillImageBox(imgCurrent,
             false,
             pnlPicture.width,
             pnlPicture.height,
             vstrCurrentImageName);
lstUnfiled.itemindex := -1;
CheckButtonStates;
end;

procedure TformMudsoxCDCreator.cmdTwainClick(Sender: TObject);
var vjpgConvert: TJPEGImage;
begin
TWAIN_AcquireToFilename(0,PCHAR(vstrBaseDir + 'TEMP.BMP'));
vjpgConvert:= tjpegImage.create;
try
If fileexists(vstrBaseDir + 'TEMP.BMP') then
  begin
  imgCurrent.picture.loadfromfile(vstrBaseDir + 'TEMP.BMP');
  vjpgConvert.assign(imgCurrent.Picture.Graphic);
  imgCurrent.picture:= nil;
  vjpgConvert.savetofile(vstrBaseDir + 'Pending_Images\' +
                   floattostr(int(FileDateTime
                   (vstrBaseDir + 'TEMP.BMP') * 100000000)) +
                   floattostr(int(time * 1000000)) + '.jpg');
  deletefile(vstrBaseDir + 'TEMP.BMP');
  lstUnfiled.update;
  RefreshThumbnailView;
  imgThumbclick(varrThumbs[1]);
  end;
finally
  vjpgConvert.free;
  end;
end;

procedure TformMudsoxCDCreator.mnuExitClick(Sender: TObject);
begin
Close;
end;

procedure TformMudsoxCDCreator.cmdHelpClick(Sender: TObject);
begin
  Application.HelpFile := vstrBaseDir + 'MudsoxCDImageCreator.HLP';
  Application.HelpJump('Main_Index');
end;

procedure TformMudsoxCDCreator.cmdAboutClick(Sender: TObject);
begin
application.Createform(tfrmAbout, frmAbout);
try
frmAbout.ShowModal;
finally
  frmAbout.Release;
  frmAbout:= nil;
  end;
end;

procedure TformMudsoxCDCreator.edtKeywordKeyPress(Sender: TObject;
  var Key: Char);
begin
If Key = #13 then
  If cmdKeyAdd.enabled then
     cmdKeyAddClick(self);
end;

procedure TformMudsoxCDCreator.pnlControlResize(Sender: TObject);
begin
If vbolExiting then
    exit;
If pnlUnfiled.height >
                (pnlControl.height - pnlREfile.height - pnlCDList.height) then
   begin
   scbThumbs.visible := true;
   scbThumbs.height:= pnlControl.height -
                      pnlCDList.height -
                      pnlREfile.height;
   scbThumbs.max:= pnlUnfiled.height - scbThumbs.height;
   end
else
   scbThumbs.visible := false;
end;

procedure TformMudsoxCDCreator.scbThumbsChange(Sender: TObject);
begin
pnlUnfiled.top := (scbThumbs.position * -1) + 140;
end;

procedure TformMudsoxCDCreator.scbThumbsScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
pnlUnfiled.top := (scbThumbs.position * -1) + 140;
end;

procedure TformMudsoxCDCreator.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
vbolExiting:= true;
end;

procedure TformMudsoxCDCreator.trvKeywordsCollapsed(Sender: TObject;
  Node: TTreeNode);
    var vintLoop: integer;
begin
For vintLoop:= 0 to trvKeywords.items.count - 1 do
  If (not trvKeywords.items[vintLoop].IsVisible) or
     (trvKeywords.items[vintLoop].HasAsParent(Node)) then
    If trvKeywords.items[vintLoop].ImageIndex = 2 then
       begin
       trvKeywords.items[vintLoop].ImageIndex:= 1;
       trvKeywords.items[vintLoop].SelectedIndex:= 1;
       end;
end;

procedure TformMudsoxCDCreator.trvKeywordsClick(Sender: TObject);
begin
If trvKeywords.Selected.HasChildren then
  begin
  trvKeywords.Selected.ImageIndex:= 0;
  trvKeywords.Selected.SelectedIndex:= 0;
  If trvKeywords.Selected.Expanded then
      trvKeywords.Selected.collapse(true)
  else
      trvKeywords.Selected.expand(false);
  end
else
If trvKeywords.Selected.ImageIndex = 2 then
   begin
   trvKeywords.Selected.ImageIndex:= 1;
   trvKeywords.Selected.SelectedIndex:= 1;
   end
else
   begin
   trvKeywords.Selected.ImageIndex:= 2;
   trvKeywords.Selected.SelectedIndex:= 2;
   end;
trvKeywords.Refresh;
CheckButtonStates;
end;

procedure TformMudsoxCDCreator.tmrSharewareTimer(Sender: TObject);
begin
{$IFDEF TRIAL}
If cmdAbout.visible= false then
  begin
  tmrShareware.Interval:= 3000;
  cmdAbout.visible:= true;
  end
else
  begin
  tmrShareware.Interval:= 250;
  cmdAbout.visible:= false;
  end;
{$ENDIF}
end;

procedure TformMudsoxCDCreator.cmdRotateClick(Sender: TObject);
begin
  RotateImage(vstrCurrentBIGImageName);
  RotateImage(vstrCurrentImageName);
  If lstUnfiled.items.count > 0 then
    begin
    If lstUnfiled.itemindex = -1 then
       lstUnfiled.itemindex:= 0;
    imgThumbclick(varrThumbs[lstUnfiled.itemindex + 1]);
    end;
end;

procedure TformMudsoxCDCreator.cmdOverrideDateClick(Sender: TObject);
var
    vfilDest: integer;
begin
If edtOverrideDate.text > '00' then
   begin
   vfilDest:= FileOpen(vstrCurrentImageName, fmOpenWrite);
   FileSetDate(vfilDest, DateTimeToFileDate(strtodatetime(edtOverrideDate.text)));
   FileClose(vfilDest);
   vfilDest:= FileOpen(vstrCurrentBIGImageName, fmOpenWrite);
   FileSetDate(vfilDest, DateTimeToFileDate(strtodatetime(edtOverrideDate.text)));
   FileClose(vfilDest);
   edtFileDate.text := formatdatetime('mm/dd/yyyy hh:mm:ss ampm dddd',
                                             FileDateTime(lstUnfiled.FileName));
   end;
end;

end.
