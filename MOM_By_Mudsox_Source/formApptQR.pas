unit formApptQR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, quickrpt, ExtCtrls, dataMainDataModule;

type
  TfrmAppointmentQR = class(TForm)
    rptAppointment: TQuickRep;
    bndHeader: TQRBand;
    bndComplaint: TQRBand;
    lbl_10001: TQRLabel;
    txtEntityDescription: TQRDBText;
    tstApptDateTime: TQRDBText;
    lbl_10003: TQRLabel;
    lbl_10002: TQRSysData;
    lbl_10004: TQRLabel;
    txtApptComplaint: TQRDBText;
    lbl_10005: TQRLabel;
    txtApptComplaintText: TQRDBText;
    bndVitalStats: TQRGroup;
    lbl_10008: TQRLabel;
    lbl_10009: TQRLabel;
    txtApptTemperature: TQRDBText;
    lbl_10010: TQRLabel;
    txtApptHeight: TQRDBText;
    lbl_10011: TQRLabel;
    txtApptWeight: TQRDBText;
    lbl_10014: TQRLabel;
    txtApptPulse: TQRDBText;
    lbl_10012: TQRLabel;
    txtApptBP1: TQRDBText;
    lbl_10013: TQRLabel;
    txtApptBP2: TQRDBText;
    lbl_10016: TQRLabel;
    txtApptRespiration: TQRDBText;
    bndDiagnosis: TQRGroup;
    lbl_10006: TQRLabel;
    lbl_10007: TQRLabel;
    txtApptDiagnosis: TQRDBText;
    txtApptComments: TQRDBText;
    bndChronicData: TQRSubDetail;
    bndChronic: TQRGroup;
    lbl_10017: TQRLabel;
    lbl_10020: TQRDBText;
    txtPatientAffliction: TQRDBText;
    lbl_10021: TQRLabel;
    txtPatientChronicComment: TQRDBText;
    lbl_10019: TQRLabel;
    lbl_10018: TQRLabel;
    bndMedData: TQRSubDetail;
    bndMed: TQRGroup;
    lbl_10023: TQRLabel;
    lbl_10025: TQRLabel;
    lbl_10024: TQRLabel;
    lbl_10026: TQRLabel;
    lbl_10027: TQRLabel;
    lbl_10028: TQRLabel;
    lbl_10030: TQRLabel;
    lbl_10031: TQRLabel;
    lbl_10029: TQRLabel;
    txtPrescriptionDate: TQRDBText;
    txtPrescription: TQRDBText;
    txtPrescriptionDuration: TQRDBText;
    txtprescriptionDScale: TQRDBText;
    txtPrescriptionPeriod: TQRDBText;
    txtPrescriptionScale: TQRDBText;
    txtprescriptionDosage: TQRDBText;
    txtPrescriptionSize: TQRDBText;
    txtPrescriptionGeneric: TQRDBText;
    txtPrescriptionRefills: TQRDBText;
    txtprescriptionApplication: TQRDBText;
    bndImmuData: TQRSubDetail;
    bndImmu: TQRGroup;
    lbl_10032: TQRLabel;
    lbl_10033: TQRLabel;
    lbl_10034: TQRLabel;
    lbl_10035: TQRDBText;
    txtImmunizationType: TQRDBText;
    bndLabData: TQRSubDetail;
    bndLab: TQRGroup;
    lbl_10036: TQRLabel;
    lbl_10037: TQRLabel;
    lbl_10040: TQRLabel;
    lbl_10041: TQRLabel;
    lbl_10038: TQRLabel;
    lbl_10039: TQRLabel;
    txtLabDate: TQRDBText;
    txtLabResults: TQRDBText;
    txtLabComments: TQRDBText;
    txtLabPositive: TQRDBText;
    txtLabProcedure: TQRDBText;
    bndReferralData: TQRSubDetail;
    bndReferral: TQRGroup;
    lbl_10042: TQRLabel;
    lbl_10043: TQRLabel;
    txtReferralDate: TQRDBText;
    lbl_10045: TQRLabel;
    txtReferralReason: TQRDBText;
    lbl_10044: TQRLabel;
    txtReferralPhysician: TQRDBText;
    imgLogo1: TQRImage;
    imgLogo2: TQRImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    constructor create(Aowner : TComponent); override;
  end;

var
  frmAppointmentQR: TfrmAppointmentQR;

implementation

uses procSharedDataModuleCalls;

{$R *.DFM}

constructor TfrmAppointmentQR.create(AOwner: TComponent);
var
  vintloop: Integer;
  vcmpComponent: TComponent;
  vstrOz: string;
begin
  {Create all form components and other start-up activities}

  Inherited create(AOwner);
  //fill images
  imgLogo1.Picture.LoadFromFile(vstrApplicationDirectory +
                                                'Pictures\Mheds_no_border.bmp');
  imgLogo2.Picture.LoadFromFile(vstrApplicationDirectory +
                                               'Pictures\Mheds2_no_border.bmp');
  rptAppointment.DataSet := vdtmQuickReport.qryAppointment;

  {Assign the tags to datasources.}
  For vintLoop := 0 to ComponentCount - 1 do
     begin
     vcmpComponent := Components[vintLoop];
     If vcmpComponent.tag > 10 then
        begin
        vstrOz := vcmpComponent.name;
        AssignDataSources(vcmpComponent, vdtmQuickReport);
        end;
     end;
end;

procedure TfrmAppointmentQR.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

end.
