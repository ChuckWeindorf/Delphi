unit Financial;
{
Created By:
  Charles Weindorf
  Techcellence
  Email: mudsox@erie.net
  "Specializing in creating, improving and maintaining Delphi applications"

Display the financial information for the customer selected on the main menu.
}

interface
{
Created By:
  Charles Weindorf
  Techcellence
  Email: mudsox@erie.net
  "Specializing in creating, improving and maintaining Delphi applications"

Display the customer information for the customer selected on the main menu.
}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, DBCtrls, Menus, ToolWin, ComCtrls,
  Datamodule, prmBusinessCode, Grids, DBGrids;

type
  TfrmFinancial = class(TForm)
    ToolBar1: TToolBar;
    MainMenu1: TMainMenu;
    mnuFile: TMenuItem;
    mnuExit: TMenuItem;
    pnlFinancial: TPanel;
    lbl1: TLabel;
    edtCustomerName: TDBEdit;
    grdFinancial: TDBGrid;
    procedure mnuExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure grdFinancialDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
    {The datamodule that will be tailored for this form}
    vdtmDynamicDatamod: TdtmDynamicDatamod;
  end;

var
  frmFinancial: TfrmFinancial;

implementation

{$R *.DFM}

procedure TfrmFinancial.FormCreate(Sender: TObject);
begin
{Create the blank datamodule that will be used to hold the query and datasource}
vdtmDynamicDatamod:= TdtmDynamicDatamod.Create(frmFinancial);
end;

procedure TfrmFinancial.mnuExitClick(Sender: TObject);
begin
Close;
end;

procedure TfrmFinancial.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action := caFree;
end;


procedure TfrmFinancial.grdFinancialDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
{Here's some more business code that has been moved to prmBusinessCode}
HighLightBank(Column, datacol);
end;

end.
