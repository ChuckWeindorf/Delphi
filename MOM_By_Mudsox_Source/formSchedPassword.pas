unit formSchedPassword;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TfrmSchedPassword = class(TForm)
    edtPassword: TEdit;
    procedure edtPasswordKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    vbolValidPass: boolean;
    { Public declarations }
  end;

var
  frmSchedPassword: TfrmSchedPassword;

implementation

{$R *.DFM}

procedure TfrmSchedPassword.edtPasswordKeyPress(Sender: TObject;
  var Key: Char);
begin
{#13 is the enter keystroke}
If key = #13 then
   begin
   If uppercase(edtPassword.text) = 'MHEDSCHED' then
      vbolValidPass:= true;
   Key := #00;
   close;
   end;
end;

procedure TfrmSchedPassword.FormCreate(Sender: TObject);
begin
vbolValidPass:= false;
end;

end.
