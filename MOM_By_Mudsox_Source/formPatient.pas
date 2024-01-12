unit formPatient;
{Author:Spencer LaDow
Description: form for use with creating or displaying the information for a
             patient.

Date:8/9/99}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGrids, ExtCtrls, DBCtrls, db,
  ComCtrls, Tabnotbk, Mask, ExtDlgs, jpeg, dataMainDatamodule, Buttons,
  ToolWin, Menus;

type
  TfrmPatient = class(TForm)
    pnlTopGroup: TPanel;
    pnlPatientExtraInfo: TPanel;
    tbrPatient: TToolBar;
    cmdHelp: TSpeedButton;
    spl1: TSplitter;
    cmdSave: TSpeedButton;
    cmdEdit: TSpeedButton;
    cmdexit: TSpeedButton;
    cmdCancel: TSpeedButton;
    mnuPatient: TMainMenu;
    mnuFile: TMenuItem;
    mnuExit: TMenuItem;
    mnuEdit: TMenuItem;
    mnuChange: TMenuItem;
    mnuSave: TMenuItem;
    mnuCancel: TMenuItem;
    mnuHelp: TMenuItem;
    mnuVideo: TMenuItem;
    mnuOnline: TMenuItem;
    spl2: TSplitter;
    cmdNewRecord: TSpeedButton;
    pnlPatientInfo: TPanel;
    pagPatientPersonal: TPageControl;
    tabPersonal: TTabSheet;
    lbl_10001: TLabel;
    edtEntityFirstName: TDBEdit;
    lbl_10002: TLabel;
    edtEntityMiddle: TDBEdit;
    lbl_10003: TLabel;
    edtEntityLastName: TDBEdit;
    lbl_10004: TLabel;
    edtPatientBirth: TDBEdit;
    lbl_10005: TLabel;
    edtPatientAge: TDBEdit;
    lbl_10006: TLabel;
    cboPatientGender: TDBComboBox;
    lbl_10007: TLabel;
    cboPatientMarital: TDBComboBox;
    lbl_10008: TLabel;
    cboPatientRace: TDBComboBox;
    tabFinancial: TTabSheet;
    lbl_10010: TLabel;
    cboInsurance: TDBComboBox;
    lbl_10009: TLabel;
    edtPatientSSN: TDBEdit;
    lbl_10011: TLabel;
    cboNationality: TDBComboBox;
    cmdDeletePatient: TSpeedButton;
    mnuDeletePatient: TMenuItem;
    tabPrograms: TTabSheet;
    cmdAddProgram: TSpeedButton;
    cmdDeleteProgram: TSpeedButton;
    cboProgram: TComboBox;
    grdPrograms: TDBGrid;
    lbl_10012: TLabel;
    edtGroup: TDBEdit;
    lbl_10013: TLabel;
    lbl_10014: TLabel;
    edtRecipient: TDBEdit;
    lbl_10015: TLabel;
    edtInsID: TDBEdit;
    edtCard: TDBEdit;
    cmdNewImage: TSpeedButton;
    cmdHousehold: TSpeedButton;
    lbl_00014: TLabel;
    cboRelationship: TDBComboBox;
    lbl_10017: TLabel;
    cboInsPriority: TDBComboBox;
    cboEmployed: TDBComboBox;
    edtEmployer: TDBEdit;
    cboInsType: TDBComboBox;
    lbl_10018: TLabel;
    lbl_10019: TLabel;
    lbl_10020: TLabel;
    cmdQuickAppt: TSpeedButton;
    cmdBilling: TSpeedButton;
    pagPatientExtraInfo: TPageControl;
    tabPictures: TTabSheet;
    pnlPatientComment: TPanel;
    memPatientComment: TDBMemo;
    pnlPicture: TPanel;
    imgPicture: TImage;
    grdImage: TDBGrid;
    tabAppointments: TTabSheet;
    grdAppointment: TDBGrid;
    tabReminder: TTabSheet;
    grdReminders: TDBGrid;
    tabSurvey: TTabSheet;
    grdSurveys: TDBGrid;
    cmdPatient: TSpeedButton;
    cmdAccounting: TSpeedButton;
    lbl_10021: TLabel;
    cboTobacco: TDBComboBox;
    tabPatientTransfer: TTabSheet;
    cmdTransfer: TSpeedButton;
    lbl_100002: TLabel;
    edtNewHousehold: TEdit;
    lbl_0001: TLabel;
    edtPatientBalance: TDBEdit;
    procedure cmdCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdEditClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure mnuExitClick(Sender: TObject);
    procedure ButtonControl(const cbolOn: boolean);
    procedure cmdexitClick(Sender: TObject);
    procedure grdRemindersDblClick(Sender: TObject);
    procedure pagPatientExtraInfoChange(Sender: TObject);
    procedure cmdNewRecordClick(Sender: TObject);
    procedure grdAppointmentDblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure grdSurveysDblClick(Sender: TObject);
    procedure cmdDeleteProgramClick(Sender: TObject);
    procedure cmdAddProgramClick(Sender: TObject);
    procedure cboProgramChange(Sender: TObject);
    procedure grdImageDblClick(Sender: TObject);
    procedure cmdDeletePatientClick(Sender: TObject);
    procedure cmdImmnuePrintClick(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure imgPictureDblClick(Sender: TObject);
    procedure cmdNewImageClick(Sender: TObject);
    procedure cmdHouseholdClick(Sender: TObject);
    procedure cmdQuickApptClick(Sender: TObject);
    procedure cmdBillingClick(Sender: TObject);
    procedure cmdPatientClick(Sender: TObject);
    procedure cmdAccountingClick(Sender: TObject);
    procedure cmdTransferClick(Sender: TObject);
  private
    dtmMainLocal : tdtmMain;
    vbolApptCalled: boolean;
    vbolReminderCalled: boolean;
    vbolSurveyCalled: boolean;
    vbolAccountingCalled: boolean;
    vbolClosingForm: boolean;
    procedure FindAppointments;
  public
    //variable used to determine wich entity is the current entity
    vintEntityNum: Integer;
    constructor create(Aowner : TComponent); override;
  end;

var
  frmPatient: TfrmPatient;

implementation

uses procSharedDataModuleCalls, formNewSurvey, FormImmunizationQR,
  procImageSupport, formApptSummQR, formPatientQR;

{$R *.DFM}

constructor TfrmPatient.Create(AOwner: TComponent);
var
  vintloop: Integer;
  vtempcomp: TComponent;
begin

  {The type of datamodule is determined by the constant}
  vintDatamoduleInstance := cintEntityPatient;
  vintEntityNum := vintCurrentEntity;
  {Create the datamodule that is within the scope of this form}
  dtmMainLocal := Tdtmmain.create(application);
  DatamoduleCreateEvent(dtmMainLocal);
  {Create all form components and other start-up activities}
  Inherited create(AOwner);
  //fill comboboxes
  FillPickList('PatientMarital',cboPatientMarital.Items);
  FillPickList('PatientGender',cboPatientGender.Items);
  FillPickList('Race',cboPatientRace.Items);
  FillPickList('Insurance',cboInsurance.Items);
  FillPickList('Nationality',cboNationality.Items);
  FillPickList('PatientTobacco',cboTobacco.Items);
  FillPickList('Programs',cboProgram.Items);
  FillPickList('PatientRelationship',cboRelationship.Items);
  FillPickList('PatientInsType',cboInsType.Items);
  FillPickList('PatientEmpORStudent',cboEmployed.Items);
  FillPickList('PatientInsPriority',cboInsPriority.Items);
  {Set all datasources}
  for vintloop:=0 to ComponentCount-1 do
  begin
    vtempcomp:=Components[vintloop];
    AssignDataSources(vtempComp, dtmMainLocal);
  end;
  //set the caption for the form
  Self.Caption := 'Patient: #' +
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
  vintCurrentEntity := 0;
  If vbolNewItem then
    begin
    vbolNewItem := false;
    cmdEditClick(Self);
    end;
  If dtmMainLocal.qryPicture.recordcount > 0 then
    grdImageDblClick(Self);
  vbolClosingForm:= false;
end;

procedure TfrmPatient.cmdCancelClick(Sender: TObject);
begin
  //cancel the information and close
  RollbackDataSets(dtmMainLocal);
  ButtonControl(true);
end;

procedure TfrmPatient.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  vbolClosingForm := true;
  //apply if needed and close the datamodule
  if cmdSave.Enabled then
    cmdSaveClick(Sender);
  {Free the memory from this instance of the datamodule}
  CloseAndFreeFiles(dtmMainLocal);
  CloseThisEntity(vintEntityNum);
  Action := caFree;
end;

procedure TfrmPatient.cmdEditClick(Sender: TObject);
begin
  //set edit on or off
  EditDataSets(dtmMainLocal);
  ButtonControl(false);
end;

procedure TfrmPatient.cmdSaveClick(Sender: TObject);
var vintHoldAge: integer;
    vstrHoldName: string;
begin
  {Calculate the age of the entity based on the birthdate}
  PostEvent(dtmMainLocal.qryPatient);
  vintHoldAge :=
        FindAge(dtmMainLocal.qryPatient.FieldByName('PatientBirth').asdatetime);
  If not vbolClosingForm then
    {EDITS PRIOR TO EXIT CONTAINED HERE}
    If vintHoldAge <>
                dtmMainLocal.qryPatient.FieldByName('PatientAge').asinteger then
      begin
      If vintHoldAge < 0 then
        begin
        MessageDlg('The birthday appears to be incorrect',
              mtError, [mbOK], 0);
        exit;
        end;

      dtmMainLocal.qryPatient.edit;
      dtmMainLocal.qryPatient.FieldByName('PatientAge').asinteger:= vintHoldAge;
      PostEvent(dtmMainLocal.qryPatient);
      end;
  {Combine the individual names into the EntityDescription field}
  PostEvent(dtmMainLocal.qryEntity);
  vstrHoldName := CombineEntityName(
                dtmMainLocal.qryEntity.Fieldbyname('EntityFirstName').asstring,
                dtmMainLocal.qryEntity.Fieldbyname('EntityMiddle').asstring,
                dtmMainLocal.qryEntity.Fieldbyname('EntityLastName').asstring);
  If vstrHoldName <>
           dtmMainLocal.qryEntity.FieldByName('EntityDescription').asstring then
      begin
      dtmMainLocal.qryEntity.edit;
      dtmMainLocal.qryEntity.FieldByName('EntityDescription').asstring:=
                                                                   vstrHoldName;
      PostEvent(dtmMainLocal.qryEntity);
      end;
  ApplyDataSets(dtmMainLocal);
  ButtonControl(true);
end;

procedure TfrmPatient.mnuExitClick(Sender: TObject);
begin
  close;
end;

procedure TfrmPatient.ButtonControl(const cbolOn: boolean);
begin
{On of true turns the edit button on, others off}
If cbolOn then
  begin
  cmdEdit.Enabled:= true;
  mnuChange.Enabled:= true;
  cmdSave.Enabled:= false;
  mnuSave.Enabled:= false;
  cmdDeletePatient.Enabled:= false;
  cmdTransfer.Enabled:= false;
  mnuDeletePatient.Enabled:= false;
  cmdCancel.Enabled:= false;
  mnuCancel.Enabled:= false;
  cmdDeleteProgram.Enabled:= false;
  cmdAddProgram.Enabled:= false;
  cboProgram.Enabled:= false;
  end
else
{Edit button off, others on}
  begin
  cmdEdit.Enabled:= false;
  mnuChange.Enabled:= false;
  cmdSave.Enabled:= true;
  mnuSave.Enabled:= true;
  cmdDeletePatient.Enabled:= true;
  cmdTransfer.Enabled:= true;
  mnuDeletePatient.Enabled:= true;
  cmdCancel.Enabled:= true;
  mnuCancel.Enabled:= true;
  cmdDeleteProgram.Enabled:= true;
  cmdAddProgram.Enabled:= true;
  cboProgram.Enabled:= true;
  end;
If dtmMainLocal.qryProgram.RecordCount = 0 then
  cmdDeleteProgram.Enabled:= false;
end;

procedure TfrmPatient.cmdexitClick(Sender: TObject);
begin
Close;
end;

procedure TfrmPatient.grdRemindersDblClick(Sender: TObject);
var vbolDummy: boolean;
begin
  //open the current patient form
  vbolReminderCalled := true;
  vintCurrentReminder := dtmMainLocal.qryReminder.fieldbyname
                                                   ('reminderTicket').asinteger;
  {This is the sneaky way to cann a routine in a form that created you!}
  vbolDummy := false;
  vfrmMainMenu.onclosequery(Sender, vbolDummy);
end;

procedure TfrmPatient.pagPatientExtraInfoChange(Sender: TObject);
begin
cmdNewRecord.Hint:= '';
If (pagPatientExtraInfo.activepage = tabAppointments) or
   (pagPatientExtraInfo.activepage = tabSurvey) or
   (pagPatientExtraInfo.activepage = tabReminder) then
   begin
   cmdNewRecord.Enabled := true;
   If pagPatientExtraInfo.activepage = tabAppointments then
      cmdNewRecord.Hint := 'New Appointment'
   else
   If pagPatientExtraInfo.activepage = tabSurvey then
      cmdNewRecord.Hint := 'New Survey'
   else
   If pagPatientExtraInfo.activepage = tabReminder then
      cmdNewRecord.Hint := 'New Reminder';
   end
else
   cmdNewRecord.Enabled := false;
If pagPatientExtraInfo.activepage = tabAppointments then
   If dtmMainLocal.qryAppointment = nil then
      FindAppointments;
end;

procedure TfrmPatient.FindAppointments;
begin
      vintCurrentEntity := vintEntityNum;
      CreateSQLList(dtmMainLocal,
                    [cstrSQLAppointment]);
      AssignDataSources(tcomponent(grdAppointment), dtmMainLocal);
      vintCurrentEntity:= 0;
end;

procedure TfrmPatient.cmdNewRecordClick(Sender: TObject);
var vbolDummy: boolean;
begin
{This switch is set to force the new screen to go to Auto-edit mode}
vbolNewItem := true;
vbolDummy := false;
vintCurrentEntity:= dtmMainLocal.qryEntity.fieldbyname('Entity').asinteger;
If (pagPatientExtraInfo.activepage = tabAppointments) then
  begin
  vbolApptCalled := true;
  vintCurrentApptTicket := NewRecord(
                  cintAppointment,
                  dtmMainLocal.qryEntity.fieldbyname('Entity').asinteger,
                  '', 0);
  If vintCurrentApptTicket > 0 then
     vfrmMainMenu.onclosequery(Sender, vbolDummy);
  end
else
If (pagPatientExtraInfo.activepage = tabReminder) then
  begin
  vbolReminderCalled := true;
  vintCurrentReminder := NewRecord(cintReminder,
                 dtmMainLocal.qryEntity.fieldbyname('Entity').asinteger,
                 '', 0);
  If vintCurrentReminder > 0 then
     vfrmMainMenu.onclosequery(Sender, vbolDummy);
  end
else
If (pagPatientExtraInfo.activepage = tabSurvey) then
  begin
  vbolSurveyCalled := true;
  //Give the user a windows to select the Type of Survey
  vstrCurrentSurveyID := '';
  frmNewSurvey := tfrmNewSurvey.Create(nil);
  try
  frmNewSurvey.ShowModal;
    finally
    frmNewSurvey.Free;
    frmNewSurvey := nil;
    end;
  {With the dialog done, check to see that a selction was made in the
  vstrCurrentSurveyID }
  If length(vstrCurrentSurveyID) > 0 then
    begin
    vintCurrentSurvey := NewRecord(cintSurvey,
                         dtmMainLocal.qryEntity.fieldbyname('Entity').asinteger,
                         vstrCurrentSurveyID,
                         vdatCurrentSurveyEdition);
    If vintCurrentSurvey > 0 then
        vfrmMainMenu.onclosequery(Sender, vbolDummy);
    end;
  end;
end;

procedure TfrmPatient.grdAppointmentDblClick(Sender: TObject);
var vbolDummy: boolean;
begin
  cmdSaveClick(self);
  vbolApptCalled := true;
  vintCurrentApptTicket := dtmMainLocal.qryAppointment.fieldbyname
                                                       ('ApptTicket').asinteger;
  vintCurrentEntity := dtmMainLocal.qryEntity.fieldbyname('Entity').asinteger;
  {This is the sneaky way to cann a routine in a form that created you!}
  vbolDummy := false;
  vfrmMainMenu.onclosequery(Sender, vbolDummy);
end;

procedure TfrmPatient.grdSurveysDblClick(Sender: TObject);
var vbolDummy: boolean;
begin
  //open the current patient form
  vbolSurveyCalled := true;
  vintCurrentSurvey := dtmMainLocal.qrySurvey.fieldbyname
                                                     ('SurveyNumber').asinteger;
  vstrCurrentSurveyID := dtmMainLocal.qrySurvey.fieldbyname
                                                          ('SurveyID').asstring;
  vdatCurrentSurveyEdition := dtmMainLocal.qrySurvey.fieldbyname
                                                  ('SurveyEdition').asdatetime;
  {This is the sneaky way to cann a routine in a form that created you!}
  vbolDummy := false;
  vfrmMainMenu.onclosequery(Sender, vbolDummy);
end;

procedure TfrmPatient.FormActivate(Sender: TObject);
begin
{Attempt to refresh the summary grid when returning from certain screens}
If vbolReminderCalled then
  begin
  dtmMainLocal.qryReminder.close;
  dtmMainLocal.qryReminder.open;
  vbolReminderCalled := false;
  end;
{Refresh all tables that may have been updated in the Appointment system}
If vbolApptCalled then
  begin
  dtmMainLocal.qryAppointment.close;
  dtmMainLocal.qryAppointment.open;
  dtmMainLocal.qryReferral.close;
  dtmMainLocal.qryReferral.open;
  dtmMainLocal.qryPatient.close;
  dtmMainLocal.qryPatient.open;
  vbolApptCalled := false;
  end;
{Refresh the survey}
If vbolSurveyCalled then
  begin
  dtmMainLocal.qrySurvey.close;
  dtmMainLocal.qrySurvey.open;
  vbolSurveyCalled := false;
  end;
If vbolAccountingCalled then
  begin
  dtmMainLocal.qryAppointment.close;
  dtmMainLocal.qryAppointment.open;
  dtmMainLocal.qryPatient.close;
  dtmMainLocal.qryPatient.open;
  vbolAccountingCalled := false;
  end;
end;

procedure TfrmPatient.cmdDeleteProgramClick(Sender: TObject);
begin
If dtmMainLocal.qryProgram.RecordCount > 0 then
   dtmMainLocal.qryProgram.Delete;
If dtmMainLocal.qryProgram.RecordCount = 0 then
  cmdDeleteProgram.Enabled:= false;
end;

procedure TfrmPatient.cmdAddProgramClick(Sender: TObject);
begin
dtmMainLocal.qryProgram.Append;
dtmMainLocal.qryProgram.Fieldbyname('Entity').asinteger := vintEntityNum;
dtmMainLocal.qryProgram.Fieldbyname('Program').asstring := 'Select Program';
PostEvent(dtmMainLocal.qryProgram);
cmdDeleteProgram.Enabled:= true;
end;

procedure TfrmPatient.cboProgramChange(Sender: TObject);
begin
If dtmMainLocal.qryProgram.RecordCount > 0 then
   begin
   dtmMainLocal.qryProgram.edit;
   dtmMainLocal.qryProgram.Fieldbyname('Program').asstring := cboProgram.Text;
   PostEvent(dtmMainLocal.qryProgram);
   end
else
   cboProgram.ItemIndex := -1;
end;

procedure TfrmPatient.grdImageDblClick(Sender: TObject);
begin
If dtmMainLocal.qryPicture.recordcount > 0 then
    FillImageBox(imgPicture,
             false,
             166,
             136,
             ExtractImagePath(dtmMainLocal));
end;

procedure TfrmPatient.cmdDeletePatientClick(Sender: TObject);
begin
if MessageDlg('This Patient will be removed permanently. OK?',
    mtWarning, [mbYes, mbCancel], 0) = mrYes then
  begin
  if cmdSave.Enabled then
     begin
     RollbackDataSets(dtmMainLocal);
     ButtonControl(true);
     end;
  DeleteAllEntity(dtmMainLocal.qryEntity.fieldbyname('Entity').asinteger);
  close;
  end;
end;

procedure TfrmPatient.cmdImmnuePrintClick(Sender: TObject);
begin
dtmMainLocal.qryImmunization.First;

{Set the temporary datamodule for use by the quickreport creation events}
vdtmQuickReport := dtmMainLocal;
frmImmunizationQR := tfrmImmunizationQR.Create(nil);
try
  frmImmunizationQR.rptImmunizationQR.Preview;
finally
  frmImmunizationQR.release;
  frmImmunizationQR := nil;
  vdtmQuickReport := nil;
  end;
end;

procedure TfrmPatient.btnPrevClick(Sender: TObject);
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

procedure TfrmPatient.imgPictureDblClick(Sender: TObject);
begin
{Show the full size version of an image}
ViewFullImage(dtmMainLocal);
end;

procedure TfrmPatient.cmdNewImageClick(Sender: TObject);
begin
DisplayImageImport(dtmMainLocal.qryEntity.fieldbyname('Entity').asinteger);
dtmMainLocal.qryPicture.close;
dtmMainLocal.qryPicture.Open;
dtmMainLocal.qryPicture.Last;
grdImageDblClick(Self);
end;

procedure TfrmPatient.cmdHouseholdClick(Sender: TObject);
var vbolDummy: boolean;
begin
  vintCurrentEntity := dtmMainLocal.qryEntity.fieldbyname
                                                  ('EntityHousehold').asinteger;
  {This is the sneaky way to call a routine in a form that created you!}
  vbolDummy := false;
  vfrmMainMenu.onclosequery(Sender, vbolDummy);
end;

procedure TfrmPatient.cmdQuickApptClick(Sender: TObject);
var vbolDummy: boolean;
begin
  NewRecord(cintAppointment,
            dtmMainLocal.qryEntity.fieldbyname('Entity').asinteger,
            'Schedule', 0);
  cmdSaveClick(self);
  vbolSchedulerDisplay:= true;
  vfrmMainMenu.onclosequery(Sender, vbolDummy);
end;

procedure TfrmPatient.cmdBillingClick(Sender: TObject);
begin
  If pagPatientExtraInfo.activepage <> tabAppointments then
       FindAppointments;
  //dtmScheduler.tblEntity.locate('entity',
  //        dtmScheduler.tblAppointmentTicket.fieldByName('Entity').asinteger,[]);
  rptApptSumm := TrptApptSumm.Create(nil);
  rptApptSumm.vintEntity := vintEntityNum;
  rptApptSumm.vdatApptDateTime :=
             dtmMainLocal.qryAppointment.fieldbyname('ApptDateTime').asdatetime;
  rptApptSumm.page.TopMargin:= strtofloat(FillDefault('top_margin'));
  try
    rptApptSumm.print;
  finally
    rptApptSumm.free;
    rptApptSumm := nil;
  end;
end;

procedure TfrmPatient.cmdPatientClick(Sender: TObject);
var vbolDummy: boolean;
begin
  vintCurrentEntity := cintPatSummary + dtmMainLocal.qryEntity.fieldbyname
                                                           ('Entity').asinteger;
  {This is the sneaky way to call a routine in a form that created you!}
  vbolDummy := false;
  vfrmMainMenu.onclosequery(Sender, vbolDummy);
end;


procedure TfrmPatient.cmdAccountingClick(Sender: TObject);
var vbolDummy: boolean;
begin
  cmdSaveClick(self);
  vintCurrentEntity := cintFinance + dtmMainLocal.qryEntity.fieldbyname
                                                           ('Entity').asinteger;
  vbolAccountingCalled:= true;
  {This is the sneaky way to call a routine in a form that created you!}
  vbolDummy := false;
  vfrmMainMenu.onclosequery(Sender, vbolDummy);
end;

procedure TfrmPatient.cmdTransferClick(Sender: TObject);
begin
try
If (strtoint(edtNewHousehold.text) > 99999) and
                                 (strtoint(edtNewHousehold.text) < 150000) then
  begin
  dtmMainLocal.qryEntity.edit;
  dtmMainLocal.qryEntity.fieldbyname('entityhousehold').asinteger :=
                                                 strtoint(edtNewHousehold.text);
  dtmMainLocal.qryEntity.post;
  end
else
  showmessage('The new household number must be between 100000 and 150000');
except
  showmessage('The new household number must be between 100000 and 150000');
  dtmMainLocal.qryEntity.cancel;
  end;
end;

end.
