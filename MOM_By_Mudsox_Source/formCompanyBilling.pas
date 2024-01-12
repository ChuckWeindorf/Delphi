unit formCompanyBilling;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Buttons, ToolWin, ComCtrls, Grids, DBGrids, StdCtrls, DBCtrls,
  Mask, db, dbtables,
  
  procSharedDatamoduleCalls, dataMainDatamodule, formInvoice,
  formInvoiceSummary, formInvoiceSummary306090;

type
  TfrmCompanyBilling = class(TForm)
    tblMain: TToolBar;
    cmdDeleteAppointment: TSpeedButton;
    spl1: TSplitter;
    cmdPrintAppt: TSpeedButton;
    cmdexit: TSpeedButton;
    pnlMain: TPanel;
    cmdNewRecord: TSpeedButton;
    pnlLeft: TPanel;
    radSearch: TRadioGroup;
    pnlDetail: TPanel;
    pnlFields: TPanel;
    cboInterpreter: TComboBox;
    cboPhysician: TComboBox;
    edtDate: TDBEdit;
    edtPatient: TDBEdit;
    edtPatientComment: TDBEdit;
    edtTime: TDBEdit;
    pnlInvTop: TPanel;
    grddetails: TDBGrid;
    edtInvDate: TDBEdit;
    chkBilled: TDBCheckBox;
    lbl_1001: TLabel;
    lbl_1002: TLabel;
    lbl_1003: TLabel;
    lbl_1004: TLabel;
    lbl_1005: TLabel;
    lbl_1006: TLabel;
    chkPaid: TDBCheckBox;
    cboCompany: TComboBox;
    lbl_0001: TLabel;
    lbl_0002: TLabel;
    qryInvoices: TQuery;
    lbl_0005: TLabel;
    edtInvoice: TDBEdit;
    dtsInvoices: TDataSource;
    grdInvoices: TDBGrid;
    qryCompanyBill: TQuery;
    dtsCompanyBill: TDataSource;
    qryCompanyBillDetail: TQuery;
    dtsCompanyBillDetail: TDataSource;
    memComments: TDBMemo;
    cmdNewDetail: TSpeedButton;
    cmdDeleteDetail: TSpeedButton;
    lbl_10010: TLabel;
    cmdSummary: TSpeedButton;
    pnlDates: TPanel;
    edtFromDate: TEdit;
    edtToDate: TEdit;
    cmdSummaryPreview: TSpeedButton;
    lbl_20001: TLabel;
    lbl_20002: TLabel;
    lbl_20003: TLabel;
    cmdNoReport: TSpeedButton;
    qrySummaryReport: TQuery;
    lbl_20010: TLabel;
    lbl_20011: TLabel;
    lbl_20012: TLabel;
    edtAmount: TDBEdit;
    edtPaid: TDBEdit;
    edtBalance: TDBEdit;
    cmd30_60_90: TSpeedButton;
    pnl30_60_90: TPanel;
    cmdPrint_30_60_90: TSpeedButton;
    SpeedButton2: TSpeedButton;
    lbl1001: TLabel;
    radDays: TRadioGroup;
    cmdCompanyUnpaid: TSpeedButton;
    Table1: TTable;
    procedure FormCreate(Sender: TObject);
    procedure cmdexitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure radSearchClick(Sender: TObject);
    procedure cmdNewDetailClick(Sender: TObject);
    procedure cmdDeleteDetailClick(Sender: TObject);
    procedure cmdDeleteAppointmentClick(Sender: TObject);
    procedure cboCompanyClick(Sender: TObject);
    procedure cboInterpreterClick(Sender: TObject);
    procedure cmdNewRecordClick(Sender: TObject);
    procedure cmdPrintApptClick(Sender: TObject);
    procedure cmdSummaryClick(Sender: TObject);
    procedure cmdSummaryPreviewClick(Sender: TObject);
    procedure cmdNoReportClick(Sender: TObject);
    procedure qryCompanyBillBeforePost(DataSet: TDataSet);
    procedure cboPhysicianClick(Sender: TObject);
    procedure dtsInvoicesDataChange(Sender: TObject; Field: TField);
    procedure dtsCompanyBillDetailDataChange(Sender: TObject;
      Field: TField);
    procedure cmd30_60_90Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure cmdPrint_30_60_90Click(Sender: TObject);
    procedure cmdCompanyUnpaidClick(Sender: TObject);
  private
    dtmMainLocal : tdtmMain;
    Procedure SynchCompany;
    Procedure SynchDetail;
    Procedure PostTheTables;
    procedure FillInterpreterInfo;
    procedure UpdateQuery;
    { Private declarations }
  public
    vintEntityNum: Integer;
    constructor Create(AOwner :TComponent); override;
    { Public declarations }
  end;

