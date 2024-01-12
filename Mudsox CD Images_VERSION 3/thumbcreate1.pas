unit thumbcreate1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Buttons, ToolWin, ComCtrls, Grids, StdCtrls, Mask,
  Menus, filectrl, procMudsoxImage, fmxutils, Consts,
  jpeg;

type
  TForm1 = class(TForm)
    vlstAfiles: TFileListBox;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  vstrimpdir: string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
  var vintloop: integer;
    vimgJPEGbig: tJPEGImage;
    vimgBMP: tBitmap;
    vdatFileDateTime: tdatetime;
    vsrcSearchRec: TSearchRec;
begin
 For vintloop := 0 to (vlstAfiles.Items.Count - 1) do
  begin
  vdatFileDateTime:= FileDateTime
                              (vstrImpDir + vlstAfiles.Items.Strings[vintloop]);
  vimgJPEGBIG:= tjpegImage.create;
  vimgBMP:= tBitmap.create;
  try
  vimgJPEGBIG.LoadFromFile(vstrImpDir + vlstAfiles.Items.Strings[vintloop]);
  vimgBMP.assign(vimgJPEGBIG);
  FindFirst(vstrImpDir + vlstAfiles.Items.Strings[vintloop],
            faAnyFile,
            vsrcSearchRec);
  CreateThumb(vimgJPEGBIG,
      vdatFileDateTime,
      vstrImpDir + 'T' + vlstAfiles.Items.Strings[vintloop],vsrcSearchRec.Size);
  FindClose(vsrcSearchRec);
   finally
    vimgJPEGBIG.Free;
    vimgBMP.Free;
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
vstrImpDir:= 'g:\mudsox\the ozzie family\img_4\';
vlstAfiles.directory:= vstrImpDir;
end;

end.
