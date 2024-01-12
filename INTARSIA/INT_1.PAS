unit Int_1;

interface
       
uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus, Int_2, Int_3, Int_4, StdCtrls, Db, DBTables,
  qr_2;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Inventory1: TMenuItem;
    Costs1: TMenuItem;
    Catalog1: TMenuItem;
    Reports1: TMenuItem;
    ValueofSalesAnnual1: TMenuItem;
    ValueofInventoryAnnual1: TMenuItem;
    ValueofCreatedAnnual1: TMenuItem;
    Edit1: TEdit;
    Label1: TLabel;
    Calculate1: TMenuItem;
    Edit2: TEdit;
    Edit3: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit4: TEdit;
    AnnualFunctions1: TMenuItem;
    ApplyBuildCostforYear1: TMenuItem;
    MoveMaterialtoPreviousYear1: TMenuItem;
    procedure Inventory1Click(Sender: TObject);
    procedure Costs1Click(Sender: TObject);
    procedure Catalog1Click(Sender: TObject);
    procedure CostsSummary1Click(Sender: TObject);
    procedure Inventory2Click(Sender: TObject);
    procedure Sales1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Calculate1Click(Sender: TObject);
    procedure ApplyBuildCostforYear1Click(Sender: TObject);
    procedure MoveMaterialtoPreviousYear1Click(Sender: TObject);
    procedure ValueofSalesAnnual1Click(Sender: TObject);
    procedure ValueofInventoryAnnual1Click(Sender: TObject);
    procedure ValueofCreatedAnnual1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Inventory1Click(Sender: TObject);
begin
  Form1.Hide;
  Int_2.Form2.Table1.Open;
  Int_2.Form2.Table2.Open;
  Int_2.Form2.Table3.Open;
  Int_2.Form2.ShowModal;
  Int_2.Form2.Table1.Close;
  Int_2.Form2.Table2.Close;
  Int_2.Form2.Table3.Close;
  Form1.Show;
end;

procedure TForm1.Costs1Click(Sender: TObject);
begin
  Form1.Hide;
  Int_3.Form3.Table1.Open;
  Int_3.Form3.ShowModal;
  Int_3.Form3.Table1.Close;
  Form1.Show;

end;

procedure TForm1.Catalog1Click(Sender: TObject);
begin
  Form1.Hide;
  Int_4.Form4.Table1.Open;
  Int_4.Form4.ShowModal;
  Int_4.Form4.Table1.Close;
  Form1.Show;

end;

procedure TForm1.CostsSummary1Click(Sender: TObject);
begin
//Form1.Report1.AutoUnload := True;
//Form1.Report1.Run;
end;

procedure TForm1.Inventory2Click(Sender: TObject);
begin
//Form1.Report2.AutoUnload := True;
//Form1.Report2.Run;
end;

procedure TForm1.Sales1Click(Sender: TObject);
begin
//Form1.Report3.AutoUnload := True;
//Form1.Report3.Run;
end;



procedure TForm1.FormCreate(Sender: TObject);
begin
edit1.text := copy (datetostr(date), length(datetostr(date)) -3, 4);
end;

procedure TForm1.Calculate1Click(Sender: TObject);
var
vtblCost, vtblInv, vtblItem: ttable;
vreaCostYear: real;
vreaTotalInches: real;
vreaCost: real;
vintYear: integer;
vintCreate: integer;

begin
vintYear:= strtoint(edit1.text);
{First, calculate the value of all building materials for this year...}
vtblCost:= ttable.create(nil);
vtblInv:= ttable.create(nil);
vtblItem:= ttable.create(nil);
try
vtblCost.TableName:= 'INT_COST.DB';
vtblInv.TableName:= 'INT_INVE.DB';
vtblItem.TableName:= 'INT_ITEM.DB';
vtblCost.open;
vreaCostYear:= 0;
while not vtblCost.eof do
  begin
  vreaCostYear:= vreaCostYear
       + round(100*(vtblCost.fieldbyname('ReceiptCost').asfloat
       * ((vtblCost.fieldbyname('ReceiptPercent').asinteger
          - vtblCost.fieldbyname('ReceiptPercentLast').asinteger)/100)))/100;
  vtblCost.next;
  end;
vtblCost.close;
edit2.text := floattostr(vreaCostYear);

