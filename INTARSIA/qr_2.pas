unit qr_2;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TrptInventory = class(TQuickRep)
    qryRpt: TQuery;
    QRBand1: TQRBand;
    QRSubDetail1: TQRSubDetail;
    qryRptItemID: TIntegerField;
    qryRptItemName: TStringField;
    qryRptDateCreated: TDateField;
    qryRptDateSold: TDateField;
    qryRptColor: TStringField;
    qryRptSalePrice: TCurrencyField;
    qryRptBuildCost: TCurrencyField;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRLabel1: TQRLabel;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRBand2: TQRBand;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRShape1: TQRShape;
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRSubDetail1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private

  public
  vintItemID: integer;
  vintItems: integer;
  vreaSale: real;
  vreaCost: real;
  end;

var
  rptInventory: TrptInventory;

implementation

{$R *.DFM}

procedure TrptInventory.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
qrLabel8.caption := inttostr(vintItems);
qrlabel9.caption := '$' + floattostr(vreaSale);
qrLabel10.caption := '$' + floattostr(vreaCost);   

end;

procedure TrptInventory.QRSubDetail1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin

If vintItemID <> qryRpt.fieldbyname('ItemID').asinteger then
   begin
   inc(vintItems);
   vreaCost:= vreaCost + qryRpt.fieldbyname('BuildCost').asfloat;
   vreaSale:= vreaSale + qryRpt.fieldbyname('SalePrice').asfloat;
   vintItemID:= qryRpt.fieldbyname('ItemID').asinteger;
   end;
end;

procedure TrptInventory.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
rptInventory.vintItems:= 0;
rptInventory.vreaSale:= 0;
rptInventory.vreaCost:= 0;
end;

end.
