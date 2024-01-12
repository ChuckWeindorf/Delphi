unit formHouseholdQR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  datamainDataModule, StdCtrls, Mask, DBCtrls, ExtCtrls, Menus, Buttons,
  ToolWin, ComCtrls, procSharedDatamoduleCalls, Grids, DBGrids, quickrpt,
  Qrctrls;

type
  TfrmHouseholdQR = class(TForm)
    rptHousehold: TQuickRep;
    bndHeader: TQRBand;
    lbl_10001: TQRLabel;
    lbl_10002: TQRSysData;
    lbl_10003: TQRLabel;
    bndPatientData: TQRSubDetail;
    txtEntityDescription: TQRDBText;
    bndAddressData: TQRSubDetail;
    bndAddress: TQRGroup;
    lbl_10009: TQRLabel;
    lbl_10010: TQRLabel;
    lbl_10011: TQRLabel;
    lbl_10012: TQRLabel;
    QRLabel5: TQRLabel;
    lbl_10013: TQRLabel;
    txtAddressType: TQRDBText;
    txtAddressZip: TQRDBText;
    txtAddressState: TQRDBText;
    txtAddressCity: TQRDBText;
    txtAddressLine2: TQRDBText;
    lbl_10014: TQRLabel;
    txtAddressZip4: TQRDBText;
    txtAddressLine1: TQRDBText;
    bndPhone: TQRGroup;
    bndPhoneData: TQRSubDetail;
    lbl_10015: TQRLabel;
    lbl_10017: TQRLabel;
    txtPhoneNumber: TQRDBText;
    txtPhoneExtension: TQRDBText;
    txtPhoneCategory: TQRDBText;
    bndHouseholdInfo: TQRBand;
    lbl_10004: TQRLabel;
    txthouseholdHead: TQRLabel;
    lbl_10006: TQRLabel;
    txtHouseholdLanguage: TQRDBText;
    txtHouseholdPhysician: TQRLabel;
    lbl_10007: TQRLabel;
    lbl_10008: TQRLabel;
    imgLogo1: TQRImage;
    imgLogo2: TQRImage;
    vlstPhysician: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    vstrPhysician: String;
    constructor create(Aowner : TComponent); override;
  end;

var
  frmHouseholdQR: TfrmHouseholdQR;

implementation



{$R *.DFM}

constructor TfrmHouseholdQR.create(AOwner: TComponent);
var
  vintloop: Integer;
  vcmpComponent: TComponent;
  vlstPhysician2: TStringList;
  vstrName: String;
  vstrOz: string;
begin
  {Create all form components and other start-up activities}
  vlstPhysician2:=tStringlist.Create;
  Inherited create(AOwner);
  //find physician
  FillPickList('Physician',vlstPhysician.items);
  for vintloop:=0 to vlstPhysician.Items.count-1  do
  begin
    vstrname:=vlstPhysician.Items[vintloop];
    vlstPhysician2.add(Copy(vstrname,Length(vstrname)-5,7));
    Delete(vstrname,Length(vstrname)-9,10);
    vlstPhysician.Items[vintloop]:=vstrname;
  end;
  vlstPhysician.ItemIndex:=vlstPhysician2.IndexOf(
         IntToStr(vdtmQuickReport.qryHouseHold.FieldByName
                                             ('HouseHoldPhysician').asinteger));
  txtHouseholdPhysician.Caption:=vlstPhysician.text;
  //fill images
  imgLogo1.Picture.LoadFromFile(vstrApplicationDirectory +
                                                'Pictures\Mheds_no_border.bmp');
  imgLogo2.Picture.LoadFromFile(vstrApplicationDirectory +
                                               'Pictures\Mheds2_no_border.bmp');

  rpthousehold.DataSet := vdtmQuickReport.qryHousehold;

  {Assign the tags to datasources.}
  For vintLoop := 0 to ComponentCount - 1 do
     begin
     vcmpComponent := Components[vintLoop];
     If vcmpComponent.tag > 10 then
        begin
        vstrOz := vcmpComponent.name;
        AssignDataSources(vcmpComponent, vdtmQuickReport);
        end;
   end;
   //make household title
   lbl_10003.Caption:=(vdtmQuickReport.qryEntityHousehold.fieldbyname
                       ('EntityDescription').asstring) + ' Household';
   lbl_10003.Left:=336-Length(lbl_10003.caption)*3;
   If vdtmQuickReport.qryEntity.Locate('Entity',
      vdtmQuickReport.qryHousehold.fieldbyName('HouseHoldHead').asinteger,[]) then
     //display the name
     txtHouseholdhead.caption:=vdtmQuickReport.qryEntity.FieldbyName
                                                 ('EntityDescription').asstring;
  //free string list
   vlstPhysician2.free;
end;

procedure TfrmHouseholdQR.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

end.