var
  frmCompanyBilling: TfrmCompanyBilling;

implementation

{$R *.DFM}
constructor TfrmCompanyBilling.Create(AOwner :TComponent);
begin
  {The type of datamodule is determined by the constant}
  vintDatamoduleInstance := cintCompanyBilling;
  {Create the datamodule that is within the scope of this form}
  dtmMainLocal := Tdtmmain.create(application);
  DatamoduleCreateEvent(dtmMainLocal);
  {Create all form components and other start-up activities}
  Inherited create(AOwner);
  {Set all datasources}
  //fill comboboxes
  FillInterpreterInfo;
  qryInvoices.databasename:= dtmMainLocal.dbsMain.DatabaseName;
  qrySummaryReport.databasename:= dtmMainLocal.dbsMain.DatabaseName;
  qryCompanyBill.databasename:= dtmMainLocal.dbsMain.DatabaseName;
  qryCompanyBillDetail.databasename:= dtmMainLocal.dbsMain.DatabaseName;
  UpdateQuery;
end;

procedure TfrmCompanyBilling.FormCreate(Sender: TObject);
begin
If vbolFinanceView then
   begin
  // cmdPrintAppt.enabled:= true;
   cmdSummary.enabled:= true;
   cmd30_60_90.enabled:= true;
//   cmdCompanyUnpaid.enabled:= true;
   end
else
   begin
   edtBalance.visible:= false;
   lbl_20011.visible:= false;
   edtAmount.visible:= false;
   lbl_20010.visible:= false;
   edtPaid.visible:= false;
   lbl_20012.visible:= false;
   end
end;

procedure TfrmCompanyBilling.FillInterpreterInfo;
  var vqryEntity: Tquery;
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
cboCompany.items.add(' New');
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
vqryEntity.SQL.Text := 'Select Insurance.Entity, Insurance.Department, ' +
                              'Entity.EntityDescription ' +
                 'From Insurance, Entity ' +
                 'Where Insurance.Entity > ' + inttostr(cintEntityOtherPhys) +
                 ' and Insurance.Entity < '
                                     + inttostr(cintEntityOtherPhys + 10000) +
                 ' and Insurance.Entity = Entity.Entity';
vqryEntity.Open;
cboPhysician.items.add(' No Physician (00000)');
while not vqryEntity.eof do
  begin
  cboPhysician.items.add(vqryEntity.fieldbyname('EntityDescription').asstring
  + ' (' + vqryEntity.fieldbyname('Entity').asstring + ')');
  vqryEntity.next;
  end;
vqryEntity.close;
  finally
  vqryEntity.Free;
  end;
end;

procedure TfrmCompanyBilling.cmdexitClick(Sender: TObject);
begin
close;
end;

procedure TfrmCompanyBilling.PostTheTables;
begin
If not qryCompanyBill.Active then exit;

  If qryCompanyBill.State <> dsBrowse then
     begin
     try
      qryCompanyBill.post
      except
      qryCompanyBill.Cancel;
      end;
     end;
  If qryCompanyBillDetail.State <> dsBrowse then
     begin
     try
      qryCompanyBillDetail.post
      except
      qryCompanyBillDetail.Cancel;
      end;
     end;
end;

procedure TfrmCompanyBilling.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PostTheTables;
  CloseAndFreeFiles(dtmMainLocal);
  CloseThisEntity(cintCompanyBilling);
  Action := caFree;
end;

procedure TfrmCompanyBilling.radSearchClick(Sender: TObject);
begin
//If not vbolFinanceView then
//   radSearch.ItemIndex:= 0
//else
   UpdateQuery;
If radSearch.itemindex = 1 then
  cmdCompanyUnpaid.Enabled:= true
else
  cmdCompanyUnpaid.enabled:= false;
end;

procedure TfrmCompanyBilling.UpdateQuery;
begin
PostTheTables;
qryCompanyBillDetail.close;
qryCompanyBill.close;
qryInvoices.close;
If radSearch.ItemIndex = 0 then
  qryInvoices.SQL[4]:= 'BillSent = False'
