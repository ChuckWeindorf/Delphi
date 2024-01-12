unit formAppointment;
{Author: Spencer LaDow
 Description:
 Date: xx/xx/xxxx - SCL - New
  }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, Buttons, ToolWin, ComCtrls, Mask, DBCtrls, StdCtrls,
  procSharedDataModuleCalls, dataMainDataModule, Grids, DBGrids, dbtables, db;

type
  TfrmAppointment = class(TForm)
    tbrAppointment: TToolBar;
    cmdEdit: TSpeedButton;
    cmdSave: TSpeedButton;
    spl1: TSplitter;
    cmdHelp: TSpeedButton;
    cmdVideo: TSpeedButton;
    mnuAppointment: TMainMenu;
    mnuFile: TMenuItem;
    mnuExit: TMenuItem;
    mnuHelp: TMenuItem;
    pnlApptDate: TPanel;
    lbl_10001: TLabel;
    edtApptDate: TDBEdit;
    pagAppt: TPageControl;
    tabComplaint: TTabSheet;
    tabDiagnosis: TTabSheet;
    tabPrescription: TTabSheet;
    tabApptInfo: TTabSheet;
    tabImmunization: TTabSheet;
    tabLabWork: TTabSheet;
    mnuVideo: TMenuItem;
    mnuOnline: TMenuItem;
    cmdCancel: TSpeedButton;
    cmdexit: TSpeedButton;
    mnuEdit: TMenuItem;
    mnuChange: TMenuItem;
    mnuSave: TMenuItem;
    mnuCancel: TMenuItem;
    spl2: TSplitter;
    tabChronic: TTabSheet;
    tabReferral: TTabSheet;
    grdReferral: TDBGrid;
    lbl_10020: TLabel;
    cboReferralPhysician: TDBComboBox;
    lbl_10021: TLabel;
    edtReferralDate: TDBEdit;
    lbl_10022: TLabel;
    edtReferralReason: TDBEdit;
    grdAfflictions: TDBGrid;
    lbl_10033: TLabel;
    cboAffliction: TDBComboBox;
    lbl_10034: TLabel;
    edtChronicDate: TDBEdit;
    lbl_10035: TLabel;
    lbl_10002: TLabel;
    edtComplaint: TDBEdit;
    lbl_10003: TLabel;
    memApptComplaintText: TDBMemo;
    lbl_10006: TLabel;
    edtApptTemp: TDBEdit;
    lbl_10007: TLabel;
    edtApptHeight: TDBEdit;
    lbl_10009: TLabel;
    edtApptWeight: TDBEdit;
    lbl_10010: TLabel;
    edtApptPulse: TDBEdit;
    lbl_10011: TLabel;
    edtApptBP1: TDBEdit;
    lbl_10012: TLabel;
    edtApptBP2: TDBEdit;
    lbl_10013: TLabel;
    edtApptRespiration: TDBEdit;
    lbl_10004: TLabel;
    lbl_10005: TLabel;
    memApptComents: TDBMemo;
    grdPrescription: TDBGrid;
    lbl_10014: TLabel;
    cboPrescription: TDBComboBox;
    lbl_10015: TLabel;
    edtPrescriptionDate: TDBEdit;
    lbl_10016: TLabel;
    edtPrescriptionDosage: TDBEdit;
    cboPrescriptionSize: TDBComboBox;
    edtPrescriptionPeriod: TDBEdit;
    lbl_10036: TLabel;
    cboPrescriptionScale: TDBComboBox;
    lbl_10018: TLabel;
    edtPrescriptionDuration: TDBEdit;
    cboPrescriptionDScale: TDBComboBox;
    lbl_10031: TLabel;
    chkGeneric: TDBCheckBox;
    lbl_10032: TLabel;
    edtRefills: TDBEdit;
    lbl_10019: TLabel;
    cboPrescriptionApplication: TDBComboBox;
    grdImmunization: TDBGrid;
    lbl_10023: TLabel;
    cboImmunizationType: TDBComboBox;
    lbl_10024: TLabel;
    edtImmunizationDate: TDBEdit;
    grdLabWork: TDBGrid;
    lbl_10026: TLabel;
    cboLabworkProcedure: TDBComboBox;
    chkLabPositive: TDBCheckBox;
    lbl_10027: TLabel;
    edtLabworkDate: TDBEdit;
    lbl_10029: TLabel;
    edtLabworkResult: TDBEdit;
    lbl_10030: TLabel;
    memLabworkComments: TDBMemo;
    memChronicComment: TDBMemo;
    cmdNew: TSpeedButton;
    cmdDelete: TSpeedButton;
    cmdDeleteAppointment: TSpeedButton;
    mnuDeleteAppointment: TMenuItem;
    cmdPrintAppt: TSpeedButton;
    lbl_0031: TLabel;
    edtLabReceived: TDBEdit;
    lbl_0032: TLabel;
    edtDoneDate: TDBEdit;
    edtDoneTime: TDBEdit;
    grd1500: TDBGrid;
    lbl_10100: TLabel;
    chkComplete: TDBCheckBox;
    tabServices: TTabSheet;
    tabBilling: TTabSheet;
    grd1500Details: TDBGrid;
    lbl_10200: TLabel;
    edtServiceFrom: TDBEdit;
    lbl_10201: TLabel;
    edtServiceTo: TDBEdit;
    lbl_10202: TLabel;
    edtServicePlace: TDBEdit;
    lbl_10203: TLabel;
    edtServiceType: TDBEdit;
    lbl_10205: TLabel;
    edtServiceCPT: TDBEdit;
    lbl_10206: TLabel;
    edtServiceModifier: TDBEdit;
    lbl_10207: TLabel;
    edtServiceDiagnosis: TDBEdit;
    lbl_10208: TLabel;
    edtServiceCharge: TDBEdit;
    lbl_10209: TLabel;
    edtServiceDays: TDBEdit;
    lbl_10210: TLabel;
    edtServiceEPSDT: TDBEdit;
    lbl_10211: TLabel;
    edtServiceEMG: TDBEdit;
    lbl_10212: TLabel;
    edtServiceCOB: TDBEdit;
    edtApptFee: TDBEdit;
    lbl_10301: TLabel;
    chkApptPaid: TDBCheckBox;
    pnlBills: TPanel;
    edtFee: TDBEdit;
    edtPayment: TDBEdit;
    edtCopay: TDBEdit;
    edtBalance: TDBEdit;
    Panel1: TPanel;
    grdBills: TDBGrid;
    memBillComments: TDBMemo;
    chkBillClosed: TDBCheckBox;
    lbl_10302: TLabel;
    lbl_10303: TLabel;
    lbl_10304: TLabel;
    lbl_10305: TLabel;
    cmdPrintBill: TSpeedButton;
    cboDiagnosis: TDBComboBox;
    cmdPatient: TSpeedButton;
    cmdHousehold: TSpeedButton;
    spl3: TSplitter;
    cmdQuickAppt: TSpeedButton;
    lbl_10003b: TLabel;
    lbl_10003c: TLabel;
    cboProgram: TDBComboBox;
    cboVisitCategory: TDBComboBox;
    tabPayments: TTabSheet;
    cboAcctType: TDBComboBox;
    grdPayments: TDBGrid;
    edtAcctDate: TDBEdit;
    calPayment: TMonthCalendar;
    edtAcctAmt: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lbl1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lblBalance: TLabel;
    tblCalcPatientTotal: TTable;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdEditClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure mnuExitClick(Sender: TObject);
    procedure cmdexitClick(Sender: TObject);
    procedure cboPrescriptionEnter(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure pagApptChange(Sender: TObject);
    procedure cboImmunizationTypeChange(Sender: TObject);
    procedure cmdDeleteClick(Sender: TObject);
    procedure cboPrescriptionChange(Sender: TObject);
    procedure cboLabworkProcedureChange(Sender: TObject);
    procedure cboReferralPhysicianChange(Sender: TObject);
    procedure cboAfflictionChange(Sender: TObject);
    procedure cmdDeleteAppointmentClick(Sender: TObject);
    procedure cmdPrintApptClick(Sender: TObject);
    procedure grd1500DblClick(Sender: TObject);
    procedure cmdPrintBillClick(Sender: TObject);
    procedure cmdHouseholdClick(Sender: TObject);
    procedure cmdPatientClick(Sender: TObject);
    procedure cmdQuickApptClick(Sender: TObject);
    procedure calPaymentClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtAcctAmtExit(Sender: TObject);
  private
    dtmMainLocal : tdtmMain;
    procedure CalcBalance;
    procedure ButtonControl(const cbolOn: boolean);
    procedure NewApptRecord(var qryQuery: tquery);
{    procedure FillInterpreterInfo;
    procedure CheckInterpret;
    procedure ApplyInterpret;    }
  public
    //variable used to determine which entity is the current entity
    vintAppointmentNum: Integer;
    constructor Create(Aowner : TComponent); override;
  end;

var
  frmAppointment: TfrmAppointment;

implementation

uses formApptQR, form1500, formInvoiceQR;

{$R *.DFM}

constructor TfrmAppointment.Create(AOwner: TComponent);
var
  vintloop: Integer;
  vtempcomp: TComponent;
begin

  {The type of datamodule is determined by the constant}
  vintDatamoduleInstance := cintAppointment;
  vintAppointmentNum := vintCurrentApptTicket;
  {Create the datamodule that is within the scope of this form}
  dtmMainLocal := Tdtmmain.create(application);
  DatamoduleCreateEvent(dtmMainLocal);

  {Create all form components and other start-up activities}
  Inherited create(AOwner);

  {Fill all small pick lists}
  FillPickList('Duration',cboPrescriptionDScale.Items);
  FillPickList('Application',cboPrescriptionApplication.Items);
  FillPickList('Frequency',cboPrescriptionScale.Items);
  FillPickList('PrescriptionType',cboPrescriptionSize.Items);
  FillPickList('Immunization',cboImmunizationType.Items);
  FillPickList('ReferralPhysician',cboReferralPhysician.Items);
  FillPickList('PatientAffliction',cboAffliction.Items);
  FillPickList('Diagnosis',cboDiagnosis.Items);
  FillPickList('Programs',cboProgram.Items);
  FillPickList('VisitCategory',cboVisitCategory.Items);
  {Set all datasources}
  for vintloop:=0 to ComponentCount-1 do
  begin
    vtempcomp:=Components[vintloop];
    AssignDataSources(vtempComp, dtmMainLocal);
  end;
  //set form caption
  Self.Caption := 'Appointment: ' +
         dtmMainLocal.qryEntity.fieldbyname('EntityDescription').asstring;

  dtmMainLocal.qryMedication.refresh;
  dtmMainLocal.qryImmunization.refresh;
  dtmMainLocal.qryReferral.refresh;
  dtmMainLocal.qryPatientChronic.refresh;
  If vbolNewItem then
    begin
    vbolNewItem := false;
    cmdEditClick(Self);
    end;
  calPayment.Date := date;
end;

procedure TfrmAppointment.ButtonControl(const cbolOn: boolean);
begin
{On of true turns the edit button on, others off}
If cbolOn then
  begin
  cmdEdit.Enabled:= true;
  mnuChange.Enabled:= true;
  cmdSave.Enabled:= false;
  mnuSave.Enabled:= false;
  cmdDeleteAppointment.Enabled:= false;
  mnuDeleteAppointment.Enabled:= false;
  cmdCancel.Enabled:= false;
  mnuCancel.Enabled:= false;
  end
else
{Edit button off, others on}
  begin
  cmdEdit.Enabled:= false;
  mnuChange.Enabled:= false;
  cmdSave.Enabled:= true;
  mnuSave.Enabled:= true;
  cmdDeleteAppointment.Enabled:= true;
  mnuDeleteAppointment.Enabled:= true;
  cmdCancel.Enabled:= true;
  mnuCancel.Enabled:= true;
  end;
pagApptChange(Self);
end;

procedure TfrmAppointment.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  // apply datasets if needed and close datamodule
  if cmdSave.Enabled then
      ApplyDataSets(dtmMainLocal);
  CloseAndFreeFiles(dtmMainLocal);
  CloseThisEntity(vintAppointmentNum);
  Action := caFree;
end;

procedure TfrmAppointment.cmdEditClick(Sender: TObject);
begin
  //set in edit mode or off edit mode
  EditDataSets(dtmMainLocal);
  ButtonControl(false);
  //CheckInterpret;
end;

procedure TfrmAppointment.NewApptRecord(var qryQuery: tquery);
begin
  qryQuery.Append;
  qryQuery.fieldbyname('Entity').asinteger :=
                    dtmMainLocal.qryAppointment.fieldbyname('Entity').asinteger;
  qryQuery.fieldbyname('ApptTicket').asinteger := vintAppointmentNum;
end;

procedure TfrmAppointment.cmdSaveClick(Sender: TObject);
var vreaMoney: real;
    vintLoop: integer;
begin
  {In order to keep the total fee for the Appointment up-to-date, calcluate the
  value of the all 1500 records and compare to the Total Fee}
  vreaMoney:= 0;
  If dtmMainLocal.qryAppt1500Detail.recordcount > 0 then
    begin
    dtmMainLocal.qryAppt1500Detail.first;
    while not dtmMainLocal.qryAppt1500Detail.eof do
      begin
      vreaMoney:= vreaMoney +
           dtmMainLocal.qryAppt1500Detail.fieldbyname('Appt1500Charge').asfloat;
      dtmMainLocal.qryAppt1500Detail.Next;
      end;
    If vreaMoney <>
                 dtmMainLocal.qryAppointment.fieldbyname('ApptFee').asfloat then
       begin
       dtmMainLocal.qryAppointment.edit;
       dtmMainLocal.qryAppointment.fieldbyname('ApptFee').asfloat := vreaMoney;
       PostEvent(dtmMainLocal.qryAppointment);
       end;
    end;
  ApplyDataSets(dtmMainLocal);
  tblCalcPatientTotal.databasename:= dtmMainLocal.dbsMain.databasename;
  tblCalcPatientTotal.open;
  tblCalcPatientTotal.SetRange
        ([dtmMainLocal.qryAppointment.fieldbyname('Entity').asinteger],
         [dtmMainLocal.qryAppointment.fieldbyname('Entity').asinteger]);
  vreaMoney:= 0;
  if tblCalcPatientTotal.recordcount > 0 then
    begin
    EditDataSets(dtmMainLocal);
    for vintLoop:= 1 to tblCalcPatientTotal.recordcount do
        begin
        if not tblCalcPatientTotal.fieldbyname('ApptBillClosed').asboolean then
          vreaMoney:= vreaMoney +
                   tblCalcPatientTotal.fieldbyname('ApptBillBalance').asfloat;
        tblCalcPatientTotal.next;
        end;
    dtmMainLocal.qryPatient.edit;
    dtmMainLocal.qryPatient.fieldbyname('PatientBalance').asfloat:= vreaMoney;
    PostEvent(dtmMainLocal.qryPatient);
    ApplyDataSets(dtmMainLocal);
    end;
  tblCalcPatientTotal.close;
  //ApplyInterpret;
  //save changes
  ButtonControl(true);
end;

procedure TfrmAppointment.cmdCancelClick(Sender: TObject);
begin
  //cancel the information and close
  RollbackDataSets(dtmMainLocal);
  ButtonControl(true);
end;

procedure TfrmAppointment.mnuExitClick(Sender: TObject);
begin
Close;
end;

procedure TfrmAppointment.cmdexitClick(Sender: TObject);
begin
Close;
end;

procedure TfrmAppointment.cboPrescriptionEnter(Sender: TObject);
begin
  If cboPrescription.items.count = 0 then
     FillPickList('Medication',cboPrescription.Items);
end;

procedure TfrmAppointment.cmdNewClick(Sender: TObject);
begin
  If pagAppt.Activepage = tabPrescription then
     begin
     NewApptRecord(dtmMainLocal.qryMedication);
     dtmMainLocal.qryMedication.fieldbyname('PrescriptionDate').asdatetime :=
                                                                           date;
     PostEvent(dtmMainLocal.qryMedication);
     end
  else
  If pagAppt.Activepage = tabImmunization then
     begin
     NewApptRecord(dtmMainLocal.qryImmunization);
     dtmMainLocal.qryImmunization.fieldbyname('ImmunizationDate').asdatetime :=
                                                                           date;
     PostEvent(dtmMainLocal.qryImmunization);
     end
  else
  If pagAppt.Activepage = tabReferral then
     begin
     NewApptRecord(dtmMainLocal.qryReferral);
     dtmMainLocal.qryReferral.fieldbyname('ReferralDate').asdatetime := date;
     dtmMainLocal.qryReferral.fieldbyname('ReferralComplete').asboolean
                                                                       := false;
     PostEvent(dtmMainLocal.qryReferral);
     end
  else
  If pagAppt.Activepage = tabChronic then
     begin
     NewApptRecord(dtmMainLocal.qryPatientChronic);
     dtmMainLocal.qryPatientChronic.fieldbyname('PatientChronicDate').asdatetime
                                                                       := date;
     PostEvent(dtmMainLocal.qryPatientChronic);
     end
  else
  If pagAppt.Activepage = tabLabwork then
     begin
     NewApptRecord(dtmMainLocal.qryLabwork);
     dtmMainLocal.qryLabwork.fieldbyname('LabDate').asdatetime := date;
     PostEvent(dtmMainLocal.qryLabwork);
     end
  else
  If pagAppt.Activepage = tabServices then
     begin
     NewApptRecord(dtmMainLocal.qryAppt1500Detail);
     dtmMainLocal.qryAppt1500Detail.fieldbyname('Appt1500Line').asinteger :=
                   dtmMainLocal.qryAppt1500Detail.recordcount + 1;
     dtmMainLocal.qryAppt1500Detail.fieldbyname
                                        ('Appt1500DateFrom').asdatetime := date;
     dtmMainLocal.qryAppt1500Detail.fieldbyname
                                        ('Appt1500DateTo').asdatetime := date;
     dtmMainLocal.qryAppt1500Detail.fieldbyname
                                        ('Appt1500Days_units').asinteger := 1;
     dtmMainLocal.qryAppt1500Detail.fieldbyname
                                        ('Appt1500Charge').asinteger := 0;
     PostEvent(dtmMainLocal.qryAppt1500Detail);
     end
  else
  If pagAppt.Activepage = tabBilling then
     begin
     NewApptRecord(dtmMainLocal.qryApptBilling);
     dtmMainLocal.qryApptBilling.fieldbyname('ApptBillDate').asdatetime
                                                                        := date;
     dtmMainLocal.qryApptBilling.fieldbyname
                                        ('ApptBillAmount').asfloat := 0;
     dtmMainLocal.qryApptBilling.fieldbyname
                                        ('ApptBillPayment').asfloat := 0;
     dtmMainLocal.qryApptBilling.fieldbyname
                                        ('ApptBillCopay').asfloat := 0;
     dtmMainLocal.qryApptBilling.fieldbyname
                                        ('ApptBillBalance').asfloat := 0;
     dtmMainLocal.qryApptBilling.fieldbyname
                                        ('ApptBillClosed').asboolean := false;
     PostEvent(dtmMainLocal.qryApptBilling);
     end
  else
  If pagAppt.Activepage = tabPayments then
     begin
     NewApptRecord(dtmMainLocal.qryApptAccount);
     dtmMainLocal.qryApptAccount.fieldbyname('ApptPayTranDate').asdatetime
                                                                        := date;
     dtmMainLocal.qryApptAccount.fieldbyname
                                        ('ApptPayTranType').asstring := '';
     cboAcctType.ItemIndex:= 0;
     dtmMainLocal.qryApptAccount.fieldbyname
                                        ('ApptPayTranAmount').asfloat := 0;
     PostEvent(dtmMainLocal.qryApptAccount);
     edtAcctDate.SetFocus;
     end
  else
  If pagAppt.Activepage = tabApptInfo then
     begin
     NewApptRecord(dtmMainLocal.qry1500Form);
     dtmMainLocal.qry1500Form.fieldbyname('Appt1500DateTime').asdatetime := now;
     PostEvent(dtmMainLocal.qry1500Form);
     vdtmQuickReport := dtmMainLocal;
     frm1500 := tfrm1500.Create(nil);
     try
       frm1500.LoadFromDataModule;
       frm1500.Showmodal;
     finally
       frm1500.release;
       frm1500 := nil;
       vdtmQuickReport := nil;
       end;
     end;
end;

procedure TfrmAppointment.pagApptChange(Sender: TObject);
begin
  If (cmdSave.Enabled = true) and
    ((pagAppt.Activepage = tabPrescription) or
     (pagAppt.Activepage = tabImmunization) or
     (pagAppt.Activepage = tabReferral) or
     (pagAppt.Activepage = tabChronic) or
     (pagAppt.Activepage = tabApptInfo) or
     (pagAppt.Activepage = tabLabwork) or
     (pagAppt.Activepage = tabBilling) or
     (pagAppt.Activepage = tabPayments) or
     (pagAppt.Activepage = tabServices)) then
     begin
     cmdNew.Enabled := true;
     cmdDelete.Enabled := true;
     end
  else
     begin
     cmdNew.Enabled := false;
     cmdDelete.Enabled := false;
     end;
  If (cmdSave.Enabled = true) and
     (pagAppt.Activepage = tabBilling) then
     cmdPrintBill.enabled:= true
  else
     cmdPrintBill.enabled:= false;
  If pagAppt.Activepage = tabPayments then
     CalcBalance;
{  If (pagAppt.Activepage = tabInterpret) and
     (cboInterpreter.Items.Count = 0) then
      FillInterpreterInfo;
  CheckInterpret;}
end;

{procedure tfrmAppointment.CheckInterpret;
begin
  If (cmdSave.Enabled = true) and
     (pagAppt.Activepage = tabInterpret) and
     (dtmMainLocal.qryInterpret.recordCount = 0) then
     begin
     NewApptRecord(dtmMainLocal.qryInterpret);
     dtmMainLocal.qryInterpret.fieldbyname('BillHours').asfloat := 0;
     PostEvent(dtmMainLocal.qryInterpret);
     end;
end;

procedure tfrmAppointment.ApplyInterpret;
begin
  If (dtmMainLocal.qryInterpret.recordCount > 0) then
  begin
   PostEvent(dtmMainLocal.qryInterpret);
   If dtmMainLocal.qryInterpret.fieldbyname('BillHours').asfloat > 0 then
     begin
     dtmMainLocal.qryInterpret.edit;
     If length(cboInterpreter.text) > 0 then
      dtmMainLocal.qryInterpret.fieldbyname('BillInterpreter').asinteger :=
        strtoint(copy(cboInterpreter.text, pos('(',cboInterpreter.text) + 1,6))
     else
        dtmMainLocal.qryInterpret.fieldbyname('BillInterpreter').asinteger := 0;
     If length(cboCompany.text) > 0 then
      dtmMainLocal.qryInterpret.fieldbyname('BillEntity').asinteger :=
        strtoint(copy(cboCompany.text, pos('(',cboCompany.text) + 1,5))
     else
        dtmMainLocal.qryInterpret.fieldbyname('BillEntity').asinteger := 0;
     PostEvent(dtmMainLocal.qryInterpret);
     end
   else
     begin
     dtmMainLocal.qryInterpret.delete;
     PostEvent(dtmMainLocal.qryInterpret);
     end;
  end;
end;

procedure TfrmAppointment.FillInterpreterInfo;
  var vqryEntity: Tquery;
      vintLoop: integer;
begin
vqryEntity:= tquery.create(nil);
try
vqryEntity.Databasename:= dtmMainLocal.dbsMain.databasename;
vqryEntity.SQL.Text := 'Select Staff.Entity, Entity.EntityDescription ' +
                       'From Staff, Entity ' +
                       'Where Staff.Entity = Entity.Entity and ' +
                             'Staff.StaffPosition = "Interpreter"';
vqryEntity.Open;
while not vqryEntity.eof do
  begin
  cboInterpreter.items.add(vqryEntity.fieldbyname('EntityDescription').asstring
  + ' (' + vqryEntity.fieldbyname('Entity').asstring + ')');
  vqryEntity.next;
  end;
vqryEntity.close;
vqryEntity.SQL.Text := 'Select Insurance.Entity, Insurance.Department, ' +
                              'Entity.EntityDescription ' +
                 'From Insurance, Entity ' +
                 'Where Insurance.Entity > ' + inttostr(cintEntityMedCompany) +
                 ' and Insurance.Entity < '
                                     + inttostr(cintEntityMedCompany + 10000) +
                 ' and Insurance.Entity = Entity.Entity';
vqryEntity.Open;
while not vqryEntity.eof do
  begin
  cboCompany.items.add(vqryEntity.fieldbyname('EntityDescription').asstring
  + '-' +
  trim(vqryEntity.fieldbyname('Department').asstring)
  + ' (' + vqryEntity.fieldbyname('Entity').asstring + ')');
  vqryEntity.next;
  end;
vqryEntity.close;
  finally
  vqryEntity.Free;
  end;
If dtmMainLocal.qryInterpret.RecordCount > 0 then
   begin
   If dtmMainLocal.qryInterpret.fieldbyname('BillEntity').asinteger > 0 then
      begin
      for vintLoop:= 0 to cboCompany.items.count - 1 do
         If pos(inttostr(
                dtmMainLocal.qryInterpret.fieldbyname('BillEntity').asinteger),
                cboCompany.items[vintLoop]) > 0 then
                begin
                cboCompany.itemindex:= vintLoop;
                break;
                end;
      end;
   If dtmMainLocal.qryInterpret.fieldbyname
                                          ('BillInterpreter').asinteger > 0 then
      begin
      for vintLoop:= 0 to cboInterpreter.items.count - 1 do
         If pos(inttostr(
            dtmMainLocal.qryInterpret.fieldbyname('BillInterpreter').asinteger),
                cboInterpreter.items[vintLoop]) > 0 then
                begin
                cboInterpreter.itemindex:= vintLoop;
                break;
                end;
      end;
   end;
end;             }

procedure TfrmAppointment.cboImmunizationTypeChange(Sender: TObject);
begin
  dtmMainLocal.qryImmunization.refresh;
  dtmMainLocal.qryImmunization.edit;
  If dtmMainLocal.qryImmunization.FieldByName('Entity').asinteger < 200000 then
     begin
     dtmMainLocal.qryImmunization.FieldByName('Entity').asinteger:=
                  dtmMainLocal.qryAppointment.FieldByName('Entity').asinteger;
     dtmMainLocal.qryImmunization.FieldByName('ApptTicket').asinteger:=
                dtmMainLocal.qryAppointment.FieldByName('ApptTicket').asinteger;
     end;
end;

procedure TfrmAppointment.cmdDeleteClick(Sender: TObject);
  Procedure RenumberDetails;
     var vintLoop: integer;
     begin
     dtmMainLocal.qryAppt1500Detail.first;
     For vintLoop:= 1 to dtmMainLocal.qryAppt1500Detail.recordCount do
         begin
         If dtmMainLocal.qryAppt1500Detail.fieldbyname('Appt1500Line').asinteger
                                                                <> vintLoop then
             begin
             dtmMainLocal.qryAppt1500Detail.edit;
             dtmMainLocal.qryAppt1500Detail.fieldbyname
                                         ('Appt1500Line').asinteger := vintLoop;
             PostEvent(dtmMainLocal.qryAppt1500Detail);
             end;
         dtmMainLocal.qryAppt1500Detail.next;
         end;
     end;
begin
If (pagAppt.Activepage = tabPrescription) and
        (dtmMainLocal.qryMedication.recordCount > 0) then
           dtmMainLocal.qryMedication.delete;
If (pagAppt.Activepage = tabImmunization) and
        (dtmMainLocal.qryImmunization.recordCount > 0) then
           dtmMainLocal.qryImmunization.delete;
If (pagAppt.Activepage = tabReferral) and
        (dtmMainLocal.qryReferral.recordCount > 0) then
           dtmMainLocal.qryReferral.delete;
If (pagAppt.Activepage = tabChronic) and
        (dtmMainLocal.qryPatientChronic.recordCount > 0) then
           dtmMainLocal.qryPatientChronic.delete;
If (pagAppt.Activepage = tabLabwork) and
        (dtmMainLocal.qryLabwork.recordCount > 0) then
           dtmMainLocal.qryLabwork.delete;
If (pagAppt.Activepage = tabApptInfo) and
        (dtmMainLocal.qry1500Form.recordCount > 0) then
           dtmMainLocal.qry1500Form.delete;
If (pagAppt.Activepage = tabBilling) and
        (dtmMainLocal.qryApptBilling.recordCount > 0) then
           dtmMainLocal.qryApptBilling.delete;
If (pagAppt.Activepage = tabPayments) and
        (dtmMainLocal.qryApptAccount.recordCount > 0) then
           dtmMainLocal.qryApptAccount.delete;
If (pagAppt.Activepage = tabServices) and
        (dtmMainLocal.qryAppt1500Detail.recordCount > 0) then
           begin
           dtmMainLocal.qryAppt1500Detail.delete;
           If dtmMainLocal.qryAppt1500Detail.recordCount > 0 then
              RenumberDetails;
           end;
pagApptChange(Self);
grdImmunization.Update;
end;

procedure TfrmAppointment.cboPrescriptionChange(Sender: TObject);
begin
  dtmMainLocal.qryMedication.refresh;
  dtmMainLocal.qryMedication.edit;
  If dtmMainLocal.qryMedication.FieldByName('Entity').asinteger < 200000 then
     begin
     dtmMainLocal.qryMedication.FieldByName('Entity').asinteger:=
                  dtmMainLocal.qryAppointment.FieldByName('Entity').asinteger;
     dtmMainLocal.qryMedication.FieldByName('ApptTicket').asinteger:=
                dtmMainLocal.qryAppointment.FieldByName('ApptTicket').asinteger;
     end;
end;

procedure TfrmAppointment.cboLabworkProcedureChange(Sender: TObject);
begin
  dtmMainLocal.qryLabWork.refresh;
  dtmMainLocal.qryLabWork.edit;
  If dtmMainLocal.qryLabWork.FieldByName('Entity').asinteger < 200000 then
     begin
     dtmMainLocal.qryLabWork.FieldByName('Entity').asinteger:=
                  dtmMainLocal.qryAppointment.FieldByName('Entity').asinteger;
     dtmMainLocal.qryLabWork.FieldByName('ApptTicket').asinteger:=
                dtmMainLocal.qryAppointment.FieldByName('ApptTicket').asinteger;
     end;
end;

procedure TfrmAppointment.cboReferralPhysicianChange(Sender: TObject);
begin
  dtmMainLocal.qryReferral.refresh;
  dtmMainLocal.qryReferral.edit;
  If dtmMainLocal.qryReferral.FieldByName('Entity').asinteger < 200000 then
     begin
     dtmMainLocal.qryReferral.FieldByName('Entity').asinteger:=
                  dtmMainLocal.qryAppointment.FieldByName('Entity').asinteger;
     dtmMainLocal.qryReferral.FieldByName('ApptTicket').asinteger:=
                dtmMainLocal.qryAppointment.FieldByName('ApptTicket').asinteger;
     end;
end;

procedure TfrmAppointment.cboAfflictionChange(Sender: TObject);
begin
  dtmMainLocal.qryPatientChronic.refresh;
  dtmMainLocal.qryPatientChronic.edit;
  If dtmMainLocal.qryPatientChronic.FieldByName('Entity').asinteger
                                                                < 200000 then
     begin
     dtmMainLocal.qryPatientChronic.FieldByName('Entity').asinteger:=
                  dtmMainLocal.qryAppointment.FieldByName('Entity').asinteger;
     dtmMainLocal.qryPatientChronic.FieldByName('ApptTicket').asinteger:=
                dtmMainLocal.qryAppointment.FieldByName('ApptTicket').asinteger;
     end;
end;

procedure TfrmAppointment.cmdDeleteAppointmentClick(Sender: TObject);
begin
if MessageDlg('This Appointment will be removed permanently. OK?',
    mtWarning, [mbYes, mbCancel], 0) = mrYes then
  begin
  if cmdSave.Enabled then
     begin
     RollbackDataSets(dtmMainLocal);
     ButtonControl(true);
     end;
  DeleteAllAppointment(dtmMainLocal.qryAppointment.fieldbyname
                                                      ('ApptTicket').asinteger);
  close;
  end;
end;

procedure TfrmAppointment.cmdPrintApptClick(Sender: TObject);
begin
  vdtmQuickReport := dtmMainLocal;
  frmAppointmentQR := tfrmAppointmentQR.Create(nil);
  try
    frmAppointmentQR.rptAppointment.Preview;
  finally
    frmAppointmentQR.release;
    frmAppointmentQR := nil;
    vdtmQuickReport := nil;
  end;
end;

procedure TfrmAppointment.grd1500DblClick(Sender: TObject);
var vintLoop: integer;
begin
If dtmMainLocal.qry1500Form.recordCount > 0 then
  begin
  vdtmQuickReport := dtmMainLocal;
  frm1500 := tfrm1500.Create(nil);
  try
    If not cmdSave.enabled then
       for vintLoop:= 0 to frm1500.componentcount - 1 do
         If (frm1500.components[vintLoop] is Tcheckbox) and
            (frm1500.components[vintLoop].tag = 0) then
            Tcheckbox(frm1500.components[vintLoop]).enabled:= false
         else
         If frm1500.components[vintLoop] is Tedit then
            Tedit(frm1500.components[vintLoop]).readonly:= true
         else
         If frm1500.components[vintLoop] is Tmemo then
            Tmemo(frm1500.components[vintLoop]).readonly:= true;
    frm1500.Load1500FromHistory;
    frm1500.Showmodal;
  finally
    frm1500.release;
    frm1500 := nil;
    vdtmQuickReport := nil;
  end;
  end;

end;

procedure TfrmAppointment.cmdPrintBillClick(Sender: TObject);
var vstlTemp: tstringlist;
    vintLoop, vintHouseHold: integer;
    vqryTemp: Tquery;
begin
If dtmMainLocal.qryApptBilling.recordCount > 0 then
  begin
  PostEvent(dtmMainLocal.qryApptBilling);
  frmInvoiceQR := tfrmInvoiceQR.Create(nil);
  vstlTemp:= tstringList.Create;
  vqryTemp:= tQuery.create(nil);
  try
    {Use current entity information}
    frmInvoiceQR.memClientInfo.lines.add(
              dtmMainLocal.qryEntity.fieldbyname('EntityDescription').asstring);
    vintHousehold:= dtmMainLocal.qryEntity.fieldbyname
                                                  ('EntityHousehold').asinteger;
    {Get the Home Address Information}
    vqryTemp.requestlive:= false;
    vqryTemp.DatabaseName := dtmMainLocal.dbsMain.databasename;
    vqryTemp.UniDirectional:= true;
    vqryTemp.SQL.Text :=
      'Select * from Address where Entity = ' + inttostr(vintHousehold) +
      ' and AddressType = "Home"';
    vqryTemp.Open;
    If vqryTemp.RecordCount = 1 then
       begin
       frmInvoiceQR.memClientInfo.lines.add
                                (vqryTemp.fieldbyname('AddressLine1').asstring);
       If vqryTemp.fieldbyname('AddressLine2').asstring > '   A' then
           frmInvoiceQR.memClientInfo.lines.add
                                (vqryTemp.fieldbyname('AddressLine2').asstring);
       frmInvoiceQR.memClientInfo.lines.add
                                 (vqryTemp.fieldbyname('AddressCity').asstring +
                          ', ' + vqryTemp.fieldbyname('AddressState').asstring +
                           '  ' +  vqryTemp.fieldbyname('AddressZip').asstring);
       end;
    vqryTemp.Close;
    {Address Done}
    {Find Physician entity}
    vqryTemp.SQL.Text :=
       'Select HouseHoldPhysician from HouseHold where Entity = ' +
                                                        inttostr(vintHousehold);
    vqryTemp.Open;
    frmInvoiceQR.lblPhysician.caption :=
          FindEntityName(vqryTemp.fieldbyname('HouseholdPhysician').asinteger);
    vqryTemp.Close;
    frmInvoiceQR.lblDate.Caption:=
        dtmMainLocal.qryAppointment.fieldbyname('ApptDateTime').asstring;
    frmInvoiceQR.lblInvoiceNumber.Caption:=
            dtmMainLocal.qryApptBilling.fieldbyname('ApptTicket').asstring + '-'
          + dtmMainLocal.qryApptBilling.fieldbyname('ApptBillDate').asstring;
    frmInvoiceQR.lblFee.Caption:= Format('%6.2m',
       [dtmMainLocal.qryApptBilling.fieldbyname('ApptBillAmount').ascurrency]);
    frmInvoiceQR.lblCopay.Caption:= Format('%6.2m',
       [dtmMainLocal.qryApptBilling.fieldbyname('ApptBillCopay').ascurrency]);
    frmInvoiceQR.lblPriorPay.Caption:= Format('%6.2m',
       [dtmMainLocal.qryApptBilling.fieldbyname('ApptBillPayment').ascurrency]);
    frmInvoiceQR.lblAmountDue.Caption:= Format('%6.2m',
       [dtmMainLocal.qryApptBilling.fieldbyname('ApptBillBalance').ascurrency]);
    vstlTemp.text :=
            dtmMainLocal.qryApptBilling.fieldbyname('ApptBillComment').asstring;
    frmInvoiceQR.memcomments.caption:= '';
    For vintLoop:= 0 to vstlTemp.count - 1 do
       frmInvoiceQR.memcomments.lines.add(vstlTemp[vintLoop]);
    frmInvoiceQR.rptInvoice.Preview;
  finally
    vqryTemp.free;
    vstlTemp.free;
    frmInvoiceQR.release;
    frmInvoiceQR := nil;
  end;
  end;
end;

procedure TfrmAppointment.cmdHouseholdClick(Sender: TObject);
var vbolDummy: boolean;
begin
  vintCurrentEntity := dtmMainLocal.qryEntity.fieldbyname
                                                  ('EntityHousehold').asinteger;
  {This is the sneaky way to call a routine in a form that created you!}
  vbolDummy := false;
  vfrmMainMenu.onclosequery(Sender, vbolDummy);
end;

procedure TfrmAppointment.cmdPatientClick(Sender: TObject);
var vbolDummy: boolean;
begin
  vintCurrentEntity := dtmMainLocal.qryEntity.fieldbyname('Entity').asinteger;
  {This is the sneaky way to cann a routine in a form that created you!}
  vbolDummy := false;
  vfrmMainMenu.onclosequery(Sender, vbolDummy);
end;

procedure TfrmAppointment.cmdQuickApptClick(Sender: TObject);
var vbolDummy: boolean;
begin
If not cmdSave.enabled then
  EditDataSets(dtmMainLocal);

if dtmMainLocal.qryAppointment.State = dsBrowse	then
    dtmMainLocal.qryAppointment.edit;
dtmMainLocal.qryAppointment.fieldbyname('ApptScheduled').asboolean := false;
dtmMainLocal.qryAppointment.fieldbyname('ApptSchedulePend').asboolean := true;
PostEvent(dtmMainLocal.qryAppointment);
ApplyDataSets(dtmMainLocal);
ButtonControl(true);vbolSchedulerDisplay:= true;
vfrmMainMenu.onclosequery(Sender, vbolDummy);
end;

procedure TfrmAppointment.calPaymentClick(Sender: TObject);
begin
If (cmdSave.enabled) and (dtmMainLocal.qryApptAccount.recordcount > 0) then
  begin
  if dtmMainLocal.qryApptAccount.State = dsBrowse then
    dtmMainLocal.qryApptAccount.edit;
  dtmMainLocal.qryApptAccount.fieldbyname('ApptPayTranDate').asdatetime :=
                                                                calPayment.Date;
  end;
end;


procedure TfrmAppointment.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
If (pagAppt.Activepage = tabPayments) and
   (cmdSave.enabled) and
   (Key = vk_F5) then
     cmdNewClick(Self);
end;

procedure TfrmAppointment.edtAcctAmtExit(Sender: TObject);
begin
try
If copy(cboAcctType.text,1,1) = '1' then
If dtmMainLocal.qryApptAccount.fieldbyname('ApptPayTranAmount').asfloat > 0 then
   edtAcctAmt.Text := floattostr(
     dtmMainLocal.qryApptAccount.fieldbyname('ApptPayTranAmount').asfloat * -1);
   except
   edtAcctAmt.text := '0';
   end;

CalcBalance;
end;

procedure TfrmAppointment.CalcBalance;
  var vreaBalance: real;
begin
vreaBalance:=0;
dtmMainLocal.qryApptAccount.first;
while not dtmMainLocal.qryApptAccount.eof do
   begin
   try
     vreaBalance :=  vreaBalance +
           dtmMainLocal.qryApptAccount.fieldbyname('ApptPayTranAmount').asfloat;
     except
     vreaBalance:= 0;
     end;
   dtmMainLocal.qryApptAccount.next;
   end;
lblBalance.caption := format('%6.2M', [vreaBalance]);
end;

end.
