unit form1500;
{Author: Chuck Weindorf
 Description: The datamodule is a placeholder for the creation of a series of
 SQL tables and datasources for use by one form, tab or report within the

 Date: 08/04/1999 - CEW - New

 TAGs - Are used in this for to override the print generation of the 1500.
 0 = Print on the preprinted and on the generated 1500
 1 = Add line returns to memo block but do not print on pre-printed forms
 2 = Do not print at any time
 3 = Override and print read-only label at all times

 Generic -
 Tshape and Timage and Tlabel do not print on pre-printed forms
 Tedit print always
 Tmemo - do not print tag 1 on pre-printed, print tag 0 always
 Tcheckbox - print the selection but not the caption on pre-printed forms

  }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Menus, ToolWin, ComCtrls, Buttons, Qrctrls, dbtables;

type
  Tfrm1500 = class(TForm)
    tbl1: TToolBar;
    pnlClient: TPanel;
    scr1500: TScrollBar;
    pnlScroll: TPanel;
    box1: TShape;
    lbl1: TLabel;
    box2: TShape;
    memCarrierAddress: TMemo;
    box3: TShape;
    chkMedicare: TCheckBox;
    chkMedicaid: TCheckBox;
    chkSSN: TCheckBox;
    chkVA: TCheckBox;
    chkSSNID: TCheckBox;
    chkFECA: TCheckBox;
    chkID: TCheckBox;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    edtID: TEdit;
    box36: TShape;
    box30: TShape;
    edtInsuredName: TEdit;
    edtInsuredAddress: TEdit;
    edtInsuredState: TEdit;
    edtInsuredGroup: TEdit;
    edtInsuredCity: TEdit;
    edtInsuredZIP: TEdit;
    edtInsuredEmployer: TEdit;
    edtInsuredPlan: TEdit;
    box8: TShape;
    img1: TImage;
    mem1: TMemo;
    edtInsuredTelephone: TEdit;
    lbl50: TLabel;
    edtInsuredBirth: TEdit;
    chkMale2: TCheckBox;
    chkFemale2: TCheckBox;
    box22: TShape;
    box23: TShape;
    box16: TShape;
    box18: TShape;
    box26: TShape;
    chkYes1: TCheckBox;
    chkNo1: TCheckBox;
    edtPatientBirth: TEdit;
    chkMale1: TCheckBox;
    chkFemale1: TCheckBox;
    lbl30: TLabel;
    edtPatientName: TEdit;
    box14: TShape;
    box28: TShape;
    box24: TShape;
    edtPatientCity: TEdit;
    edtPatientState: TEdit;
    edtPatientAddress: TEdit;
    chkSelf: TCheckBox;
    chkSpouse: TCheckBox;
    chkChild: TCheckBox;
    chkOther: TCheckBox;
    edtOtherBirth: TEdit;
    chkMale3: TCheckBox;
    chkFemale3: TCheckBox;
    mem7: TMemo;
    box13: TShape;
    edtPatientZIP: TEdit;
    box37: TShape;
    edtPatientTelephone: TEdit;
    chkSingle: TCheckBox;
    chkMarried: TCheckBox;
    chkOther2: TCheckBox;
    chkEmployed: TCheckBox;
    chkFullTime: TCheckBox;
    chkPartTime: TCheckBox;
    lbl5: TLabel;
    lbl19: TLabel;
    lbl11: TLabel;
    lbl10: TLabel;
    lbl9: TLabel;
    lbl8: TLabel;
    lbl7: TLabel;
    lbl6: TLabel;
    lbl49: TLabel;
    lbl48: TLabel;
    lbl47: TLabel;
    box34: TShape;
    lbl46: TLabel;
    lbl45: TLabel;
    lbl44: TLabel;
    lbl43: TLabel;
    lbl42: TLabel;
    mem6: TMemo;
    box21: TShape;
    box7: TShape;
    chkYes3: TCheckBox;
    chkNo3: TCheckBox;
    chkYes2: TCheckBox;
    chkNo2: TCheckBox;
    chkYes: TCheckBox;
    chkNo: TCheckBox;
    edtAccState: TEdit;
    lbl41: TLabel;
    lbl40: TLabel;
    lbl29: TLabel;
    lbl28: TLabel;
    lbl27: TLabel;
    lbl26: TLabel;
    edtOtherName: TEdit;
    edtOtherPolicy: TEdit;
    edtOtherEmployer: TEdit;
    edtOtherInsurance: TEdit;
    lbl25: TLabel;
    lbl24: TLabel;
    lbl23: TLabel;
    lbl22: TLabel;
    lbl21: TLabel;
    lbl20: TLabel;
    lbl18: TLabel;
    lbl17: TLabel;
    lbl16: TLabel;
    lbl15: TLabel;
    box11: TShape;
    lbl14: TLabel;
    lbl13: TLabel;
    lbl12: TLabel;
    box32: TShape;
    box29: TShape;
    box33: TShape;
    box35: TShape;
    box48: TShape;
    box47: TShape;
    box46: TShape;
    box15: TShape;
    box19: TShape;
    box44: TShape;
    box43: TShape;
    box42: TShape;
    lbl51: TLabel;
    edtCurrentDate: TEdit;
    mem2: TMemo;
    lbl52: TLabel;
    edtSimilarDate: TEdit;
    lbl53: TLabel;
    lbl54: TLabel;
    edtWorkDateFrom: TEdit;
    edtWorkDateTo: TEdit;
    lbl55: TLabel;
    lbl56: TLabel;
    lbl57: TLabel;
    edtReferralPhysician: TEdit;
    lbl58: TLabel;
    edtReferralID: TEdit;
    lbl59: TLabel;
    lbl60: TLabel;
    lbl61: TLabel;
    lbl62: TLabel;
    lbl71: TLabel;
    lbl72: TLabel;
    edtHospFrom: TEdit;
    edtHospTo: TEdit;
    lbl64: TLabel;
    lbl65: TLabel;
    chkYes4: TCheckBox;
    chkNo4: TCheckBox;
    box50: TShape;
    box51: TShape;
    lbl66: TLabel;
    lbl67: TLabel;
    lbl68: TLabel;
    lbl69: TLabel;
    lbl70: TLabel;
    edtDiagnose1: TEdit;
    edtDiagnose2: TEdit;
    edtDiagnose3: TEdit;
    edtDiagnose4: TEdit;
    lbl76: TLabel;
    lbl73: TLabel;
    lbl74: TLabel;
    box52: TShape;
    edtCharges: TEdit;
    edtMedicaidCode: TEdit;
    edtMedicaidOriginal: TEdit;
    lbl75: TLabel;
    edtPriorAuthor: TEdit;
    box53: TShape;
    box54: TShape;
    box55: TShape;
    box56: TShape;
    lbl80: TLabel;
    box61: TShape;
    lbl81: TLabel;
    lbl77: TLabel;
    lbl78: TLabel;
    lbl79: TLabel;
    lbl91: TLabel;
    lbl89: TLabel;
    lbl90: TLabel;
    box60: TShape;
    lbl83: TLabel;
    lbl85: TLabel;
    lbl86: TLabel;
    lbl87: TLabel;
    lbl92: TLabel;
    lbl93: TLabel;
    box87: TShape;
    lbl94: TLabel;
    lbl96: TLabel;
    lbl98: TLabel;
    box65: TShape;
    box64: TShape;
    box63: TShape;
    box62: TShape;
    lbl95: TLabel;
    lbl99: TLabel;
    lbl100: TLabel;
    lbl101: TLabel;
    lbl102: TLabel;
    lbl103: TLabel;
    lbl104: TLabel;
    lbl105: TLabel;
    lbl106: TLabel;
    lbl107: TLabel;
    lbl108: TLabel;
    lbl109: TLabel;
    lbl110: TLabel;
    lbl111: TLabel;
    lbl112: TLabel;
    lbl113: TLabel;
    lbl114: TLabel;
    lbl116: TLabel;
    lbl117: TLabel;
    lbl118: TLabel;
    lbl120: TLabel;
    lbl121: TLabel;
    lbl122: TLabel;
    lbl123: TLabel;
    lbl124: TLabel;
    box70: TShape;
    mem3: TMemo;
    mem4: TMemo;
    mem5: TMemo;
    lbl125: TLabel;
    lbl126: TLabel;
    lbl127: TLabel;
    box71: TShape;
    lbl128: TLabel;
    lbl129: TLabel;
    lbl130: TLabel;
    lbl131: TLabel;
    lbl132: TLabel;
    lbl134: TLabel;
    edtServiceFrom1: TEdit;
    edtServiceTo1: TEdit;
    edtServicePlace1: TEdit;
    edtServiceType1: TEdit;
    edtCode1: TEdit;
    edtModifier1: TEdit;
    edtDiagnosis1: TEdit;
    edtServCharges1: TEdit;
    edtDays1: TEdit;
    edtFamily1: TEdit;
    edtEMG1: TEdit;
    edtCOB1: TEdit;
    edtServiceFrom3: TEdit;
    edtServiceTo3: TEdit;
    edtServicePlace3: TEdit;
    edtServiceType3: TEdit;
    edtCode3: TEdit;
    edtModifier3: TEdit;
    edtDiagnosis3: TEdit;
    edtServCharges3: TEdit;
    edtDays3: TEdit;
    edtFamily3: TEdit;
    edtEMG3: TEdit;
    edtCOB3: TEdit;
    edtServiceFrom4: TEdit;
    edtServiceTo4: TEdit;
    edtServicePlace4: TEdit;
    edtServiceType4: TEdit;
    edtCode4: TEdit;
    edtModifier4: TEdit;
    edtDiagnosis4: TEdit;
    edtServCharges4: TEdit;
    edtDays4: TEdit;
    edtFamily4: TEdit;
    edtEMG4: TEdit;
    edtCOB4: TEdit;
    edtServiceFrom5: TEdit;
    edtServiceTo5: TEdit;
    edtServicePlace5: TEdit;
    edtServiceType5: TEdit;
    edtCode5: TEdit;
    edtModifier5: TEdit;
    edtDiagnosis5: TEdit;
    edtServCharges5: TEdit;
    edtDays5: TEdit;
    edtFamily5: TEdit;
    edtEMG5: TEdit;
    edtCOB5: TEdit;
    edtServiceTo6: TEdit;
    edtServicePlace6: TEdit;
    edtServiceType6: TEdit;
    edtCode6: TEdit;
    edtModifier6: TEdit;
    edtDiagnosis6: TEdit;
    edtServCharges6: TEdit;
    edtDays6: TEdit;
    edtFamily6: TEdit;
    edtEMG6: TEdit;
    edtCOB6: TEdit;
    edtServiceFrom6: TEdit;
    edtFedTax: TEdit;
    edtPatientAccount: TEdit;
    edtYes5: TCheckBox;
    edtNo5: TCheckBox;
    edtTotalCharge: TEdit;
    edtAmountPaid: TEdit;
    edtBalance: TEdit;
    memAddressService: TMemo;
    memPhysicianInfo: TMemo;
    edtPIN: TEdit;
    edtGroup: TEdit;
    edtServiceFrom2: TEdit;
    edtServiceTo2: TEdit;
    edtServicePlace2: TEdit;
    edtServiceType2: TEdit;
    edtCode2: TEdit;
    edtModifier2: TEdit;
    edtDiagnosis2: TEdit;
    edtServCharges2: TEdit;
    edtDays2: TEdit;
    edtFamily2: TEdit;
    edtEMG2: TEdit;
    edtCOB2: TEdit;
    cmdPrint1500: TSpeedButton;
    box74: TShape;
    box85: TShape;
    box84: TShape;
    box77: TShape;
    box75: TShape;
    box96: TShape;
    box95: TShape;
    box94: TShape;
    box93: TShape;
    box101: TShape;
    edtSignatureDate: TEdit;
    lbl150: TLabel;
    lbl151: TLabel;
    box6: TShape;
    edtPhysicianName: TEdit;
    chkFormType: TCheckBox;
    chkSSNyes: TCheckBox;
    chkEINyes: TCheckBox;
    lbl152: TLabel;
    chkBlueCross: TCheckBox;
    chkMedicarePrint: TCheckBox;
    chkShift: TCheckBox;
    edtREV1: TEdit;
    edtREV2: TEdit;
    edtREV3: TEdit;
    edtREV4: TEdit;
    edtREV5: TEdit;
    edtREV6: TEdit;
    chk1500_0805: TCheckBox;
    pnlMsg: TPanel;
    lblDoubleClick: TLabel;
    edtPatientBalance: TEdit;
    lbl300: TLabel;
    edtPIN2: TEdit;
    procedure scr1500Change(Sender: TObject);
    procedure edtPatientNameEnter(Sender: TObject);
    procedure edtPatientNameExit(Sender: TObject);
    procedure memCarrierAddressEnter(Sender: TObject);
    procedure memCarrierAddressExit(Sender: TObject);
    procedure cmdPrint1500Click(Sender: TObject);
    procedure Save1500;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkBlueCrossClick(Sender: TObject);
    procedure chkFormTypeClick(Sender: TObject);
    procedure chkMedicarePrintClick(Sender: TObject);
    procedure chkShiftClick(Sender: TObject);
    procedure edtREV1DblClick(Sender: TObject);
    procedure chk1500_0805Click(Sender: TObject);
  private
    { Private declarations }
    Procedure AdjustPrePrinted1500;
    Procedure AdjustPrePrintedBlueCross;
    Procedure AdjustPrePrintedMedicare;
  public
    { Public declarations }
    Procedure Load1500FromHistory;
    Procedure LoadFromDataModule;
  end;

