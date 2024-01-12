unit Order;
{
Created By:
  Charles Weindorf
  Techcellence
  Email: mudsox@erie.net
  "Specializing in creating, improving and maintaining Delphi applications"

Display the customer information for the customer selected on the main menu.
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ToolWin, ComCtrls, Menus, Grids, DBGrids, StdCtrls, Mask, DBCtrls,
  ExtCtrls, Datamodule, prmBusinessCode;

type
  TfrmOrder = class(TForm)
    pnlFinancial: TPanel;
    lbl1: TLabel;
    edtCustomerName: TDBEdit;
    grdFinancial: TDBGrid;
    MainMenu1: TMainMenu;
    mnuFile: TMenuItem;
    mnuExit: TMenuItem;
    ToolBar1: TToolBar;
    lbl2: TLabel;
    edtBank: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mnuExitClick(Sender: TObject);
    procedure grdFinancialCellClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    {The local copy of the blank datamodule that will be tailored for the form}
    vdtmDynamicDatamod: TdtmDynamicDatamod;
  end;

var
  frmOrder: TfrmOrder;

implementation

{$R *.DFM}

procedure TfrmOrder.FormCreate(Sender: TObject);
begin
{Create the blank datamodule before the form is displayed}
vdtmDynamicDatamod:= TdtmDynamicDatamod.Create(frmOrder);
end;

procedure TfrmOrder.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := caFree;
end;

procedure TfrmOrder.mnuExitClick(Sender: TObject);
begin
Close;
end;

procedure TfrmOrder.grdFinancialCellClick(Column: TColumn);
begin
{Business code that has been mode down to prmBusinessCode}
FindRightBank(vdtmDynamicDatamod.qryOrder,
              vdtmDynamicDatamod.qryFinancial);
end;

procedure TfrmOrder.FormShow(Sender: TObject);
begin
{Business code that has been mode down to prmBusinessCode}
FindRightBank(vdtmDynamicDatamod.qryOrder,
              vdtmDynamicDatamod.qryFinancial);
end;

end.
