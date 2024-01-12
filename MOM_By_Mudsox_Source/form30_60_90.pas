unit form30_60_90;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, DBTables, form30_60_90QR;

type
  Tfrm30_60_90 = class(TForm)
    cmdPrint: TSpeedButton;
    cbo30_60_90: TComboBox;
    lbl1: TLabel;
    tblAppointment: TTable;
    tblAcctSummary: TTable;
    tblEntity: TTable;
    tblApptBilling: TTable;
    procedure FormCreate(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm30_60_90: Tfrm30_60_90;

implementation

{$R *.DFM}

procedure Tfrm30_60_90.FormCreate(Sender: TObject);
begin
cbo30_60_90.ItemIndex:= 0;
end;

{procedure Tfrm30_60_90.cmdPrintClick(Sender: TObject);
var vreaBalance, vreaBigBalance: real;
    vintAppt, vintEntity, vintDays: integer;
    vdatTran: tdatetime;
    Procedure CheckBalance;
      begin
       If (vreaBalance <> 0) then
         If ((vintDays = 30) and (date-vdatTran > 29) and (date-vdatTran < 60))
           or
            ((vintDays = 60) and (date-vdatTran > 59) and (date-vdatTran < 90))
           or
            ((vintDays = 90) and (date-vdatTran > 90)) then
           begin
           tblAcctSummary.Insert;
           try
           tblAcctSummary.fieldbyName('ApptTicket').asinteger := vintAppt;
           tblAcctSummary.fieldbyName('ApptPayTranDate').asdatetime := vdatTran;
           tblAcctSummary.fieldbyName('ApptBalance').asfloat := vreaBalance;
           vreaBigBalance:= vreaBigBalance + vreaBalance;
           If tblEntity.findkey([vintEntity]) then
            tblAcctSummary.fieldbyname('EntityDescription').asstring :=
                            tblEntity.fieldbyname('EntityDescription').asstring;
           tblAcctSummary.post;
             except
             tblAcctSummary.cancel;
             end
           end;
       vreaBalance := 0;
       vintAppt:= tblApptAccount.fieldbyName('ApptTicket').asinteger;
       vintEntity:= tblApptAccount.fieldbyName('Entity').asinteger;
       vdatTran:= tblApptAccount.fieldbyName('ApptPayTranDate').asdatetime;
      end;
begin
vintDays:= strtoint(copy(cbo30_60_90.text,1,2));
tblAcctSummary.EmptyTable;
tblAcctSummary.open;
tblEntity.open;
tblApptAccount.open;
vreaBalance := 0;
vintAppt:= tblApptAccount.fieldbyName('ApptTicket').asinteger;
vintEntity:= tblApptAccount.fieldbyName('Entity').asinteger;
vdatTran:= tblApptAccount.fieldbyName('ApptPayTranDate').asdatetime;

while not tblApptAccount.eof do
   begin
   If ((copy(tblApptAccount.fieldbyName('ApptPayTranType').asstring,1,1) = '1')
      and (tblApptAccount.fieldbyName('ApptPayTranAmount').asfloat > 0)) or
      ((copy(tblApptAccount.fieldbyName('ApptPayTranType').asstring,1,1) <> '1')
      and (tblApptAccount.fieldbyName('ApptPayTranAmount').asfloat < 0)) then
      begin
      tblApptAccount.Edit;
      tblApptAccount.fieldbyName('ApptPayTranAmount').asfloat:=
              tblApptAccount.fieldbyName('ApptPayTranAmount').asfloat * -1;
      tblApptAccount.post;
      end;
   If (vintAppt <> tblApptAccount.fieldbyName('ApptTicket').asinteger) then
      CheckBalance;
   vreaBalance := vreaBalance +
                        tblApptAccount.fieldbyName('ApptPayTranAmount').asfloat;
   tblApptAccount.next;
   end;
If tblApptAccount.recordCount > 0 then
   CheckBalance;

rpt30_60_90 := trpt30_60_90.Create(nil);

If cbo30_60_90.ItemIndex = 0 then
  rpt30_60_90.lbl_0007.caption := 'Appointment fees overdue from 30-59 days'
else
If cbo30_60_90.ItemIndex = 1 then
  rpt30_60_90.lbl_0007.caption := 'Appointment fees overdue from 60-89 days'
else
  rpt30_60_90.lbl_0007.caption :=
                                'Appointment fees overdue greater than 90 days';
try
 rpt30_60_90.tblTemp.databaseName:= tblAcctSummary.databasename;
 rpt30_60_90.tblTemp.tablename:= tblAcctSummary.tablename;
 rpt30_60_90.tblTemp.open;
 rpt30_60_90.lblBalTot.caption:= format('%6.2m', [vreaBigBalance]);
 rpt30_60_90.Prepare;
 rpt30_60_90.Preview;
  finally
  rpt30_60_90.free;
  rpt30_60_90 := nil;
  end;

tblAcctSummary.close;
tblEntity.close;
tblApptAccount.close;

end;}


procedure Tfrm30_60_90.cmdPrintClick(Sender: TObject);
var vreaBalance, vreaBigBalance: real;
    vintDays: integer;
    vdatTran: tdatetime;
    Procedure CheckBalance;
      begin
         vdatTran:= tblApptBilling.fieldbyName('ApptBillDate').asfloat;
         If ((vintDays = 30) and (date-vdatTran > 29) and (date-vdatTran < 60))
           or
            ((vintDays = 60) and (date-vdatTran > 59) and (date-vdatTran < 90))
           or
            ((vintDays = 90) and (date-vdatTran > 90)) then
           begin
           tblAcctSummary.Insert;
           try
           tblAcctSummary.fieldbyName('ApptTicket').asinteger :=
                             tblApptBilling.fieldbyName('ApptTicket').asinteger;
           tblAcctSummary.fieldbyName('ApptPayTranDate').asdatetime :=
                          tblApptBilling.fieldbyName('ApptBillDate').asdatetime;
           tblAcctSummary.fieldbyName('ApptBalance').asfloat:=
                          tblApptBilling.fieldbyName('ApptBillBalance').asfloat;
           vreaBigBalance:= vreaBigBalance +
                          tblApptBilling.fieldbyName('ApptBillBalance').asfloat;
           If tblAppointment.findkey
                     ([tblApptBilling.fieldbyName('ApptTicket').asinteger]) then
              begin
              tblAcctSummary.fieldbyName('Entity').asfloat:=
                                 tblApptBilling.fieldbyName('Entity').asinteger;
              If tblEntity.findkey
                     ([tblAppointment.fieldbyName('Entity').asinteger]) then
                tblAcctSummary.fieldbyname('EntityDescription').asstring :=
                            tblEntity.fieldbyname('EntityDescription').asstring;
              end;
           tblAcctSummary.post;
             except
             tblAcctSummary.cancel;
             end
           end;
       vreaBalance := 0;
      end;
begin
vintDays:= strtoint(copy(cbo30_60_90.text,1,2));
tblAcctSummary.EmptyTable;
tblAcctSummary.open;
tblEntity.open;
tblApptBilling.open;
tblAppointment.open;
vreaBalance := 0;

while not tblApptBilling.eof do
   begin
   try
   If (not tblApptBilling.fieldbyName('ApptBillClosed').asboolean)
     and (tblApptBilling.fieldbyName('ApptBillBalance').asfloat > 0) then
      CheckBalance;
      except end;
   tblApptBilling.next;
   end;

rpt30_60_90 := trpt30_60_90.Create(nil);

If cbo30_60_90.ItemIndex = 0 then
  rpt30_60_90.lbl_0007.caption := 'Appointment fees overdue from 30-59 days'
else
If cbo30_60_90.ItemIndex = 1 then
  rpt30_60_90.lbl_0007.caption := 'Appointment fees overdue from 60-89 days'
else
  rpt30_60_90.lbl_0007.caption :=
                                'Appointment fees overdue greater than 90 days';
try
 rpt30_60_90.tblTemp.databaseName:= tblAcctSummary.databasename;
 rpt30_60_90.tblTemp.tablename:= tblAcctSummary.tablename;
 rpt30_60_90.tblTemp.open;
 rpt30_60_90.lblBalTot.caption:= format('%6.2m', [vreaBigBalance]);
 rpt30_60_90.Prepare;
 rpt30_60_90.Preview;
  finally
  rpt30_60_90.free;
  rpt30_60_90 := nil;
  end;

tblAcctSummary.close;
tblEntity.close;
tblApptBilling.close;

end;

end.