vreaTotalInches:= 0;
vtblInv.open;
vtblItem.open;
while not vtblInv.eof do
   begin
   vintCreate:= strtoint(copy(vtblInv.fieldbyname('DateCreated').asstring,
                      length(vtblInv.fieldbyname('DateCreated').asstring)-3,4));
   {All items from 1995 to 2002 treated as a single year.  2003 and forward
   are calculated anually}
   If (vintYear = vintCreate) or
       ((vintYear = 2002) and (vintCreate < 2003)) then
      If vtblItem.findkey([vtblInv.fieldbyname('ItemName').asstring]) then
         vreaTotalInches:= vreaTotalInches + vtblItem['AdjSquareIn']
      else
         ShowMessage('Item does not exist in Catalog - Inches incorrect '
                                    + vtblInv.fieldbyname('ItemName').asstring);
   vtblInv.next;
   end;
   vreaTotalInches:= round(vreaTotalInches * 100) / 100;
edit3.text := floattostr(vreaTotalInches);
vreaCost:= round((vreaCostYear/vreaTotalInches) *10000) / 10000;
edit4.text := floattostr(vreaCost);

vtblInv.close;
vtblItem.close;
finally
   vtblCost.free;
   vtblItem.free;
   vtblInv.free;
   end;
end;

procedure TForm1.ApplyBuildCostforYear1Click(Sender: TObject);
var vtblInv: ttable;
    vtblItem: ttable;
    vintCreate: integer;
    vintYear: integer;
begin
If length(edit2.text) = 0 then
   begin
   ShowMessage('Run Calc_To_Date First with the right Year');
   exit;
   end;

vintYear:= strtoint(edit1.text);
vtblInv:= ttable.create(nil);
vtblInv.Tablename:= 'INT_INVE.DB';
vtblInv.open;
vtblItem:= ttable.create(nil);
vtblItem.Tablename:= 'INT_ITEM.DB';
vtblItem.open;
try
while not vtblInv.eof do
   begin
   vintCreate:= strtoint(copy(vtblInv.fieldbyname('DateCreated').asstring,
                      length(vtblInv.fieldbyname('DateCreated').asstring)-3,4));
   {All items from 1995 to 2002 treated as a single year.  2003 and forward
   are calculated anually}
   If (vintYear = vintCreate) or
       ((vintYear = 2002) and (vintCreate < 2003)) then
      If vtblItem.findkey([vtblInv.fieldbyname('ItemName').asstring]) then
         If vtblInv.fieldbyName('BuildCost').asfloat = 0 then
            begin
            vtblInv.edit;
            vtblInv.fieldbyName('BuildCost').asfloat:=
                round((vtblItem['AdjSquareIn'] * strtofloat(edit4.text)) *100) /100;
            vtblInv.post;
            end;

   vtblInv.next;
   end;
vtblInv.close;
vtblItem.Close;
finally
  vtblInv.free;
  vtblItem.Free;
  end;
end;

procedure TForm1.MoveMaterialtoPreviousYear1Click(Sender: TObject);
var
vtblCost: ttable;
begin
{Move the current year percent to the "old" year percent to start a new year of
accounting}
vtblCost:= ttable.create(nil);
try
vtblCost.TableName:= 'INT_COST.DB';
vtblCost.open;
while not vtblCost.eof do
  begin
  vtblCost.edit;
  vtblCost['ReceiptPercentLast']:= vtblCost['ReceiptPercent'];
  vtblCost.post;
  vtblCost.next;
  end;
vtblCost.close;

finally
   vtblCost.free;
   end;

end;

procedure TForm1.ValueofSalesAnnual1Click(Sender: TObject);
begin

rptInventory.qrlabel1.caption:= 'Intarsia Sales for ' + edit1.text;

rptInventory.qryRpt.sql.text :=
     'Select * from INT_INVE where EXTRACT(YEAR FROM DateSold) = "' + edit1.text + '" ' +
     'Order By ItemName, DateSold';

rptInventory.qryRpt.Open;
rptInventory.Preview;
rptInventory.qryRpt.close;

end;

procedure TForm1.ValueofInventoryAnnual1Click(Sender: TObject);
begin

rptInventory.qrlabel1.caption:= 'Intarsia Unsold Inventory';

rptInventory.qryRpt.sql.text :=
     'Select * from INT_INVE where DateSold is Null ' +
     'Order By ItemName, DateCreated';

rptInventory.qryRpt.Open;
rptInventory.Preview;
rptInventory.qryRpt.close;

end;

procedure TForm1.ValueofCreatedAnnual1Click(Sender: TObject);
begin
rptInventory.qrlabel1.caption:= 'Intarsia Created in ' + edit1.text;

rptInventory.qryRpt.sql.text :=
     'Select * from INT_INVE where EXTRACT(YEAR FROM DateCreated) = "' + edit1.text + '" ' +
     'Order By ItemName, DateCreated';

rptInventory.qryRpt.Open;
rptInventory.Preview;
rptInventory.qryRpt.close;
end;

end.
