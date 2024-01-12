unit MainMenu;
{
Created By:
  Charles Weindorf
  Techcellence
  Email: mudsox@erie.net
  "Specializing in creating, improving and maintaining Delphi applications"

The main menu will call the specific form per the requested icon. Note the
procedure SetUpDatamodule that is called with the form's individual instance
of the blank datamodule. All queries and datasources required for the form
are created by this call. See prmDatamoduleManager.
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, Menus, ToolWin, ComCtrls, Grids, DBGrids, ExtCtrls, StdCtrls,
  DBTables, Db;

type
  TfrmMainMenu = class(TForm)
    tbrMain: TToolBar;
    mnuMain: TMainMenu;
    mnuFile: TMenuItem;
    mnuExit: TMenuItem;
    cmdOrder: TSpeedButton;
    mnuDisplay: TMenuItem;
    pnlMain: TPanel;
    grdMain: TDBGrid;
    pnlCredits: TPanel;
    memCredits: TRichEdit;
    qryEntity: TQuery;
    dtsEntity: TDataSource;
    cmdFinancial: TSpeedButton;
    cmdCustomer: TSpeedButton;
    procedure mnuExitClick(Sender: TObject);
    procedure cmdOrderClick(Sender: TObject);
    procedure cmdCustomerClick(Sender: TObject);
    procedure cmdFinancialClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMainMenu: TfrmMainMenu;

implementation

{Use each form and an the procedure module that constructs the dynamic
datamodule}
uses Customer, Financial, Order, prmDatamoduleManager;

{$R *.DFM}

procedure TfrmMainMenu.mnuExitClick(Sender: TObject);
begin
Close;
end;

procedure TfrmMainMenu.cmdCustomerClick(Sender: TObject);
var vfrmCustomer: tfrmCustomer;
begin
{The customer screen requires the customer table and address table.  After
creating the form, call prmDatamoduleManager to create the correct datamodule
for this instance of this form.  The current customer number is passed as
a parameter to allow the datamodule to be focused on the correct
customer.}
vfrmCustomer := tfrmCustomer.Create(frmMainMenu);
SetUpDatamodule(vfrmCustomer,
                vfrmCustomer.vdtmDynamicDatamod,
                qryEntity['CustomerNumber']);
vfrmCustomer.Show;
end;

procedure TfrmMainMenu.cmdOrderClick(Sender: TObject);
var vfrmOrder: tfrmOrder;
begin
{The order form contains three queries that are created within
prmDatamoduleManager. Customer number forms the basis for the customer number
query.}
vfrmOrder := tfrmOrder.Create(frmMainMenu);
SetUpDatamodule(vfrmOrder,
                vfrmOrder.vdtmDynamicDatamod,
                qryEntity['CustomerNumber']);
vfrmOrder.Show;
end;


procedure TfrmMainMenu.cmdFinancialClick(Sender: TObject);
var vfrmFinancial: tfrmFinancial;
begin
{The Financial screen requires the customer table and financial table.  Again,
prmDatamoduleManager creates the instance of the datamodule.}
vfrmFinancial := tfrmFinancial.Create(frmMainMenu);
SetUpDatamodule(vfrmFinancial,
                vfrmFinancial.vdtmDynamicDatamod,
                qryEntity['CustomerNumber']);
vfrmFinancial.Show;
end;

procedure TfrmMainMenu.FormCreate(Sender: TObject);
begin
qryEntity.open;
end;

procedure TfrmMainMenu.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
qryEntity.close;
end;

end.