else
If radSearch.ItemIndex = 2 then
  qryInvoices.SQL[4]:= 'BillPaid = True'
else
  qryInvoices.SQL[4]:= 'BillPaid = false and BillSent = true';
qryInvoices.open;
qryCompanyBill.open;
qryCompanyBillDetail.open;
SynchCompany;
end;

procedure TfrmCompanyBilling.cmdNewDetailClick(Sender: TObject);
begin
If qryCompanyBill.recordcount = 0 then
  exit;
PostTheTables;
qryCompanyBillDetail.Insert;
qryCompanyBillDetail.fieldbyname('InvoiceNumber').asinteger :=
                     qryCompanyBill.fieldbyname('InvoiceNumber').asinteger;
qryCompanyBillDetail.fieldbyname('BillApptDate').asdatetime := date;
qryCompanyBillDetail.fieldbyname('BillInterpreter').asinteger := 0;
qryCompanyBillDetail.fieldbyname('BillPhysician').asinteger := 0;
SynchDetail;
end;

procedure TfrmCompanyBilling.cmdDeleteDetailClick(Sender: TObject);
begin
If qryCompanyBillDetail.recordcount > 0 then
   qryCompanyBillDetail.delete;
SynchDetail;
end;

procedure TfrmCompanyBilling.cmdDeleteAppointmentClick(Sender: TObject);
begin
while qryCompanyBillDetail.recordcount > 0 do
      qryCompanyBillDetail.delete;
If qryCompanyBill.recordcount > 0 then
   qryCompanyBill.delete;
qryInvoices.close;
qryInvoices.open;
SynchCompany;
end;

procedure TfrmCompanyBilling.SynchCompany;
var vintLoop: integer;
begin
  If not qryCompanyBill.active then exit;
   If qryCompanyBill.fieldbyname('Entity').asinteger > 0 then
      begin
      for vintLoop:= 0 to cboCompany.items.count - 1 do
         If pos(inttostr(
                qryCompanyBill.fieldbyname('Entity').asinteger),
                cboCompany.items[vintLoop]) > 0 then
                begin
                cboCompany.itemindex:= vintLoop;
                break;
                end;
      end
   else
      cboCompany.ItemIndex:= 0;
   SynchDetail;
end;

procedure TfrmCompanyBilling.SynchDetail;
var vintLoop: integer;
begin
   If qryCompanyBillDetail.fieldbyname('BillInterpreter').asinteger > 0 then
      begin
      for vintLoop:= 0 to cboInterpreter.items.count - 1 do
         If pos(inttostr(
                qryCompanyBillDetail.fieldbyname('BillInterpreter').asinteger),
                cboInterpreter.items[vintLoop]) > 0 then
                begin
                cboInterpreter.itemindex:= vintLoop;
                break;
                end;
      end
   else
      cboInterpreter.ItemIndex:= -1;

   If qryCompanyBillDetail.fieldbyname('BillPhysician').asinteger > 0 then
      begin
      for vintLoop:= 0 to cboPhysician.items.count - 1 do
         If pos(inttostr(
                qryCompanyBillDetail.fieldbyname('BillPhysician').asinteger),
                cboPhysician.items[vintLoop]) > 0 then
                begin
                cboPhysician.itemindex:= vintLoop;
                break;
                end;
      end
   else
      cboPhysician.ItemIndex:= -1;
end;

procedure TfrmCompanyBilling.cboCompanyClick(Sender: TObject);
var vintInvoice: integer;
begin
If qryCompanyBill.RecordCount > 0 then
  If qryCompanyBill.State = dsBrowse then
     qryCompanyBill.edit;
PostTheTables;
vintInvoice:= qryInvoices.fieldbyname('InvoiceNumber').asinteger;
qryInvoices.close;
qryInvoices.open;
qryInvoices.Locate('InvoiceNumber', vintInvoice, []);
end;

procedure TfrmCompanyBilling.cboInterpreterClick(Sender: TObject);
begin
If (qryCompanyBillDetail.RecordCount > 0) or
    (qryCompanyBillDetail.State = dsInsert) then
  begin
  If qryCompanyBillDetail.State = dsBrowse then
   qryCompanyBillDetail.edit;
  If length(cboInterpreter.text) > 0 then
     qryCompanyBillDetail.fieldbyname('BillInterpreter').asinteger :=
         strtoint(copy(cboInterpreter.text, pos('(',cboInterpreter.text) + 1,6))
  else
     qryCompanyBillDetail.fieldbyname('BillInterpreter').asinteger := 0;
  end;
