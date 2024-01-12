unit MudsoxImageTest1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, fmxutils, Consts, filectrl, inifiles;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    procedure MudsoxCopyFile(const FileName, DestName: TFileName);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var vintFileNumber: longint;
    vstrOldName, vstrNewName, vstrdir: string;
begin
vstrOldName:= 'E:\Mudsox Image\Pending_Images\1.jpg';
for vintFileNumber := 9001 to 10000 do
  begin
  vstrdir:= 'E:\Mudsox Image\The Ozzie Family\IMG_' + floattostr(int(vintFileNumber/300+1));
  ForceDirectories(vstrdir);
  vstrNewName:= 'E:\Mudsox Image\The Ozzie Family\IMG_' + floattostr(int(vintFileNumber/300+1))
              + '\9000000' + inttostr(vintFileNumber * 1000) + '.jpg';
  MudsoxCopyFile(vstrOldName, vstrNewName);
  end;
end;

procedure Tform1.MudsoxCopyFile(const FileName, DestName: TFileName);
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

procedure TForm1.Button2Click(Sender: TObject);
var lstImages: tstringlist;
    vintFileNumber: integer;
begin
  screen.Cursor:= crHourglass;
  lstImages:= tstringlist.Create;
  lstImages.loadfromfile('E:\Mudsox Image\The Ozzie Family\ImageList.lst');
  try
  for vintFileNumber := 9001 to 10000 do
    lstImages.add('9000000' + inttostr(vintFileNumber * 1000) + '.jpg=' +
                  floattostr(int(vintFileNumber/300+1)) + '~|' +
                  formatdatetime('mm/dd/yyyy hh:mm:ss ampm dddd', now) +
                  '~|' + 'XXXXXXXXXXXXXXXXXXX Random' + inttostr(random(100)) +
                  '~|' + 'Chuck^|');
  lstImages.savetofile('E:\Mudsox Image\The Ozzie Family\ImageList.lst');
  finally
     lstImages.Free;
     screen.Cursor:=crdefault;
     end;
end;

end.
