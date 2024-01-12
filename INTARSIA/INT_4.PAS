unit Int_4;

interface
        
uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Grids, DBGrids, DB, DBTables, ExtCtrls, DBCtrls, StdCtrls;

type
  TForm4 = class(TForm)
    DataSource1: TDataSource;
    Table1: TTable;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Table1ItemName: TStringField;
    Table1Height: TFloatField;
    Table1Width: TFloatField;
    Table1SalePrice: TCurrencyField;
    Table1WastePercent: TFloatField;
    Table1AdjSquareIn: TFloatField;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.DFM}

procedure TForm4.Button1Click(Sender: TObject);
begin
If table1.State <> dsbrowse then
   table1.post;
table1.edit;
table1['AdjSquareIn'] := round((table1['Height'] * table1['Width'] -
             (table1['Height'] * table1['Width'] * (table1['wastepercent']/100))
             )*100) / 100;
table1.post;
end;

end.
