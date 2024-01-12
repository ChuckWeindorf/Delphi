unit formMudsoxView;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls, ToolWin, ComCtrls, Menus, StdCtrls,
  formMudsoxFullImage, procMudsoxImage, Mask, Consts, fmxutils, SakMsg,
  SakSMTP, formEmail, procroutines, formNew, Filectrl, formHTML, ImgList;

type
  TformMudsoxViewer = class(TForm)
    mnuMain: TMainMenu;
    mnuFile: TMenuItem;
    tbrMain: TToolBar;
    pnlPicture: TPanel;
    cmdSearch: TSpeedButton;
    cmdDescriptions: TSpeedButton;
    cmdFullImage: TSpeedButton;
    pnlCriteria: TPanel;
    pnlOptions: TPanel;
    memWords: TMemo;
    lbl1: TLabel;
    cmdEmail: TSpeedButton;
    pnlBorder: TPanel;
    rad1: TRadioGroup;
    edtFrom: TMaskEdit;
    edtTo: TMaskEdit;
    lbl2: TLabel;
    lbl3: TLabel;
    pnlPictureDetail: TPanel;
    memDescription: TMemo;
    edtStamp: TEdit;
    lbl4: TLabel;
    cmdUploadWeb: TSpeedButton;
    calFrom: TDateTimePicker;
    calTo: TDateTimePicker;
    cmdThumbnails: TSpeedButton;
    pnlThumb: TPanel;
    imgCurrentThumb: TImage;
    pnlImg: TPanel;
    imgCurrent: TImage;
    lstMatches: TListBox;
    cmdPrint: TSpeedButton;
    cmdAlbum: TSpeedButton;
    pnlAlbum: TPanel;
    mnuExit: TMenuItem;
    mnuEdit: TMenuItem;
    mnuView: TMenuItem;
    mnuDescriptions: TMenuItem;
    mnuFullImage: TMenuItem;
    mnuThumbnails: TMenuItem;
    mnuGo: TMenuItem;
    mnuSearch: TMenuItem;
    mnuAlbum: TMenuItem;
    mnuHelp1: TMenuItem;
    mnuUnfile: TMenuItem;
    mnuPrint: TMenuItem;
    mnuNext: TMenuItem;
    mnuPrevious: TMenuItem;
    mnuHelp: TMenuItem;
    mnuAbout: TMenuItem;
    cmdHelp: TSpeedButton;
    mnuAddFav: TMenuItem;
    mnuEmail: TMenuItem;
    mnuUploadWeb: TMenuItem;
    tbrImage: TToolBar;
    cmdAddFav: TSpeedButton;
    cmdPrevious: TSpeedButton;
    cmdNext: TSpeedButton;
    cmdUnfile: TSpeedButton;
    cmdAbout: TSpeedButton;
    cmdAddEmail: TSpeedButton;
    cmdAddWeb: TSpeedButton;
    mnuAddEmail: TMenuItem;
    mnuAddWeb: TMenuItem;
    pnlRight: TPanel;
    lstPages: TListBox;
    pnlTop: TPanel;
    imgAlbumThumb: TImage;
    cmdSlides: TSpeedButton;
    tmrSlides: TTimer;
    mnuSlideshow: TMenuItem;
    pnlFavCtrl: TPanel;
    cmdFavDelete: TBitBtn;
    imgList: TImageList;
    trvKeywords: TTreeView;
    pnlKeyBack: TPanel;
    lbl11: TLabel;
    lbl12: TLabel;
    cmddummy1: TSplitter;
    cmdDummy2: TSplitter;
    cmdDummy4: TSplitter;
    cmdDummy3: TSplitter;
    cmdDummy5: TSplitter;
    cmdDummy6: TSplitter;
    lblImage: TLabel;
    procedure cmdEmailClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure imgCurrentDblClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure cmdSearchClick(Sender: TObject);
    procedure lstMatchesClick(Sender: TObject);
    procedure lstMatchesDblClick(Sender: TObject);
    procedure cmdDescriptionsClick(Sender: TObject);
    procedure cmdFullImageClick(Sender: TObject);
    procedure rad1Click(Sender: TObject);
    procedure cmdPreviousClick(Sender: TObject);
    procedure cmdNextClick(Sender: TObject);
    procedure calFromChange(Sender: TObject);
    procedure calToChange(Sender: TObject);
    procedure cmdUnfileClick(Sender: TObject);
    procedure cmdThumbnailsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure cmdAlbumClick(Sender: TObject);
    procedure cmdAddFavClick(Sender: TObject);
    procedure cmdFavDeleteClick(Sender: TObject);
    procedure mnuExitClick(Sender: TObject);
    procedure cmdUploadWebClick(Sender: TObject);
    procedure cmdHelpClick(Sender: TObject);
    procedure mnuAboutClick(Sender: TObject);
    procedure cmdAddWebClick(Sender: TObject);
    procedure cmdAddEmailClick(Sender: TObject);
    procedure lstPagesClick(Sender: TObject);
    procedure cmdSlidesClick(Sender: TObject);
    procedure tmrSlidesTimer(Sender: TObject);
    procedure lstPagesDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lstPagesDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure trvKeywordsClick(Sender: TObject);
    procedure trvKeywordsCollapsed(Sender: TObject; Node: TTreeNode);
    procedure lblImageClick(Sender: TObject);
  private
    { Private declarations }
    vstrBaseDir, vstrCurrentImage, vstrCurrentImageT, vstrLocalPath,
                 vstrLastFavorite, vstrHTMLName, vstrAlbumName,
                 vstrCurrentImageName: string;
    vintBaseThumb, vintMatch, vintCurrentPage, vintoldx, vintoldy, vintMustJump,
                   vintSlides: integer;
    vstlKeywordlist: tstringlist;
    vstlName, vstlKeys, vstlDesc, vstlDate, vstlMatchImage, vstlAlbumNames,
                                                      vstlAlbumDim: tstringlist;
    vbolVIEWONLY, vbolClosingSystem, vbolDown, vbolResize, vbolDouble,
                   vbolSlideDown: boolean;
    varrDirectory: array [0..11000] of integer;
    varrThumbs: array [1..100] of Timage;
    procedure CheckButtonStates;
    procedure BuildKeywords;
    procedure AssignCurrentFile;
    procedure ClearImages;
    procedure MudsoxCopyFile(const FileName, DestName: TFileName);
    procedure FreeImages;
    procedure imgThumbClick(Sender: TObject);
    procedure imgThumbDoubleClick(Sender: TObject);
    procedure DisplayAlbumPage;
    procedure ResetSelect;
    Function SetCurrentImage(vimgWork: timage): integer;
    Procedure SaveFavorites;
    procedure imgFavoriteClick(Sender: TObject);
    procedure imgFavoriteMouseDown(Sender: TObject;
                       Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure imgFavoriteMouseMove
                           (Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure imgFavoriteMouseUp
     (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MajorDeactivate;
  public
    { Public declarations }
  end;

var
  formMudsoxViewer: TformMudsoxViewer;

implementation

uses formPrint, formMudsoxAbout;

{$R *.DFM}

procedure TformMudsoxViewer.cmdEmailClick(Sender: TObject);
begin
application.Createform(tfrmEmail, frmEmail);
try
frmEmail.vstrLocalPath:= vstrLocalPath;
frmEmail.edtServer.text:=
                      ReadRegistry('Software\Mudsox\Viewer', 'Email', 'Server');
frmEmail.edtFrom.Text:= ReadRegistry('Software\Mudsox\Viewer', 'Email', 'From');
frmEmail.ShowModal;
WriteRegistry
         ('Software\Mudsox\Viewer', 'Email', 'Server', frmEmail.edtServer.text);
WriteRegistry
         ('Software\Mudsox\Viewer', 'Email', 'From', frmEmail.edtFrom.Text);
finally
  frmEmail.Release;
  frmEmail:= nil;
  end; 
end;

procedure TformMudsoxViewer.FormCreate(Sender: TObject);
var vintLoop: integer;
    vstlAllKeys, vstlAlbum: tstringlist;
    vstrWork: string;
begin
screen.Cursor:= crHourglass;
vbolClosingSystem:= false;
vintLoop:= pos('MUDSOXVIEWER.EXE', UPPERCASE(application.ExeName));
vstrBaseDir:= copy(application.ExeName, 1, vintLoop-1);
vstlKeywordList:= Tstringlist.create;
vstlAllKeys:= tstringlist.create;
vstlAlbum:= tstringlist.create;
vstlKeywordList.sorted := false;
if (FileGetAttr(vstrBaseDir + 'ImageList.lst')
    and FILE_ATTRIBUTE_READONLY) > 0 then
     vbolVIEWONLY:= true
else
     vbolVIEWONLY:= false;
calFrom.date:= date;
calTo.date:= date;
try
   If not fileexists(vstrBaseDir + 'ImageTotal.lst') then
        exit;
   vstlKeywordList.loadfromfile(vstrBaseDir + 'Keywords.lst');
   BuildKeywords;
   For vintLoop:= 1 to 90 do
      varrThumbs[vintLoop]:= nil;
   vstlDesc:= tstringlist.create;
   vstlName:= tstringlist.create;
   vstlDate:= tstringlist.create;
   vstlKeys:= tstringlist.create;
   vstlMatchImage:= Tstringlist.create;
   vstlAlbumNames:= Tstringlist.create;
   vstlAlbumDim:= Tstringlist.create;
   vstlNewImages:= tstringlist.create;
   vstlEmailImages:= tstringlist.create;
   vstlNewHTML:= tstringlist.create;
   vstlOldHTML:= tstringlist.create;
   vstlAllKeys.loadfromfile(vstrBaseDir + 'ImageList.lst');
   for vintLoop:= 0 to vstlAllKeys.Count - 1 do
      begin
      vstrWork := vstlAllKeys[vintLoop];
      vstlName.add(copy(vstrWork, 1,
                   pos('=', vstrWork) -1));
      vstrWork:= copy(vstrWork, pos('=', vstrWork) + 1, 999);
      varrDirectory[vintLoop]:=strtoint(copy(vstrWork, 1,
                   pos('~|', vstrWork) -1));
      vstrWork:= copy(vstrWork, pos('~|', vstrWork) + 2, 999);
      vstlDate.add(copy(vstrWork, 1, pos('~|', vstrWork) -1));
      vstrWork:= copy(vstrWork, pos('~|', vstrWork) + 2, 999);
      If copy(vstrWork,1,2) = '~|' then
        vstlDesc.add('Untitled')
      else
        vstlDesc.add(copy(vstrWork, 1, pos('~|', vstrWork) -1));
      vstrWork:= copy(vstrWork, pos('~|', vstrWork) + 2, 999);
      while pos('^|',  vstrWork) > 0 do
         vstrWork := copy(vstrWork,1,pos('^|', vstrWork)-1) + ';' +
                     copy(vstrWork,pos('^|', vstrWork)+2, 999);
      while pos('~',  vstrWork) > 0 do
        If pos('~', vstrWork) = 2 then
           vstrWork := copy(vstrWork,3,999)
        else
           vstrWork := copy(vstrWork,1,pos('~', vstrWork)-2) + '/' +
                       copy(vstrWork,pos('~', vstrWork)+1, 999);
      while pos(';/',  vstrWork) > 0 do
           vstrWork := copy(vstrWork,1,pos(';/', vstrWork)-1) + ';' +
                       copy(vstrWork,pos(';/', vstrWork)+2, 999);
      If length(vstrWork) > 0 then
         vstrWork:=copy(vstrWork, 1, length(vstrWork)-1);
      vstlKeys.add(vstrWork);
      end;
      vstlAlbum.Loadfromfile(vstrBaseDir + 'ImageTotal.lst');
      If vstlAlbum.count = 2 then
        begin
        formMudsoxViewer.caption:=
                          formMudsoxViewer.caption + ' - ' + vstlAlbum[1];
        vstrAlbumName:= 'Album ' + vstlAlbum[1] + '.dat';
        vstrHTMLName:= 'HTML ' + vstlAlbum[1] + '.dat';
        end
      else
        vstrAlbumName:= 'Album.dat';
   finally
     vstlKeywordList.free;
     vstlAllKeys.free;
     vstlAlbum.free;
     CheckButtonStates;
     screen.Cursor:=crdefault;
     end;
end;

procedure TformMudsoxViewer.BuildKeywords;
  var vintLoop, vintLevel: integer;
      vtndNode: ttreenode;
      varrLevels: array [1..9] of ttreenode;
  begin
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
  end;

procedure TformMudsoxViewer.CheckButtonStates;
  begin
  If lstMatches.Items.count > 0 then
     begin
     cmdFullImage.enabled := true;
     cmdThumbnails.enabled := true;
     cmdAddFav.enabled := true;
     cmdAddEmail.enabled := true;
     cmdAddWeb.enabled := true;
     mnuFullImage.enabled := true;
     mnuThumbnails.enabled := true;
     mnuAddFav.enabled := true;
     mnuAddEmail.enabled := true;
     mnuAddWeb.enabled := true;
     end
  else
     begin
     cmdFullImage.enabled := false;
     cmdThumbnails.enabled := false;
     cmdAddFav.enabled := false;
     cmdAddEmail.enabled := false;
     cmdAddWeb.enabled := false;
     mnuFullImage.enabled := false;
     mnuThumbnails.enabled := false;
     mnuAddFav.enabled := false;
     mnuAddEmail.enabled := false;
     mnuAddWeb.enabled := false;
     end;
  cmdAlbum.Enabled := true;
  cmdSearch.Enabled := true;
  cmdDescriptions.enabled:= true;
  cmdEmail.enabled:= true;
  cmdUploadWeb.enabled:= true;
  cmdPrevious.enabled := false;
  cmdNext.enabled:= false;
  mnuAlbum.Enabled := true;
  mnuSearch.Enabled := true;
  mnuDescriptions.enabled:= true;
  mnuEmail.enabled:= true;
  mnuUploadWeb.enabled:= true;
  mnuPrevious.enabled := false;
  mnuNext.enabled:= false;
  If (lstMatches.items.count > 0) and not cmdThumbnails.down then
     begin
     If lstMatches.itemindex < lstMatches.items.count - 1 then
        begin
        cmdNext.enabled := true;
        mnuNext.enabled := true;
        end;
     If lstMatches.itemindex > 0 then
        begin
        cmdPrevious.enabled := true;
        mnuPrevious.enabled := true;
        end;
     end;
  If vbolVIEWONLY or (lstMatches.itemindex = -1)
     or not cmdDescriptions.down then
     begin
     cmdUnfile.enabled := false;
     mnuUnfile.enabled := false;
     end
  else
     begin
     cmdUnfile.enabled := true;
     mnuUnfile.enabled := true;
     end;
  end;

procedure TformMudsoxViewer.imgCurrentDblClick(Sender: TObject);
begin
If pnlAlbum.visible then
   begin
   ResetSelect;
   vbolDouble:= true;
   end;
application.Createform(tfrmFullImage, frmFullImage);
try
frmFullImage.caption := 'Mudsox picture magnifier';
FillImageBox(frmFullImage.imgFullImage,
                      true, 0, 0,
                      vstrCurrentImage);
frmFullImage.vintImgWidth:= screen.Width;
frmFullImage.vintImgHeight:= screen.Height;
frmFullImage.ShowModal;
finally
  frmFullImage.Release;
  frmFullImage:= nil;
  end;
end;

procedure TformMudsoxViewer.FormResize(Sender: TObject);
begin
cmdDummy4.width:= formMudsoxViewer.width - 532;
If vbolClosingSystem then
   exit;
If pnlAlbum.Visible then
   exit;
If cmdFullImage.down then
  cmdFullImageClick(self)
else
If cmdThumbnails.down then
  cmdThumbnailsClick(self);
end;

procedure TformMudsoxViewer.cmdSearchClick(Sender: TObject);
var vintLoop, vintLoop2, vintLoop3, vintKey:integer;
    vbolMatch: boolean;
    vdatTest, vdatTo, vdatFrom: tdatetime;
    vstrWork: string;
    vstlKeySearch: tstringlist;
    varrLevels: array [1..9] of ttreenode;
begin
screen.Cursor:= crHourglass;
vstlKeySearch:= tstringlist.create;
for vintLoop2:= 0 to trvKeywords.items.Count - 1 do
  begin
  If trvKeywords.items[vintLoop2].imageindex = 2 then
     begin
     vstrWork:= trvKeywords.items[vintLoop2].text;
     for vintLoop3:= trvKeywords.items[vintLoop2].level downto 1 do
         vstrWork:= varrLevels[vintLoop3].text + '/' + vstrWork;
     vstlKeySearch.add(vstrWork);
     end;
  varrLevels[trvKeywords.items[vintLoop2].level + 1]:=
                                                   trvKeywords.items[vintLoop2];
  end;
try
lstMatches.visible := false;
imgCurrent.picture := nil;
imgCurrentThumb.picture := nil;
lstMatches.Items.Clear;
vstlMatchImage.Clear;
vdatFrom:= 0;
vdatTo:=0;
try
vdatFrom:= strtodate(edtFrom.text);
vdatTo:= strtodate(edtTo.text);
except end;
for vintloop:= 0 to vstlKeys.count - 1 do
  begin
  vbolMatch := True;
  If vstlKeySearch.count > 0 then
    for vintLoop2:= 0 to vstlKeySearch.count - 1 do
      If pos(uppercase(vstlKeySearch[vintLoop2]),
                               uppercase(vstlKeys[vintLoop])) = 0 then
                               vbolMatch:= false;
  for vintKey := 0 to memWords.lines.Count - 1 do
              If pos(uppercase(memWords.lines[vintKey]),
                               uppercase(vstlDesc[vintLoop])) = 0 then
                               vbolMatch:= false;
  try
  vstrWork:=copy(vstlDate[vintloop],1,
                         pos(' ',vstlDate[vintloop])-1);
  vdatTest:= strtodate(vstrWork);
  If rad1.ItemIndex = 1 then
     begin
     If vdatFrom <> vdatTest then
         vbolMatch:= false;
     end
  else
  If rad1.ItemIndex = 2 then
     begin
     If vdatFrom > vdatTest then
         vbolMatch:= false;
     end
  else
  If rad1.ItemIndex = 3 then
     begin
     If vdatTo < vdatTest then
         vbolMatch:= false;
     end
  else
  If rad1.ItemIndex = 4 then
     begin
     If (vdatTo < vdatTest) or (vdatFrom > vdatTest) then
         vbolMatch:= false;
     end;
  except end;
  If vbolMatch then
    begin
    If length(vstlKeys[vintLoop]) > 0 then
      lstMatches.Items.add(vstlDesc[vintLoop] + ' of ' + vstlKeys[vintLoop])
    else
      lstMatches.Items.add(vstlDesc[vintLoop]);
    vstlMatchImage.add(vstlName[vintLoop]);
    end;
  end;
lstMatches.Visible:= true;
imgCurrent.visible:=false;
cmdDescriptions.down:= true;
CheckButtonStates;
If lstMatches.items.count > 0 then
   begin
   lstMatches.Itemindex := 0;
   lstMatchesClick(self);
   end;
finally
  vstlKeySearch.free;
  screen.Cursor:=crdefault;
  end;
end;

procedure TformMudsoxViewer.AssignCurrentFile;
var vstrname: string;
begin
  vstrName:=vstlMatchImage[lstmatches.itemindex];
  vintMatch:= vstlName.IndexOf(vstrName);
  edtStamp.text := vstlDate[vintMatch];
  memDescription.text := vstlDesc[vintMatch];
  memDescription.lines.add(vstlKeys[vintMatch]);
  while pos(';', memDescription.lines.text) > 0 do
     memDescription.lines.text:= copy(memDescription.lines.text, 1,
                                 pos(';', memDescription.lines.text) - 1) +
                                 #13#10 +
                                 copy(memDescription.lines.text,
                                 pos(';', memDescription.lines.text) + 1, 999);
  vstrCurrentImage:= vstrBaseDir + 'img_' +
                           inttostr(varrDirectory[vintMatch]) + '\' + vstrName;
  vstrCurrentImageT:= vstrBaseDir + 'img_' +
                          inttostr(varrDirectory[vintMatch]) + '\T' + vstrName;
  lblImage.Caption:= vstrCurrentImage;
end;

procedure TformMudsoxViewer.lstMatchesClick(Sender: TObject);
begin
  AssignCurrentFile;
  imgCurrentThumb.stretch:= false;
  FillImageBox(imgCurrentThumb,
             false,
             111,
             85,
             vstrCurrentImageT);
  CheckButtonStates;
end;

procedure TformMudsoxViewer.lstMatchesDblClick(Sender: TObject);
begin
cmdFullImage.down:=true;
cmdFullImageclick(self);
end;

procedure TformMudsoxViewer.cmdDescriptionsClick(Sender: TObject);
begin
FreeImages;
imgCurrent.Visible:= false;
imgCurrent.picture:= nil;
imgCurrentThumb.picture:= nil;
imgCurrentThumb.Visible:= true;
lstMatches.visible:=true;
CheckButtonStates;
If lstMatches.ItemIndex <> -1 then
   lstMatchesClick(self);
end;

procedure TformMudsoxViewer.cmdFullImageClick(Sender: TObject);
begin
FreeImages;
imgCurrentThumb.Visible:= false;
imgCurrentThumb.picture:= nil;
AssignCurrentFile;
FillImageBox(imgCurrent,
             false,
             pnlImg.width,
             pnlImg.height,
             vstrCurrentImage);
lstMatches.visible:=false;
CheckButtonStates;
end;

procedure TformMudsoxViewer.rad1Click(Sender: TObject);
begin
If rad1.ItemIndex = 0 then
  begin
  lbl2.visible:= false;
  lbl3.visible:= false;
  edtFrom.visible:= false;
  edtTo.visible:= false;
  calFrom.visible:= false;
  calTo.visible:= false;
  end
else
If rad1.ItemIndex = 1 then
  begin
  lbl2.caption:= 'On:';
  lbl2.visible:= true;
  lbl3.visible:= false;
  edtFrom.visible:= true;
  edtTo.visible:= false;
  calFrom.visible:= true;
  calTo.visible:= false;
  end
else
If rad1.ItemIndex = 2 then
  begin
  lbl2.caption:= 'From:';
  lbl2.visible:= true;
  lbl3.visible:= false;
  edtFrom.visible:= true;
  edtTo.visible:= false;
  calFrom.visible:= true;
  calTo.visible:= false;
  end
else
If rad1.ItemIndex = 3 then
  begin
  lbl2.caption:= 'From:';
  lbl2.visible:= false;
  lbl3.visible:= true;
  edtFrom.visible:= false;
  edtTo.visible:= true;
  calFrom.visible:= false;
  calTo.visible:= true;
  end
else
If rad1.ItemIndex = 4 then
  begin
  lbl2.caption:= 'From:';
  lbl2.visible:= true;
  lbl3.visible:= true;
  edtFrom.visible:= true;
  edtTo.visible:= true;
  calFrom.visible:= true;
  calTo.visible:= true;
  end;
end;

procedure TformMudsoxViewer.cmdPreviousClick(Sender: TObject);
begin
If lstMatches.ItemIndex > 0 then
   begin
   cmdFullImage.down:=true;
   lstMatches.ItemIndex:= lstMatches.itemindex-1;
   AssignCurrentFile;
   cmdFullImageClick(self);
   CheckButtonStates;
   end;
end;

procedure TformMudsoxViewer.cmdNextClick(Sender: TObject);
begin
If lstMatches.ItemIndex < lstMatches.Items.Count - 1 then
   begin
   cmdFullImage.down:=true;
   lstMatches.ItemIndex:= lstMatches.itemindex+1;
   AssignCurrentFile;
   cmdFullImageClick(self);
   CheckButtonStates;
   end;
end;

procedure TformMudsoxViewer.calFromChange(Sender: TObject);
begin
edtFrom.text:= datetostr(calFrom.date);
end;

procedure TformMudsoxViewer.calToChange(Sender: TObject);
begin
edtTo.text:= datetostr(calTo.date);
end;

procedure TformMudsoxViewer.cmdUnfileClick(Sender: TObject);
var
  vstrFromPath, vstrToPath: string;
  vintItem, vintLoop: integer;
  vstlPictures: tstringlist;
begin
  screen.Cursor:= crHourglass;
  vstlPictures:= tstringlist.create;
  try
  vstlPictures.LoadFromFile(vstrBaseDir + 'ImageList.lst');
  vstrFromPath:= vstrCurrentImage;
  vstrToPath:= vstrBaseDir + '..\Pending_Images\'
                          + vstlMatchImage[lstmatches.itemindex];
  MudsoxCopyFile(vstrFromPath, vstrToPath);
  For vintLoop :=  0 to vstlPictures.count - 1 do
    If pos(vstlMatchImage[lstmatches.itemindex],
                                                vstlPictures[vintLoop]) > 0 then
         begin
         vstlPictures.Delete(vintLoop);
         vstlKeys.Delete(vintLoop);
         vstlDesc.Delete(vintLoop);
         vstlName.Delete(vintLoop);
         break;
         end;
  vstlPictures.SaveToFile(vstrBaseDir + 'ImageList.lst');
  DeleteFile(vstrFromPath);
  vintItem:= lstmatches.itemindex;
  vstlMatchImage.delete(lstmatches.itemindex);
  lstmatches.items.delete(lstmatches.itemindex);
  imgCurrent.Picture:= nil;
  If (lstMatches.items.count > 0) and
      (vintItem <> lstMatches.items.count) then
     begin
     lstMatches.itemindex:= vintItem;
     lstMatchesClick(self);
     end;
  finally
    CheckButtonStates;
    screen.Cursor:=crdefault;
    end;
end;

{Modified Copy file from the FMXUTILS unit the works the way I want it to}
procedure TformMudsoxViewer.MudsoxCopyFile
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
   Source := FileOpen(FileName, fmShareDenyWrite); { open source file }
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

procedure TformMudsoxViewer.cmdThumbnailsClick(Sender: TObject);
var vintLeft, vintTop, vintLoop1, vintMatch: integer;
    vintPictures: longint;
    vstrName: string;
begin
{The thumbs can start at the current image - commented for now}
// vintBaseThumb:= lstmatches.itemindex;
   vintBaseThumb:= 0;
   CheckButtonStates;
   If lstMatches.Items.Count = 0 then
      exit;
// If lstMatches.itemindex = -1 then
   lstMatches.itemindex:=0;
   imgCurrentThumb.Visible:= false;
   imgCurrentThumb.picture:= nil;
   imgCurrent.visible:= false;
   imgCurrent.picture:= nil;
   lstMatches.visible:= false;
   FreeImages;
   vintPictures:= lstMatches.Items.count;
   If vintPictures > 100 then
      vintPictures:= 100;
   vintLeft:= 2;
   vintTop:= 31;
   for vintLoop1 := 1 to vintPictures do
      begin
        varrThumbs[vintLoop1]:= timage.create(nil);
        with varrThumbs[vintLoop1] do
          begin
          parent:= pnlImg;
          name:= 'imgThumb' + inttostr(vintLoop1);
          tag:= vintLoop1 - 1;
          left:=vintLeft;
          top:=vintTop;
          width := 88;
          height:= 65;
          OnDblClick:= imgThumbDoubleClick;
          OnClick:= imgThumbClick;
          vstrName:=vstlMatchImage[vintBaseThumb + (vintLoop1-1)];
          vintMatch:= vstlName.IndexOf(vstrName);
          vstrCurrentImage:= vstrBaseDir + 'img_' +
                           inttostr(varrDirectory[vintMatch]) + '\' +
                           'T' + vstrName;
          FillImageBox(varrThumbs[vintLoop1],
             false,
             width,
             height,
             vstrCurrentImage);
          formMudsoxViewer.update;
          vintLeft := vintLeft + 90;
          If vintLeft > pnlImg.width - 88 then
             begin
             vintLeft := 2;
             vintTop:= vintTop + 66
             end;
          If vintTop > pnlImg.height - 65 then
             break;
          If lstMatches.ItemIndex + vintLoop1 = lstMatches.Items.count then
             break;
          end;
      end;
end;

procedure TformMudsoxViewer.FreeImages;
  var vintLoop: integer;
begin
   for vintLoop:= 1 to 90 do
      begin
      varrThumbs[vintLoop].free;
      varrThumbs[vintLoop]:= nil;
      end;
end;

procedure TformMudsoxViewer.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   If fileexists(vstrBaseDir + 'ImageTotal.lst') then
       SaveFavorites;
   FreeImages;
   vstlName.free;
   vstlKeys.free;
   vstlDesc.free;
   vstlDate.free;
   vstlMatchImage.free;
   vstlAlbumNames.free;
   vstlAlbumDim.free;
   vstlNewImages.free;
   vstlEmailImages.free;
   vstlNewHTML.Free;
   vstlOldHTML.free;
   vbolClosingSystem:= true;
end;

procedure TformMudsoxViewer.imgThumbClick(Sender: TObject);
begin
lstMatches.ItemIndex:= timage(sender).tag + vintBaseThumb;
lstMatchesClick(self);
end;

procedure TformMudsoxViewer.imgThumbDoubleClick(Sender: TObject);
begin
imgThumbClick(Sender);
AssignCurrentFile;
imgCurrentDblClick(self);
end;

procedure TformMudsoxViewer.FormShow(Sender: TObject);
var vintLoop: integer;
begin
  If not fileexists(vstrBaseDir + 'ImageTotal.lst') then
      begin
      Showmessage
             ('This program will only run with a valid Mudsox CD Creator file');
      close;
      exit;
      end;

  vstrLocalPath:=ReadRegistry('Software\Mudsox\Viewer', 'Directory', 'Path');
  If (length(vstrLocalPath) = 0) or not DirectoryExists(vstrLocalPath) then
   begin
   application.Createform(tfrmNew, frmNew);
   try
     frmNew.ShowModal;
     vstrLocalPath:= frmNew.edtDirectory.text;
     finally
     frmNew.Release;
     frmNew:= nil;
     end;
  end;
  If FileExists(vstrLocalPath + '\' + vstrAlbumName) then
     begin
     vstlAlbumNames.LoadFromFile(vstrLocalPath + '\' + vstrAlbumName);
     For vintLoop := 0 to vstlAlbumNames.Count - 1 do
       begin
       vstlAlbumDim.add(copy(vstlAlbumNames[vintLoop],
                             pos('|~', vstlAlbumNames[vintLoop]) + 2,999));
       vstlAlbumNames[vintLoop]:= Copy(vstlAlbumNames[vintLoop],1,
                                  pos('|~', vstlAlbumNames[vintLoop]) -1);
       end;
     end;
end;

procedure TformMudsoxViewer.cmdPrintClick(Sender: TObject);
var vreaRatio: real;
begin
If length(vstrCurrentImage) > 0 then
  begin
   If pnlAlbum.visible then
      ResetSelect;
   application.Createform(tfrmPrint, frmPrint);
   try
     frmPrint.imgQR.picture.loadfromfile(vstrCurrentImage);
     if frmPrint.imgQR.width > frmPrint.qrband1.width then
       begin
       frmPrint.imgQR.Autosize:= false;
       vreaRatio:= frmPrint.qrband1.Width / frmPrint.imgQR.width;
       frmPrint.imgQR.width:= frmPrint.qrband1.Width;
       frmPrint.imgQR.height:=round(frmPrint.imgQR.height * vreaRatio);
       end;
     frmPrint.rptPrint.Preview;
     finally
     frmPrint.Release;
     frmPrint:= nil;
     end;
  end;
end;

procedure TformMudsoxViewer.SaveFavorites;
var vintLoop: integer;
    vstlTemp: tstringlist;
begin
   vstlTemp:= tstringlist.create;
   try
    For vintLoop := 0 to vstlAlbumNames.Count - 1 do
      vstlTemp.add(vstlAlbumNames[vintLoop]+ '|~' + vstlAlbumDim[vintLoop]);
    vstlTemp.savetofile(vstrLocalPath + '\' + vstrAlbumName);
    Finally
      vstlTemp.free;
      end;
end;

procedure TformMudsoxViewer.cmdAlbumClick(Sender: TObject);
var vintLoop, vintPageWork: integer;
begin
If pnlAlbum.visible then
   begin
   pnlAlbum.visible := false;
   ClearImages;
   imgAlbumThumb.picture:= nil;
   pnlBorder.visible:= true;
   pnlCriteria.Visible:= true;
   pnlPicture.visible:= true;
   ResetSelect;
   CheckButtonStates;
   SaveFavorites;
   If cmdFullImage.Down then
        cmdFullImageClick(Self)
   else
   If cmdThumbnails.Down then
        cmdThumbnailsClick(Self);
   cmdSlides.enabled:= true;
   mnuSlideshow.enabled:= true;
   exit;
   end;
cmdAlbum.Down:= true;
cmdSlides.enabled:= false;
mnuSlideshow.enabled:= false;
cmdAlbum.Down:= true;
vbolDouble:= false;
pnlAlbum.visible := true;
pnlAlbum.align:= alclient;
pnlCriteria.Visible:= false;
pnlBorder.visible:= false;
pnlPicture.visible:= false;
MajorDeactivate;
vintCurrentPage:= 1;
lstPages.Items.clear;
lstPages.Items.add(' New Page');
lstPages.Items.add(' Unfiled');
For vintLoop:= 0 to vstlAlbumDim.count - 1 do
   begin
   vintPageWork:= strtoint(copy(vstlAlbumDim[vintLoop], 4, 3));
   If vintPageWork <> 0 then
      If lstPages.items.IndexOf('Page ' +
                                    format('%.3d', [vintPageWork])) = -1 then
         lstPages.items.add('Page ' + format('%.3d', [vintPageWork]));
   end;
vintCurrentPage:= vintMustJump;
vintMustJump:= 0;
DisplayAlbumPage;
end;

Procedure TformMudsoxViewer.ClearImages;
var vintLoop: integer;
begin
vintLoop:= 0;
while vintLoop < pnlAlbum.componentcount do
  begin
  If (pnlAlbum.components[vintLoop] is TImage) and
     (pnlAlbum.components[vintLoop].tag = 100) then
        timage(pnlAlbum.components[vintLoop]).free
  else
    inc(vintLoop);
  end;
end;

Procedure TformMudsoxViewer.DisplayAlbumPage;
var vintLoop, vintTop, vintLeft, vintWidth, vintHeight,
    vintUnfiledTop, vintUnfiledLeft, vintLocation: integer;
    vimgWork: timage;
begin
screen.cursor:= crHourglass;
try
If vintCurrentPage = 0 then
  lstPages.ItemIndex:= 1
else
  lstPages.itemindex:= lstPages.items.IndexOf
                                  ('Page ' + format('%.3d', [vintCurrentPage]));
ClearImages;
vintUnfiledLeft:=1;
vintUnfiledTop:=50;
For vintLoop:= 0 to vstlAlbumDim.count - 1 do
   begin
   If strtoint(copy(vstlAlbumDim[vintLoop], 4,
                   pos('/~T', vstlAlbumDim[vintLoop])-4)) = vintCurrentPage then
       begin
       vintTop:= strtoint(copy(vstlAlbumDim[vintLoop],
                 pos('/~T', vstlAlbumDim[vintLoop]) + 3,
                 pos('/~L', vstlAlbumDim[vintLoop]) -
                        pos('/~T', vstlAlbumDim[vintLoop]) - 3));
       vintLeft:= strtoint(copy(vstlAlbumDim[vintLoop],
                 pos('/~L', vstlAlbumDim[vintLoop]) + 3,
                 pos('/~W', vstlAlbumDim[vintLoop]) -
                        pos('/~L', vstlAlbumDim[vintLoop]) - 3));
       vintWidth:= strtoint(copy(vstlAlbumDim[vintLoop],
                 pos('/~W', vstlAlbumDim[vintLoop]) + 3,
                 pos('/~H', vstlAlbumDim[vintLoop]) -
                        pos('/~W', vstlAlbumDim[vintLoop]) - 3));
       vintHeight:= strtoint(copy(vstlAlbumDim[vintLoop],
                 pos('/~H', vstlAlbumDim[vintLoop]) + 3,
                 pos('/|', vstlAlbumDim[vintLoop]) -
                        pos('/~H', vstlAlbumDim[vintLoop]) - 3));
       If vintTop = 0 then
          begin
          vintTop:= vintUnfiledTop;
          vintLeft:= vintUnfiledLeft;
          vintUnfiledLeft:= vintUnfiledLeft + 20;
          vintUnfiledTop:= vintUnfiledTop + 15;
          vintWidth:= 100;
          vintHeight:= 100;
          end;
       vimgWork:= timage.create(pnlAlbum);
       vimgWork.parent:= pnlAlbum;
       vimgWork.name:= 'i' + copy(vstlAlbumNames[vintLoop],1,
                                          pos('.', vstlAlbumNames[vintLoop])-1);
       vimgWork.tag:= 100;
       vimgWork.left:=vintLeft;
       vimgWork.top:=vintTop;
       vintLocation:= SetCurrentImage(vimgWork);
       vimgWork.Hint:= vstlDate[vintLocation] + #13#10 +
            vstlKeys[vintLocation] + #13#10 +
            vstlDesc[vintLocation];
       vimgWork.OnDblClick:=imgCurrentDblClick;
       vimgWork.OnClick:=imgFavoriteClick;
       vimgWork.OnMouseDown:=imgFavoriteMouseDown;
       vimgWork.OnMouseUp:=imgFavoriteMouseUp;
       vimgWork.OnMouseMove:=imgFavoriteMouseMove;
       vimgWork.ShowHint:= true;
       FillImageBox(vimgWork,
             false,
             vintWidth,
             vintHeight,
             vstrCurrentImage);
       end;
   end;
finally
  screen.cursor:= crDefault;
  end;
end;

function TformMudsoxViewer.SetCurrentImage(vimgWork: timage): integer;
var vintMatch: integer;
begin
vintMatch := vstlName.Indexof(copy(vimgWork.name,2,999) + '.jpg');
vstrCurrentImage:= vstrBaseDir + 'img_' +
                    inttostr(varrDirectory[vintMatch]) +
                    '\' +
                    copy(vimgWork.name,2,999) + '.jpg';
vstrCurrentImageName:= copy(vimgWork.name,2,999) + '.jpg';
result:= vintMatch;
end;

procedure TformMudsoxViewer.imgFavoriteClick(Sender: TObject);
begin
SetCurrentImage(timage(sender));
FillImageBox(imgAlbumThumb,
             false,
             60,
             49,
             vstrCurrentImage);
timage(sender).bringtofront;
end;

procedure TformMudsoxViewer.imgFavoriteMouseMove
                           (Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
If timage(sender).name <> vstrLastFavorite then
   begin
   vstrLastFavorite := timage(sender).name;
   vintoldx:= 0;
   vintoldy:= 0;
   end;
If screen.cursor <> crHandPoint then
  If (x > timage(sender).width - 10) and (y > timage(sender).Height - 10)
   and (x <= timage(sender).width - 2) and (y <= timage(sender).Height - 2) then
   begin
   vbolResize:= true;
   screen.Cursor:= crSizeNWSE;
   end
else
If not vbolDown then
   begin
   vbolResize := false;
   screen.cursor:= crDefault;
   end;
If not vbolDown then exit;
If vintoldx = 0 then vintoldx := x;
If vintoldy = 0 then vintoldy := y;
If vbolResize then
  begin
  timage(sender).width:= x + 5;
  timage(sender).height:= y + 5;
  If timage(sender).Height < 50 then
     timage(sender).height:= 50;
  If timage(sender).Width < 50 then
     timage(sender).Width:= 50;
  end
else
  begin
  timage(sender).left:= timage(sender).left - (vintoldx - x);
  timage(sender).top := timage(sender).top - (vintoldy - y);
  end;
end;

procedure TformMudsoxViewer.imgFavoriteMouseDown(Sender: TObject;
                       Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
If vbolDouble then
   begin
   vbolDouble:= false;
   exit;
   end;
vbolDown:= true;
If Screen.Cursor = crDefault then
   screen.cursor := crHandPoint;
vintoldx:=0;
vintoldy:=0;
end;

procedure TformMudsoxViewer.imgFavoriteMouseUp
     (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var vintWork: integer;
begin
SetCurrentImage(timage(sender));
imgFavoriteClick(sender);
If vbolResize then
   begin
   FillImageBox(timage(sender),
             false,
             timage(sender).Width,
             timage(sender).Height,
             vstrCurrentImage);
   vbolResize:= false;
   end;
vbolDown:= false;
vintWork:= vstlAlbumNames.indexof(copy(timage(sender).name,2,999) + '.jpg');
IF vintWork <> -1 then
   begin
   vstlAlbumDim[vintWork]:=
   '/~P' + format('%.3d', [vintCurrentPage]) +
   '/~T' + inttostr(timage(sender).Top) +
   '/~L' + inttostr(timage(sender).Left) +
   '/~W' + inttostr(timage(sender).Width) +
   '/~H' + inttostr(timage(sender).Height) +
   '/|';
   end;
screen.cursor:= crDefault;
end;

procedure TformMudsoxViewer.cmdAddFavClick(Sender: TObject);
var vintWork: integer;
begin
vintWork:= vstlAlbumNames.IndexOf(vstlName[vintMatch]);
If vintWork <> -1 then
   begin
   vintMustJump:= strtoint(copy(vstlAlbumDim[vintWork], 4, 3));
   ShowMessage('This picture is in the Album already');
   cmdAlbum.down:= true;
   cmdAlbumClick(Self);
   end
else
   begin
   vstlAlbumNames.add(vstlName[vintMatch]);
   vstlAlbumDim.add('/~P000/~T0/~L0/~W0/~H0/|');
   end;
end;

procedure TformMudsoxViewer.ResetSelect;
begin
   vbolDown := false;
   vbolResize:= false;
   Screen.cursor:= crDefault;
   vstrLastFavorite:= '';
end;

procedure TformMudsoxViewer.cmdFavDeleteClick(Sender: TObject);
var vintWork: integer;
begin
vintWork:= vstlAlbumNames.indexof(vstrCurrentImageName);
If vintWork > -1 then
   begin
   vstlAlbumNames.delete(vintWork);
   vstlAlbumDim.delete(vintWork);
   imgAlbumThumb.picture:= nil;
   DisplayAlbumPage;
   end;
end;

procedure TformMudsoxViewer.mnuExitClick(Sender: TObject);
begin
Close;
end;

procedure TformMudsoxViewer.cmdUploadWebClick(Sender: TObject);
var vintLoop: integer;
begin
application.Createform(tfrmHTML, frmHTML);
try
frmHTML.vstrHTMLName:= vstrHTMLName;
frmHTML.vstrLocalPath:= vstrLocalPath;
vstlOldHTML.Clear;
If fileexists(vstrLocalPath + '\' + vstrHTMLName) then
  begin
  frmHTML.lstImagesOLD.items.Loadfromfile
                                       (vstrLocalPath + '\' + vstrHTMLName);
  for vintLoop:= 0 to frmHTML.lstImagesOLD.items.count-1 do
    begin
    vintMatch:= vstlName.IndexOf
                        (extractfilename(frmHTML.lstImagesOLD.items[vintLoop]));
    vstlOldHTML.add(vstlDate[vintMatch] + '||' + vstlDesc[vintMatch] +
                                                  ' of ' + vstlKeys[vintMatch]);
    end;
  end;
frmHTML.edtServer.text:=
                       ReadRegistry('Software\Mudsox\Viewer', 'HTML', 'Server');
frmHTML.edtLogin.Text:= ReadRegistry('Software\Mudsox\Viewer', 'HTML', 'Login');
frmHTML.edtDirectory.Text:=
                    ReadRegistry('Software\Mudsox\Viewer', 'HTML', 'Directory');
frmHTML.ShowModal;
WriteRegistry
           ('Software\Mudsox\Viewer', 'HTML', 'Server', frmHTML.edtServer.text);
WriteRegistry('Software\Mudsox\Viewer', 'HTML', 'Login', frmHTML.edtLogin.Text);
WriteRegistry
     ('Software\Mudsox\Viewer', 'HTML', 'Directory', frmHTML.edtDirectory.Text);
finally
  frmHTML.Release;
  frmHTML:= nil;
  end;
end;

procedure TformMudsoxViewer.cmdHelpClick(Sender: TObject);
begin
  Application.HelpFile := vstrBaseDir + 'MudsoxImageViewer.HLP';
  Application.HelpJump('Main_Index');
end;

procedure TformMudsoxViewer.mnuAboutClick(Sender: TObject);
begin
application.Createform(tfrmAbout, frmAbout);
try
frmAbout.ShowModal;
finally
  frmAbout.Release;
  frmAbout:= nil;
  end; 
end;

procedure TformMudsoxViewer.cmdAddWebClick(Sender: TObject);
var vintwork: integer;
begin
If vstlNewImages.IndexOf(vstrCurrentImage) = -1 then
  begin
  vstlNewImages.Add(vstrCurrentImage);
  vintWork:= vstlName.IndexOf(extractfilename(vstrCurrentImage));
  vstlNewHTML.add(vstlDate[vintWork] + '||' + vstlDesc[vintWork] +
                                                   ' of ' + vstlKeys[vintWork]);
  end;
end;

procedure TformMudsoxViewer.cmdAddEmailClick(Sender: TObject);
begin
If vstlEmailImages.IndexOf(vstrCurrentImage) = -1 then
   vstlEmailImages.Add(vstrCurrentImage);
end;

procedure TformMudsoxViewer.lstPagesClick(Sender: TObject);
begin
imgAlbumThumb.picture:= nil;
If lstPages.items[lstPages.itemindex] = ' New Page' then
  begin
  vintCurrentPage:= 0;
  lstPages.itemindex:= 1;
  end
else
If lstPages.items[lstPages.itemindex] = ' Unfiled' then
  vintCurrentPage:= 0
else
  vintCurrentPage:= strtoint(copy(lstPages.items[lstPages.itemindex], 6, 3));
DisplayAlbumPage;
end;

procedure TformMudsoxViewer.cmdSlidesClick(Sender: TObject);
begin
If vbolSlideDown then
  begin
  CheckButtonStates;
  vbolSlideDown:= false;
  tmrSlides.enabled:= false;
  imgCurrent.visible:= false;
  imgCurrent.picture:= nil;
  exit;
  end
else
  begin
  FreeImages;
  MajorDeactivate;
  cmdAlbum.Enabled:= false;
  mnuAlbum.Enabled:= false;
  vbolSlideDown:= true;
  vintSlides:= 0;
  lstMatches.visible := false;
  imgCurrent.visible:= true;
  tmrSlides.interval:= 100;
  tmrSlides.enabled:= true;
  end;
end;

procedure TformMudsoxViewer.tmrSlidesTimer(Sender: TObject);
  var vintMatch: integer;
begin
If vintSlides = vstlAlbumNames.count then
  begin
  vbolSlideDown:= false;
  tmrSlides.enabled:= false;
  imgCurrent.visible:= false;
  imgCurrent.picture:= nil;
  lstMatches.visible := true;
  CheckButtonStates;
  end
else
  begin
  tmrSlides.interval:= 3000;
  vintMatch := vstlName.Indexof(vstlAlbumNames[vintSlides]);
  vstrCurrentImage:= vstrBaseDir + 'img_' +
                    inttostr(varrDirectory[vintMatch]) +
                    '\' +
                    vstlAlbumNames[vintSlides];
  vstrCurrentImageName:= vstlAlbumNames[vintSlides];
  FillImageBox(imgCurrent,
             false,
             pnlImg.width,
             pnlImg.height,
             vstrCurrentImage);
  inc(vintSlides);
  end;
end;

procedure TformMudsoxViewer.MajorDeactivate;
begin
cmdSearch.enabled:= false;
cmdDescriptions.enabled:= false;
cmdFullImage.enabled := false;
cmdThumbnails.enabled:= false;
cmdAddFav.enabled := false;
cmdAddEmail.enabled := false;
cmdAddWeb.enabled := false;
cmdPrevious.enabled := false;
cmdNext.enabled := false;
cmdUnfile.enabled := false;
cmdUploadWeb.enabled := false;
cmdEmail.enabled:= false;
mnuSearch.enabled:= false;
mnuDescriptions.enabled:= false;
mnuFullImage.enabled := false;
mnuThumbnails.enabled:= false;
mnuAddFav.enabled := false;
mnuPrevious.enabled := false;
mnuNext.enabled := false;
mnuUnfile.enabled := false;
mnuUploadWeb.enabled := false;
mnuEmail.enabled:= false;
end;

procedure TformMudsoxViewer.lstPagesDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
If tcontrol(source).name = 'imgAlbumThumb' then
  begin
  If (y < 3) and (tlistbox(sender).TopIndex > 0) then
     tlistbox(sender).TopIndex:= tlistbox(sender).TopIndex - 1;
  tlistbox(sender).itemindex:= round(int(Y/13)) + tlistbox(sender).TopIndex;
    accept:= true;
  end;
end;

procedure TformMudsoxViewer.lstPagesDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var vintWork, vintWork2: integer;
    vstrWork: string;
begin
  If lstPages.itemindex = -1 then
     exit;
  vintWork:= vstlAlbumNames.indexof(vstrCurrentImageName);
  If lstPages.Items[lstPages.itemindex] = ' Unfiled' then
     vstrWork:= '000'
  else
  If lstPages.Items[lstPages.itemindex] = ' New Page' then
     begin
     try
     vstrWork:= copy(lstPages.Items[lstPages.items.count - 1],6,3);
     vintWork2:= strtoint(vstrWork);
     inc(vintWork2);
     vstrWork:= format('%.3d', [vintWork2]);
     except
       vstrWork:= '001';
       end;
     lstPages.Items.Add('Page ' + vstrWork);
     end
  else
     begin
     try
     vstrWork:= format('%.3d',
                      [strtoint(copy(lstPages.Items[lstPages.itemindex],6,3))]);
     except
       vstrWork:= '001';
       end;
     end;
  vstlAlbumDim[vintWork]:= '/~P' + vstrWork +
          copy(vstlAlbumDim[vintWork], pos('/~T', vstlAlbumDim[vintWork]), 999);
  imgAlbumThumb.picture:= nil;
//  vintCurrentPage:= strtoint(vstrWork);
  DisplayAlbumPage;
end;

procedure TformMudsoxViewer.trvKeywordsClick(Sender: TObject);
begin
If trvKeywords.Selected.HasChildren then
  If trvKeywords.Selected.Expanded then
      trvKeywords.Selected.collapse(true)
  else
      trvKeywords.Selected.expand(false)
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
end;

procedure TformMudsoxViewer.trvKeywordsCollapsed(Sender: TObject;
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

procedure TformMudsoxViewer.lblImageClick(Sender: TObject);
begin
  MudsoxCopyFile(lblImage.caption, 'G:\pictures\'
         + ExtractFileName(lblImage.caption));

end;

end.
