unit formSpecialUtilities;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, procSharedDatamoduleCalls, dbTables;

type
  TfrmSpecialUtilities = class(TForm)
    cmdBirthdays: TBitBtn;
    lblProgress: TLabel;
    cmdResetFinance: TBitBtn;
    lblProgress2: TLabel;
    procedure cmdBirthdaysClick(Sender: TObject);
    procedure cmdResetFinanceClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSpecialUtilities: TfrmSpecialUtilities;

implementation

{$R *.DFM}

{In order to make sure the database keeps the proper age for Patients,
this command will update any patient ages that have had birthdays since the last
special run.}
procedure TfrmSpecialUtilities.cmdBirthdaysClick(Sender: TObject);
var vqryPatient: Tquery;
    vintHoldAge: integer;
begin
  vqryPatient := tquery.Create(nil);
  try
  lblProgress.Caption := 'Working...';
  Refresh;
  vqryPatient.RequestLive:= true;
  vqryPatient.databasename := 'mmom_MainDatabase';
  vqryPatient.SQL.Add('Select Entity, PatientBirth, PatientAge from Patient');
  vqryPatient.Open;
  While not vqryPatient.eof do
    begin
    vintHoldAge :=
        FindAge(vqryPatient.FieldByName('PatientBirth').asdatetime);
    If vintHoldAge <>
                vqryPatient.FieldByName('PatientAge').asinteger then
      begin
      vqryPatient.edit;
      vqryPatient.FieldByName('PatientAge').asinteger:= vintHoldAge;
      PostEvent(vqryPatient);
      end;
    vqryPatient.Next;
    end;
  vqryPatient.close;
  finally
    vqryPatient.free;
    lblProgress.Caption := 'Complete';
    end;
end;

procedure TfrmSpecialUtilities.cmdResetFinanceClick(Sender: TObject);
var vqryBilling: Tquery;
begin
  vqryBilling := tquery.Create(nil);
  try
  lblProgress2.Caption := 'Working...';
  vqryBilling.RequestLive:= true;
  vqryBilling.databasename := 'mmom_MainDatabase';
  vqryBilling.SQL.Add('UPDATE "ApptBilling.DB" SET ApptBillClosed = TRUE');
  vqryBilling.ExecSQL;
  finally
    vqryBilling.free;
    lblProgress2.Caption := 'Complete';
    end;
end;

end.
