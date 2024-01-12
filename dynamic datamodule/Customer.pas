unit Customer;
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
  StdCtrls, Mask, DBCtrls, ExtCtrls, Menus, ToolWin, ComCtrls,
  Datamodule, prmBusinessCode, dbtables;

type
  TfrmCustomer = class(TForm)
    MainMenu1: TMainMenu;
    ToolBar1: TToolBar;
    mnuFile: TMenuItem;
    mnuExit: TMenuItem;
    pnlCustomer: TPanel;
    edtCustomerName: TDBEdit;
    edtAddress1: TDBEdit;
    edtAddress2: TDBEdit;
    edtAddressCity: TDBEdit;
    edtAddressState: TDBEdit;
    edtAddressZip: TDBEdit;
    radAddress: TRadioGroup;
    lbl1: TLabel;
    lbl2: TLabel;
    procedure mnuExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure radAddressClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    {This is the datamodule instance that will be tailored for the form}
    vdtmDynamicDatamod: TdtmDynamicDatamod;
  end;

var
  frmCustomer: TfrmCustomer;

implementation

{$R *.DFM}

procedure TfrmCustomer.mnuExitClick(Sender: TObject);
begin
close;
end;

procedure TfrmCustomer.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action := caFree;
end;

procedure TfrmCustomer.FormCreate(Sender: TObject);
begin
{Create the datamodule as a public variable within this form}
vdtmDynamicDatamod:= TdtmDynamicDatamod.Create(frmCustomer);
end;

{Call the business procedure to locate the correct address based on the value
assigned in the radio group box.  This way, the detailed business code can be
contined within the procedure module without having to appear in every instance
of the customer form.  Normally, really large chunks of business logic may be
required to make complex forms work.  This code can reside in the
prmBusinessCode unit and shared between any number of forms.}
procedure TfrmCustomer.radAddressClick(Sender: TObject);
begin
LocateCorrectAddress(vdtmDynamicDatamod.qryAddress,
                     radAddress.Items[radAddress.Itemindex]);
end;

end.