var
  frm1500: Tfrm1500;

implementation

uses form1500QR, procSharedDatamoduleCalls;

{$R *.DFM}

procedure Tfrm1500.scr1500Change(Sender: TObject);
begin
pnlScroll.top:= (scr1500.Position * -1) + 1;
end;

procedure Tfrm1500.edtPatientNameEnter(Sender: TObject);
begin
tedit(sender).color:=clSilver;
end;

procedure Tfrm1500.edtPatientNameExit(Sender: TObject);
begin
tedit(sender).color:=clWhite;
end;

procedure Tfrm1500.memCarrierAddressEnter(Sender: TObject);
begin
tmemo(sender).color:= clSilver;
end;

procedure Tfrm1500.memCarrierAddressExit(Sender: TObject);
begin
tmemo(sender).color:= clWhite;
end;

procedure Tfrm1500.cmdPrint1500Click(Sender: TObject);
var vintLoop: integer;
const
    creaHeightTop: real = 0.835;
    creaWidthLeft: real = 0.98;
begin
  frm1500QR := tfrm1500QR.Create(nil);
  {Per Cindy 7-4-2004 place the Physician info into the Service Address}
//  If chkMedicarePrint.checked then
//     memAddressService.text:= memPhysicianInfo.text;
  try
  For vintLoop:= 0 to frm1500.ComponentCount - 1 do
    begin
    If (((not chkFormType.checked) and
             ((frm1500.Components[vintLoop] is Tshape) or
              (frm1500.Components[vintLoop] is TLabel) or
              (frm1500.Components[vintLoop] is TImage)))
       or (frm1500.Components[vintLoop].tag = 2))
       and (frm1500.Components[vintLoop].tag <> 3) then
          {Do not print these objects!}
    else
    If frm1500.Components[vintLoop] is Tshape then
       begin
       with TQRShape.Create(frm1500QR.rpt1500) do
         begin
         Left:= round(Tshape(frm1500.Components[vintLoop]).Left *creaWidthLeft);
         Top:= round(Tshape(frm1500.Components[vintLoop]).Top   *creaHeightTop);
         Width:= round((Tshape(frm1500.Components[vintLoop]).Left +
                  Tshape(frm1500.Components[vintLoop]).Width)
                                                         *creaWidthLeft) - Left;
         Height:= round((Tshape(frm1500.Components[vintLoop]).Top +
                Tshape(frm1500.Components[vintLoop]).Height + 1) *
                                                           creaHeightTop) - Top;
         If height < 3 then
            begin
            height:= Tshape(frm1500.Components[vintLoop]).pen.Width;
            pen.Width:= 1;
            end;
         If width < 3 then
            begin
            width:= Tshape(frm1500.Components[vintLoop]).pen.Width;
            pen.Width:= 1;
            end;
         Top:= Top + 30;
         Left:= Left + 25;
         pen.width:= Tshape(frm1500.Components[vintLoop]).pen.Width;
         Parent:= frm1500QR.rpt1500;
         If (width + left > 780) and (width + left < 784) then
            width := 784 - left;
         end;
       end
    else
    If frm1500.Components[vintLoop] is TLabel then
       begin
       with TQRLabel.Create(frm1500QR.rpt1500) do
         begin
         name:= TLabel(frm1500.Components[vintLoop]).name;
         Left:= round((TLabel(frm1500.Components[vintLoop]).Left+25)
                                                                *creaWidthLeft);
         Top:= round((TLabel(frm1500.Components[vintLoop]).Top+36)
                                                                *creaHeightTop);
         Width:= round((TLabel(frm1500.Components[vintLoop]).Width)
                                                                *creaWidthLeft);
         Height:= round(TLabel(frm1500.Components[vintLoop]).Height
                                                                *creaHeightTop);
         caption:= TLabel(frm1500.Components[vintLoop]).caption;
         {Special hard code that I love!}
         If pos('BLK LUNG', caption) > 0 then
           left := left - 30;
         font.size:= TLabel(frm1500.Components[vintLoop]).font.size-1;
         font.name:= TLabel(frm1500.Components[vintLoop]).font.name;
         font.style:= TLabel(frm1500.Components[vintLoop]).font.style;
         Parent:= frm1500QR.rpt1500;
         end;
       end
    else
    If frm1500.Components[vintLoop] is TCheckbox then
       begin
       with TQRLabel.Create(frm1500QR.rpt1500) do
         begin
         name:= TCheckbox(frm1500.Components[vintLoop]).name;
         Left:= round((TCheckbox(frm1500.Components[vintLoop]).Left+25)
                                                                *creaWidthLeft);
         Top:= round((TCheckbox(frm1500.Components[vintLoop]).Top+36)
                                                                *creaHeightTop);
         Width:= round((TCheckbox(frm1500.Components[vintLoop]).Width)
                                                                *creaWidthLeft);
         Height:= round(TCheckbox(frm1500.Components[vintLoop]).Height
                                                                *creaHeightTop);
        {The default is to print the caption only on full form, not pre-printed}
         If chkFormType.checked then
             caption:= TCheckbox(frm1500.Components[vintLoop]).caption
         else
             caption:= '';
         font.size:= TCheckbox(frm1500.Components[vintLoop]).font.size-1;
         font.name:= TCheckbox(frm1500.Components[vintLoop]).font.name;
         font.style:= TCheckbox(frm1500.Components[vintLoop]).font.style;
         If TCheckbox(frm1500.Components[vintLoop]).checked then
             If chkFormType.checked then
                caption:= 'X-' + caption
             else
                caption:= 'X'
         else
             caption:= '   ' + caption;
         Parent:= frm1500QR.rpt1500;
         end;
       end
    else
    If frm1500.Components[vintLoop] is Tedit then
       begin
       with TQRLabel.Create(frm1500QR.rpt1500) do
         begin
         name:= Tedit(frm1500.Components[vintLoop]).name;
         Left:= round((Tedit(frm1500.Components[vintLoop]).Left+25)
                                                                *creaWidthLeft);
         Top:= round((Tedit(frm1500.Components[vintLoop]).Top+36)
                                                                *creaHeightTop);
         Width:= round((Tedit(frm1500.Components[vintLoop]).Width)
                                                                *creaWidthLeft);
         Height:= round(Tedit(frm1500.Components[vintLoop]).Height
                                                                *creaHeightTop);
         caption:= Tedit(frm1500.Components[vintLoop]).text;
         font.size:= Tedit(frm1500.Components[vintLoop]).font.size-1;
         font.name:= Tedit(frm1500.Components[vintLoop]).font.name;
         Parent:= frm1500QR.rpt1500;
         end;
       end
    else
    If (frm1500.Components[vintLoop] is Tmemo) and
          ((chkFormType.checked) or
           (frm1500.components[vintLoop].tag = 0)) then
       begin
       with TQRmemo.Create(frm1500QR.rpt1500) do
         begin
         name:= Tmemo(frm1500.Components[vintLoop]).name;
         Left:= round((Tmemo(frm1500.Components[vintLoop]).Left+25)
                                                                *creaWidthLeft);
         Top:= round((Tmemo(frm1500.Components[vintLoop]).Top+36)
                                                                *creaHeightTop);
         Width:= round((Tmemo(frm1500.Components[vintLoop]).Width)
                                                                *creaWidthLeft);
         Height:= round(Tmemo(frm1500.Components[vintLoop]).Height
                                                                *creaHeightTop);
         lines.text:= Tmemo(frm1500.Components[vintLoop]).lines.text;
         font.size:= Tmemo(frm1500.Components[vintLoop]).font.size-1;
         font.name:= Tmemo(frm1500.Components[vintLoop]).font.name;
         Parent:= frm1500QR.rpt1500;
         end;
       end
    else
    If frm1500.Components[vintLoop] is Timage then
       begin
       with TQRimage.Create(frm1500QR.rpt1500) do
         begin
         Left:= round((Timage(frm1500.Components[vintLoop]).Left+25)
                                                                *creaWidthLeft);
         Top:= round((Timage(frm1500.Components[vintLoop]).Top+36)
                                                                *creaHeightTop);
         Width:= round((Timage(frm1500.Components[vintLoop]).Width)
                                                                *creaWidthLeft);
         Height:= round(Timage(frm1500.Components[vintLoop]).Height
                                                                *creaHeightTop);
         stretch:=true;
         picture:= Timage(frm1500.Components[vintLoop]).picture;
         Parent:= frm1500QR.rpt1500;
         end;
       end;
    end;
  {Adjust fields to the correct location on the pre-printed form}
  If not chkFormType.checked then
     If chkBlueCross.checked then
         AdjustPrePrintedBlueCross
     else
     If (chkMedicarePrint.checked) or (chk1500_0805.checked) then
         AdjustPrePrintedMedicare
     else
         AdjustPrePrinted1500;
  {---------------}
  frm1500QR.rpt1500.Preview;
  finally
    frm1500QR.release;
    frm1500QR := nil;
  end;

end;

{Load all values for components back to the form from the memo field in the
datamodule}
Procedure Tfrm1500.Load1500FromHistory;
var vstlFields: tstringlist;
    vintLoop1: integer;
    Procedure Fieldscan(const cstrField: string; const cstrValue: string);
      var vintLoop2: integer;
          vstrWork: string;
      begin
      For vintLoop2:= 0 to ComponentCount -1 do
        If Components[vintLoop2].name = cstrField then
           begin
           If Components[vintLoop2] is TEdit then
              Tedit(Components[vintLoop2]).text:= cstrValue
           else
           If Components[vintLoop2] is TMemo then
              begin
              vstrWork:= cstrValue;
              while pos('||', vstrWork) > 0 do
                 vstrWork:= copy(vstrWork,1,pos('||', vstrWork)-1) + #13#10 +
                            copy(vstrWork,pos('||', vstrWork)+2,999);
              Tmemo(Components[vintLoop2]).text:= vstrWork;
              end
           else
           If Components[vintLoop2] is TCheckBox then
              If cstrValue = 'True' then
                 TCheckBox(Components[vintLoop2]).checked:= true
              else
                 TCheckBox(Components[vintLoop2]).checked:= false;
           break;
           end;
      end;
