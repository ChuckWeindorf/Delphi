unit formPatientHistory;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, ComCtrls, ExtCtrls, Buttons, ToolWin, dataMainDatamodule;

type
  TfrmPatientHistory = class(TForm)
    tbrPatient: TToolBar;
    spl1: TSplitter;
    btnPrev: TSpeedButton;
    cmdexit: TSpeedButton;
    cmdVideo: TSpeedButton;
    cmdHelp: TSpeedButton;
    pnlTopGroup: TPanel;
    pnlPatientExtraInfo: TPanel;
    pagPatientExtraInfo: TPageControl;
    tabAppointments: TTabSheet;
    grdAppointment: TDBGrid;
    tabLab: TTabSheet;
    grdLab: TDBGrid;
    tabCronic: TTabSheet;
    grdPatientCronic: TDBGrid;
    tabMedication: TTabSheet;
    grdPrescription: TDBGrid;
    tabImmunization: TTabSheet;
    grdImmunization: TDBGrid;
    ToolBar1: TToolBar;
    splI1: TSplitter;
    cmdImmnuePrint: TSpeedButton;
    tabReferal: TTabSheet;
    grdReferrals: TDBGrid;
    procedure btnPrevClick(Sender: TObject);
    procedure cmdexitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    dtmMainLocal : tdtmMain;
  public
    { Public declarations }
    vintCurrentPatient: integer;
    constructor create(Aowner : TComponent); override;
  end;

var
  frmPatientHistory: TfrmPatientHistory;

implementation
uses procSharedDataModuleCalls, formPatientQR;
{$R *.DFM}

constructor TfrmPatientHistory.Create(AOwner: TComponent);
var
  vintloop: Integer;
  vtempcomp: TComponent;
begin

  {The type of datamodule is determined by the constant}
  vintDatamoduleInstance := cintEntityPatHistory;
  {Create the datamodule that is within the scope of this form}
  dtmMainLocal := Tdtmmain.create(application);
  DatamoduleCreateEvent(dtmMainLocal);
  {Create all form components and other start-up activities}
  Inherited create(AOwner);
  {Set all datasources}
  for vintloop:=0 to ComponentCount-1 do
  begin
    vtempcomp:=Components[vintloop];
    AssignDataSources(vtempComp, dtmMainLocal);
  end;
  //set the caption for the form
  Self.Caption := 'Patient History: #' +
         dtmMainLocal.qryEntity.fieldbyname('Entity').asstring + '=' +
         dtmMainLocal.qryEntity.fieldbyname('EntityDescription').asstring;
  {In order to make this linking of patient information easier,
  create a Patient record if there is not one.  This is a direct match to the
  Entity record.}
  If dtmMainLocal.qryPatient.RecordCount = 0 then
     begin
     dtmMainLocal.qryPatient.Append;
     dtmMainLocal.qryPatient.Fieldbyname('Entity').asinteger :=
                             vintCurrentEntity;
     PostEvent(dtmMainLocal.qryPatient);
     end;
  {Create an edit mask for 2 digit numeric}
  dtmMainLocal.qryPatient.FieldByName('PatientMACard').editmask:='00';
end;

procedure TfrmPatientHistory.btnPrevClick(Sender: TObject);
begin
  vdtmQuickReport := dtmMainLocal;
  frmPatientQR := tfrmPatientQR.Create(nil);
  try
    frmPatientQR.rptPatient.Preview;
  finally
    frmPatientQR.release;
    frmPatientQR := nil;
    vdtmQuickReport := nil;
  end;
end;

procedure TfrmPatientHistory.cmdexitClick(Sender: TObject);
begin
Close;
end;

procedure TfrmPatientHistory.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CloseThisEntity(cintPatSummary + vintCurrentPatient);
  Action := caFree;
end;

end.
