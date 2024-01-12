unit fmImportComment;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, pmScriptWaveShareVariable, pmUtilities;

type
  TfrmImport = class(TForm)
    memComments: TMemo;
    lblOld: TLabel;
    lblNew: TLabel;
    edtNew: TEdit;
    edtOld: TEdit;
    lbl1: TLabel;
    cmdOK: TSpeedButton;
    cmdPriority: TButton;
    lblPhysician: TLabel;
    cboPhysician: TComboBox;
    procedure cmdOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdPriorityClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmImport: TfrmImport;

implementation

{$R *.DFM}

procedure TfrmImport.cmdOKClick(Sender: TObject);
begin
If vstrSessionType = 'Typist' then
 if length(cboPhysician.Text) = 0 then
   begin
   showmessage('Please select a Physician from the list.  This is the Physician'
   + ' who dictated the file.');
   exit;
   end;
close;
end;

procedure TfrmImport.FormShow(Sender: TObject);
begin
memComments.lines.text := 'File: ' + edtOld.text +#13#10;
If vstrSessionType = 'Typist' then
    begin
    lblPhysician.visible := true;
    cboPhysician.visible := true;
    edtNew.visible:= false;
    lblNew.visible:= false;
    cboPhysician.Items.text:= comScriptWaveComm.LoadEntityList('Physician');
    end;

end;

procedure TfrmImport.cmdPriorityClick(Sender: TObject);
begin
If pos('PRIORITY', memComments.lines.text) < 1 then
    memComments.lines.text := 'IMPORTANT: THIS IS A PRIORITY DICTATION' + #13#10
                       + memComments.lines.text;
end;

end.
