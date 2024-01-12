unit formNewPickList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TfrmNewPickList = class(TForm)
    edtNewPickList: TEdit;
    Label1: TLabel;
    cmdOK: TBitBtn;
    procedure cmdOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtNewPickListKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNewPickList: TfrmNewPickList;

implementation

{$R *.DFM}

procedure TfrmNewPickList.cmdOKClick(Sender: TObject);
begin
If length(edtNewPickList.text) > 0 then
   close;
end;

procedure TfrmNewPickList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action := caFree;
end;

procedure TfrmNewPickList.edtNewPickListKeyPress(Sender: TObject;
  var Key: Char);
begin
{#13 is the enter keystroke}
If key = #13 then
   begin
   {Do the query and nullify the keystroke}
   cmdOKClick(Self);
   Key := #00;
   end;
end;

end.
