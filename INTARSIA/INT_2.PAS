unit Int_2;

interface
                     
uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Mask, DBCtrls, DB, DBTables, ExtCtrls, DBLookup,
  Grids, DBGrids, qr_1;

type
  TForm2 = class(TForm)
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Panel1: TPanel;
    DBEdit9: TDBEdit;
    DBEdit1: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBLookupCombo1: TDBLookupCombo;
    DataSource1: TDataSource;
    Table1: TTable;
    DataSource2: TDataSource;
    Table2: TTable;
    DataSource3: TDataSource;
    Table3: TTable;
    Panel3: TPanel;
    Panel4: TPanel;
    DBLookupCombo2: TDBLookupCombo;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Query1: TQuery;
    DataSource4: TDataSource;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    Button1: TButton;
    Label11: TLabel;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Label12: TLabel;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    Label13: TLabel;
    procedure DBLookupCombo2Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure DataSource4DataChange(Sender: TObject; Field: TField);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.DFM}

procedure TForm2.DBLookupCombo2Change(Sender: TObject);
begin
query1.close;
Query1.SQL.Text := 'Select ItemID, ItemName, DateCreated, DateSold from int_inve.db where ItemName = "' +
          dblookupcombo2.Value + '" order by DateCreated, DateSold';
query1.open;
edit1.Text := inttostr(query1.recordcount);
if query1.recordcount > 0 then
    table1.FindKey([query1['itemid']]);
end;

procedure TForm2.Button1Click(Sender: TObject);
var vintNext: integer;
begin
table1.last;
vintNext:= table1['ItemID'];
table1.Insert;
inc(vintNext);
table1['itemid']:= vintnext;
table1['itemname']:= dblookupcombo2.Value;
table1['datecreated']:=date;
table1.post;
table1.flushbuffers;
query1.close;
query1.open;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
table1.delete;

query1.close;
query1.open;
if query1.recordcount > 0 then
    table1.FindKey([query1['itemid']]);
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
If table1.State = dsEdit then
  begin
  table1.post;
  table1.flushbuffers;
  query1.close;
  query1.open;
  end;
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
rptCert.qrlabel3.caption := table1['ItemName'];
rptCert.qrlabel4.caption :=
                  'Serial Number: DAW' + table1.fieldbyname('ItemID').asstring;
rptCert.Prepare;
rptCert.preview;
end;

procedure TForm2.DataSource4DataChange(Sender: TObject; Field: TField);
begin
if query1.recordcount > 0 then
    table1.FindKey([query1['itemid']]);
end;

end.
