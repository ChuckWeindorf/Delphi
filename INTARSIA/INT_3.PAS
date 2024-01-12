unit Int_3;

interface
              
uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Grids, DBGrids, DB, DBTables, ExtCtrls, DBCtrls;

type
  TForm3 = class(TForm)
    DataSource1: TDataSource;
    Table1: TTable;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Table1ReceiptDate: TDateField;
    Table1ReceiptDescription: TStringField;
    Table1ReceiptCost: TCurrencyField;
    Table1ReceiptPercent: TSmallintField;
    Table1ReceiptPercentLast: TSmallintField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.DFM}

end.
