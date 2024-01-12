unit formImportImage;

interface

uses
  fmxutils, SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ExtDlgs, FileCtrl, Buttons, ToolWin, ComCtrls,
  Gauges;

type
  TfrmImportImage = class(TForm)
    pnlTop: TPanel;
    imgMainPicture: TImage;
    lbl_10001: TLabel;
    lbl_10002: TLabel;
    edtDesc: TEdit;
    lbl_10003: TLabel;
    flbPictureList: TFileListBox;
    pnlBack: TPanel;
    pnlBottom: TPanel;
    ToolBar1: TToolBar;
    cmdSave: TSpeedButton;
    cmdCancel: TSpeedButton;
    cmdFromDiskette: TSpeedButton;
    cmdViewDiskette: TSpeedButton;
    cmdViewTemp: TSpeedButton;
    spl1: TSplitter;
    cmdexit: TSpeedButton;
    spl2: TSplitter;
    ggeCopyPictures: TGauge;
    procedure cmdexitClick(Sender: TObject);
    procedure cmdViewDisketteClick(Sender: TObject);
    procedure cmdViewTempClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure imgGenericClick(Sender: TObject);
    procedure cmdFromDisketteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
  private
    procedure ImportFiles;
    { Private declarations }
  public
    { Public declarations }
    vintImageEntity: integer;
    varrImage:         Array[0..19] of TImage;
    varrImagePath:     Array[0..19] of string;
    vintSelectedImage: integer;
  end;

var
  frmImportImage: TfrmImportImage;
implementation

uses procimagesupport, procSharedDatamoduleCalls;
{$R *.DFM}

procedure TfrmImportImage.ImportFiles;
var vintloop:Integer;
    vintleft: Integer;
    vinttop: Integer;
    vstrPath: string;
begin
  {Clear out the current values of the image components}
  For vintLoop := 0 to 19 do
     begin
     varrImage[vintloop].visible := false;
     varrImagePath[vintLoop]:= '';
     end;
  {Set the path based on the selected button - Temp Disk or Diskette}
  If cmdViewTemp.down then
     vstrPath:= vstrLocalApplicationDirectory + '\'
  else
     vstrPath:= 'a:\';
  {Load the avaliable pictures into the arrays for image and path}
  For vintloop := 0 to (flbPictureList.Items.Count - 1) do
  begin
    varrImagePath[vintLoop]:= vstrPath + flbPictureList.Items.Strings[vintloop];
    // find vintleft and vinttop
    vintleft := 4 +(vintloop mod 5) * 90;
    vinttop := 4 + trunc(vintloop/5) * 84;
    //Create Image Box
    with varrImage[vintloop] do
      begin
        Top := vinttop;
        Left := vintleft;
        Name := 'img' + inttostr(vintloop);
        Height := 81;
        Width := 87;
        Parent := pnlBottom;
        OnClick := imgGenericClick;
        tag:= vintLoop;
      end;
    //Fill the image box
    FillImageBox(varrImage[vintloop],
                 false,
                 varrImage[vintloop].width,
                 varrImage[vintloop].Height,
                 varrImagePath[vintLoop]);
    varrImage[vintloop].visible := true;
    Application.ProcessMessages;
    If vintLoop = 19 then
       break;
  end;
end;

procedure TfrmImportImage.cmdexitClick(Sender: TObject);
begin
close;
end;

procedure TfrmImportImage.cmdViewDisketteClick(Sender: TObject);
begin
Screen.Cursor := crHourglass;
flbPictureList.enabled := false;
flbPictureList.mask := 'a:\*.jpg';
flbPictureList.enabled := true;
ImportFiles;
Screen.Cursor := crDefault;
end;

procedure TfrmImportImage.cmdViewTempClick(Sender: TObject);
begin
flbPictureList.enabled := false;
flbPictureList.mask := vstrLocalApplicationDirectory + '\*.jpg';
flbPictureList.enabled := true;
ImportFiles;
end;

procedure TfrmImportImage.FormCreate(Sender: TObject);
var vintLoop: integer;
begin
For vintLoop := 0 to 19 do
   varrImage[vintloop] := TImage.Create(nil);
cmdViewTempClick(self);
end;

procedure TfrmImportImage.imgGenericClick(Sender: TObject);
begin
imgMainPicture.visible:= false;
cmdSave.enabled := false;
{Get the tag off of the image that was clicked}
vintSelectedImage:= TImage(sender).tag;
{If there is no valid image, exit}
If varrImagePath[vintSelectedImage] < ' A' then
    exit;
FillImageBox(imgMainPicture,
             false,
             100,
             70,
             varrImagePath[vintSelectedImage]);
imgMainPicture.visible:= true;
cmdSave.enabled := true;
end;

procedure TfrmImportImage.cmdSaveClick(Sender: TObject);
begin
CreateImageRecord(vintImageEntity,
                  edtDesc.Text,
                  varrImagePath[vintSelectedImage]);
If cmdViewTemp.down then
   deletefile(pchar(varrImagePath[vintSelectedImage]));
Close;
end;

procedure TfrmImportImage.cmdFromDisketteClick(Sender: TObject);
var vintLoop: integer;
begin
{Copy all jpg files from diskette to local disk and display local for speed...}
Screen.Cursor := crHourglass;
flbPictureList.enabled := false;
flbPictureList.mask := 'a:\*.jpg';
flbPictureList.enabled := true;
ggeCopyPictures.maxvalue := flbPictureList.Items.Count - 1;
For vintloop := 0 to (flbPictureList.Items.Count - 1) do
  begin
  fmxutils.Copyfile('a:\' + flbPictureList.Items.Strings[vintloop],
           vstrLocalApplicationDirectory + '\');
  ggeCopyPictures.progress := vintLoop;
  end;
{Show the local table view}
cmdViewTempClick(self);
ggeCopyPictures.progress := 0;
Screen.Cursor := crDefault;
end;

procedure TfrmImportImage.FormClose(Sender: TObject;
  var Action: TCloseAction);
var vintLoop: integer;
begin
For vintLoop := 0 to 19 do
   varrImage[vintloop].free;
end;

procedure TfrmImportImage.cmdCancelClick(Sender: TObject);
begin
Close;
end;

end.
