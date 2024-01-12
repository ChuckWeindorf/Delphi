unit formSchedule1;
{Author:Chuck Weindorf
Description: Show the daily schedule for a single Physician

Date:10/27/00}

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TrptSchedule1 = class(TQuickRep)
    bndTitle: TQRBand;
    imgLogo2: TQRImage;
    imgLogo1: TQRImage;
    lbl_10007: TQRLabel;
    lbl_100008: TQRLabel;
    bndDetails: TQRSubDetail;
    lbl_00001: TQRLabel;
    lbl_00006: TQRLabel;
    lbl_00007: TQRLabel;
    lbl_100009: TQRLabel;
    lbl_ApptTime: TQRDBText;
    lbl_100001: TQRLabel;
    lbl_Patient1: TQRLabel;
    lbl_PatientDesc1: TQRLabel;
    lbl_Complaint1: TQRLabel;
    lbl_PatientDesc2: TQRLabel;
    lbl_Complaint2: TQRLabel;
    lbl_Patient2: TQRLabel;
    lbl_PatientDesc3: TQRLabel;
    lbl_Complaint3: TQRLabel;
    lbl_Patient3: TQRLabel;
    procedure bndDetailsBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    vintDuration: integer;

  public
    constructor create(Aowner : TComponent); override;

  end;

var
  rptSchedule1: TrptSchedule1;

implementation

uses procSharedDatamoduleCalls, dataScheduler;

{$R *.DFM}
constructor TrptSchedule1.Create(AOwner: TComponent);
begin
  {Create all form components and other start-up activities}
  Inherited create(AOwner);
  imgLogo1.Picture.LoadFromFile(vstrApplicationDirectory +
                                                'Pictures\Mheds_no_border.bmp');
  imgLogo2.Picture.LoadFromFile(vstrApplicationDirectory +
                                               'Pictures\Mheds2_no_border.bmp');
end;

procedure TrptSchedule1.bndDetailsBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var vreaDateTime: tdatetime;
begin
bndDetails.Height:= 15;
vreaDateTime:= strtodate(lbl_100008.caption) +
               vqryQuickReport.fieldbyname('ApptTime').asdatetime;
lbl_Patient1.caption := '';
lbl_PatientDesc1.caption := '';
lbl_Complaint1.caption := '';
lbl_Patient2.caption := '';
lbl_PatientDesc2.caption := '';
lbl_Complaint2.caption := '';
lbl_Patient3.caption := '';
lbl_PatientDesc3.caption := '';
lbl_Complaint3.caption := '';
If vintDuration > 0 then
   begin
   vintDuration:= vintDuration - 1;
   lbl_ApptTime.color:= clSilver;
   lbl_Patient1.color:= clSilver;
   lbl_PatientDesc1.color:= clSilver;
   lbl_Complaint1.color:= clSilver;
   lbl_Patient2.color:= clSilver;
   lbl_PatientDesc2.color:= clSilver;
   lbl_Complaint2.color:= clSilver;
   lbl_Patient3.color:= clSilver;
   lbl_PatientDesc3.color:= clSilver;
   lbl_Complaint3.color:= clSilver;
   end
else
   begin
   lbl_ApptTime.color:= clWhite;
   lbl_Patient1.color:= clWhite;
   lbl_PatientDesc1.color:= clWhite;
   lbl_Complaint1.color:= clWhite;
   lbl_Patient2.color:= clWhite;
   lbl_PatientDesc2.color:= clWhite;
   lbl_Complaint2.color:= clWhite;
   lbl_Patient3.color:= clWhite;
   lbl_PatientDesc3.color:= clWhite;
   lbl_Complaint3.color:= clWhite;
   If vqryQuickReport2.locate('ApptDateTime',vreaDateTime,[]) then
      begin
      try
      vintDuration:=
      round((vqryQuickReport2.fieldbyName('ApptDuration').asinteger - 15) / 15);
        except
        vintDuration:=0;
        end;
      {Printable caption up to triple-schadule}
      lbl_Patient1.caption :=
                     vqryQuickReport2.fieldbyname('Patient').asstring;
      lbl_PatientDesc1.caption :=
                     vqryQuickReport2.fieldbyname('EntityDescription').asstring;
      lbl_Complaint1.caption :=
                     vqryQuickReport2.fieldbyname('ApptComplaint').asstring;
      vqryQuickReport2.Next;
      If not vqryQuickReport2.Eof then
         begin
         If vqryQuickReport2.fieldbyname('ApptDateTime').asdatetime =
                                                               vreaDateTime then
            begin
            lbl_Patient2.caption :=
                     vqryQuickReport2.fieldbyname('Patient').asstring;
            lbl_PatientDesc2.caption :=
                     vqryQuickReport2.fieldbyname('EntityDescription').asstring;
            lbl_Complaint2.caption :=
                     vqryQuickReport2.fieldbyname('ApptComplaint').asstring;
            bndDetails.Height:= 30;
            end;
         vqryQuickReport2.Next;
         If not vqryQuickReport2.Eof then
            begin
            If vqryQuickReport2.fieldbyname('ApptDateTime').asdatetime =
                                                               vreaDateTime then
               begin
               lbl_Patient3.caption :=
                     vqryQuickReport2.fieldbyname('Patient').asstring;
               lbl_PatientDesc3.caption :=
                     vqryQuickReport2.fieldbyname('EntityDescription').asstring;
               lbl_Complaint3.caption :=
                     vqryQuickReport2.fieldbyname('ApptComplaint').asstring;
               bndDetails.Height:= 45;
               end;
            end;
         end;
      end;
   end;
end;

end.