begin
vstlFields:= tstringlist.create;
try
vstlFields.text:= vdtmQuickReport.qry1500Form['Appt1500Fields'];
For vintLoop1 := 0 to vstlFields.count - 1 do
  FieldScan(copy(vstlFields[vintLoop1], 1, pos('=', vstlFields[vintLoop1])-1),
            copy(vstlFields[vintLoop1], pos('=', vstlFields[vintLoop1])+1,999));
finally
  vstlFields.free;
  end;
end;

procedure Tfrm1500.Save1500;
var vintLoop2: integer;
    vstlFields: tstringlist;
    vstrWork: string;
begin
vstlFields:= tstringList.create;
try
For vintLoop2:= 0 to ComponentCount -1 do
     begin
     vstrWork:= '';
     If Components[vintLoop2] is TEdit then
        vstrWork:= Tedit(Components[vintLoop2]).text
     else
     If (Components[vintLoop2] is TMemo) and
        (Components[vintLoop2].tag = 0) then
        begin
        vstrWork:= Tmemo(Components[vintLoop2]).text;
        while pos(#13#10, vstrWork) > 0 do
           vstrWork := copy(vstrWork, 1, pos(#13#10, vstrWork)-1)
           + '||' + copy(vstrWork, pos(#13#10, vstrWork)+2, 999);
        end
     else
     If Components[vintLoop2] is TCheckBox then
        If TCheckBox(Components[vintLoop2]).checked then
           vstrWork := 'True'
        else
           vstrWork := 'False';
     If Length(vstrWork) > 1 then
        begin
        vstrWork:= Components[vintLoop2].name + '=' + vstrWork;
        vstlFields.add(vstrWork);
        end;
     end;
vdtmQuickReport.qry1500Form.edit;
vdtmQuickReport.qry1500Form['Appt1500Fields']:= vstlFields.text;
vdtmQuickReport.qry1500Form.post;
finally
  vstlFields.free;
  end;
end;

procedure Tfrm1500.LoadFromDataModule;
var vintHouseHold, vintHouseholdHead, vintInsuranceEntity: integer;
    vqryTemp: tquery;
    vstrWork, vstrLineNumber: string;
    Procedure Fill1500Field(const cstrField: string; const cstrValue: string);
      var vintLoop: integer;
      begin
      For vintLoop:= 0 to frm1500.ComponentCount - 1 do
        If cstrField = frm1500.Components[vintLoop].name then
           begin
           tedit(frm1500.Components[vintLoop]).text := cstrValue;
           break;
           end;
      end;
begin
{Save values for temporary queries}
vintHousehold:= vdtmQuickReport.qryEntity.fieldbyname
                                                  ('EntityHousehold').asinteger;
{Use appointment information}
edtCurrentDate.text:= datetostr(vdtmQuickReport.qryAppointment.fieldbyname
                                                   ('ApptDateTime').asdatetime);
edtSignatureDate.text:= datetostr(vdtmQuickReport.qryAppointment.fieldbyname
                                                   ('ApptDateTime').asdatetime);
{Use current entity information}
  edtPatientName.text:=
      vdtmQuickReport.qryEntity.fieldbyname('EntityLastName').asstring +
      ', ' + vdtmQuickReport.qryEntity.fieldbyname('EntityFirstName').asstring +
      ' ' + vdtmQuickReport.qryEntity.fieldbyname('EntityMiddle').asstring;
{Use patient information}
edtPatientBirth.text:= datetostr(vdtmQuickReport.qryPatient.fieldbyname
                                                ('PatientBirth').asdatetime);

edtID.text:= vdtmQuickReport.qryPatient.fieldbyname('PatientInsID').asstring;

If vdtmQuickReport.qryPatient.fieldbyname
                                        ('PatientGender').asstring = 'Male' then
  chkMale1.checked:= true
else
If vdtmQuickReport.qryPatient.fieldbyname
                                      ('PatientGender').asstring = 'Female' then
  chkFemale1.checked:= true;

If vdtmQuickReport.qryPatient.fieldbyname
                                  ('PatientRelationship').asstring = 'Self' then
  chkSelf.checked:= true
else
If vdtmQuickReport.qryPatient.fieldbyname
                                ('PatientRelationship').asstring = 'Spouse' then
  chkSpouse.checked:= true
else
If vdtmQuickReport.qryPatient.fieldbyname
                                ('PatientRelationship').asstring = 'Child' then
  chkChild.checked:= true
else
  chkOther.checked:= true;

If vdtmQuickReport.qryPatient.fieldbyname
                                ('PatientMarital').asstring = 'Single' then
  chkSingle.checked:= true
else
If vdtmQuickReport.qryPatient.fieldbyname
                                ('PatientMarital').asstring = 'Married' then
  chkMarried.checked:= true
else
  chkOther2.checked:= true;

If vdtmQuickReport.qryPatient.fieldbyname
                              ('PatientEmpOrStudent').asstring = 'Employed' then
  chkEmployed.checked:= true
else
If vdtmQuickReport.qryPatient.fieldbyname
                     ('PatientEmpOrStudent').asstring = 'Full-Time Student' then
  chkFullTime.checked:= true
else
If vdtmQuickReport.qryPatient.fieldbyname
                     ('PatientEmpOrStudent').asstring = 'Part-Time Student' then
  chkPartTime.checked:= true;

  vqryTemp:= tquery.create(nil);
try
{Insurance Carrier Address Information}
vqryTemp.requestlive:= false;
vqryTemp.DatabaseName := vdtmQuickReport.dbsMain.databasename;
vqryTemp.UniDirectional:= true;
vqryTemp.SQL.Text :=
  'Select * from Entity where Entity < 19999 and EntityDescription = "'
     + vdtmQuickReport.qryPatient.fieldbyname
                     ('PatientInsurance').asstring + '"';
vqryTemp.Open;
memCarrierAddress.lines.add(vdtmQuickReport.qryPatient.fieldbyname
                                                 ('PatientInsurance').asstring);
If vqryTemp.RecordCount = 1 then
   begin
   vintInsuranceEntity:= vqryTemp.fieldbyname('Entity').asinteger;
   vqryTemp.Close;
   vqryTemp.SQL.Text :=
        'Select * from Address where Entity = ' + inttostr(vintInsuranceEntity);
   vqryTemp.open;
   If vqryTemp.RecordCount = 1 then
     begin
     memCarrierAddress.lines.add(vqryTemp.fieldbyname
                                                  ('AddressLine1').asstring);
     If vqryTemp.fieldbyname('AddressLine2').asstring > '    A' then
        memCarrierAddress.lines.add(vqryTemp.fieldbyname
                                                  ('AddressLine2').asstring);
     memCarrierAddress.lines.add(vqryTemp.fieldbyname
                                              ('AddressCity').asstring + ', '
      + vqryTemp.fieldbyname('AddressState').asstring +
      ' ' + vqryTemp.fieldbyname('AddressZip').asstring);
     end;
   vqryTemp.Close;
   end
else
   vqryTemp.Close;
{Household Address Information}
vqryTemp.requestlive:= false;
vqryTemp.DatabaseName := vdtmQuickReport.dbsMain.databasename;
vqryTemp.UniDirectional:= true;
vqryTemp.SQL.Text :=
  'Select * from Address where Entity = ' + inttostr(vintHousehold) +
  ' and AddressType = "Home"';
vqryTemp.Open;
If vqryTemp.RecordCount = 1 then
   begin
   edtInsuredAddress.text := vqryTemp.fieldbyname('AddressLine1').asstring;
   edtPatientAddress.text := vqryTemp.fieldbyname('AddressLine1').asstring;
   edtInsuredCity.text := vqryTemp.fieldbyname('AddressCity').asstring;
   edtPatientCity.text := vqryTemp.fieldbyname('AddressCity').asstring;
   edtInsuredState.text := vqryTemp.fieldbyname('AddressState').asstring;
   edtPatientState.text := vqryTemp.fieldbyname('AddressState').asstring;
   edtInsuredZip.text := vqryTemp.fieldbyname('AddressZip').asstring;
   edtPatientZip.text := vqryTemp.fieldbyname('AddressZip').asstring;
   end;
vqryTemp.Close;
{Household Phone Information}
vqryTemp.SQL.Text :=
  'Select * from PhoneNumber where Entity = ' + inttostr(vintHousehold) +
  ' and PhoneCategory = "Home"';
vqryTemp.Open;
If vqryTemp.RecordCount = 1 then
   begin
   edtInsuredTelephone.text := vqryTemp.fieldbyname('PhoneNumber').asstring;
   edtPatientTelephone.text := vqryTemp.fieldbyname('PhoneNumber').asstring;
   end;
vqryTemp.Close;
{Find Household Head Entity and Physician entity}
vqryTemp.SQL.Text :=
  'Select HouseHoldHead, HouseHoldPhysician from HouseHold where Entity = ' +
     inttostr(vintHousehold);
vqryTemp.Open;
edtReferralPhysician.text:=
          FindEntityName(vqryTemp.fieldbyname('HouseholdPhysician').asinteger);
edtPhysicianName.text:= edtReferralPhysician.text;
vintHouseHoldHead := vqryTemp.fieldbyname('HouseHoldHead').asinteger;
vqryTemp.Close;
{Find HouseHoldHead Entity information}
vqryTemp.SQL.Text :=
  'Select * from Entity where Entity = ' + inttostr(vintHouseholdHead);
vqryTemp.Open;
If vqryTemp.RecordCount = 1 then
   edtInsuredName.text:=
      vdtmQuickReport.qryEntity.fieldbyname('EntityLastName').asstring +
      ', ' + vdtmQuickReport.qryEntity.fieldbyname('EntityFirstName').asstring +
      ' ' + vdtmQuickReport.qryEntity.fieldbyname('EntityMiddle').asstring;
vqryTemp.Close;

{Patient for the insured - head of household}
vqryTemp.SQL.Text :=
  'Select * from Patient where Entity = ' + inttostr(vintHouseholdHead);
vqryTemp.Open;
If vqryTemp.RecordCount = 1 then
   edtInsuredName.text:=
      vdtmQuickReport.qryEntity.fieldbyname('EntityLastName').asstring +
      ', ' + vdtmQuickReport.qryEntity.fieldbyname('EntityFirstName').asstring +
      ' ' + vdtmQuickReport.qryEntity.fieldbyname('EntityMiddle').asstring;

If length(edtID.text) = 0 then
    edtID.text:= vqryTemp.fieldbyname('PatientInsID').asstring;
If length(edtID.text) = 0 then
    edtID.text:= vqryTemp.fieldbyname('PatientSSN').asstring;

edtInsuredGroup.text:= vqryTemp.fieldbyname('PatientInsGroup').asstring;
edtInsuredBirth.text:= vqryTemp.fieldbyname('PatientBirth').asstring;
edtPatientBalance.text:= format('%5.2m',
                           [vqryTemp.fieldbyname('PatientBalance').ascurrency]);

If vdtmQuickReport.qryPatient.fieldbyname
                                        ('PatientGender').asstring = 'Male' then
  chkMale2.checked:= true
else
If vdtmQuickReport.qryPatient.fieldbyname
                                      ('PatientGender').asstring = 'Female' then
  chkFemale2.checked:= true;
edtInsuredEmployer.text := vqryTemp.fieldbyname
                                             ('PatientEmployerSchool').asstring;
edtInsuredPlan.text := vqryTemp.fieldbyname('PatientInsurance').asstring;

If vdtmQuickReport.qryPatient.fieldbyname
                              ('PatientInsType').asstring = 'Medicaid' then
  chkMedicaid.checked:= true
else
If vdtmQuickReport.qryPatient.fieldbyname
                     ('PatientInsType').asstring = 'Medicare' then
  chkMedicare.checked:= true
else
If vdtmQuickReport.qryPatient.fieldbyname
                     ('PatientInsType').asstring = 'ChampUS' then
  chkSSN.checked:= true
else
If vdtmQuickReport.qryPatient.fieldbyname
                     ('PatientInsType').asstring = 'ChampVA' then
  chkVA.checked:= true
else
If vdtmQuickReport.qryPatient.fieldbyname
                     ('PatientInsType').asstring = 'Group Health Plan' then
  chkSSNID.checked:= true
else
If vdtmQuickReport.qryPatient.fieldbyname
                     ('PatientInsType').asstring = 'FECA Blk Lung' then
  chkFECA.checked:= true
else
If vdtmQuickReport.qryPatient.fieldbyname
                     ('PatientInsType').asstring = 'Other' then
  chkOther.checked:= true;
vqryTemp.Close;

{1500 Billing Detail records from the Appointment screen}
If vdtmQuickReport.qryAppt1500Detail.RecordCount > 0 then
  begin
  vdtmQuickReport.qryAppt1500Detail.first;
  While not vdtmQuickReport.qryAppt1500Detail.eof do
    begin
    If (vdtmQuickReport.qryAppt1500Detail.fieldbyname
                                             ('Appt1500Line').asinteger > 0) and
       (vdtmQuickReport.qryAppt1500Detail.fieldbyname
                                            ('Appt1500Line').asinteger < 7) then
       begin
       vstrLineNumber := inttostr
                         (vdtmQuickReport.qryAppt1500Detail.fieldbyname
                                                    ('Appt1500Line').asinteger);
       Fill1500Field('edtServiceFrom' + vstrLineNumber,
                 vdtmQuickReport.qryAppt1500Detail.fieldbyname
                                             ('Appt1500DateFrom').asstring);
       Fill1500Field('edtServiceTo' + vstrLineNumber,
                 vdtmQuickReport.qryAppt1500Detail.fieldbyname
                                             ('Appt1500DateTo').asstring);
       Fill1500Field('edtServicePlace' + vstrLineNumber,
                 vdtmQuickReport.qryAppt1500Detail.fieldbyname
                                             ('Appt1500Place').asstring);
       Fill1500Field('edtServiceType' + vstrLineNumber,
                 vdtmQuickReport.qryAppt1500Detail.fieldbyname
                                             ('Appt1500Type').asstring);
       Fill1500Field('edtCode' + vstrLineNumber,
                 vdtmQuickReport.qryAppt1500Detail.fieldbyname
                                             ('Appt1500CPT_HCPCS').asstring);
       Fill1500Field('edtModifier' + vstrLineNumber,
                 vdtmQuickReport.qryAppt1500Detail.fieldbyname
                                             ('Appt1500Modifier').asstring);
       Fill1500Field('edtDiagnosis' + vstrLineNumber,
                 vdtmQuickReport.qryAppt1500Detail.fieldbyname
                                             ('Appt1500Diagnosis').asstring);
       Fill1500Field('edtServCharges' + vstrLineNumber,
         format('%5.2m', [vdtmQuickReport.qryAppt1500Detail.fieldbyname
                                             ('Appt1500Charge').ascurrency]));
       Fill1500Field('edtDays' + vstrLineNumber,
                 vdtmQuickReport.qryAppt1500Detail.fieldbyname
                                             ('Appt1500Days_Units').asstring);
       Fill1500Field('edtFamily' + vstrLineNumber,
                 vdtmQuickReport.qryAppt1500Detail.fieldbyname
                                             ('Appt1500EPSDT').asstring);
       Fill1500Field('edtEMG' + vstrLineNumber,
                 vdtmQuickReport.qryAppt1500Detail.fieldbyname
                                             ('Appt1500EMG').asstring);
       Fill1500Field('edtCOB' + vstrLineNumber,
                 vdtmQuickReport.qryAppt1500Detail.fieldbyname
                                             ('Appt1500COB').asstring);
       end;
    vdtmQuickReport.qryAppt1500Detail.next;
    end;

  end;

{Values obtained from the picklist system}
edtFedTax.text:= FillDefault('FederalTaxID');
vstrWork:= FillDefault('SupplierBill');
While pos('|', vstrWork) > 0 do
   begin
   memPhysicianInfo.lines.add(copy(vstrWork, 1, pos('|', vstrWork) - 1));
   vstrWork:= copy(vstrWork,pos('|', vstrWork) + 1, 999);
   end;
{--- Override with bigger literal than default can provide}
 vstrWork:= 'Multi-Cultural Health Evaluation Delivery ' + #13#10 +
 'System (814) 453-6229' + #13#10 + '2928 Peach St.  Erie, PA 16508-1843';
{---------------------------------------------------------}
memPhysicianInfo.text:= vstrWork;
//Per Cindy - add to all forms the defail address.
edtPIN.text:= '1730227307';
edtPIN2.text:= edtPIN.text;
memAddressService.text:= memPhysicianInfo.text;
vqryTemp.Close;
finally
  vqryTemp.Free;
  end;
end;

procedure Tfrm1500.FormClose(Sender: TObject; var Action: TCloseAction);
begin
If not edtPatientName.readonly then
    Save1500;
end;

{Mutually exclusive setting for form(s)}
procedure Tfrm1500.chkBlueCrossClick(Sender: TObject);
begin
If chkBlueCross.Checked then
   begin
   edtPatientName.text:=
      vdtmQuickReport.qryEntity.fieldbyname('EntityFirstName').asstring +
      ' ' + vdtmQuickReport.qryEntity.fieldbyname('EntityMiddle').asstring +
      ' ' + vdtmQuickReport.qryEntity.fieldbyname('EntityLastName').asstring;
   chkMedicarePrint.Checked:= false;
   chkFormType.Checked := false;
   chk1500_0805.checked:= false;
   end;
end;

procedure Tfrm1500.chkFormTypeClick(Sender: TObject);
begin
If chkFormType.Checked then
   begin
   chkMedicarePrint.Checked:= false;
   chkBlueCross.Checked:= false;
   end;
end;

procedure Tfrm1500.chkMedicarePrintClick(Sender: TObject);
begin
If chkMedicarePrint.Checked then
   begin
   chkFormType.Checked:= false;
   chkBlueCross.Checked:= false;
   chk1500_0805.checked:= false;
   end;
end;

{Monster case routine follows}
{----------------------------------------------------------------------------}
Procedure Tfrm1500.AdjustPrePrinted1500;
  var vintLoop, vintTop, vintLeft, vintTopDef, vintLeftDef: integer;
      vstrN: string;
begin
vintTopDef:= strtoint(FillDefault('1500_top'));
vintLeftDef:= strtoint(FillDefault('1500_left'));

for vintLoop:= 0 to frm1500QR.rpt1500.ComponentCount-1 do
 with frm1500QR.rpt1500.Components[vintLoop] do
  begin
  vintTop:= 0;
  vintLeft:= 0;
  vstrN:= frm1500QR.rpt1500.Components[vintLoop].name;
  {Fields checked by name from left to right, top to bottom on this form}
  {Line 1}
  If vstrN='chkMedicare' then            begin vinttop:= 18;  vintLeft:= 09; end
  else If vstrN='chkMedicaid' then       begin vinttop:= 18;  vintLeft:= 07; end
  else If vstrN='chkSSN' then            begin vinttop:= 18;  vintLeft:= 06; end
  else If vstrN='chkVA' then             begin vinttop:= 18;  vintLeft:= 11; end
  else If vstrN='chkSSNID' then          begin vinttop:= 18;  vintLeft:= 13; end
  else If vstrN='chkFECA' then           begin vinttop:= 18;  vintLeft:= 07; end
  else If vstrN='chkID' then             begin vinttop:= 18;  vintLeft:= 05; end
  else If vstrN='edtID' then             begin vinttop:= 18;  vintLeft:= 09; end
  {Line 2}
  else If vstrN='edtPatientName' then    begin vinttop:= 16;  vintLeft:= 09; end
  else If vstrN='edtPatientBirth' then   begin vinttop:= 16;  vintLeft:= 11; end
  else If vstrN='chkMale1' then          begin vinttop:= 16;  vintLeft:= 05; end
  else If vstrN='chkFemale1' then        begin vinttop:= 16;  vintLeft:= 15; end
  else If vstrN='edtInsuredName' then    begin vinttop:= 16;  vintLeft:= 09; end
  {Line 3}
  else If vstrN='edtPatientAddress' then begin vinttop:= 16;  vintLeft:= 09; end
  else If vstrN='chkSelf' then           begin vinttop:= 15;  vintLeft:= 27; end
  else If vstrN='chkSpouse' then         begin vinttop:= 15;  vintLeft:= 39; end
  else If vstrN='chkChild' then          begin vinttop:= 15;  vintLeft:= 23; end
  else If vstrN='chkOther' then          begin vinttop:= 15;  vintLeft:= 29; end
  else If vstrN='edtInsuredAddress' then begin vinttop:= 16;  vintLeft:= 09; end
  {Line 4}
  else If vstrN='edtPatientCity' then    begin vinttop:= 15;  vintLeft:= 09; end
  else If vstrN='edtPatientState' then   begin vinttop:= 15;  vintLeft:= 15; end
  else If vstrN='chkSingle' then         begin vinttop:= 15;  vintLeft:= 48; end
  else If vstrN='chkMarried' then        begin vinttop:= 15;  vintLeft:= 45; end
  else If vstrN='chkOther2' then         begin vinttop:= 15;  vintLeft:= 45; end
  else If vstrN='edtInsuredCity' then    begin vinttop:= 15;  vintLeft:= 09; end
  else If vstrN='edtInsuredState' then   begin vinttop:= 15;  vintLeft:= 05; end
  {Line 5}
  else If vstrN='edtPatientZIP' then     begin vinttop:= 15;  vintLeft:= 09; end
  else If vstrN='edtPatientTelephone' then
                                         begin vinttop:= 15;  vintLeft:= 55; end
  else If vstrN='chkEmployed' then       begin vinttop:= 27;  vintLeft:= 48; end
  else If vstrN='chkFullTime' then       begin vinttop:= 27;  vintLeft:= 45; end
  else If vstrN='chkPartTime' then       begin vinttop:= 27;  vintLeft:= 45; end
  else If vstrN='edtInsuredZIP' then     begin vinttop:= 15;  vintLeft:= 09; end
  else If vstrN='edtInsuredTelephone' then
                                         begin vinttop:= 15;  vintLeft:= 75; end
  {Line 6}
  else If vstrN='edtOtherName' then      begin vinttop:= 15;  vintLeft:= 09; end
  else If vstrN='edtInsuredGroup' then   begin vinttop:= 15;  vintLeft:= 09; end
  {Line 7}
  else If vstrN='edtOtherPolicy' then    begin vinttop:= 12;  vintLeft:= 09; end
  else If vstrN='chkYes' then            begin vinttop:= 12;  vintLeft:= 16; end
  else If vstrN='chkNo' then             begin vinttop:= 12;  vintLeft:= 12; end
  else If vstrN='edtInsuredBirth' then   begin vinttop:= 13;  vintLeft:= 45; end
  else If vstrN='chkMale2' then          begin vinttop:= 12;  vintLeft:=-10; end
  else If vstrN='chkFemale2' then        begin vinttop:= 12;  vintLeft:= 13; end
  {Line 8}
  else If vstrN='edtOtherBirth' then     begin vinttop:= 13;  vintLeft:= 19; end
  else If vstrN='chkMale3' then          begin vinttop:= 14;  vintLeft:=-19; end
  else If vstrN='chkFemale3' then        begin vinttop:= 14;  vintLeft:=-07; end
  else If vstrN='chkYes2' then           begin vinttop:= 14;  vintLeft:= 16; end
  else If vstrN='chkNo2' then            begin vinttop:= 14;  vintLeft:= 12; end
  else If vstrN='edtAccState' then       begin vinttop:= 13;  vintLeft:= 10; end
  else If vstrN='edtInsuredEmployer' then
                                         begin vinttop:= 13;  vintLeft:= 09; end
  {Line 9}
  else If vstrN='edtOtherEmployer' then  begin vinttop:= 12;  vintLeft:= 09; end
  else If vstrN='chkYes3' then           begin vinttop:= 10;  vintLeft:= 16; end
  else If vstrN='chkNo3' then            begin vinttop:= 10;  vintLeft:= 12; end
  else If vstrN='edtInsuredPlan' then
                                         begin vinttop:= 12;  vintLeft:= 09; end
  {Line 10}
  else If vstrN='edtOtherInsurance' then begin vinttop:= 11;  vintLeft:= 09; end
  else If vstrN='chkYes1' then           begin vinttop:= 10;  vintLeft:= 23; end
  else If vstrN='chkNo1' then            begin vinttop:= 10;  vintLeft:= 17; end
  {Line 11}
  else If vstrN='edtSignatureDate' then  begin vinttop:= 08;  vintLeft:= 00; end
  else If vstrN='lbl151' then            begin vinttop:= 08;  vintLeft:= 00; end
  else If vstrN='lbl152' then            begin vinttop:= 08;  vintLeft:= 00; end
  {Line 12}
  else If vstrN='edtCurrentDate' then    begin vinttop:= 07;  vintLeft:= 20; end
  else If vstrN='edtSimilarDate' then    begin vinttop:= 07;  vintLeft:=-09; end
  else If vstrN='edtWorkDateFrom' then   begin vinttop:= 07;  vintLeft:= 25; end
  else If vstrN='edtWorkDateTo' then     begin vinttop:= 07;  vintLeft:=-08; end
  {Line 13}
  else If vstrN='edtReferralPhysician' then
                                         begin vinttop:= 07;  vintLeft:=-20; end
  else If vstrN='edtReferralID' then     begin vinttop:= 07;  vintLeft:= 09; end
  else If vstrN='edtHospFrom' then       begin vinttop:= 07;  vintLeft:= 18; end
  else If vstrN='edtHospTo' then         begin vinttop:= 07;  vintLeft:=-10; end
  {Line 14}
  else If vstrN='chkYes4' then           begin vinttop:= 03;  vintLeft:= 21; end
  else If vstrN='chkNo4' then            begin vinttop:= 03;  vintLeft:= 16; end
  else If vstrN='edtCharges' then        begin vinttop:= 05;  vintLeft:= 12; end
  {Line 15}
  else If vstrN='edtDiagnose1' then      begin vinttop:= 01;  vintLeft:= 05; end
  else If vstrN='edtDiagnose3' then      begin vinttop:= 02;  vintLeft:= 28; end
  else If vstrN='edtMedicaidCode' then   begin vinttop:= 04;  vintLeft:=-25; end
  else If vstrN='edtMedicaidOriginal' then
                                         begin vinttop:= 04;  vintLeft:=-40; end
  {Line 16}
  else If vstrN='edtDiagnose2' then      begin vinttop:= 03;  vintLeft:= 05; end
  else If vstrN='edtDiagnose4' then      begin vinttop:= 04;  vintLeft:= 28; end
  else If vstrN='edtPriorAuthor' then    begin vinttop:= 05;  vintLeft:=-15; end
  {Line 17}
  else If vstrN='edtServiceFrom1' then   begin vinttop:=-08;  vintLeft:= 15; end
  else If vstrN='edtServiceTo1' then     begin vinttop:=-08;  vintLeft:= 15; end
  else If vstrN='edtServicePlace1' then  begin vinttop:=-08;  vintLeft:= 09; end
  else If vstrN='edtServiceType1' then   begin vinttop:=-08;  vintLeft:= 12; end
  else If vstrN='edtCode1' then          begin vinttop:=-08;  vintLeft:= 25; end
  else If vstrN='edtModifier1' then      begin vinttop:=-08;  vintLeft:= 18; end
  else If vstrN='edtDiagnosis1' then     begin vinttop:=-08;  vintLeft:= 08; end
  else If vstrN='edtServCharges1' then   begin vinttop:=-08;  vintLeft:= 14; end
  else If vstrN='edtDays1' then          begin vinttop:=-08;  vintLeft:= 06; end
  else If vstrN='edtFamily1' then        begin vinttop:=-08;  vintLeft:= 07; end
  else If vstrN='edtEMG1' then           begin vinttop:=-08;  vintLeft:= 00; end
  else If vstrN='edtCOB1' then           begin vinttop:=-08;  vintLeft:=-02; end
  {Line 18}
  else If vstrN='edtServiceFrom2' then   begin vinttop:=-09;  vintLeft:= 15; end
  else If vstrN='edtServiceTo2' then     begin vinttop:=-09;  vintLeft:= 15; end
  else If vstrN='edtServicePlace2' then  begin vinttop:=-09;  vintLeft:= 09; end
  else If vstrN='edtServiceType2' then   begin vinttop:=-09;  vintLeft:= 12; end
  else If vstrN='edtCode2' then          begin vinttop:=-09;  vintLeft:= 25; end
  else If vstrN='edtModifier2' then      begin vinttop:=-09;  vintLeft:= 18; end
  else If vstrN='edtDiagnosis2' then     begin vinttop:=-09;  vintLeft:= 08; end
  else If vstrN='edtServCharges2' then   begin vinttop:=-09;  vintLeft:= 14; end
  else If vstrN='edtDays2' then          begin vinttop:=-09;  vintLeft:= 06; end
  else If vstrN='edtFamily2' then        begin vinttop:=-09;  vintLeft:= 07; end
  else If vstrN='edtEMG2' then           begin vinttop:=-09;  vintLeft:= 00; end
  else If vstrN='edtCOB2' then           begin vinttop:=-09;  vintLeft:=-02; end
  {Line 19}
  else If vstrN='edtServiceFrom3' then   begin vinttop:=-10;  vintLeft:= 15; end
  else If vstrN='edtServiceTo3' then     begin vinttop:=-10;  vintLeft:= 15; end
  else If vstrN='edtServicePlace3' then  begin vinttop:=-10;  vintLeft:= 09; end
  else If vstrN='edtServiceType3' then   begin vinttop:=-10;  vintLeft:= 12; end
  else If vstrN='edtCode3' then          begin vinttop:=-10;  vintLeft:= 25; end
  else If vstrN='edtModifier3' then      begin vinttop:=-10;  vintLeft:= 18; end
  else If vstrN='edtDiagnosis3' then     begin vinttop:=-10;  vintLeft:= 08; end
  else If vstrN='edtServCharges3' then   begin vinttop:=-10;  vintLeft:= 14; end
  else If vstrN='edtDays3' then          begin vinttop:=-10;  vintLeft:= 06; end
  else If vstrN='edtFamily3' then        begin vinttop:=-10;  vintLeft:= 07; end
  else If vstrN='edtEMG3' then           begin vinttop:=-10;  vintLeft:= 00; end
  else If vstrN='edtCOB3' then           begin vinttop:=-10;  vintLeft:=-02; end
  {Line 20}
  else If vstrN='edtServiceFrom4' then   begin vinttop:=-10;  vintLeft:= 15; end
  else If vstrN='edtServiceTo4' then     begin vinttop:=-10;  vintLeft:= 15; end
  else If vstrN='edtServicePlace4' then  begin vinttop:=-10;  vintLeft:= 09; end
  else If vstrN='edtServiceType4' then   begin vinttop:=-10;  vintLeft:= 12; end
  else If vstrN='edtCode4' then          begin vinttop:=-10;  vintLeft:= 25; end
  else If vstrN='edtModifier4' then      begin vinttop:=-10;  vintLeft:= 18; end
  else If vstrN='edtDiagnosis4' then     begin vinttop:=-10;  vintLeft:= 08; end
  else If vstrN='edtServCharges4' then   begin vinttop:=-10;  vintLeft:= 14; end
  else If vstrN='edtDays4' then          begin vinttop:=-10;  vintLeft:= 06; end
  else If vstrN='edtFamily4' then        begin vinttop:=-10;  vintLeft:= 07; end
  else If vstrN='edtEMG4' then           begin vinttop:=-10;  vintLeft:= 00; end
  else If vstrN='edtCOB4' then           begin vinttop:=-10;  vintLeft:=-02; end
  {Line 21}
  else If vstrN='edtServiceFrom5' then   begin vinttop:=-11;  vintLeft:= 15; end
  else If vstrN='edtServiceTo5' then     begin vinttop:=-11;  vintLeft:= 15; end
  else If vstrN='edtServicePlace5' then  begin vinttop:=-11;  vintLeft:= 09; end
  else If vstrN='edtServiceType5' then   begin vinttop:=-11;  vintLeft:= 12; end
  else If vstrN='edtCode5' then          begin vinttop:=-11;  vintLeft:= 25; end
  else If vstrN='edtModifier5' then      begin vinttop:=-11;  vintLeft:= 18; end
  else If vstrN='edtDiagnosis5' then     begin vinttop:=-11;  vintLeft:= 08; end
  else If vstrN='edtServCharges5' then   begin vinttop:=-11;  vintLeft:= 14; end
  else If vstrN='edtDays5' then          begin vinttop:=-11;  vintLeft:= 06; end
  else If vstrN='edtFamily5' then        begin vinttop:=-11;  vintLeft:= 07; end
  else If vstrN='edtEMG5' then           begin vinttop:=-11;  vintLeft:= 00; end
  else If vstrN='edtCOB5' then           begin vinttop:=-11;  vintLeft:=-02; end
  {Line 22}
  else If vstrN='edtServiceFrom6' then   begin vinttop:=-12;  vintLeft:= 15; end
  else If vstrN='edtServiceTo6' then     begin vinttop:=-12;  vintLeft:= 15; end
  else If vstrN='edtServicePlace6' then  begin vinttop:=-12;  vintLeft:= 09; end
  else If vstrN='edtServiceType6' then   begin vinttop:=-12;  vintLeft:= 12; end
  else If vstrN='edtCode6' then          begin vinttop:=-12;  vintLeft:= 25; end
  else If vstrN='edtModifier6' then      begin vinttop:=-12;  vintLeft:= 18; end
  else If vstrN='edtDiagnosis6' then     begin vinttop:=-12;  vintLeft:= 08; end
  else If vstrN='edtServCharges6' then   begin vinttop:=-12;  vintLeft:= 14; end
  else If vstrN='edtDays6' then          begin vinttop:=-12;  vintLeft:= 06; end
  else If vstrN='edtFamily6' then        begin vinttop:=-12;  vintLeft:= 07; end
  else If vstrN='edtEMG6' then           begin vinttop:=-12;  vintLeft:= 00; end
  else If vstrN='edtCOB6' then           begin vinttop:=-12;  vintLeft:=-02; end
  {Line 23}
  else If vstrN='edtFedTax' then         begin vinttop:=-19;  vintLeft:= 06; end
  else If vstrN='chkSSNyes' then         begin vinttop:=-19;  vintLeft:=-06; end
  else If vstrN='chkEINyes' then         begin vinttop:=-19;  vintLeft:=-08; end
  else If vstrN='edtPatientAccount' then begin vinttop:=-19;  vintLeft:= 05; end
  else If vstrN='edtYes5' then           begin vinttop:=-22;  vintLeft:=-04; end
  else If vstrN='edtNo5' then            begin vinttop:=-22;  vintLeft:=-09; end
  else If vstrN='edtTotalCharge' then    begin vinttop:=-19;  vintLeft:= 29; end
  else If vstrN='edtAmountPaid' then     begin vinttop:=-19;  vintLeft:= 17; end
  else If vstrN='edtBalance' then        begin vinttop:=-19;  vintLeft:= 06; end
  {Line 24}  {-------------------------------------}
  else If vstrN='edtPhysicianName' then  begin vinttop:=-19;  vintLeft:= 09; end
  else If vstrN='memAddressService' then begin vinttop:=-17;  vintLeft:= 05; end
  else If vstrN='memPhysicianInfo' then  begin vinttop:=-15;  vintLeft:= 09; end
  {Line 25}  {-------------------------------------}
  else If vstrN='edtPIN' then            begin vinttop:=-12;  vintLeft:= 02; end
  else If vstrN='edtPIN2' then           begin vinttop:=-12;  vintLeft:= 05; end
  else If vstrN='edtGroup' then          begin vinttop:=-12;  vintLeft:=-10; end
  ;
  TqrLabel(frm1500QR.rpt1500.Components[vintLoop]).top :=
                TqrLabel(frm1500QR.rpt1500.Components[vintLoop]).top
                + vintTop
                + vintTopDef;
  TqrLabel(frm1500QR.rpt1500.Components[vintLoop]).left :=
                TqrLabel(frm1500QR.rpt1500.Components[vintLoop]).left
                + vintLeft
                + vintLeftDef;
  end;

end;

{Blue Cross has less required fields, so it will re-format to match the B/C form
Extra fields are flagged invisible.}
Procedure Tfrm1500.AdjustPrePrintedBlueCross;
  var vintLoop, vintTop, vintLeft, vintTopDef, vintLeftDef: integer;
      vstrN: string;
begin
vintTopDef:= strtoint(FillDefault('BlueC_top'));
vintLeftDef:= strtoint(FillDefault('BlueC_left'));

for vintLoop:= 0 to frm1500QR.rpt1500.ComponentCount-1 do
 with frm1500QR.rpt1500.Components[vintLoop] do
  begin
  vintTop:= 0;
  vintLeft:= 0;
  vstrN:= frm1500QR.rpt1500.Components[vintLoop].name;
  {Fields checked by name from left to right, top to bottom on this form}
  {Line 1}
  If vstrN='edtPatientName' then         begin vinttop:= 00;  vintLeft:= 09; end
  else If vstrN='edtPatientBirth' then   begin vinttop:= 02;  vintLeft:= 40; end
  else If vstrN='edtInsuredName' then    begin vinttop:= 02;  vintLeft:= 20; end
  {Line 2}
  else If vstrN='edtPatientAddress' then begin vinttop:=-04;  vintLeft:= 09; end
  else If vstrN='chkMale1' then          begin vinttop:= 33;  vintLeft:=-15; end
  else If vstrN='chkFemale1' then        begin vinttop:= 33;  vintLeft:=-20; end
  else If vstrN='edtID' then             begin vinttop:= 61;  vintLeft:= 20; end
  {Line 3}
  else If vstrN='edtPatientCity' then    begin vinttop:=-21;  vintLeft:= 09; end
  else If vstrN='edtPatientState' then   begin vinttop:=-21;  vintLeft:=-25; end
  else If vstrN='edtPatientZIP' then     begin vinttop:=-41;  vintLeft:= 09; end
  {Line 4}
  else If vstrN='edtPatientTelephone' then
                                         begin vinttop:=-33;  vintLeft:=-25; end
  else If vstrN='chkSelf' then           begin vinttop:= 35;  vintLeft:= 57; end
  else If vstrN='chkSpouse' then         begin vinttop:= 35;  vintLeft:= 54; end
  else If vstrN='chkChild' then          begin vinttop:= 35;  vintLeft:= 33; end
  else If vstrN='chkOther' then          begin vinttop:= 35;  vintLeft:= 29; end
  else If vstrN='edtInsuredGroup' then   begin vinttop:=-65;  vintLeft:= 20; end
  {Line 4}
  else If vstrN='edtOtherName' then      begin vinttop:=-25;  vintLeft:= 09; end
  else If vstrN='edtInsuredAddress' then begin vinttop:= 60;  vintLeft:= 20; end
  {Line 5}
  else If vstrN='edtOtherInsurance' then begin vinttop:=-141; vintLeft:= 09; end
  else If vstrN='chkYes' then            begin vinttop:=-47;  vintLeft:= 61; end
  else If vstrN='chkNo' then             begin vinttop:=-47;  vintLeft:= 32; end
  else If vstrN='edtInsuredCity' then    begin vinttop:= 42;  vintLeft:= 20; end
  else If vstrN='edtInsuredState' then   begin vinttop:= 42;  vintLeft:=-15; end
  else If vstrN='edtInsuredZIP' then     begin vinttop:= 24;  vintLeft:= 20; end
  {Line 6}
  else If vstrN='edtOtherPolicy' then    begin vinttop:=-24;  vintLeft:= 09; end
  else If vstrN='chkYes2' then           begin vinttop:=-48;  vintLeft:= 60; end
  else If vstrN='chkYes3' then           begin vinttop:=-80;  vintLeft:= 95; end
  else If vstrN='edtInsuredTelephone' then
                                         begin vinttop:= 43;  vintLeft:=-100;end
  {Line 7}
  else If vstrN='edtCurrentDate' then    begin vinttop:=-117; vintLeft:= 20; end
  else If vstrN='edtSimilarDate' then    begin vinttop:=-116; vintLeft:=-09; end
  {Line 8}
  else If vstrN='edtWorkDateTo' then     begin vinttop:=-87;  vintLeft:=-583;end
  {Line 9}
  else If vstrN='edtReferralPhysician' then
                                         begin vinttop:=-85;  vintLeft:=-20; end
  else If vstrN='edtReferralID' then     begin vinttop:=-85;  vintLeft:= 09; end
  else If vstrN='edtHospFrom' then       begin vinttop:=-85;  vintLeft:= 38; end
  else If vstrN='edtHospTo' then         begin vinttop:=-85;  vintLeft:= 35; end
  {Line 10}
  else If vstrN='chkYes4' then           begin vinttop:=-87;  vintLeft:= 65; end
  else If vstrN='chkNo4' then            begin vinttop:=-87;  vintLeft:= 40; end
  else If vstrN='edtCharges' then        begin vinttop:=-86;  vintLeft:=110; end
  {Line 11}
  else If vstrN='edtDiagnose1' then      begin vinttop:=-87;  vintLeft:=-15; end
  {Line 12}
  else If vstrN='edtDiagnose2' then      begin vinttop:=-97; vintLeft:=-15; end
  {Line 13}
  else If vstrN='edtDiagnose3' then      begin vinttop:=-55;  vintLeft:=-257;end
  {Line 14}
  else If vstrN='edtDiagnose4' then      begin vinttop:=-66;  vintLeft:=-257;end
  {Line 15}
  else If vstrN='edtServiceFrom1' then   begin vinttop:=-90;  vintLeft:=-03; end
  else If vstrN='edtServiceTo1' then     begin vinttop:=-90;  vintLeft:=-22; end
  else If vstrN='edtServicePlace1' then  begin vinttop:=-90;  vintLeft:=-35; end
  else If vstrN='edtServiceType1' then   begin vinttop:=-90;  vintLeft:=-23; end
  else If vstrN='edtCode1' then          begin vinttop:=-90;  vintLeft:=-05; end
  else If vstrN='edtModifier1' then      begin vinttop:=-90;  vintLeft:= 03; end
  else If vstrN='edtDiagnosis1' then     begin vinttop:=-90;  vintLeft:=135; end
  else If vstrN='edtServCharges1' then   begin vinttop:=-90;  vintLeft:=120; end
  else If vstrN='edtDays1' then          begin vinttop:=-90;  vintLeft:=107; end
  else If vstrN='edtFamily1' then        begin vinttop:=-90;  vintLeft:=120; end
  else If vstrN='edtREV1' then           begin vinttop:=-90;  vintLeft:= 00; end
  {Line 16}
  else If vstrN='edtServiceFrom2' then   begin vinttop:=-90;  vintLeft:=-03; end
  else If vstrN='edtServiceTo2' then     begin vinttop:=-90;  vintLeft:=-22; end
  else If vstrN='edtServicePlace2' then  begin vinttop:=-90;  vintLeft:=-35; end
  else If vstrN='edtServiceType2' then   begin vinttop:=-90;  vintLeft:=-23; end
  else If vstrN='edtCode2' then          begin vinttop:=-90;  vintLeft:=-05; end
  else If vstrN='edtModifier2' then      begin vinttop:=-90;  vintLeft:= 03; end
  else If vstrN='edtDiagnosis2' then     begin vinttop:=-90;  vintLeft:=135; end
  else If vstrN='edtServCharges2' then   begin vinttop:=-90;  vintLeft:=120; end
  else If vstrN='edtDays2' then          begin vinttop:=-90;  vintLeft:=107; end
  else If vstrN='edtFamily2' then        begin vinttop:=-90;  vintLeft:=120; end
  else If vstrN='edtREV2' then           begin vinttop:=-90;  vintLeft:= 00; end
  {Line 17}
  else If vstrN='edtServiceFrom3' then   begin vinttop:=-90;  vintLeft:=-03; end
  else If vstrN='edtServiceTo3' then     begin vinttop:=-90;  vintLeft:=-22; end
  else If vstrN='edtServicePlace3' then  begin vinttop:=-90;  vintLeft:=-35; end
  else If vstrN='edtServiceType3' then   begin vinttop:=-90;  vintLeft:=-23; end
  else If vstrN='edtCode3' then          begin vinttop:=-90;  vintLeft:=-05; end
  else If vstrN='edtModifier3' then      begin vinttop:=-90;  vintLeft:= 03; end
  else If vstrN='edtDiagnosis3' then     begin vinttop:=-90;  vintLeft:=135; end
  else If vstrN='edtServCharges3' then   begin vinttop:=-90;  vintLeft:=120; end
  else If vstrN='edtDays3' then          begin vinttop:=-90;  vintLeft:=107; end
  else If vstrN='edtFamily3' then        begin vinttop:=-90;  vintLeft:=120; end
  else If vstrN='edtREV3' then           begin vinttop:=-90;  vintLeft:= 00; end
  {Line 18}
  else If vstrN='edtServiceFrom4' then   begin vinttop:=-90;  vintLeft:=-03; end
  else If vstrN='edtServiceTo4' then     begin vinttop:=-90;  vintLeft:=-22; end
  else If vstrN='edtServicePlace4' then  begin vinttop:=-90;  vintLeft:=-35; end
  else If vstrN='edtServiceType4' then   begin vinttop:=-90;  vintLeft:=-23; end
  else If vstrN='edtCode4' then          begin vinttop:=-90;  vintLeft:=-05; end
  else If vstrN='edtModifier4' then      begin vinttop:=-90;  vintLeft:= 03; end
  else If vstrN='edtDiagnosis4' then     begin vinttop:=-90;  vintLeft:=135; end
  else If vstrN='edtServCharges4' then   begin vinttop:=-90;  vintLeft:=120; end
  else If vstrN='edtDays4' then          begin vinttop:=-90;  vintLeft:=107; end
  else If vstrN='edtFamily4' then        begin vinttop:=-90;  vintLeft:=120; end
  else If vstrN='edtREV4' then           begin vinttop:=-90;  vintLeft:= 00; end
  {Line 19}
  else If vstrN='edtServiceFrom5' then   begin vinttop:=-90;  vintLeft:=-03; end
  else If vstrN='edtServiceTo5' then     begin vinttop:=-90;  vintLeft:=-22; end
  else If vstrN='edtServicePlace5' then  begin vinttop:=-90;  vintLeft:=-35; end
  else If vstrN='edtServiceType5' then   begin vinttop:=-90;  vintLeft:=-23; end
  else If vstrN='edtCode5' then          begin vinttop:=-90;  vintLeft:=-05; end
  else If vstrN='edtModifier5' then      begin vinttop:=-90;  vintLeft:= 03; end
  else If vstrN='edtDiagnosis5' then     begin vinttop:=-90;  vintLeft:=135; end
  else If vstrN='edtServCharges5' then   begin vinttop:=-90;  vintLeft:=120; end
  else If vstrN='edtDays5' then          begin vinttop:=-90;  vintLeft:=107; end
  else If vstrN='edtFamily5' then        begin vinttop:=-90;  vintLeft:=120; end
  else If vstrN='edtREV5' then           begin vinttop:=-90;  vintLeft:= 00; end
  {Line 20}
  else If vstrN='edtServiceFrom6' then   begin vinttop:=-90;  vintLeft:=-03; end
  else If vstrN='edtServiceTo6' then     begin vinttop:=-90;  vintLeft:=-22; end
  else If vstrN='edtServicePlace6' then  begin vinttop:=-90;  vintLeft:=-35; end
  else If vstrN='edtServiceType6' then   begin vinttop:=-90;  vintLeft:=-23; end
  else If vstrN='edtCode6' then          begin vinttop:=-90;  vintLeft:=-05; end
  else If vstrN='edtModifier6' then      begin vinttop:=-90;  vintLeft:= 03; end
  else If vstrN='edtDiagnosis6' then     begin vinttop:=-90;  vintLeft:=135; end
  else If vstrN='edtServCharges6' then   begin vinttop:=-90;  vintLeft:=120; end
  else If vstrN='edtDays6' then          begin vinttop:=-90;  vintLeft:=107; end
  else If vstrN='edtFamily6' then        begin vinttop:=-90;  vintLeft:=120; end
  else If vstrN='edtREV6' then           begin vinttop:=-90;  vintLeft:= 00; end
  {Line 21}
  else If vstrN='edtTotalCharge' then    begin vinttop:=-30;  vintLeft:= 34; end
  else If vstrN='edtAmountPaid' then     begin vinttop:=-30;  vintLeft:= 34; end
  else If vstrN='edtBalance' then        begin vinttop:=-30;  vintLeft:= 24; end
  {Line 22}
  else If vstrN='edtPhysicianName' then  begin vinttop:=-58;  vintLeft:= 09; end
  else If vstrN='edtYes5' then           begin vinttop:=0;  vintLeft:=-20; end
  else If vstrN='edtNo5' then            begin vinttop:=0;  vintLeft:=-39; end
  {Line 23}
  else If vstrN='edtFedTax' then         begin vinttop:= 15;  vintLeft:=300; end
  {Line 24}
  else If vstrN='edtPatientAccount' then begin vinttop:= 70;  vintLeft:=-203;end
  {Line 25}
  {If the field was not listed above, make it invisble for Blue Cross}
  else TqrLabel(frm1500QR.rpt1500.Components[vintLoop]).Enabled := false;

  {Make the final displacements}
  TqrLabel(frm1500QR.rpt1500.Components[vintLoop]).top :=
                TqrLabel(frm1500QR.rpt1500.Components[vintLoop]).top
                + vintTop
                + vintTopDef;
  TqrLabel(frm1500QR.rpt1500.Components[vintLoop]).left :=
                TqrLabel(frm1500QR.rpt1500.Components[vintLoop]).left
                + vintLeft
                + vintLeftDef;
  end;
end;

{Blue Cross has less required fields, so it will re-format to match the B/C form
Extra fields are flagged invisible.}
Procedure Tfrm1500.AdjustPrePrintedMedicare;
  var vintLoop, vintTop, vintLeft, vintTopDef, vintLeftDef: integer;
      vstrN: string;
begin
vintTopDef:= strtoint(FillDefault('MediC_top'));
vintLeftDef:= strtoint(FillDefault('MediC_left'));

for vintLoop:= 0 to frm1500QR.rpt1500.ComponentCount-1 do
 with frm1500QR.rpt1500.Components[vintLoop] do
  begin
  vintTop:= 0;
  vintLeft:= 0;
  vstrN:= frm1500QR.rpt1500.Components[vintLoop].name;
  {Fields checked by name from left to right, top to bottom on this form}
  {Header}
  If vstrN= 'memCarrierAddress' then     begin vintTop:=-05;  vintLeft:= 00; end
  else If vstrN='chkMedicare' then       begin vinttop:= 07;  vintLeft:= 00; end
  else If vstrN='chkMedicaid' then       begin vinttop:= 07;  vintLeft:=-02; end
  else If vstrN='chkSSN' then            begin vinttop:= 07;  vintLeft:=-04; end
  else If vstrN='chkVA' then             begin vinttop:= 07;  vintLeft:= 01; end
  else If vstrN='chkSSNID' then          begin vinttop:= 07;  vintLeft:= 04; end
  else If vstrN='chkFECA' then           begin vinttop:= 07;  vintLeft:=-03; end
  else If vstrN='chkID' then             begin vinttop:= 07;  vintLeft:=-04; end
  else If vstrN='edtID' then             begin vinttop:= 06;  vintLeft:= 00; end
  {Line 1}
  else If vstrN='edtPatientName' then    begin vinttop:= 02;  vintLeft:= 00; end
  else If vstrN='edtPatientBirth' then   begin vinttop:= 06;  vintLeft:= 05; end
  else If vstrN='chkMale1' then          begin vinttop:= 06;  vintLeft:=-03; end
  else If vstrN='chkFemale1' then        begin vinttop:= 06;  vintLeft:= 07; end
  else If vstrN='edtInsuredName' then    begin vinttop:= 03;  vintLeft:= 00; end
  {Line 2}
  else If vstrN='edtPatientAddress' then begin vinttop:= 02;  vintLeft:= 00; end
  else If vstrN='chkSelf' then           begin vinttop:= 04;  vintLeft:= 17; end
  else If vstrN='chkSpouse' then         begin vinttop:= 04;  vintLeft:= 28; end
  else If vstrN='chkChild' then          begin vinttop:= 04;  vintLeft:= 12; end
  else If vstrN='chkOther' then          begin vinttop:= 04;  vintLeft:= 18; end
  else If vstrN='edtInsuredAddress' then begin vinttop:= 02;  vintLeft:= 00; end
  {Line 3}
  else If vstrN='edtPatientCity' then    begin vinttop:= 00;  vintLeft:= 00; end
  else If vstrN='edtPatientState' then   begin vinttop:= 00;  vintLeft:= 05; end
  else If vstrN='chkSingle' then         begin vinttop:= 05;  vintLeft:= 37; end
  else If vstrN='chkMarried' then        begin vinttop:= 05;  vintLeft:= 35; end
  else If vstrN='chkOther2' then         begin vinttop:= 05;  vintLeft:= 35; end
  else If vstrN='edtInsuredCity' then    begin vinttop:= 01;  vintLeft:= 00; end
  else If vstrN='edtInsuredState' then   begin vinttop:= 01;  vintLeft:= 00; end
  {Line 4}
  else If vstrN='edtPatientZIP' then     begin vinttop:= 01;  vintLeft:= 00; end
  else If vstrN='edtPatientTelephone' then
                                         begin vinttop:= 01;  vintLeft:= 50; end
  else If vstrN='chkEmployed' then       begin vinttop:= 17;  vintLeft:= 38; end
  else If vstrN='chkFullTime' then       begin vinttop:= 16;  vintLeft:= 35; end
  else If vstrN='chkPartTime' then       begin vinttop:= 17;  vintLeft:= 35; end
  else If vstrN='edtInsuredZIP' then     begin vinttop:= 01;  vintLeft:= 00; end
  else If vstrN='edtInsuredTelephone' then
                                         begin vinttop:= 01;  vintLeft:= 60; end
  {Line 5}
  else If vstrN='edtOtherName' then      begin vinttop:= 01;  vintLeft:= 00; end
  else If vstrN='edtInsuredGroup' then   begin vinttop:= 01;  vintLeft:= 00; end
  {Line 6}
  else If vstrN='edtOtherPolicy' then    begin vinttop:=-02;  vintLeft:= 00; end
  else If vstrN='chkYes' then            begin vinttop:= 01;  vintLeft:= 06; end
  else If vstrN='chkNo' then             begin vinttop:= 01;  vintLeft:= 03; end
  else If vstrN='edtInsuredBirth' then   begin vinttop:= 02;  vintLeft:= 40; end
  else If vstrN='chkMale2' then          begin vinttop:= 00;  vintLeft:=-17; end
  else If vstrN='chkFemale2' then        begin vinttop:= 00;  vintLeft:= 05; end
  {Line 7}
  else If vstrN='edtOtherBirth' then     begin vinttop:= 03;  vintLeft:= 10; end
  else If vstrN='chkMale3' then          begin vinttop:= 01;  vintLeft:=-28; end
  else If vstrN='chkFemale3' then        begin vinttop:= 01;  vintLeft:=-16; end
  else If vstrN='chkYes2' then           begin vinttop:= 00;  vintLeft:= 06; end
  else If vstrN='chkNo2' then            begin vinttop:= 00;  vintLeft:= 02; end
  else If vstrN='edtAccState' then       begin vinttop:= 00;  vintLeft:= 00; end
  else If vstrN='edtInsuredEmployer' then
                                         begin vinttop:= 00;  vintLeft:= 00; end
  {Line 8}
  else If vstrN='edtOtherEmployer' then  begin vinttop:= 00;  vintLeft:= 00; end
  else If vstrN='chkYes3' then           begin vinttop:=-02;  vintLeft:= 07; end
  else If vstrN='chkNo3' then            begin vinttop:=-02;  vintLeft:= 02; end
  else If vstrN='edtInsuredPlan' then    begin vinttop:= 00;  vintLeft:= 00; end
  {Line 9}
  else If vstrN='edtOtherInsurance' then begin vinttop:= 00;  vintLeft:= 00; end
  else If vstrN='chkYes1' then           begin vinttop:=-01;  vintLeft:= 10; end
  else If vstrN='chkNo1' then            begin vinttop:=-01;  vintLeft:= 05; end
  {Line 10}
  else If vstrN='lbl151' then            begin vinttop:=-06;  vintLeft:= 00; end
  else If vstrN='edtSignatureDate' then  begin vinttop:=-06;  vintLeft:= 00; end
  else If vstrN='lbl152' then            begin vinttop:=-06;  vintLeft:= 00; end
  {Line 11}
  else If vstrN='edtCurrentDate' then    begin vinttop:=-03;  vintLeft:= 10; end
  else If vstrN='edtSimilarDate' then    begin vinttop:=-03;  vintLeft:=-20; end
  else If vstrN='edtWorkDateFrom' then   begin vinttop:=-03;  vintLeft:= 10; end
  else If vstrN='edtWorkDateTo' then     begin vinttop:=-03;  vintLeft:=-20; end
  {Line 12}
  else If vstrN='edtReferralPhysician' then
                                         begin vinttop:=-08;  vintLeft:= 00; end
  else If vstrN='edtReferralID' then
       begin
       If chk1500_0805.checked then
          vintLeft := 35
       else
         vintLeft:= 00;
       vinttop:=-08;
       end
  else If vstrN='edtHospFrom' then       begin vinttop:=-05;  vintLeft:= 10; end
  else If vstrN='edtHospTo' then         begin vinttop:=-05;  vintLeft:=-20; end
  {Line 13}
  else If vstrN='chkYes4' then           begin vinttop:=-08;  vintLeft:= 10; end
  else If vstrN='chkNo4' then            begin vinttop:=-08;  vintLeft:= 05; end
  else If vstrN='edtCharges' then        begin vinttop:=-07;  vintLeft:= 00; end
  {Line 14}
  else If vstrN='edtDiagnose1' then      begin vinttop:=-08;  vintLeft:= 00; end
  else If vstrN='edtDiagnose3' then      begin vinttop:=-08;  vintLeft:= 20; end
  else If vstrN='edtMedicaidCode' then   begin vinttop:=-08;  vintLeft:=-30; end
  else If vstrN='edtMedicaidOriginal' then
                                         begin vinttop:=-08;  vintLeft:=-40; end
  {Line 15}
  else If vstrN='edtDiagnose2' then      begin vinttop:=-08;  vintLeft:= 00; end
  else If vstrN='edtDiagnose4' then      begin vinttop:=-08;  vintLeft:= 20; end
  else If vstrN='edtPriorAuthor' then    begin vinttop:=-08;  vintLeft:=-10; end
  {Line 16}
  else If vstrN='edtServiceFrom1' then   begin vinttop:=-24;  vintLeft:= 03; end
  else If vstrN='edtServiceTo1' then     begin vinttop:=-24;  vintLeft:= 03; end
  else If vstrN='edtServicePlace1' then  begin vinttop:=-24;  vintLeft:= 00; end
  else If vstrN='edtServiceType1' then   begin vinttop:=-24;  vintLeft:= 00; end
  else If vstrN='edtCode1' then          begin vinttop:=-24;  vintLeft:= 13; end
  else If vstrN='edtModifier1' then      begin vinttop:=-24;  vintLeft:= 11; end
  else If vstrN='edtDiagnosis1' then     begin vinttop:=-24;  vintLeft:= 00; end
  else If vstrN='edtServCharges1' then   begin vinttop:=-24;  vintLeft:= 11; end
  else If vstrN='edtDays1' then          begin vinttop:=-24;  vintLeft:= 00; end
  else If vstrN='edtFamily1' then        begin vinttop:=-24;  vintLeft:=-04; end
  else If vstrN='edtEMG1' then           begin vinttop:=-24;  vintLeft:=-10; end
  else If vstrN='edtCOB1' then           begin vinttop:=-24;  vintLeft:=-12; end
  else If vstrN='edtREV1' then           begin vinttop:=-24;  vintLeft:= 00; end
  {Line 17}
  else If vstrN='edtServiceFrom2' then   begin vinttop:=-25;  vintLeft:= 03; end
  else If vstrN='edtServiceTo2' then     begin vinttop:=-25;  vintLeft:= 03; end
  else If vstrN='edtServicePlace2' then  begin vinttop:=-25;  vintLeft:= 00; end
  else If vstrN='edtServiceType2' then   begin vinttop:=-25;  vintLeft:= 00; end
  else If vstrN='edtCode2' then          begin vinttop:=-25;  vintLeft:= 13; end
  else If vstrN='edtModifier2' then      begin vinttop:=-25;  vintLeft:= 11; end
  else If vstrN='edtDiagnosis2' then     begin vinttop:=-25;  vintLeft:= 00; end
  else If vstrN='edtServCharges2' then   begin vinttop:=-25;  vintLeft:= 11; end
  else If vstrN='edtDays2' then          begin vinttop:=-25;  vintLeft:= 00; end
  else If vstrN='edtFamily2' then        begin vinttop:=-25;  vintLeft:=-04; end
  else If vstrN='edtEMG2' then           begin vinttop:=-25;  vintLeft:=-10; end
  else If vstrN='edtCOB2' then           begin vinttop:=-25;  vintLeft:=-12; end
  else If vstrN='edtREV2' then           begin vinttop:=-25;  vintLeft:= 00; end
  {Line 18}
  else If vstrN='edtServiceFrom3' then   begin vinttop:=-26;  vintLeft:= 03; end
  else If vstrN='edtServiceTo3' then     begin vinttop:=-26;  vintLeft:= 03; end
  else If vstrN='edtServicePlace3' then  begin vinttop:=-26;  vintLeft:= 00; end
  else If vstrN='edtServiceType3' then   begin vinttop:=-26;  vintLeft:= 00; end
  else If vstrN='edtCode3' then          begin vinttop:=-26;  vintLeft:= 13; end
  else If vstrN='edtModifier3' then      begin vinttop:=-26;  vintLeft:= 11; end
  else If vstrN='edtDiagnosis3' then     begin vinttop:=-26;  vintLeft:= 00; end
  else If vstrN='edtServCharges3' then   begin vinttop:=-26;  vintLeft:= 11; end
  else If vstrN='edtDays3' then          begin vinttop:=-26;  vintLeft:= 00; end
  else If vstrN='edtFamily3' then        begin vinttop:=-26;  vintLeft:=-04; end
  else If vstrN='edtEMG3' then           begin vinttop:=-26;  vintLeft:=-10; end
  else If vstrN='edtCOB3' then           begin vinttop:=-26;  vintLeft:=-12; end
  else If vstrN='edtREV3' then           begin vinttop:=-26;  vintLeft:= 00; end
  {Line 19}
  else If vstrN='edtServiceFrom4' then   begin vinttop:=-27;  vintLeft:= 03; end
  else If vstrN='edtServiceTo4' then     begin vinttop:=-27;  vintLeft:= 03; end
  else If vstrN='edtServicePlace4' then  begin vinttop:=-27;  vintLeft:= 00; end
  else If vstrN='edtServiceType4' then   begin vinttop:=-27;  vintLeft:= 00; end
  else If vstrN='edtCode4' then          begin vinttop:=-27;  vintLeft:= 13; end
  else If vstrN='edtModifier4' then      begin vinttop:=-27;  vintLeft:= 11; end
  else If vstrN='edtDiagnosis4' then     begin vinttop:=-27;  vintLeft:= 00; end
  else If vstrN='edtServCharges4' then   begin vinttop:=-27;  vintLeft:= 11; end
  else If vstrN='edtDays4' then          begin vinttop:=-27;  vintLeft:= 00; end
  else If vstrN='edtFamily4' then        begin vinttop:=-27;  vintLeft:=-04; end
  else If vstrN='edtEMG4' then           begin vinttop:=-27;  vintLeft:=-10; end
  else If vstrN='edtCOB4' then           begin vinttop:=-27;  vintLeft:=-12; end
  else If vstrN='edtREV4' then           begin vinttop:=-27;  vintLeft:= 00; end
  {Line 20}
  else If vstrN='edtServiceFrom5' then   begin vinttop:=-28;  vintLeft:= 03; end
  else If vstrN='edtServiceTo5' then     begin vinttop:=-28;  vintLeft:= 03; end
  else If vstrN='edtServicePlace5' then  begin vinttop:=-28;  vintLeft:= 00; end
  else If vstrN='edtServiceType5' then   begin vinttop:=-28;  vintLeft:= 00; end
  else If vstrN='edtCode5' then          begin vinttop:=-28;  vintLeft:= 13; end
  else If vstrN='edtModifier5' then      begin vinttop:=-28;  vintLeft:= 11; end
  else If vstrN='edtDiagnosis5' then     begin vinttop:=-28;  vintLeft:= 00; end
  else If vstrN='edtServCharges5' then   begin vinttop:=-28;  vintLeft:= 11; end
  else If vstrN='edtDays5' then          begin vinttop:=-28;  vintLeft:= 00; end
  else If vstrN='edtFamily5' then        begin vinttop:=-28;  vintLeft:=-04; end
  else If vstrN='edtEMG5' then           begin vinttop:=-28;  vintLeft:=-10; end
  else If vstrN='edtCOB5' then           begin vinttop:=-28;  vintLeft:=-12; end
  else If vstrN='edtREV5' then           begin vinttop:=-28;  vintLeft:= 00; end
  {Line 21}
  else If vstrN='edtServiceFrom6' then   begin vinttop:=-29;  vintLeft:= 03; end
  else If vstrN='edtServiceTo6' then     begin vinttop:=-29;  vintLeft:= 03; end
  else If vstrN='edtServicePlace6' then  begin vinttop:=-29;  vintLeft:= 00; end
  else If vstrN='edtServiceType6' then   begin vinttop:=-29;  vintLeft:= 00; end
  else If vstrN='edtCode6' then          begin vinttop:=-29;  vintLeft:= 13; end
  else If vstrN='edtModifier6' then      begin vinttop:=-29;  vintLeft:= 11; end
  else If vstrN='edtDiagnosis6' then     begin vinttop:=-29;  vintLeft:= 00; end
  else If vstrN='edtServCharges6' then   begin vinttop:=-29;  vintLeft:= 11; end
  else If vstrN='edtDays6' then          begin vinttop:=-29;  vintLeft:= 00; end
  else If vstrN='edtFamily6' then        begin vinttop:=-29;  vintLeft:=-04; end
  else If vstrN='edtEMG6' then           begin vinttop:=-29;  vintLeft:=-10; end
  else If vstrN='edtCOB6' then           begin vinttop:=-29;  vintLeft:=-12; end
  else If vstrN='edtREV6' then           begin vinttop:=-29;  vintLeft:= 00; end
  {Line 22}
  else If vstrN='edtFedTax' then         begin vinttop:=-29;  vintLeft:= 00; end
  else If vstrN='chkSSNyes' then         begin vinttop:=-29;  vintLeft:=-15; end
  else If vstrN='chkEINyes' then         begin vinttop:=-29;  vintLeft:=-17; end
  else If vstrN='edtPatientAccount' then begin vinttop:=-29;  vintLeft:= 00; end
  else If vstrN='edtYes5' then           begin vinttop:=-29;  vintLeft:=-11; end
  else If vstrN='edtNo5' then            begin vinttop:=-29;  vintLeft:=-17; end
  else If vstrN='edtTotalCharge' then    begin vinttop:=-29;  vintLeft:= 12; end
  else If vstrN='edtAmountPaid' then     begin vinttop:=-29;  vintLeft:= 00; end
  else If vstrN='edtBalance' then        begin vinttop:=-29;  vintLeft:=-03; end
  {Line 23}
  else If vstrN='edtPhysicianName' then  begin vinttop:=-29;  vintLeft:= 00; end
  else If vstrN='memAddressService' then begin vinttop:=-29;  vintLeft:= 00; end
  else If vstrN='memPhysicianInfo' then  begin vinttop:=-28;  vintLeft:= 00; end
  {Line 24}
  else If vstrN='edtPIN' then            begin vinttop:=-23;  vintLeft:=-05; end
  else If vstrN='edtPIN2' then           begin vinttop:=-23;  vintLeft:= 00; end
  else If vstrN='edtGroup' then          begin vinttop:=-23;  vintLeft:=-20; end
  {If the field was not listed above, make it invisble for Medicare (labels and
  graphics included}
  else TqrLabel(frm1500QR.rpt1500.Components[vintLoop]).Enabled := false;

  {Make the final displacements}
  TqrLabel(frm1500QR.rpt1500.Components[vintLoop]).top :=
                TqrLabel(frm1500QR.rpt1500.Components[vintLoop]).top
                + vintTop
                + vintTopDef;
  TqrLabel(frm1500QR.rpt1500.Components[vintLoop]).left :=
                TqrLabel(frm1500QR.rpt1500.Components[vintLoop]).left
                + vintLeft
                + vintLeftDef;
  end;
end;



procedure Tfrm1500.chkShiftClick(Sender: TObject);
begin
If not chkShift.checked then
    memCarrierAddress.left:= 76
else
    memCarrierAddress.left:= 360;
end;

procedure Tfrm1500.edtREV1DblClick(Sender: TObject);
begin
If (tedit(sender).text < ' A') or (tedit(sender).text = '1730227307') then
   tedit(sender).text := '1568429280'
else
   tedit(sender).text := '1730227307';
end;

procedure Tfrm1500.chk1500_0805Click(Sender: TObject);
begin
If chk1500_0805.Checked then
   begin
   chkFormType.Checked:= false;
   chkBlueCross.Checked:= false;
   chkMedicarePrint.checked:= false;
   end;
end;

end.
