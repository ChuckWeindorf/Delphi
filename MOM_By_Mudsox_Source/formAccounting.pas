unit formAccounting;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ToolWin, ComCtrls, Db, DBTables, Grids,
  DBGrids, Mask;

type
  TfrmAccounting = class(TForm)
    tbl1: TToolBar;
    pnlMain: TPanel;
    pnlSearch: TPanel;
    pnlResults: TPanel;
    cmdSearch: TSpeedButton;
    radType: TRadioGroup;
    radDates: TRadioGroup;
    lbl_10101: TLabel;
    lbl_10102: TLabel;
    edtDateFrom: TMaskEdit;
    edtDateTo: TMaskEdit;
    grdAcctResult: TDBGrid;
    dtsAccounting: TDataSource;
    qryAccounting: TQuery;
    cmdPrev: TSpeedButton;
    cmdexit: TSpeedButton;
    cmdVideo: TSpeedButton;
    cmdHelp: TSpeedButton;
    spl1: TSplitter;
    edtTotal: TEdit;
    lbl_1009: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdSearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdAcctResultDblClick(Sender: TObject);
    procedure cmdexitClick(Sender: TObject);
    procedure radDatesClick(Sender: TObject);
    procedure cmdPrevClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAccounting: TfrmAccounting;

implementation

{$R *.DFM}

uses procSharedDatamoduleCalls, formAccountingQR;

procedure TfrmAccounting.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CloseThisEntity(cintFinance);
  Action := caFree;
end;

procedure TfrmAccounting.cmdSearchClick(Sender: TObject);
  var vstrHoldDateField: string;
      vreaTotal: real;
begin
try
If radDates.Itemindex = 3 then
  begin
  strtodate(edtDateFrom.text);
  strtodate(edtDateTo.text);
  end;
except
  Showmessage('Please check the Criteria dates');
  exit;
  end;
qryAccounting.close;
qryAccounting.SQL.Clear;
qryAccounting.SQL.add
    ('Select Distinct Appointment.ApptTicket, Entity.Entity, ' +
      'Entity.EntityDescription,');
If radType.ItemIndex = 2 then
    {Not paid Bills, show the curent balance}
    qryAccounting.SQL.add
    ('            ApptBilling.ApptBillBalance as Fee')
else
If radType.ItemIndex = 1 then
    {All Paid, show the BillPayment}
    qryAccounting.SQL.add
    ('            ApptBilling.ApptBillPayment as Fee')
else
    {All appointments and Not Billed, show the appointment total}
    qryAccounting.SQL.add
    ('            Appointment.ApptFee as Fee');
qryAccounting.SQL.add
     ('From Appointment, Entity, ApptBilling');
qryAccounting.SQL.add
     ('Where (entity.entity = appointment.entity)');
If radType.ItemIndex = 3 then
   qryAccounting.SQL.add
      ('and (appointment.apptbilled = False)')
else
If radType.ItemIndex = 2 then
   begin
   qryAccounting.SQL.add
      ('and (entity.entity = apptbilling.entity)');
   qryAccounting.SQL.add
      ('and (appointment.ApptTicket = apptbilling.ApptTicket)');
   qryAccounting.SQL.add
      ('and (apptbilling.ApptBillClosed = False)');
   end
else
If radType.ItemIndex = 1 then
   begin
   qryAccounting.SQL.add
      ('and (entity.entity = apptbilling.entity)');
   qryAccounting.SQL.add
      ('and (appointment.ApptTicket = apptbilling.ApptTicket)');
   qryAccounting.SQL.add
      ('and (apptbilling.ApptBillClosed = True)');
   end;

If (radType.Itemindex = 0) or (radDates.Itemindex = 3) then
  vstrHoldDateField:= 'Appointment.ApptDateTime'
else
  vstrHoldDateField:= 'ApptBilling.ApptBillDate';

If radDates.Itemindex = 0 then
   begin
   qryAccounting.SQL.add
      ('and (' + vstrHoldDateField + ' <= "' + Datetostr(date - 30) + '")');
   qryAccounting.SQL.add
      ('and (' + vstrHoldDateField + ' >= "' + Datetostr(date - 60) + '")');
   end
else
If radDates.Itemindex = 1 then
   begin
   qryAccounting.SQL.add
      ('and (' + vstrHoldDateField + ' <= "' + Datetostr(date - 60) + '")');
   qryAccounting.SQL.add
      ('and (' + vstrHoldDateField + ' >= "' + Datetostr(date - 90) + '")');
   end
else
If radDates.Itemindex = 2 then
   qryAccounting.SQL.add
      ('and (' + vstrHoldDateField + ' <= "' + Datetostr(date - 90) + '")')
else
   begin
   qryAccounting.SQL.add
      ('and (' + vstrHoldDateField + ' >= "' + edtDateFrom.text + '")');
   qryAccounting.SQL.add
      ('and (' + vstrHoldDateField + ' <= "' + edtDateTo.text + '")');
   end;

qryAccounting.SQL.add
     ('Order By Entity.EntityDescription');
grdAcctResult.enabled:= false;
qryAccounting.open;
vreaTotal:= 0;
while not qryAccounting.eof do
  begin
  try
    vreaTotal:= vreaTotal + qryAccounting.Fieldbyname('Fee').asfloat;
    except
    end;
  qryAccounting.next;
  end;
edtTotal.text := Format('%6.2m',[vreaTotal]);
grdAcctResult.enabled:= true;
end;

procedure TfrmAccounting.FormCreate(Sender: TObject);
begin
   qryAccounting.databasename := 'mmom_maindatabase';
end;
procedure TfrmAccounting.grdAcctResultDblClick(Sender: TObject);
var vbolDummy: boolean;
begin
  //open the current patient form
  vintCurrentApptTicket := qryAccounting.fieldbyname('ApptTicket').asinteger;
  vintCurrentEntity := qryAccounting.fieldbyname('Entity').asinteger;
  {This is the sneaky way to cann a routine in a form that created you!}
  vbolDummy := false;
  vfrmMainMenu.onclosequery(Sender, vbolDummy);
end;

procedure TfrmAccounting.cmdexitClick(Sender: TObject);
begin
Close;
end;

procedure TfrmAccounting.radDatesClick(Sender: TObject);
begin
If radDates.ItemIndex = 3 then
  begin
  edtDateFrom.enabled:= true;
  edtDateTo.enabled:= true;
  end
else
  begin
  edtDateFrom.enabled:= false;
  edtDateTo.enabled:= false;
  edtDateFrom.text:= '';
  edtDateTo.text:= '';
  end;
end;

procedure TfrmAccounting.cmdPrevClick(Sender: TObject);
begin
  vqryQuickReport:= qryAccounting;
  frmAccountingQR := tfrmAccountingQR.Create(nil);
  frmAccountingQR.edtTotal.caption:= edtTotal.text;
  try
    frmAccountingQR.rptAccounting.Preview;
  finally
    frmAccountingQR.release;
    frmAccountingQR := nil;
  end;
end;

end.
