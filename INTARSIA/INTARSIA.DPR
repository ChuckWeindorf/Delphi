program Intarsia;

uses
  Forms,
  Int_1 in 'INT_1.PAS' {Form1},
  Int_2 in 'INT_2.PAS' {Form2},
  Int_3 in 'INT_3.PAS' {Form3},
  Int_4 in 'INT_4.PAS' {Form4},
  qr_1 in 'qr_1.pas' {rptCert: TQuickRep},
  qr_2 in 'qr_2.pas' {rptInventory: TQuickRep};

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TrptCert, rptCert);
  Application.CreateForm(TrptInventory, rptInventory);
  Application.Run;
end.
