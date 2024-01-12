unit formMudsoxFullImage;
{Author: Chuck Weindorf
 Description: Display the image in its true size and allow the user to zoom in
 an area and return to full screen size.

 Date: 04/08/2000 - CEW - New
  }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ToolWin, ComCtrls, Buttons;

type
  TfrmFullImage = class(TForm)
    ToolBar1: TToolBar;
    pnlDynamImage: TPanel;
    imgFullImage: TImage;
    cmdExit: TSpeedButton;
    cmdUnZoom: TSpeedButton;
    cmdZoom: TSpeedButton;
    cmdDummy: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure cmdExitClick(Sender: TObject);
    procedure cmdUnZoomClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure cmdZoomClick(Sender: TObject);
    procedure imgFullImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  vbolShow, vbolResize, vbolZoom: boolean;
  public
  vintImgHeight, vintImgWidth: integer;
    { Public declarations }
  end;

var
  frmFullImage: TfrmFullImage;
  
implementation

uses procMudsoxImage;
{$R *.DFM}

procedure TfrmFullImage.FormShow(Sender: TObject);
begin
vbolShow:= true;
frmFullImage.Width := vintImgWidth + 10;
frmFullImage.height := vintImgHeight + 61;
cmdDummy.Width := frmFullImage.Width - 87;
vbolShow:= false;
end;

procedure TfrmFullImage.cmdExitClick(Sender: TObject);
begin
vbolZoom := false;
Close;
end;

procedure TfrmFullImage.cmdUnZoomClick(Sender: TObject);
begin
vbolZoom:= false;
screen.cursor:= crdefault;
FormShow(Self);
imgFullImage.width := vintImgWidth;
imgFullImage.Height := vintImgHeight;
imgFullImage.Left := 1;
imgFullImage.top := 1;
DynamicImageSize(imgFullImage,
                 frmFullImage.Width - 10,
                 frmFullImage.height - 61);
frmFullImage.Windowstate := wsNormal;
end;

{Adjust the image within the panel to match the current panel size after the
screen is resized.  DynamicImageSize retains the aspect ratio}
procedure TfrmFullImage.FormResize(Sender: TObject);
begin
  {Do not do any resizing when the show event is running}
  If vbolShow then exit;
  If vbolResize then exit;
  vbolResize := true;
  {Limit the shrinking of the form to a certain level...}
  If frmFullImage.width < 90 then
     frmFullImage.Width:= 90;
  If frmFullImage.height < 85 then
     frmFullImage.height:= 85;
  {Resize the image to match the current form size.}
  DynamicImageSize(imgFullImage,
                   frmFullImage.Width - 10,
                   frmFullImage.height - 61);
  {Make sure toolbar buttons are still visible on the right margin}
  frmFullImage.Width := imgFullImage.Width + 10;
  frmFullImage.height := imgFullImage.Height + 61;
  imgFullImage.Left := 1;
  imgFullImage.top := 1;
  cmdDummy.Width := frmFullImage.Width - 87;
  vbolResize:= false;
end;

procedure TfrmFullImage.cmdZoomClick(Sender: TObject);
begin
vbolZoom:= true;
screen.cursor:= crHandPoint;
end;

procedure TfrmFullImage.imgFullImageMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
If vbolZoom then
  begin
  imgFullImage.Width := round(imgFullImage.Width * 1.5);
  imgFullImage.Height := round(imgFullImage.Height * 1.5);
  imgFullImage.Left := imgFullImage.Left - round(x/2);
  imgFullImage.top := imgFullImage.top - round(y/2);
  end;
end;

end.
