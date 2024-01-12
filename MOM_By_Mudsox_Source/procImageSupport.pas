unit procImageSupport;
{Author: Chuck Weindorf
 Description: Support the imaging functions including the creation, display,
 indexing and storage of the pictures.

 Date: 03/11/2000 - CEW - New
  }

interface
uses {VCL based uses for maniplulating components}
     Sysutils, ExtCtrls, JPEG, Filectrl, Windows, dbtables, forms,
     {MMoM units required}
     dataMainDatamodule, procSharedDatamoduleCalls,
         formImportImage, formFullImage;

{Imaging - Adjust the size of a picture to the visual component limits but
retain the aspect ratio}
function FillImageBox(var imgLocalImage: Timage;
                      const cbolFullSize: boolean;
                      const cintMaxWidth: integer;
                      const cintMaxHeight: integer;
                      const cstrPath:string): boolean;
Procedure DynamicImageSize(var imgLocalImage: Timage;
                      const cintMaxWidth: integer;
                      const cintMaxHeight: integer);

{Each year and month combination start a new directory.  Check to create a new
combination if needed.  Use the current date to generate the check}
function ImageDirectoryCheck: boolean;
{Obtain and copy the actual picture to a permanent name and disk area.  Create
the Pictures table record linked to entity}
function CreateImageRecord(const cintEntity: integer;
                           const cstrDescription: string;
                           const cstrFromPath: string): boolean;
{Display the import form }
Procedure DisplayImageImport(const cintEntity: integer);
{View the image at full size }
Procedure ViewFullImage(var vdtmMainLocal: tdtmMain);

implementation
  var
  vstrImgMonth: string[2];
  vstrImgYear:  string[4];

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

{Before storing an image, make sure the directory combination exists.
The images are stored by year and month and use the current date to verify
or create the directories}
function ImageDirectoryCheck: boolean;
begin
Result := false;
try
{Get both the month and year in the correct format: month with leading zeros and
year with centurty}
vstrImgMonth:= formatdatetime('mm', now);
vstrImgYear := formatdatetime('yyyy', now);
{Check both the year and month directories in the Pictures folder}
If (not DirectoryExists(vstrApplicationDirectory + '\pictures\'
                                                              + vstrImgYear)) or
   (not DirectoryExists(vstrApplicationDirectory + '\pictures\'
                                       + vstrImgYear + '\' + vstrImgMonth)) then
   {One of the directories does not exist so force the creation of the complete
   path to store the image}
   ForceDirectories(vstrApplicationDirectory + '\pictures\'
                                           + vstrImgYear + '\' + vstrImgMonth);
except
  exit;
  end;
{Function OK - no errors}
Result := true;
end;

{Once the image is selected from the list of images, store it in the next
available image value in the database and copy the image to the new name in
the pictures images}
function CreateImageRecord(const cintEntity: integer;
                           const cstrDescription: string;
                           const cstrFromPath: string): boolean;
var vstrToPath: string;
    vintNewImage: LongInt;
    vqryNew, vqryMax: tQuery;
begin
Result := false;
ImageDirectoryCheck;
vqryNew:= tQuery.Create(nil);
vqryNew.databasename := 'mmom_MainDatabase';
vqryNew.UniDirectional := false;
vqryNew.RequestLive := true;
{For speed, limit the range returned from the entire table}
vqryNew.SQL.text := 'Select * from Picture where Entity < 1';
{Find the highest number...}
vqryMax:= tQuery.Create(nil);
vqryMax.databasename := 'mmom_MainDatabase';
vqryMax.UniDirectional := true;
vqryMax.RequestLive := false;
vqryMax.SQL.text := 'SELECT MAX(PictureID) as PictureID From Picture';
try
vqryMax.Open;
If vqryMax.fieldbyName('PictureID').asinteger = 0 then
   vintNewImage:= cintPicture
else
   vintNewImage:= vqryMax.fieldbyName('PictureID').asinteger + 1;
vqryMax.Close;
{Based on the new name, copy the file from the temporary media.}
vstrToPath := vstrApplicationDirectory + 'Pictures\' + vstrImgYear + '\'
              + vstrImgMonth + '\' + inttostr(vintNewImage) + '.jpg';
CopyFile(pchar(cstrFromPath), pchar(vstrToPath), false {overwrite the file});
{Add the record to the Pictures table}
vqryNew.Open;
vqryNew.Insert;
vqryNew.fieldbyname('Entity').asinteger := cintEntity;
vqryNew.fieldbyname('PictureDateTime').asdatetime := now;
vqryNew.fieldbyname('PictureDescription').asstring := cstrDescription;
vqryNew.fieldbyname('PictureVolume').asstring := vstrImgYear + vstrImgMonth;
vqryNew.fieldbyname('PictureID').asinteger := vintNewImage;

vqryNew.post;
vqryNew.close;

finally
  vqryNew.free;
  vqryMax.Free;
  end;
end;

{This form allows a user to import an image and link it to the Pictures table}
Procedure DisplayImageImport(const cintEntity: integer);
begin
application.Createform(tfrmImportImage, frmImportImage);
try
frmImportImage.vintImageEntity := cintEntity;
frmImportImage.lbl_10003.caption := FindEntityName(cintEntity);
frmImportImage.ShowModal;
finally
  frmImportImage.Release;
  frmImportImage:= nil;
  end;
end;

{This form allows a user to import an image and link it to the Pictures table}
Procedure ViewFullImage(var vdtmMainLocal: tdtmMain);
begin
application.Createform(tfrmFullImage, frmFullImage);
try
frmFullImage.caption :=
vdtmMainLocal.qryPicture.fieldbyname('PictureDescription').asstring;
FillImageBox(frmFullImage.imgFullImage,
                      true, {Full size image...} 0, 0,
                      ExtractImagePath(vdtmMainLocal));
frmFullImage.vintImgWidth:= frmFullImage.imgFullImage.Width;
frmFullImage.vintImgHeight:= frmFullImage.imgFullImage.Height;
frmFullImage.ShowModal;
finally
  frmFullImage.Release;
  frmFullImage:= nil;
  end;
end;


end.
