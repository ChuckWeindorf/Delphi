unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Query1: TQuery;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
query1.SQL.text := 'Alter Table Patient add COLUMN PatientTobacco varchar(25)';
query1.ExecSQL;
query1.SQL.text := 'Alter Table Query add COLUMN QueryDistinct boolean';
query1.ExecSQL;
query1.SQL.text := 'Update Patient set PatientTobacco = "Unknown"';
query1.ExecSQL;
query1.SQL.text := 'Update Query set QueryDistinct = "false"';
query1.ExecSQL;
query1.SQL.text:= 'Select * from Picklist';
query1.open;
query1.Insert;
query1['ListField']:= 'PatientTobacco';
query1['Listvalue']:= 'Unknown';
query1.post;
query1.Insert;
query1['ListField']:= 'PatientTobacco';
query1['Listvalue']:= 'Smoker';
query1.post;
query1.Insert;
query1['ListField']:= 'PatientTobacco';
query1['Listvalue']:= 'Non-smoker';
query1.post;
query1.Insert;
query1['ListField']:= 'PatientTobacco';
query1['Listvalue']:= 'Quit smoking/tobacco';
query1.post;
query1.Insert;
query1['ListField']:= 'PatientTobacco';
query1['Listvalue']:= 'Tobacco chew';
query1.post;
query1.Insert;
query1['ListField']:= 'PatientTobacco';
query1['Listvalue']:= 'Smoker/Tobacco chew';
query1.post;
query1.close;


end;

end.