end;

procedure TfrmCompanyBilling.cmdNewRecordClick(Sender: TObject);
begin
NewRecord(cintCompanyBilling,0,'',0);
radSearch.ItemIndex:= 0;
UpdateQuery;
end;

procedure TfrmCompanyBilling.cmdPrintApptClick(Sender: TObject);
var vintEntity: integer;
    vstrHold: string;
    vreaHours: real;
    vdatLow, vdatHigh: tdate;
begin
 If (pos('(',cboCompany.text) = 0) or
   (qryCompanyBillDetail.recordcount = 0) then
    exit;
  
 PostTheTables;

{allign the database}
 vintEntity:= strtoint(copy(cboCompany.text, pos('(',cboCompany.text) + 1,5));
 dtmMainLocal.qryEntity.locate('Entity', vintEntity, []);
 dtmMainLocal.qryInsurance.locate('Entity', vintEntity, []);
 dtmMainLocal.qryAddress.locate('Entity', vintEntity, []);

 dtsCompanyBillDetail.Enabled:= false;
 qryCompanyBillDetail.first;
 vreaHours:= 0;
 vdatLow:= qryCompanyBillDetail.fieldbyname('BillApptDate').asdatetime;
 vdatHigh:= vdatLow;

{Loop through this invoice and calculate the date range, hours, total amount}
If vbolFinanceView then
  begin
  while not qryCompanyBillDetail.Eof do
    begin
    vreaHours:=
              vreahours + qryCompanyBillDetail.fieldbyname('BillHours').asfloat;
    If vdatLow > qryCompanyBillDetail.fieldbyname('BillApptDate').asdatetime then
      vdatLow := qryCompanyBillDetail.fieldbyname('BillApptDate').asdatetime;
    If vdatHigh <
                qryCompanyBillDetail.fieldbyname('BillApptDate').asdatetime then
      vdatHigh := qryCompanyBillDetail.fieldbyname('BillApptDate').asdatetime;
    qryCompanyBillDetail.next;
    end;
  If qryCompanyBill.state = dsBrowse then
    qryCompanyBill.edit;
  qryCompanyBill.fieldbyname('BillTotalAmount').asfloat:=
     vreaHours * dtmMainLocal.qryInsurance.fieldbyname('Rate').asfloat;
  qryCompanyBill.fieldbyname('BillTotalHours').asfloat:= vreaHours;
  PostTheTables;
  end;

 dtsCompanyBillDetail.Enabled:= true;
 
 rptInvoice := trptInvoice.Create(nil);
 try
   rptInvoice.lbl_10008.caption :=
               datetostr(vdatLow) + ' to ' + datetostr(vdatHigh);
   IF vbolFinanceView then
      rptInvoice.lbl_20005.caption := format(
           '%6.2m', [dtmMainLocal.qryInsurance.fieldbyname('Rate').ascurrency])
   else
      rptInvoice.lbl_20005.caption := '';
   rptInvoice.memLegal.Lines[1] :=
            rptInvoice.memLegal.Lines[1] + ' ' + FillDefault('Company');
   vstrHold:= FillDefault('InvoiceName')
                          + '|' +
                          FillDefault('InvoiceAddr');
   rptInvoice.memcompany.lines.text:=
                          StringReplace(vstrHold, '|', #13#10, [rfReplaceAll]);
   rptInvoice.vstlInterpreters.text:= cboInterpreter.Items.text;
   rptInvoice.vstlPhysicians.text:= cboPhysician.Items.text;
   rptInvoice.vqryTemp := qryCompanyBillDetail;
   rptInvoice.DataSet := rptInvoice.vqryTemp;
   rptInvoice.bndDetail.DataSet := rptInvoice.vqryTemp;
   rptInvoice.edtDate.dataset:= rptInvoice.vqryTemp;
   rptInvoice.edtPatient.dataset:= rptInvoice.vqryTemp;
   rptInvoice.edtHours.dataset:= rptInvoice.vqryTemp;
   rptInvoice.edtPatientComment.dataset:= rptInvoice.vqryTemp;
   rptInvoice.lbl_10003.Caption:=
                           qryCompanyBill.fieldbyname('invoicenumber').asstring;
   rptInvoice.lbl_10006.Caption:=
                           qryCompanyBill.fieldbyname('billdate').asstring;
   rptInvoice.lbl_20004.caption:=
                          qryCompanyBill.fieldbyname('billtotalhours').asstring;
   IF vbolFinanceView then
      rptInvoice.lbl_20006.caption:= format(
           '%6.2m', [qryCompanyBill.fieldbyname('billtotalamount').ascurrency])
   else
      rptInvoice.lbl_20006.caption:='';
   rptInvoice.memClient.lines.text:=
               dtmMainLocal.qryEntity.fieldbyname('entitydescription').asstring;
   If length
         (dtmMainLocal.qryInsurance.fieldbyname('department').asstring) > 0 then
       rptInvoice.memClient.lines.add
                 (dtmMainLocal.qryInsurance.fieldbyname('department').asstring);
   rptInvoice.memClient.lines.add
                 (dtmMainLocal.qryAddress.fieldbyname('AddressLine1').asstring);
   If dtmMainLocal.qryAddress.fieldbyname('AddressLine2').asstring > '  A' then
        rptInvoice.memClient.lines.add
                 (dtmMainLocal.qryAddress.fieldbyname('AddressLine2').asstring);
   rptInvoice.memClient.lines.add(
        dtmMainLocal.qryAddress.fieldbyname('AddressCity').asstring
        + ', ' +
        dtmMainLocal.qryAddress.fieldbyname('AddressState').asstring
        + ' ' +
        dtmMainLocal.qryAddress.fieldbyname('AddressZip').asstring
        + ' ' +
        dtmMainLocal.qryAddress.fieldbyname('AddressZip4').asstring
        );
   rptInvoice.vqryAddress:= dtmMainLocal.qryAddress;
   rptInvoice.Preview;
     finally
     rptInvoice.free;
     rptInvoice := nil;
     end;
end;

procedure TfrmCompanyBilling.cmdSummaryClick(Sender: TObject);
begin
pnlDates.Align:= alClient;
pnlDates.Visible:= true;
end;

procedure TfrmCompanyBilling.cmdSummaryPreviewClick(Sender: TObject);
begin
PostTheTables;
qrySummaryReport.sql[12]:=
                       'and CompanyBill.BillDate >= "' + edtFromDate.text + '"';
qrySummaryReport.sql[13]:=
                       'and CompanyBill.BillDate <= "' + edtToDate.text + '"';
qrySummaryReport.sql[14]:= '';

qrySummaryReport.open;
rptInvoiceSummary := trptInvoiceSummary.Create(nil);
try
 rptInvoiceSummary.vqryTemp:= qrySummaryReport;
 rptInvoiceSummary.lbl_10008.caption :=
                                     edtFromDate.text + ' to ' + edtToDate.text;

 rptInvoiceSummary.DataSet := rptInvoiceSummary.vqryTemp;
 rptInvoiceSummary.bndDetail.DataSet := rptInvoiceSummary.vqryTemp;
 rptInvoiceSummary.lblInvoice.Dataset := rptInvoiceSummary.vqryTemp;
 rptInvoiceSummary.lblDate.Dataset := rptInvoiceSummary.vqryTemp;
 rptInvoiceSummary.lblCompany.Dataset := rptInvoiceSummary.vqryTemp;
 rptInvoiceSummary.lblDepartment.Dataset := rptInvoiceSummary.vqryTemp;
 rptInvoiceSummary.lblAmount.Dataset := rptInvoiceSummary.vqryTemp;
 rptInvoiceSummary.lblBalance.Dataset := rptInvoiceSummary.vqryTemp;
 rptInvoiceSummary.lblPayment.Dataset := rptInvoiceSummary.vqryTemp;

 rptInvoiceSummary.Preview;
  finally
  rptInvoiceSummary.free;
  rptInvoiceSummary := nil;
  end;

qrySummaryReport.close;
pnlDates.Visible:= false;
end;

procedure TfrmCompanyBilling.cmdNoReportClick(Sender: TObject);
begin
pnlDates.Visible:= false;
end;

procedure TfrmCompanyBilling.qryCompanyBillBeforePost(DataSet: TDataSet);
begin
 qryCompanyBill.fieldbyname('BillTotalBalance').asfloat :=
    qryCompanyBill.fieldbyname('BillTotalAmount').asfloat -
    qryCompanyBill.fieldbyname('BillTotalPayment').asfloat;

 If length(cboCompany.text) > 0 then
     qryCompanyBill.fieldbyname('Entity').asinteger :=
             strtoint(copy(cboCompany.text, pos('(',cboCompany.text) + 1,5))
 else
     qryCompanyBill.fieldbyname('Entity').asinteger := 0;
end;

procedure TfrmCompanyBilling.cboPhysicianClick(Sender: TObject);
begin
If (qryCompanyBillDetail.RecordCount > 0) or
    (qryCompanyBillDetail.State = dsInsert) then
  begin
  If qryCompanyBillDetail.State = dsBrowse then
   qryCompanyBillDetail.edit;
  If length(cboPhysician.text) > 0 then
     qryCompanyBillDetail.fieldbyname('BillPhysician').asinteger :=
         strtoint(copy(cboPhysician.text, pos('(',cboPhysician.text) + 1,5))
  else
     qryCompanyBillDetail.fieldbyname('BillPhysician').asinteger := 0;
  end;
end;

procedure TfrmCompanyBilling.dtsInvoicesDataChange(Sender: TObject;
  Field: TField);
begin
SynchCompany;
end;

procedure TfrmCompanyBilling.dtsCompanyBillDetailDataChange(
  Sender: TObject; Field: TField);
begin
SynchDetail;
end;

procedure TfrmCompanyBilling.cmd30_60_90Click(Sender: TObject);
begin
pnl30_60_90.Align:= alClient;
pnl30_60_90.Visible:= true;
end;

procedure TfrmCompanyBilling.SpeedButton2Click(Sender: TObject);
begin
pnl30_60_90.Visible:= false;
end;

procedure TfrmCompanyBilling.cmdPrint_30_60_90Click(Sender: TObject);
var vdat3060901, vdat3060902: tdatetime;
begin
PostTheTables;
If radDays.ItemIndex = 0 then
  begin
  vdat3060901:= now - 30;
  vdat3060902:= now - 59;
  end
else
If radDays.ItemIndex = 1 then
  begin
  vdat3060901:= now - 60;
  vdat3060902:= now - 89;
  end
else
  begin
  vdat3060901:= now - 90;
  vdat3060902:= now - 2000;
  end;
qrySummaryReport.sql[12]:=
            'and CompanyBill.BillDate >= "' + datetimetostr(vdat3060902) + '"';
qrySummaryReport.sql[13]:=
            'and CompanyBill.BillDate <= "' + datetimetostr(vdat3060901) + '"';
qrySummaryReport.sql[14]:= 'and (BillPaid = false)';

qrySummaryReport.open;
rptInvoiceSummary306090 := trptInvoiceSummary306090.Create(nil);

If radDays.ItemIndex = 0 then
  rptInvoiceSummary306090.lbl_0007.caption := 'Invoices overdue from 30-59 days'
else
If radDays.ItemIndex = 1 then
  rptInvoiceSummary306090.lbl_0007.caption := 'Invoices overdue from 60-89 days'
else
  rptInvoiceSummary306090.lbl_0007.caption :=
                                        'Invoices overdue greater than 90 days';
try
 rptInvoiceSummary306090.vqryTemp:= qrySummaryReport;
 rptInvoiceSummary306090.DataSet := rptInvoiceSummary306090.vqryTemp;
 rptInvoiceSummary306090.bndDetail.DataSet := rptInvoiceSummary306090.vqryTemp;
 rptInvoiceSummary306090.lblInvoice.Dataset := rptInvoiceSummary306090.vqryTemp;
 rptInvoiceSummary306090.lblDate.Dataset := rptInvoiceSummary306090.vqryTemp;
 rptInvoiceSummary306090.lblCompany.Dataset := rptInvoiceSummary306090.vqryTemp;
 rptInvoiceSummary306090.lblDepartment.Dataset :=
                                               rptInvoiceSummary306090.vqryTemp;
 rptInvoiceSummary306090.lblAmount.Dataset := rptInvoiceSummary306090.vqryTemp;
 rptInvoiceSummary306090.lblBalance.Dataset := rptInvoiceSummary306090.vqryTemp;
 rptInvoiceSummary306090.lblPayment.Dataset := rptInvoiceSummary306090.vqryTemp;

 rptInvoiceSummary306090.Preview;
  finally
  rptInvoiceSummary306090.free;
  rptInvoiceSummary306090 := nil;
  end;

qrySummaryReport.close;
pnl30_60_90.Visible:= false;
end;

procedure TfrmCompanyBilling.cmdCompanyUnpaidClick(Sender: TObject);
begin
If qryInvoices.RecordCount = 0 then
   exit;

end;

end.
