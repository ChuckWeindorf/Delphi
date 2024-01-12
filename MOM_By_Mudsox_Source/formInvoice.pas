unit formInvoice;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, dbtables, db;

type
  TrptInvoice = class(TQuickRep)
    bndTitle: TQRBand;
    bndFooter: TQRBand;
    lbl_100001: TQRLabel;
    imgLogo1: TQRImage;
    memCompany: TQRMemo;
    lbl_00001: TQRLabel;
    memClient: TQRMemo;
    lbl_00002: TQRLabel;
    lbl_10003: TQRLabel;
    lbl_10005: TQRLabel;
    lbl_10006: TQRLabel;
    lbl_0007: TQRLabel;
    lbl_10008: TQRLabel;
    lbl_10010: TQRLabel;
    lbl_10013: TQRLabel;
    lbl_10012: TQRLabel;
    lbl_10014: TQRLabel;
    lbl_10015: TQRLabel;
    lbl_2000: TQRLabel;
    lbl_2001: TQRLabel;
    lbl_2002: TQRLabel;
    lbl_20004: TQRLabel;
    lbl_20005: TQRLabel;
    lbl_20006: TQRLabel;
    memLegal: TQRMemo;
    bndDetail: TQRSubDetail;
    memPhysician: TQRMemo;
    edtPatient: TQRDBText;
    edtDate: TQRDBText;
    edtHours: TQRDBText;
    edtInterpreter: TQRLabel;
    edtPatientComment: TQRDBText;
    procedure bndDetailBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
  public
    vqryTemp: Tquery;
    vqryAddress: Tquery;
    vstlInterpreters, vstlPhysicians: tstringlist;
    constructor create(Aowner : TComponent); override;
    destructor destroy; override;
  end;

var
  rptInvoice: TrptInvoice;

implementation

  uses procSharedDataModuleCalls;

{$R *.DFM}
constructor TrptInvoice.Create(AOwner: TComponent);
begin
  {Create all form components and other start-up activities}
  Inherited create(AOwner);
  imgLogo1.Picture.LoadFromFile(vstrApplicationDirectory +
                                                'Pictures\Mheds_no_border.bmp');
  vstlInterpreters:= tstringlist.create;
  vstlPhysicians:= tstringlist.create;
end;

destructor TrptInvoice.destroy;
begin
  vstlInterpreters.free;
  vstlPhysicians.free;
  Inherited destroy;
end;

procedure TrptInvoice.bndDetailBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
  var vintLoop: integer;
begin
      for vintLoop:= 0 to vstlInterpreters.count - 1 do
         If pos(inttostr(
                vqryTemp.fieldbyname('BillInterpreter').asinteger),
                vstlInterpreters[vintLoop]) > 0 then
                begin
                edtInterpreter.caption:= copy(vstlInterpreters[vintLoop],1,
                               pos('(',vstlInterpreters[vintLoop]) - 1);
                break;
                end;

   If vqryTemp.fieldbyname('BillPhysician').asinteger < 1000 then
      memPhysician.lines.text:=
                              vqryTemp.fieldbyname('BillDetailComment').asstring
   else
      for vintLoop:= 0 to vstlPhysicians.count - 1 do
         If pos(inttostr(
                vqryTemp.fieldbyname('BillPhysician').asinteger),
                vstlPhysicians[vintLoop]) > 0 then
                begin
                memPhysician.lines.text:= copy(vstlPhysicians[vintLoop],1,
                               pos('(',vstlPhysicians[vintLoop]) - 1);
                vqryAddress.locate
                                ('Entity',
                                vqryTemp.fieldbyname('BillPhysician').asinteger,
                                []);
                memPhysician.lines.add(
                              vqryAddress.fieldbyname('AddressLine1').asstring);
                If vqryAddress.fieldbyname('AddressLine2').asstring > '  A' then
                     memPhysician.lines.add(
                              vqryAddress.fieldbyname('AddressLine2').asstring);
                memPhysician.lines.add(
                              vqryAddress.fieldbyname('AddressCity').asstring
                              + ', ' +
                              vqryAddress.fieldbyname('AddressState').asstring
                              + ' ' +
                              vqryAddress.fieldbyname('AddressZip').asstring
                              + ' ' +
                              vqryAddress.fieldbyname('AddressZip4').asstring
                              );
                break;
                end;
end;

end.
