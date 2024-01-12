unit formCindySummary;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  procSharedDatamoduleCalls, ExtCtrls, Buttons, ToolWin, ComCtrls, Db,
  DBTables, Grids, DBGrids, rptOpenBills;

type
  TfrmCindySummary = class(TForm)
    ToolBar1: TToolBar;
    cmdexit: TSpeedButton;
    Splitter1: TSplitter;
    Panel1: TPanel;
    grdAnswers: TDBGrid;
    qryOpenBills: TQuery;
    dtsOpenBills: TDataSource;
    qryOpenBillsEntity: TIntegerField;
    qryOpenBillsEntityDescription: TStringField;
    qryOpenBillsPatientbalance: TCurrencyField;
    cmdPatient: TSpeedButton;
    cmdAccounting: TSpeedButton;
    Splitter2: TSplitter;
    cmdPrintAppt: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdexitClick(Sender: TObject);
    procedure cmdPatientClick(Sender: TObject);
    procedure cmdAccountingClick(Sender: TObject);
    procedure cmdPrintApptClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(Aowner : TComponent); override;
  end;

var
  frmCindySummary: TfrmCindySummary;

implementation

{$R *.DFM}

constructor TfrmCindySummary.Create(AOwner: TComponent);
begin

  {Create all form components and other start-up activities}
  Inherited create(AOwner);

  qryOpenBills.active:= true;
end;

procedure TfrmCindySummary.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  qryOpenBills.active:= false;
  CloseThisEntity(cintCindySummary);
  Action := caFree;
end;

procedure TfrmCindySummary.cmdexitClick(Sender: TObject);
begin
close;
end;

procedure TfrmCindySummary.cmdPatientClick(Sender: TObject);
var vbolDummy: boolean;
begin
  vintCurrentEntity := qryOpenBills.fieldbyname('Entity').asinteger;
  {This is the sneaky way to cann a routine in a form that created you!}
  vbolDummy := false;
  vfrmMainMenu.onclosequery(Sender, vbolDummy);
end;

procedure TfrmCindySummary.cmdAccountingClick(Sender: TObject);
var vbolDummy: boolean;
begin
  vintCurrentEntity := cintFinance
                                 + qryOpenBills.fieldbyname('Entity').asinteger;
  {This is the sneaky way to cann a routine in a form that created you!}
  vbolDummy := false;
  vfrmMainMenu.onclosequery(Sender, vbolDummy);
end;

procedure TfrmCindySummary.cmdPrintApptClick(Sender: TObject);
begin
application.Createform(TrptAllOpenBills, rptAllOpenBills);
try
rptAllOpenBills.qryTemp:= qryOpenBills;
rptAllOpenBills.DataSet:= rptAllOpenBills.qryTemp;
rptAllOpenBills.lblEntity.dataset:= rptAllOpenBills.qryTemp;
rptAllOpenBills.lblCompany.dataset:= rptAllOpenBills.qryTemp;
rptAllOpenBills.lblBalance.dataset:= rptAllOpenBills.qryTemp;
rptAllOpenBills.Prepare;
rptAllOpenBills.Preview;
finally
  rptAllOpenBills.free;
  rptAllOpenBills:= nil;
  end;
end;

end.
