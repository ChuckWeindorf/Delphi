unit formNew;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, procRoutines, filectrl;

type
  TfrmNew = class(TForm)
    lbl1: TLabel;
    edtDirectory: TEdit;
    cmdCreate: TBitBtn;
    procedure cmdCreateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNew: TfrmNew;

implementation

{$R *.DFM}

procedure TfrmNew.cmdCreateClick(Sender: TObject);
begin
If length(edtDirectory.text) = 0 then exit;
Forcedirectories(edtDirectory.text);
If DirectoryExists(edtDirectory.text) then
   begin
   WriteRegistry
             ('Software\Mudsox\Viewer', 'Directory', 'Path', edtDirectory.text);
   frmNew.close;
   end
else
   Showmessage('Directory not created.  Please try again.');
end;

end.
