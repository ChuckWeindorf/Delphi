unit procMudsoxImage;
{Author: Chuck Weindorf
 Description: Support the imaging functions for dynamic sizing of JPG.

 Date: 07/11/2000 - CEW - New
  }

interface
uses {VCL based uses for maniplulating components}
  Windows, SysUtils, Classes, Graphics, Forms,
  ExtCtrls, filectrl, dbtables, jpeg, fmxutils;

function FillImageBox(var imgLocalImage: Timage;
                      const cbolFullSize: boolean;
                      const cintMaxWidth: integer;
                      const cintMaxHeight: integer;
                      const cstrPath:string): boolean;
Procedure DynamicImageSize(var imgLocalImage: Timage;
                      const cintMaxWidth: integer;
                      const cintMaxHeight: integer);
procedure RotateImage(const vstrFileName: string);
procedure CreateThumb(vimgJPEG: Tjpegimage;
                      const cdatSave: tdatetime;
                      const cstrNewName: string;
                      vintSize: integer);
CONST
  MaxPixelCount = 8388608;

TYPE
  TRGBTripleArray = ARRAY[0..MaxPixelCount-1] OF TRGBTriple;
  pRGBTripleArray = ^TRGBTripleArray;

implementation

{------------------------------IMAGING-------------------------------}
{Place the current image in the database to the image box with the maximum
dimensions placed in the constants}
function FillImageBox(var imgLocalImage: Timage;
                       const cbolFullSize: boolean;
                       const cintMaxWidth: integer;
                       const cintMaxHeight: integer;
                       const cstrPath: string): boolean;
begin
   Result := false;
   {If there are no image records, exit}
  {Make the image invisible while the maniplulation takes place.}
  imgLocalImage.visible := false;
  {Do not allow stretch so the aspect ration of the image remains in place}
  imgLocalImage.Stretch := false;
  {Allow autosize to figure out the initial load size of the image}
  imgLocalImage.Autosize := true;
  {Protect against a possible crash when accessing the picture on the disk}
  try
    If FileExists(cstrPath) then
       imgLocalImage.Picture.LoadFromFile(cstrPath)
    else
       exit;
    except
      exit;
    end;
  {If the image is not to be restricted to a small window, bypass the last
  portion of this routine that does the compacting of the image}
  If cbolFullSize then
      begin
      imgLocalImage.visible := true;
      Result := true;
      exit;
      end;
  DynamicImageSize(imgLocalImage, cintMaxWidth, cintMaxHeight);
  {Make the image visible once more}
  imgLocalImage.visible := true;
  Result := true;
end;

{Retain the aspect ratio of the image no matter what we do to the dimensions
of the parent form}
Procedure DynamicImageSize(var imgLocalImage: Timage;
                      const cintMaxWidth: integer;
                      const cintMaxHeight: integer);
  {The variable stores the ratio between height and width of the original
   JPG image}
  var vreaFactor: real;
begin
If imgLocalImage.height = 0 then exit;
  {Calculate the ration based on the Autosize load}
  vreaFactor := imgLocalImage.width / imgLocalImage.height;
  {Shut off autosize}
  imgLocalImage.Autosize := false;
  {Allow stretch to size the JPG image}
  imgLocalImage.Stretch := true;
  {Set the width to maximum of the image box}
  imgLocalImage.Width := cintMaxWidth;
  {Adjust the height to keep the proportion of the image}
  imgLocalImage.Height := strtoint(floattostr(int(cintMaxWidth / vreaFactor)));
  {If the height is beyond the limit of the maximum, adjust it}
  If imgLocalImage.Height > cintMaxHeight then
   begin
   {Set the height of the image to the max}
   imgLocalImage.Height := cintMaxHeight;
   {Adjust the width down to the appropriate size to keep the proportion}
   imgLocalImage.Width := strtoint(floattostr(int(cintMaxHeight * vreaFactor)));
   end;
end;

procedure RotateImage(const vstrFileName: string);
var vintloop, vintLoop2: integer;
    vrgbRowOld, vrgbRowNew : pRGBTRipleArray;
    vjpgOld, vjpgNew: Tjpegimage;
    vbmpOld, vbmpNew: TBitmap;
    vfilDest: integer;
    vdatFileDateTime: tdatetime;
begin
  vdatFileDateTime:= FileDateTime(vstrFileName);
  vjpgOld:= tjpegImage.create;
  vjpgNew:= tjpegImage.create;
  vbmpOld:= tBitmap.create;
  vbmpNew:= tBitmap.create;
  vjpgNew.CompressionQuality:= 90;

  try
  vjpgOld.LoadFromFile(vstrFileName);
  vbmpOld.assign(vjpgOld);
  vbmpOld.PixelFormat := pf24bit;
  vbmpNew.height := vbmpOld.width;
  vbmpNew.width := vbmpOld.height;
  vbmpNew.PixelFormat := pf24bit;

  for vintloop:= 0 to vbmpOld.Height - 1 do
    begin
    vrgbRowOld:= vbmpOld.scanline[vintLoop];
    for vintLoop2 := 0 to vbmpOld.Width - 1 do
        begin
         vrgbRowNew:= vbmpNew.scanline[vintLoop2];
         vrgbRowNew[vbmpOld.Height-1-vintLoop]:= vrgbRowOld[vintLoop2];
        end;
    end;
   vjpgNew.assign(vbmpNew);
   vjpgNew.Savetofile(vstrFileName);
   finally
     vjpgOld.free;
     vjpgNew.free;
     vbmpOld.free;
     vbmpNew.free;
     end;
  vfilDest:= FileOpen(vstrFileName, fmOpenWrite);
  FileSetDate(vfilDest, DateTimeToFileDate(vdatFileDateTime));
  FileClose(vfilDest); { close the destination file }
end;

procedure CreateThumb(vimgJPEG: TJPEGIMAGE;
                      const cdatSave: tdatetime;
                      const cstrNewName: string;
                      vintSize: integer);
var
  vimgJPEGThumb: tJPEGImage;
  vimgBMP: tbitmap;
  vfilDest: integer;
  vintCompression: integer;
begin
  vimgJPEGThumb:= tjpegImage.create;
  vimgBMP:= tBitmap.create;
  try
    vimgJPEG.scale:= jsQuarter;
    vimgBMP.assign(vimgJPEG);
    vimgJPEGThumb.assign(vimgBMP);
    vintCompression:= 100;
    vintCompression:=round(vintCompression *((5000000 - vintSize)/5000000));
    If vintCompression < 1 then
       vintCompression:= 1;
    vimgJPEGThumb.CompressionQuality:= vintCompression;
    vimgJPEGThumb.Compress;
    vimgJPEGThumb.SaveToFile(cstrNewName);
    vfilDest:= FileOpen(cstrNewName, fmOpenWrite);
    FileSetDate(vfilDest, DateTimeToFileDate(cdatSave));
    FileClose(vfilDest);
    finally
    vimgJPEGThumb.free;
    vimgBMP.free;
    end;
end;


end.
