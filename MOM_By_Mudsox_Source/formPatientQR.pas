unit formPatientQR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, Qrctrls, ExtCtrls, dataMainDataModule;

type
  TfrmPatientQR = class(TForm)
    rptPatient: TQuickRep;
    bndHeader: TQRBand;
    lbl_10001: TQRLabel;
    lbl_10002: TQRSysData;
    bndPatient: TQRBand;
    lbl_10007: TQRLabel;
    lbl_10006: TQRLabel;
    lbl_10004: TQRLabel;
    txtPatientBirth: TQRDBText;
    txtPatientAge: TQRDBText;
    txtPatientGender: TQRDBText;
    lbl_10009: TQRLabel;
    txtPatientNationality: TQRDBText;
    txtPatientRace: TQRDBText;
    lbl_10008: TQRLabel;
    lbl_10005: TQRLabel;
    txtPatientMarital: TQRDBText;
    bndApptData: TQRSubDetail;
    txtApptDateTime: TQRDBText;
    txtApptComplaint: TQRDBText;
    bndLabData: TQRSubDetail;
    txtLabDate: TQRDBText;
    txtLabProcedure: TQRDBText;
    bndLab: TQRGroup;
    lbl_10015: TQRLabel;
    bndDiagData: TQRSubDetail;
    bndDiag: TQRGroup;
    bndMedData: TQRSubDetail;
    bndMed: TQRGroup;
    bndAppt: TQRGroup;
    lbl_10010: TQRLabel;
    bndImmunData: TQRSubDetail;
    bndImmun: TQRGroup;
    bndRefData: TQRSubDetail;
    bndRef: TQRGroup;
    bndRemindData: TQRSubDetail;
    bndRemind: TQRGroup;
    bndSurveyData: TQRSubDetail;
    bndSurvey: TQRGroup;
    lbl_10016: TQRLabel;
    txtPatientAffliction: TQRDBText;
    txtPatientChronicDate: TQRDBText;
    lbl_10019: TQRLabel;
    txtPrescriptionDate: TQRDBText;
    txtPrescription: TQRDBText;
    lbl_10022: TQRLabel;
    txtImmuunizationDate: TQRDBText;
    txtImmunizationType: TQRDBText;
    lbl_10025: TQRLabel;
    txtReferralDate: TQRDBText;
    txtReferralPhysician: TQRDBText;
    lbl_10028: TQRLabel;
    txtRiminderCategory: TQRDBText;
    txtReminderDate: TQRDBText;
    txtReminderActive: TQRDBText;
    lbl_10032: TQRLabel;
    txtSurveyDate: TQRDBText;
    txtSurveyEdition: TQRDBText;
    txtSurveyID: TQRDBText;
    txtEntityDescription: TQRDBText;
    lbl_10011: TQRLabel;
    lbl_10013: TQRLabel;
    lbl_10017: TQRLabel;
    lbl_10020: TQRLabel;
    lbl_10023: TQRLabel;
    lbl_10029: TQRLabel;
    lbl_10033: TQRLabel;
    lbl_10026: TQRLabel;
    lbl_10012: TQRLabel;
    lbl_10014: TQRLabel;
    lbl_10018: TQRLabel;
    lbl_10021: TQRLabel;
    lbl_10024: TQRLabel;
    lbl_10027: TQRLabel;
    lbl_10030: TQRLabel;
    lbl_10031: TQRLabel;
    lbl_10034: TQRLabel;
    lbl_10035: TQRLabel;
    imgLogo1: TQRImage;
    imgLogo2: TQRImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }

  public
    constructor create(Aowner : TComponent); override;
  end;

var
  frmPatientQR: TfrmPatientQR;

implementation

uses procSharedDataModuleCalls;

{$R *.DFM}

constructor TfrmPatientQR.create(AOwner: TComponent);
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
  rptPatient.DataSet := vdtmQuickReport.qryPatient;

  {Assign the tags to datasources.}
  For vintLoop := 0 to ComponentCount - 1 do
     begin
     vcmpComponent := Components[vintLoop];
     If vcmpComponent.tag > 10 then
        begin
        vstrOz := vcmpComponent.name;
        AssignDataSources(vcmpComponent,
                          vdtmQuickReport);
        end;
     end;
end;

procedure TfrmPatientQR.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

end.
