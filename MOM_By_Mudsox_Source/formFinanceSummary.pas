unit formFinanceSummary;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls, ToolWin, ComCtrls, StdCtrls, DBCtrls, Mask, Grids,
  DBGrids, dbtables, dataMainDataModule, DBLookup, Db;

type
  TfrmFinanceSummary = class(TForm)
    tbl1: TToolBar;
    spl1: TSplitter;
    cmdexit: TSpeedButton;
    cmdHelp: TSpeedButton;
    cmdAppointment: TSpeedButton;
    cmdPatient: TSpeedButton;
    cmdHousehold: TSpeedButton;
    pnl1500: TPanel;
    grd1500: TDBGrid;
    pnlBilling: TPanel;
    pnlLeft: TPanel;
    grdBills: TDBGrid;
    lbl_10302: TLabel;
    edtFee: TDBEdit;
    lbl_10303: TLabel;
    edtPayment: TDBEdit;
    lbl_10304: TLabel;
    edtCopay: TDBEdit;
    lbl_10305: TLabel;
    edtBalance: TDBEdit;
    chkBillClosed: TDBCheckBox;
    pnlAppointment: TPanel;
    lbl_10001: TLabel;
    cmdNew: TSpeedButton;
    cmdDelete: TSpeedButton;
    cmdPrintBill: TSpeedButton;
    pnlmenu2: TPanel;
    cmdNew1500: TSpeedButton;
    cmdDelete1500: TSpeedButton;
    memBillComments: TDBMemo;
    SpeedButton3: TSpeedButton;
    cbxApptTicket: TComboBox;
    lbl_10008: TLabel;
    spl2: TSplitter;
    cmdEdit: TSpeedButton;
    cmdSave: TSpeedButton;
    cmdCancel: TSpeedButton;
    edtPatientBalance: TDBEdit;
    tblCalcPatientTotal: TTable;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdexitClick(Sender: TObject);
    procedure cmdAppointmentClick(Sender: TObject);
    procedure cmdPatientClick(Sender: TObject);
    procedure cmdHouseholdClick(Sender: TObject);
    procedure cmdDelete1500Click(Sender: TObject);
    procedure grd1500DblClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdDeleteClick(Sender: TObject);
    procedure cmdPrintBillClick(Sender: TObject);
    procedure cbxApptTicketChange(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdNew1500Click(Sender: TObject);
  private
    dtmMainLocal : tdtmMain;
    procedure NewApptRecord(var qryQuery: tquery);
    procedure ButtonControl(const cbolOn: boolean);
    procedure UpdateBalance;
    { Private declarations }
  public
    vintCurrentPatient: integer;
    vintCurrentAppointment: integer;
    vintCurrentHousehold: integer;
    { Public declarations }
    constructor Create(Aowner : TComponent); override;
  end;

var
  frmFinanceSummary: TfrmFinanceSummary;

implementation

uses procSharedDatamoduleCalls, form1500, formInvoiceQR;

{$R *.DFM}

constructor TfrmFinanceSummary.Create(AOwner: TComponent);
var
  vintloop: Integer;
  vtempcomp: TComponent;
begin
  {The type of datamodule is determined by the constant}
  vintDatamoduleInstance := cintFinance;
  {Create the datamodule that is within the scope of this form}
  dtmMainLocal := Tdtmmain.create(application);
  DatamoduleCreateEvent(dtmMainLocal);

  {Create all form components and other start-up activities}
  Inherited create(AOwner);

  dtmMainLocal.qryAppointment.last;
  for vintLoop := dtmMainLocal.qryAppointment.RecordCount downto 1 do
      begin
      cbxApptTicket.Items.Add(
          dtmMainLocal.qryAppointment.fieldbyname('ApptDateTime').asstring +
          '  [' +
          dtmMainLocal.qryAppointment.fieldbyname('ApptTicket').asstring +
          ']');
      If not dtmMainLocal.qryAppointment.Bof then
          dtmMainLocal.qryAppointment.Prior;
      end;
  If cbxApptTicket.Items.count > 0 then
     cbxApptTicket.ItemIndex:= 0;
  {Set all datasources}
  for vintloop:=0 to ComponentCount-1 do
  begin
    vtempcomp:=Components[vintloop];
    AssignDataSources(vtempComp, dtmMainLocal);
  end;

  Self.Caption := 'Finance Summary: #' +
         dtmMainLocal.qryEntity.fieldbyname('Entity').asstring + '=' +
         dtmMainLocal.qryEntity.fieldbyname('EntityDescription').asstring;
  cbxApptTicketChange(self);
  vintCurrentHousehold:=
                dtmMainLocal.qryEntity.fieldbyname('EntityHousehold').asinteger;
  ButtonControl(true);
end;

procedure TfrmFinanceSummary.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CloseThisEntity(cintFinance + vintCurrentPatient);
  Action := caFree;
end;

procedure TfrmFinanceSummary.cmdexitClick(Sender: TObject);
begin
close;
end;

procedure TfrmFinanceSummary.cmdAppointmentClick(Sender: TObject);
var vbolDummy: boolean;
begin
If cbxApptTicket.itemindex > -1 then
  begin
  vintCurrentApptTicket := vintCurrentAppointment;
  vintCurrentEntity := vintCurrentPatient;
  {This is the sneaky way to cann a routine in a form that created you!}
  vbolDummy := false;
  vfrmMainMenu.onclosequery(Sender, vbolDummy);
  end;
end;

procedure TfrmFinanceSummary.cmdPatientClick(Sender: TObject);
var vbolDummy: boolean;
begin
  vintCurrentEntity := vintCurrentPatient;
  {This is the sneaky way to cann a routine in a form that created you!}
  vbolDummy := false;
  vfrmMainMenu.onclosequery(Sender, vbolDummy);
end;

procedure TfrmFinanceSummary.cmdHouseholdClick(Sender: TObject);
var vbolDummy: boolean;
begin
  vintCurrentEntity := vintCurrentHousehold;
  {This is the sneaky way to cann a routine in a form that created you!}
  vbolDummy := false;
  vfrmMainMenu.onclosequery(Sender, vbolDummy);
end;

procedure TfrmFinanceSummary.cmdDelete1500Click(Sender: TObject);
begin
If dtmMainLocal.qry1500Form.recordCount > 0 then
   dtmMainLocal.qry1500Form.delete;
end;

procedure TfrmFinanceSummary.grd1500DblClick(Sender: TObject);
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

procedure TfrmFinanceSummary.cmdNewClick(Sender: TObject);
begin
  NewApptRecord(dtmMainLocal.qryApptBilling);
  dtmMainLocal.qryApptBilling.fieldbyname('ApptBillDate').asdatetime := date;
  dtmMainLocal.qryApptBilling.fieldbyname('ApptBillAmount').asfloat := 0;
  dtmMainLocal.qryApptBilling.fieldbyname('ApptBillPayment').asfloat := 0;
  dtmMainLocal.qryApptBilling.fieldbyname('ApptBillCopay').asfloat := 0;
  dtmMainLocal.qryApptBilling.fieldbyname('ApptBillBalance').asfloat := 0;
  dtmMainLocal.qryApptBilling.fieldbyname('ApptBillClosed').asboolean := false;
  PostEvent(dtmMainLocal.qryApptBilling);
end;

procedure TfrmFinanceSummary.cmdDeleteClick(Sender: TObject);
begin
If dtmMainLocal.qryApptBilling.recordCount > 0 then
           dtmMainLocal.qryApptBilling.delete;
end;

procedure TfrmFinanceSummary.NewApptRecord(var qryQuery: tquery);
begin
  qryQuery.Append;
  qryQuery.fieldbyname('Entity').asinteger :=
                    dtmMainLocal.qryAppointment.fieldbyname('Entity').asinteger;
  qryQuery.fieldbyname('ApptTicket').asinteger := vintCurrentAppointment;
end;


procedure TfrmFinanceSummary.cmdPrintBillClick(Sender: TObject);
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

procedure TfrmFinanceSummary.cbxApptTicketChange(Sender: TObject);
var vstrWork: string;
begin
If cbxApptTicket.itemindex > -1 then
   begin
   vstrWork:= cbxApptTicket.items[cbxApptTicket.itemindex];
   vintCurrentAppointment:= strtoint(copy(vstrWork, pos('[',vstrWork) + 1, 7));
   dtmMainLocal.qryAppointment.locate('ApptTicket', vintCurrentAppointment, []);
   end;
end;

procedure TfrmFinanceSummary.cmdEditClick(Sender: TObject);
begin
  //set edit on or off
  EditDataSets(dtmMainLocal);
  ButtonControl(false);
end;

procedure TfrmFinanceSummary.cmdSaveClick(Sender: TObject);
  var vreaMoney: real;
      vintLoop: integer;
begin
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

  ButtonControl(true);
end;

procedure TfrmFinanceSummary.cmdCancelClick(Sender: TObject);
begin
  //cancel the information and close
  RollbackDataSets(dtmMainLocal);
  ButtonControl(true);
end;

procedure TfrmFinanceSummary.ButtonControl(const cbolOn: boolean);
begin
{On of true turns the edit button on, others off}
If cbolOn then
  begin
  cmdEdit.Enabled:= true;
  cmdSave.Enabled:= false;
  cmdCancel.Enabled:= false;
  cmdNew.Enabled:= false;
  cmdDelete.Enabled:= false;
  cmdNew1500.Enabled:= false;
  cmdDelete1500.Enabled:= false;
  end
else
{Edit button off, others on}
  begin
  cmdEdit.Enabled:= false;
  cmdSave.Enabled:= true;
  cmdCancel.Enabled:= true;
  cmdNew.Enabled:= true;
  cmdDelete.Enabled:= true;
  cmdNew1500.Enabled:= true;
  cmdDelete1500.Enabled:= true;
  end;
UpdateBalance;
end;

procedure TfrmFinanceSummary.cmdNew1500Click(Sender: TObject);
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

procedure TfrmFinanceSummary.UpdateBalance;
var vreaBalance: real;
begin
vreaBalance:= 0;
dtmMainLocal.dtsApptBilling.Enabled := false;
try
dtmMainLocal.qryApptBilling.first;
while not dtmMainLocal.qryApptBilling.eof do
  begin
  If not dtmMainLocal.qryApptBilling.fieldbyname
                                               ('ApptBillClosed').asboolean then
      vreaBalance:= vreaBalance +
             dtmMainLocal.qryApptBilling.fieldbyname('ApptBillBalance').asfloat;
  dtmMainLocal.qryApptBilling.next;
  end;

finally
dtmMainLocal.dtsApptBilling.Enabled := true;
end;
end;

end.
