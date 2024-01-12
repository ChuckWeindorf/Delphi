unit formApptSummQR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls, dbtables,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, dataScheduler,
  procSharedDatamoduleCalls;

type
  TrptApptSumm = class(TQuickRep)
    QRBand1: TQRBand;
    lblPatientNumber: TQRLabel;
    lblPatientName: TQRLabel;
    lblGender: TQRLabel;
    lblBirthdate: TQRLabel;
    lblSSN: TQRLabel;
    lblPhone: TQRLabel;
    lblInsurance: TQRLabel;
    lblID: TQRLabel;
    lblGroup: TQRLabel;
    lblPhysician: TQRLabel;
    lblDate: TQRLabel;
    lblBalance: TQRLabel;
    procedure rptApptSummNeedData(Sender: TObject; var MoreData: Boolean);
  private

  public
  vintEntity, vintHoldHousehold: integer;
  vdatApptDateTime: tdatetime;
  vreaBalance: real;
  end;

var
  rptApptSumm: TrptApptSumm;

implementation

{$R *.DFM}

procedure TrptApptSumm.rptApptSummNeedData(Sender: TObject;
  var MoreData: Boolean);
var vqryTemp: tquery;
begin
{Because this routine is called both from the Patient and Scheduler, I needed
to make all table reads dynamic.  Patient and Scheduler use different
datamodules.}
vqryTemp:= tquery.create(nil);
try
  vqryTemp.requestlive:= false;
  vqryTemp.DatabaseName := 'mmom_maindatabase';
  vqryTemp.UniDirectional:= true;
  {Get the entity table}
  vqryTemp.SQL.Text := 'Select * from Entity where Entity = ' +
                        inttostr(vintEntity);
  vqryTemp.Open;
  If vqryTemp.RecordCount = 1 then
     begin
     lblPatientNumber.caption:= vqryTemp.fieldbyname('Entity').asstring;
     lblPatientName.caption:=
                             vqryTemp.fieldbyname('EntityDescription').asstring;
     {Find Household Head Entity and Physician entity}
     lblPhone.Caption := ' ';
     vintHoldHousehold := vqryTemp.fieldbyname('EntityHousehold').asinteger;
     If vintHoldHousehold > 0 then
       begin
       vqryTemp.close;
       vqryTemp.SQL.Text :=
        'Select PhoneNumber from PhoneNumber where Entity = ' +
           inttostr(vintHoldHousehold)
           + ' and PhoneCategory = "Home"';
       vqryTemp.Open;
       If vqryTemp.RecordCount = 1 then
           lblPhone.caption := vqryTemp.fieldbyname('PhoneNumber').asstring;
       end;
     end;
  vqryTemp.Close;
  {Get the Patient info}
  vqryTemp.SQL.Text := 'Select * from Patient where Entity = ' +
                        inttostr(vintEntity);
  vqryTemp.Open;
  If vqryTemp.RecordCount = 1 then
    begin
    lblBirthdate.caption:=
            vqryTemp.fieldbyname('PatientBirth').asstring;
    lblGender.caption:=
            vqryTemp.fieldbyname('PatientGender').asstring;
    lblSSN.caption:=
            vqryTemp.fieldbyname('PatientSSN').asstring;
    lblInsurance.caption:=
            vqryTemp.fieldbyname('PatientInsurance').asstring;
    lblID.caption:=
            vqryTemp.fieldbyname('PatientInsID').asstring;
    If length(lblID.caption) < 1 then
       lblID.caption:=
          vqryTemp.fieldbyname('PatientMARecipient').asstring;
    lblGroup.caption:=
            vqryTemp.fieldbyname('PatientInsGroup').asstring;
    If length(lblGroup.caption) < 1 then
       lblGroup.caption:=
            vqryTemp.fieldbyname('PatientMACard').asstring;
    lblBalance.caption:=
         Format('%m', [vqryTemp.fieldbyname('PatientBalance').asfloat]);
    end;
  vqryTemp.Close;
  {Get the Household info}
  vqryTemp.SQL.Text := 'Select * from Household where Entity = ' +
                        inttostr(vintHoldHousehold);
  vqryTemp.Open;

  lblPhysician.caption:= '';
  If vqryTemp.RecordCount = 1 then
    begin
    lblPhysician.caption:=
           FindEntityName(vqryTemp.fieldbyname('HouseholdPhysician').asinteger);
    end;

  {Get the phone numbers}
  vqryTemp.Close;
  vqryTemp.SQL.Text := 'Select * from PhoneNumber where Entity = ' +
                        inttostr(vintEntity);
  vqryTemp.Open;
  If vqryTemp.RecordCount = 1 then
    begin
    lblPhone.caption := vqryTemp.fieldbyname('PhoneNumber').asstring;
    end;
  vqryTemp.close;

  lblDate.caption:= datetostr(vdatApptDateTime);

finally
  vqryTemp.free;
  end;
end;

end.
