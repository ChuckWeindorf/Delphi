unit formClinicReports;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, ExtCtrls, Buttons, ToolWin, ComCtrls, StdCtrls, Mask,
  DBCtrls, Db, DBTables, QRCtrls;

type
  TfrmClinicReports = class(TForm)
    qryProblems: TQuery;
    dtsProblems: TDataSource;
    dtsProgramStats: TDataSource;
    tblProgramStats: TTable;
    tblProgramStatsProgramTicket: TIntegerField;
    tblProgramStatsProgramName: TStringField;
    tblProgramStatsProgramDate: TDateField;
    tblProgramStatsProgramBirthday: TDateField;
    tblProgramStatsProgramAge: TIntegerField;
    tblProgramStatsProgramNationality: TStringField;
    tblProgramStatsProgramGender: TStringField;
    pagReports: TPageControl;
    tabMissing: TTabSheet;
    Panel1: TPanel;
    cmdSearch: TSpeedButton;
    lblYear: TLabel;
    edtYear: TEdit;
    grdProblems: TDBGrid;
    TabSheet1: TTabSheet;
    pnlEntry: TPanel;
    lbl_10006: TLabel;
    lbl_10004: TLabel;
    lbl_10011: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    cmdDelete: TSpeedButton;
    cboProgram: TComboBox;
    mskService: TMaskEdit;
    cboGender: TComboBox;
    cboNationality: TComboBox;
    Button1: TButton;
    grdProgramDetails: TDBGrid;
    tabOnlRept: TTabSheet;
    scrRpt: TScrollBar;
    pnlScroll: TPanel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    edtRptYear: TEdit;
    edtRptMonth: TEdit;
    edtMale: TEdit;
    edtFemale: TEdit;
    edtMaleY: TEdit;
    edtFemaleY: TEdit;
    edtMale14: TEdit;
    edtMale1419: TEdit;
    edtMale14Y: TEdit;
    edtMale1419Y: TEdit;
    edtMale2029: TEdit;
    edtMale3039: TEdit;
    edtMale2029Y: TEdit;
    edtMale3039Y: TEdit;
    edtMale4049: TEdit;
    edtMale50: TEdit;
    edtMale4049Y: TEdit;
    edtMale50Y: TEdit;
    edtMaleOther: TEdit;
    edtMaleOtherY: TEdit;
    edtFemale14: TEdit;
    edtFemale1419: TEdit;
    edtFemale14Y: TEdit;
    edtFemale1419Y: TEdit;
    edtFemale2029: TEdit;
    edtFemale3039: TEdit;
    edtFemale2029Y: TEdit;
    edtFemale3039Y: TEdit;
    edtFemale4049: TEdit;
    edtFemale50: TEdit;
    edtFemale4049Y: TEdit;
    edtFemale50Y: TEdit;
    edtFemaleOther: TEdit;
    edtFemaleOtherY: TEdit;
    edtEuro: TEdit;
    edtAfrican: TEdit;
    edtEuroT: TEdit;
    edtAfricanT: TEdit;
    edtPuertoRican: TEdit;
    edtMexican: TEdit;
    edtPuertoRicanT: TEdit;
    edtMexicanT: TEdit;
    edtColumbian: TEdit;
    edtSalvadoran: TEdit;
    edtDominican: TEdit;
    edtHonduran: TEdit;
    edtHonduranT: TEdit;
    edtDominicanT: TEdit;
    edtSalvadoranT: TEdit;
    edtColumbianT: TEdit;
    edtGuatemalan: TEdit;
    edtCuban: TEdit;
    edtGuatemalanT: TEdit;
    edtCubanT: TEdit;
    edtRussian: TEdit;
    edtUkranian: TEdit;
    edtRussianT: TEdit;
    edtUkranianT: TEdit;
    edtIndia: TEdit;
    edtRomanian: TEdit;
    edtIraqi: TEdit;
    edtKurdish: TEdit;
    edtKurdishT: TEdit;
    edtIraqiT: TEdit;
    edtRomanianT: TEdit;
    edtIndiaT: TEdit;
    edtLebanese: TEdit;
    edtSomalian: TEdit;
    edtSomalianT: TEdit;
    edtLebaneseT: TEdit;
    edtSudanese: TEdit;
    edtBosnian: TEdit;
    edtSudaneseT: TEdit;
    edtBosnianT: TEdit;
    edtKosovo: TEdit;
    edtCroatian: TEdit;
    edtKosovoT: TEdit;
    edtCroatianT: TEdit;
    edtSerbian: TEdit;
    edtVietnamese: TEdit;
    edtSaudi: TEdit;
    edtOther: TEdit;
    edtOtherT: TEdit;
    edtSaudiT: TEdit;
    edtVietnameseT: TEdit;
    edtSerbianT: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtWICNMT: TEdit;
    edtWICNM: TEdit;
    Label8: TLabel;
    edtWICM: TEdit;
    edtWICMT: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edtTranDis: TEdit;
    edtTranCourt: TEdit;
    edtTranDisT: TEdit;
    edtTranCourtT: TEdit;
    Label12: TLabel;
    Label13: TLabel;
    edtTranPolice: TEdit;
    edtTranLegal: TEdit;
    edtTranPoliceT: TEdit;
    edtTranLegalT: TEdit;
    Label14: TLabel;
    Label15: TLabel;
    edtTranHousing: TEdit;
    edtTranMental: TEdit;
    edtTranHousingT: TEdit;
    edtTranMentalT: TEdit;
    Label16: TLabel;
    Label17: TLabel;
    edtTranSchool: TEdit;
    edtTranSocial: TEdit;
    edtTranSchoolT: TEdit;
    edtTranSocialT: TEdit;
    Label18: TLabel;
    edtTranAppeal: TEdit;
    edtTranAppealT: TEdit;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    edtFoodInd: TEdit;
    edtFoodFam: TEdit;
    edtFoodIndT: TEdit;
    edtFoodFamT: TEdit;
    Label22: TLabel;
    Label23: TLabel;
    edtAchievement: TEdit;
    edtACL: TEdit;
    edtAchievementT: TEdit;
    edtACLT: TEdit;
    Label24: TLabel;
    Label25: TLabel;
    edtBarber: TEdit;
    edtChildren: TEdit;
    edtBarberT: TEdit;
    edtChildrenT: TEdit;
    Label26: TLabel;
    Label27: TLabel;
    edtCommunity: TEdit;
    edtHealth: TEdit;
    edtCommunityT: TEdit;
    edtHealthT: TEdit;
    Label28: TLabel;
    Label29: TLabel;
    edtCancer: TEdit;
    edtSarah: TEdit;
    edtCancerT: TEdit;
    edtSarahT: TEdit;
    Label30: TLabel;
    edtShriners: TEdit;
    edtShrinersT: TEdit;
    Label31: TLabel;
    edtStairways: TEdit;
    edtStairwaysT: TEdit;
    Label80: TLabel;
    Label81: TLabel;
    Label82: TLabel;
    edtAbstainence: TEdit;
    edtECHD: TEdit;
    edtAbstainenceT: TEdit;
    edtECHDT: TEdit;
    Label83: TLabel;
    Label84: TLabel;
    edtHIV: TEdit;
    edtSafenet: TEdit;
    edtHIVT: TEdit;
    edtSafenetT: TEdit;
    Label85: TLabel;
    Label86: TLabel;
    edtTobacco: TEdit;
    edtFolic: TEdit;
    edtTobaccoT: TEdit;
    edtFolicT: TEdit;
    Label87: TLabel;
    Label88: TLabel;
    Label89: TLabel;
    edtAfterInd: TEdit;
    edtAfterFam: TEdit;
    edtAfterIndT: TEdit;
    edtAfterFamT: TEdit;
    Label91: TLabel;
    Label92: TLabel;
    edtZIPCounty: TEdit;
    edtZIPErie: TEdit;
    edtZIPCountyT: TEdit;
    edtZIPErieT: TEdit;
    Label93: TLabel;
    edtZIPOther: TEdit;
    edtZIPOtherT: TEdit;
    Label90: TLabel;
    Label94: TLabel;
    Label95: TLabel;
    edtClinAIDS: TEdit;
    edtClinAIDSY: TEdit;
    Label96: TLabel;
    Label97: TLabel;
    Label98: TLabel;
    edtClinBeha: TEdit;
    edtClinBehaY: TEdit;
    Label99: TLabel;
    edtClinLead: TEdit;
    edtClinLeadY: TEdit;
    Label100: TLabel;
    edtClinPres: TEdit;
    edtClinPresY: TEdit;
    Label101: TLabel;
    edtClinSuga: TEdit;
    edtClinSugaY: TEdit;
    Label102: TLabel;
    edtClinBrea: TEdit;
    edtClinBreaY: TEdit;
    Label103: TLabel;
    edtClinClin: TEdit;
    edtClinClinY: TEdit;
    Label104: TLabel;
    Label105: TLabel;
    Label106: TLabel;
    edtClinMass: TEdit;
    edtClinMassY: TEdit;
    Label107: TLabel;
    edtClinDA: TEdit;
    edtClinDAY: TEdit;
    Label108: TLabel;
    edtClinDena: TEdit;
    edtClinDenaY: TEdit;
    Label109: TLabel;
    edtClinDtra: TEdit;
    edtClinDtraY: TEdit;
    Label110: TLabel;
    edtClinEPSD: TEdit;
    edtClinEPSDY: TEdit;
    Label111: TLabel;
    edtClinHear: TEdit;
    edtClinHearY: TEdit;
    Label112: TLabel;
    edtClinHema: TEdit;
    edtClinHemaY: TEdit;
    Label113: TLabel;
    edtClinHome: TEdit;
    edtClinHomeY: TEdit;
    Label114: TLabel;
    edtClinHosp: TEdit;
    edtClinHospY: TEdit;
    Label115: TLabel;
    Label116: TLabel;
    edtClinChrrY: TEdit;
    edtClinChrr: TEdit;
    Label117: TLabel;
    Label118: TLabel;
    edtClinImmu: TEdit;
    edtClinImmuY: TEdit;
    Label119: TLabel;
    edtClinPap: TEdit;
    edtClinPapY: TEdit;
    Label120: TLabel;
    edtClinNata: TEdit;
    edtClinNataY: TEdit;
    Label121: TLabel;
    edtClinSpec: TEdit;
    edtClinSpecY: TEdit;
    Label122: TLabel;
    edtClinTB: TEdit;
    edtClinTBY: TEdit;
    Label123: TLabel;
    edtClinUrin: TEdit;
    edtClinUrinY: TEdit;
    Label124: TLabel;
    edtClinVisi: TEdit;
    edtClinVisiY: TEdit;
    Label125: TLabel;
    edtClinWIC: TEdit;
    edtClinWICY: TEdit;
    edtClinImmiY: TEdit;
    edtClinImmi: TEdit;
    Label126: TLabel;
    edtClinPhon: TEdit;
    edtClinPhonY: TEdit;
    Label7: TLabel;
    edtMale14A: TEdit;
    edtMale1419A: TEdit;
    edtMale2029A: TEdit;
    edtMale3039A: TEdit;
    edtMale4049A: TEdit;
    edtMale50A: TEdit;
    edtMaleOtherA: TEdit;
    Label128: TLabel;
    edtFemale14A: TEdit;
    edtFemale1419A: TEdit;
    edtFemale2029A: TEdit;
    edtFemale3039A: TEdit;
    edtFemale4049A: TEdit;
    edtFemale50A: TEdit;
    edtFemaleOtherA: TEdit;
    Label127: TLabel;
    edtMaleA: TEdit;
    edtFemaleA: TEdit;
    Label129: TLabel;
    edtEuroA: TEdit;
    edtAfricanA: TEdit;
    edtPuertoRicanA: TEdit;
    edtMexicanA: TEdit;
    edtColumbianA: TEdit;
    edtSalvadoranA: TEdit;
    edtDominicanA: TEdit;
    edtHonduranA: TEdit;
    edtGuatemalanA: TEdit;
    edtCubanA: TEdit;
    edtRussianA: TEdit;
    edtUkranianA: TEdit;
    edtIndiaA: TEdit;
    edtRomanianA: TEdit;
    edtIraqiA: TEdit;
    edtKurdishA: TEdit;
    edtLebaneseA: TEdit;
    edtSomalianA: TEdit;
    edtSudaneseA: TEdit;
    edtBosnianA: TEdit;
    edtKosovoA: TEdit;
    edtCroatianA: TEdit;
    edtSerbianA: TEdit;
    edtVietnameseA: TEdit;
    edtSaudiA: TEdit;
    edtOtherA: TEdit;
    tblUnitedWay: TTable;
    cmdSave: TSpeedButton;
    cmdLoad: TSpeedButton;
    edtAge: TEdit;
    cmdCalculate: TSpeedButton;
    qryReptProgram: TQuery;
    qryReptClinic: TQuery;
    cmdPrintAppt: TSpeedButton;
    edtAbstainenceA: TEdit;
    edtECHDA: TEdit;
    edtHIVA: TEdit;
    edtSafenetA: TEdit;
    edtTobaccoA: TEdit;
    edtFolicA: TEdit;
    edtAfterIndA: TEdit;
    edtAfterFamA: TEdit;
    edtClinAIDSA: TEdit;
    edtClinBehaA: TEdit;
    edtClinLeadA: TEdit;
    edtClinPresA: TEdit;
    edtClinSugaA: TEdit;
    edtClinBreaA: TEdit;
    edtClinClinA: TEdit;
    edtClinChrrA: TEdit;
    edtClinMassA: TEdit;
    edtClinDAA: TEdit;
    edtClinDenaA: TEdit;
    edtClinDtraA: TEdit;
    edtClinEPSDA: TEdit;
    edtClinHearA: TEdit;
    edtClinHemaA: TEdit;
    edtClinHomeA: TEdit;
    edtClinHospA: TEdit;
    edtClinImmiA: TEdit;
    edtClinImmuA: TEdit;
    edtClinPapA: TEdit;
    edtClinNataA: TEdit;
    edtClinSpecA: TEdit;
    edtClinTBA: TEdit;
    edtClinUrinA: TEdit;
    edtClinVisiA: TEdit;
    edtClinWICA: TEdit;
    edtClinPhonA: TEdit;
    grdInterpret: TStringGrid;
    qryReptInterpret: TQuery;
    Label130: TLabel;
    edtAmerInd: TEdit;
    edtAmerIndT: TEdit;
    edtAmerIndA: TEdit;
    Label131: TLabel;
    edtBhutan: TEdit;
    edtBhutanT: TEdit;
    edtBhutanA: TEdit;
    lblBurmese: TLabel;
    edtBurmese: TEdit;
    edtBurmeseT: TEdit;
    edtBurmeseA: TEdit;
    Label132: TLabel;
    edtBurundi: TEdit;
    edtBurundiT: TEdit;
    edtBurundiA: TEdit;
    Label133: TLabel;
    edtCongo: TEdit;
    edtCongoA: TEdit;
    edtCongoT: TEdit;
    Label134: TLabel;
    edtEritrean: TEdit;
    edtEritreanA: TEdit;
    edtEritreanT: TEdit;
    Label135: TLabel;
    edtIsreal: TEdit;
    edtIsrealT: TEdit;
    edtIsrealA: TEdit;
    Label136: TLabel;
    edtItalian: TEdit;
    edtItalianA: TEdit;
    edtItalianT: TEdit;
    Label137: TLabel;
    edtKoren: TEdit;
    edtKorenA: TEdit;
    edtKorenT: TEdit;
    Label138: TLabel;
    edtLiberian: TEdit;
    edtLiberianA: TEdit;
    edtLiberianT: TEdit;
    Label139: TLabel;
    edtNepal: TEdit;
    edtNepalA: TEdit;
    edtNepalT: TEdit;
    Label140: TLabel;
    edtPersian: TEdit;
    edtPersianA: TEdit;
    edtPersianT: TEdit;
    Label141: TLabel;
    edtSwahili: TEdit;
    edtSwahiliT: TEdit;
    edtSwahiliA: TEdit;
    Label142: TLabel;
    edtTanzanian: TEdit;
    edtTanzanianT: TEdit;
    edtTanzanianA: TEdit;
    Label143: TLabel;
    edtThai: TEdit;
    edtThaiT: TEdit;
    edtThaiA: TEdit;
    Label144: TLabel;
    edtTogo: TEdit;
    edtTogoT: TEdit;
    edtTogoA: TEdit;
    Label145: TLabel;
    edtTurkish: TEdit;
    edtTurkishT: TEdit;
    edtTurkishA: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdexitClick(Sender: TObject);
    procedure mnuExitClick(Sender: TObject);
    procedure cmdSearchClick(Sender: TObject);
    procedure grdProblemsDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cmdDeleteClick(Sender: TObject);
    procedure scrRptChange(Sender: TObject);
    procedure cmdCalculateClick(Sender: TObject);
    procedure cmdLoadClick(Sender: TObject);
    procedure cmdPrintApptClick(Sender: TObject);
  private
    { Private declarations }
    varrNames: array [1..300] of string;
    varrCounts: array [1..12, 1..300] of integer;
    procedure LoadReport;
    procedure SaveReport;
    procedure CalcMaleFemale;
    procedure CalcAge;
    procedure CalcNationality;
    procedure CalcClinic;
    procedure CalcPrograms;
    procedure CalcTotal;
    procedure LoadStatArray;
  public
    { Public declarations }
    constructor Create(AOwner :TComponent); override;
  end;

var
  frmClinicReports: TfrmClinicReports;

implementation

{$R *.DFM}

uses procSharedDatamoduleCalls, formUnitedWayQR, formUnitedWayQR1a,
     formUnitedWayQR2, formUnitedWayQR3, formUnitedWayQR2b;

constructor TfrmClinicReports.Create(AOwner :TComponent);
begin
  {Create all form components and other start-up activities}
  Inherited create(AOwner);

  FillPickList('PatientGender',cboGender.Items);
  FillPickList('Nationality',cboNationality.Items);
  FillPickList('Programs',cboProgram.Items);
  tblProgramStats.open;
  tblUnitedWay.open;

  {Set all datasources}
  //set the forms caption
end;

procedure TfrmClinicReports.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  tblProgramStats.close;
  tblUnitedWay.close;
  CloseThisEntity(cintClinicReports);
  Action := caFree;
end;

procedure TfrmClinicReports.cmdSaveClick(Sender: TObject);
var vintYear, vintMonth: integer;
begin
try
vintYear:= strtoint(edtRptYear.text);
vintMonth:= strtoint(edtRptMonth.text);
If (vintYear < 2002) or (vintYear > 2014) or (vintMonth < 1) or (vintMonth > 12) then
   begin
   ShowMessage('Year or Month is not valid.  Please check and try again');
   exit;
   end;
except
   ShowMessage('Year or Month is not valid.  Please check and try again');
   exit;
   end;
  SaveReport;
end;

procedure TfrmClinicReports.cmdLoadClick(Sender: TObject);
var vintYear, vintMonth, vintLoop, vintMonthc, vintYearc: integer;
begin
try
vintYear:= strtoint(edtRptYear.text);
vintMonth:= strtoint(edtRptMonth.text);

if vintYear < 2005 then
   grdInterpret.visible:= false
else
   begin
   grdInterpret.visible:= true;
   grdInterpret.ColWidths[0]:= 380;
   grdInterpret.ColWidths[1]:= 60;
   grdInterpret.ColWidths[2]:= 60;
   qryReptInterpret.sql[5] :=
                            'and (CompanyBillDetail.BillApptDate <= "12/31/' +
                             edtRptYear.text + '")';
   qryReptInterpret.sql[6] :=
                            'and (CompanyBillDetail.BillApptDate >= "1/1/' +
                             edtRptYear.text + '")';
   qryReptInterpret.active:= true;
   grdInterpret.RowCount:= qryReptInterpret.RecordCount;
   for vintLoop:= 0 to qryReptInterpret.recordcount - 1 do
       begin
       grdInterpret.Cells[0, vintLoop]:= qryReptInterpret.fields[0].asstring
                                   + '-' + qryReptInterpret.fields[1].asstring;
       grdInterpret.Cells[2, vintLoop]:= qryReptInterpret.fields[2].asstring;
       qryReptInterpret.Next;
       end;
   qryReptInterpret.active:= false;
   If vintMonth = 12 then
     qryReptInterpret.sql[5] :=
                           'and (CompanyBillDetail.BillApptDate < ' +
                           '"1/1/' +
                           inttostr(vintYear + 1) + '")'
     else
     qryReptInterpret.sql[5] :=
                           'and (CompanyBillDetail.BillApptDate < "' +
                           inttostr(vintMonth + 1) +
                           '/1/' +
                           edtRptYear.text + '")';
   qryReptInterpret.sql[6] :=
                           'and (CompanyBillDetail.BillApptDate >= "' +
                           edtRptMonth.text +
                           '/1/' +
                           edtRptYear.text + '")';
   qryReptInterpret.active:= true;
   qryReptInterpret.first;
   for vintLoop:= 0 to grdInterpret.RowCount - 1 do
       begin
       If grdInterpret.Cells[0, vintLoop] =
         (qryReptInterpret.fields[0].asstring
                               + '-' + qryReptInterpret.fields[1].asstring) then
          begin
          grdInterpret.Cells[1, vintLoop]:= qryReptInterpret.fields[2].asstring;
          qryReptInterpret.Next;
          end
       else
          grdInterpret.Cells[1, vintLoop]:= '0';
       end;
   vintMonthc:= 0;
   vintYearc:= 0;
   If grdInterpret.RowCount > 0 then
      begin
      for vintLoop:= 0 to grdInterpret.RowCount - 1 do
         begin
         vintMonthc:= vintMonthc + strtoint(grdInterpret.Cells[1, vintLoop]);
         vintYearc:= vintYearc + strtoint(grdInterpret.Cells[2, vintLoop]);
         end;
      grdInterpret.RowCount:= grdInterpret.RowCount + 1;
      grdInterpret.Cells[0, grdInterpret.RowCount-1]:= 'Totals';
      grdInterpret.Cells[1, grdInterpret.RowCount-1]:= inttostr(vintMonthc);
      grdInterpret.Cells[2, grdInterpret.RowCount-1]:= inttostr(vintYearc);
      end;
   end;

   If (vintYear < 2002) or (vintYear > 2015) or (vintMonth < 1) or (vintMonth > 12) then
   begin
   ShowMessage('Year or Month is not valid.  Please check and try again');
   exit;
   end;
except
   ShowMessage('Year or Month is not valid.  Please check and try again');
   exit;
   end;
LoadStatArray;
LoadReport;
CalcTotal;
end;

procedure TfrmClinicReports.LoadStatArray;
var vintYear, vintLoop, vintLoop2: integer;
begin
for vintLoop:= 1 to 12 do
   for vintLoop2:= 1 to 300 do
      begin
      varrNames[vintLoop2]:= '';
      varrCounts[vintLoop, vintLoop2]:= 0;
      end;
vintYear:= strtoint(edtRptYear.text);
tblUnitedWay.setrange([vintYear], [vintYear]);
for vintLoop:= 1 to 12 do
   If tblUnitedWay.findkey([vintYear, vintLoop]) then
      begin
      for vintLoop2:= 2 to tblUnitedWay.FieldCount - 1 do
          begin
          varrNames[vintLoop2]:= tblUnitedWay.FieldDefs.Items[vintLoop2].Name;
          varrCounts[vintLoop, vintLoop2]:=
                                       tblUnitedWay.Fields[vintLoop2].asinteger;
          end;
      end;
end;

procedure TfrmClinicReports.CalcTotal;
var vintMonth, vintLoop: integer;
    vstrWork: string;
  function AddAll(const vstrName: string): integer;
     var vintTotal, vintLoop2, vintLoop3: integer;
     begin
     vintTotal:= 0;
     for vintLoop2:= 1 to 300 do
        If (varrNames[vintLoop2] = vstrName) or
           (varrNames[vintLoop2] = vstrName + 'A') then
          for vintLoop3:= 1 to vintMonth do
              vintTotal:= vintTotal + varrCounts[vintLoop3, vintloop2];
     AddAll:= vintTotal;
     end;
begin
vintMonth:= strtoint(edtRptMonth.text);
for vintLoop:= 0 to componentCount - 1 do
   begin
   vstrWork:= copy(tedit(Components[vintLoop]).name,
                          length(tedit(Components[vintLoop]).name),1);
   If (copy(vstrWork,length(vstrWork),1) = 'Y')
                               or (copy(vstrWork,length(vstrWork),1) = 'T') then
        tedit(Components[vintLoop]).text:=
                        inttostr(AddAll(copy(tedit(Components[vintLoop]).name,
                               4, length(tedit(Components[vintLoop]).name)-4)));
   end;
edtZipCountyT.text:= edtZipCounty.text;
edtZipErieT.text:= edtZipErie.text;
edtZipOtherT.text:= edtZipOther.text;
end;

procedure TfrmClinicReports.cmdexitClick(Sender: TObject);
begin
Close;
end;

procedure TfrmClinicReports.mnuExitClick(Sender: TObject);
begin
Close;
end;

procedure TfrmClinicReports.cmdSearchClick(Sender: TObject);
begin
qryProblems.SQL[7]:= 'and (Cast(Appointment.ApptDateTime AS DATE) > "1/1/'
   + edtYear.text + '")';
qryProblems.open;
panel1.caption:= inttostr(qryProblems.recordcount);
end;

procedure TfrmClinicReports.grdProblemsDblClick(Sender: TObject);
var vbolDummy: boolean;
begin
  vintCurrentEntity := qryProblems.fieldbyname('Entity').asinteger;
  {This is the sneaky way to cann a routine in a form that created you!}
  vbolDummy := false;
  vfrmMainMenu.onclosequery(Sender, vbolDummy);
end;

procedure TfrmClinicReports.FormCreate(Sender: TObject);
  var vstrYear: string;
begin
vstrYear:= datetostr(date);
edtYear.text:= copy(vstrYear, length(vstrYear)-3, 4);
end;

procedure TfrmClinicReports.Button1Click(Sender: TObject);
var vdatTestSday: tdatetime;
    vintAge, vintNextTicket: longint;
begin
try
  vdatTestSday:= strtodate(mskservice.text);
  except
  Showmessage('The date is not valid.  Please check');
  exit;
  end;
try
  vintAge:= strtoint(edtAge.text);
  except
  Showmessage('The age is not valid.  Please check');
  exit;
  end;
If (cboProgram.ItemIndex = -1) or
   (cboGender.ItemIndex = -1) or
   (cboNationality.ItemIndex = -1) then
    begin
    Showmessage('One of the fields is missing.  Please check');
    exit;
    end;
If tblProgramStats.RecordCount = 0 then
   vintNextTicket := cintClinicReport
else
   begin
   tblProgramStats.last;
   vintNextTicket:= tblProgramStats['ProgramTicket'];
   end;
inc(vintNextTicket);
tblProgramStats.Insert;
tblProgramStats.fieldbyname('ProgramTicket').asinteger:= vintNextTicket;
tblProgramStats.fieldbyname('ProgramDate').asdatetime:= vdatTestSday;
tblProgramStats.fieldbyname('ProgramName').asstring:= cboProgram.Text;
tblProgramStats.fieldbyname('ProgramGender').asstring:= cboGender.Text;
tblProgramStats.fieldbyname('ProgramNationality').asstring:=
                                                            cboNationality.Text;
tblProgramStats.fieldbyname('ProgramAge').asinteger:= vintAge;
tblProgramStats.post;
end;

procedure TfrmClinicReports.cmdDeleteClick(Sender: TObject);
begin
If tblProgramStats.RecordCount > 0 then
    tblProgramStats.delete;
end;

procedure TfrmClinicReports.scrRptChange(Sender: TObject);
begin
pnlScroll.Top := scrRpt.Position * -1;
end;

procedure TfrmClinicReports.SaveReport;
var vintLoop: integer;
begin
If tblUnitedWay.findkey([strtoint(edtRptYear.text), strtoint(edtRptMonth.text)]) then
   tblUnitedWay.edit
else
   tblUnitedWay.Insert;

tblUnitedWay.fieldbyname('ReportYear').asinteger:= strtoint(edtRptYear.text);
tblUnitedWay.fieldbyname('ReportMonth').asinteger:= strtoint(edtRptMonth.text);

for vintLoop:= 0 to componentCount - 1 do
   If tedit(Components[vintLoop]).tag = 1 then
      If length(tedit(Components[vintLoop]).text) = 0 then
        tblUnitedWay.FieldByName(copy(Components[vintLoop].name,4,99)).asinteger:= 0
      else
        tblUnitedWay.FieldByName(copy(Components[vintLoop].name,4,99)).asinteger:=
                          strtoint(tedit(Components[vintLoop]).text);
tblUnitedWay.Post;
end;

procedure TfrmClinicReports.LoadReport;
var vintLoop: integer;
begin
If tblUnitedWay.findkey([strtoint(edtRptYear.text), strtoint(edtRptMonth.text)]) then
   begin
   for vintLoop:= 0 to componentCount - 1 do
     If tedit(Components[vintLoop]).tag = 1 then
        tedit(Components[vintLoop]).text:=
          tblUnitedWay.FieldByName(copy(Components[vintLoop].name,4,99)).asstring;
   end
else
   begin
   for vintLoop:= 0 to componentCount - 1 do
     If tedit(Components[vintLoop]).tag = 1 then
        tedit(Components[vintLoop]).text:= '0';
   end;
end;

procedure TfrmClinicReports.cmdCalculateClick(Sender: TObject);
begin

qryReptProgram.close;
qryReptProgram.SQL.text:=
   'SELECT ProgramName, ProgramAge, ProgramNationality, ProgramGender'
 + ' FROM ProgramStats where EXTRACT(YEAR FROM ProgramDate) = "'
 + edtRptYear.text + '" and EXTRACT(MONTH FROM ProgramDate) = "'
 + edtRptMonth.text + '"';
qryReptProgram.open;

qryReptClinic.close;
qryReptClinic.SQL.text:=
   'SELECT Patient.PatientAge, Patient.PatientNationality, '
 + 'Patient.PatientGender, Appointment.ApptProgram, Appointment.ApptVisitCategory'
 + ' FROM Patient, Appointment where EXTRACT(YEAR FROM Appointment.ApptDateTime) = "'
 + edtRptYear.text + '" and EXTRACT(MONTH FROM Appointment.ApptDateTime) = "'
 + edtRptMonth.text + '" and Appointment.entity = Patient.Entity';
qryReptClinic.open;

CalcMaleFemale;
CalcAge;
CalcNationality;
CalcClinic;
CalcPrograms;
SaveReport;
LoadStatArray;
CalcTotal;
end;

procedure TfrmClinicReports.CalcAge;
var vint14m, vint14f, vint19m, vint19f, vint29m, vint29f, vint39m, vint39f,
    vint49m, vint49f, vint50m, vint50f: integer;
begin
vint14m:= 0;
vint19m:= 0;
vint29m:= 0;
vint39m:= 0;
vint49m:= 0;
vint50m:= 0;
vint14f:= 0;
vint19f:= 0;
vint29f:= 0;
vint39f:= 0;
vint49f:= 0;
vint50f:= 0;

qryReptProgram.first;
while not qryReptProgram.eof do
  begin
  If qryReptProgram.fieldbyname('ProgramGender').asstring = 'Male' then
     begin
     If qryReptProgram.fieldbyname('ProgramAge').asinteger < 14 then
         inc(vint14m)
     else
     If qryReptProgram.fieldbyname('ProgramAge').asinteger < 20 then
         inc(vint19m)
     else
     If qryReptProgram.fieldbyname('ProgramAge').asinteger < 30 then
         inc(vint29m)
     else
     If qryReptProgram.fieldbyname('ProgramAge').asinteger < 40 then
         inc(vint39m)
     else
     If qryReptProgram.fieldbyname('ProgramAge').asinteger < 50 then
         inc(vint49m)
     else
     If qryReptProgram.fieldbyname('ProgramAge').asinteger > 50 then
         inc(vint50m);
     end
  else
  If qryReptProgram.fieldbyname('ProgramGender').asstring = 'Female' then
     begin
     If qryReptProgram.fieldbyname('ProgramAge').asinteger < 14 then
         inc(vint14f)
     else
     If qryReptProgram.fieldbyname('ProgramAge').asinteger < 20 then
         inc(vint19f)
     else
     If qryReptProgram.fieldbyname('ProgramAge').asinteger < 30 then
         inc(vint29f)
     else
     If qryReptProgram.fieldbyname('ProgramAge').asinteger < 40 then
         inc(vint39f)
     else
     If qryReptProgram.fieldbyname('ProgramAge').asinteger < 50 then
         inc(vint49f)
     else
     If qryReptProgram.fieldbyname('ProgramAge').asinteger > 50 then
         inc(vint50f);
     end;
  qryReptProgram.next;
  end;

qryReptClinic.first;
while not qryReptClinic.eof do
  begin
  If qryReptClinic.fieldbyname('PatientGender').asstring = 'Male' then
     begin
     If qryReptClinic.fieldbyname('PatientAge').asinteger < 14 then
         inc(vint14m)
     else
     If qryReptClinic.fieldbyname('PatientAge').asinteger < 20 then
         inc(vint19m)
     else
     If qryReptClinic.fieldbyname('PatientAge').asinteger < 30 then
         inc(vint29m)
     else
     If qryReptClinic.fieldbyname('PatientAge').asinteger < 40 then
         inc(vint39m)
     else
     If qryReptClinic.fieldbyname('PatientAge').asinteger < 50 then
         inc(vint49m)
     else
     If qryReptClinic.fieldbyname('PatientAge').asinteger > 50 then
         inc(vint50m);
     end
  else
  If qryReptClinic.fieldbyname('PatientGender').asstring = 'Female' then
     begin
     If qryReptClinic.fieldbyname('PatientAge').asinteger < 14 then
         inc(vint14f)
     else
     If qryReptClinic.fieldbyname('PatientAge').asinteger < 20 then
         inc(vint19f)
     else
     If qryReptClinic.fieldbyname('PatientAge').asinteger < 30 then
         inc(vint29f)
     else
     If qryReptClinic.fieldbyname('PatientAge').asinteger < 40 then
         inc(vint39f)
     else
     If qryReptClinic.fieldbyname('PatientAge').asinteger < 50 then
         inc(vint49f)
     else
     If qryReptClinic.fieldbyname('PatientAge').asinteger > 50 then
         inc(vint50f);
     end;
  qryReptClinic.next;
  end;

edtMale14.text:= inttostr(vint14m);
edtMale1419.text:= inttostr(vint19m);
edtMale2029.text:= inttostr(vint29m);
edtMale3039.text:= inttostr(vint39m);
edtMale4049.text:= inttostr(vint49m);
edtMale50.text:= inttostr(vint50m);
edtFemale14.text:= inttostr(vint14f);
edtFemale1419.text:= inttostr(vint19f);
edtFemale2029.text:= inttostr(vint29f);
edtFemale3039.text:= inttostr(vint39f);
edtFemale4049.text:= inttostr(vint49f);
edtFemale50.text:= inttostr(vint50f);
end;

procedure TfrmClinicReports.CalcMaleFemale;
var vintMale, vintFemale: integer;
begin
vintMale:= 0;
vintFemale:= 0;
qryReptProgram.first;
while not qryReptProgram.eof do
  begin
  If qryReptProgram.fieldbyname('ProgramGender').asstring = 'Male' then
     inc(vintMale)
  else
  If qryReptProgram.fieldbyname('ProgramGender').asstring = 'Female' then
     inc(vintFemale);
  qryReptProgram.next;
  end;

qryReptClinic.first;
while not qryReptClinic.eof do
  begin
  If qryReptClinic.fieldbyname('PatientGender').asstring = 'Male' then
     inc(vintMale)
  else
  If qryReptClinic.fieldbyname('PatientGender').asstring = 'Female' then
     inc(vintFemale);
  qryReptClinic.next;
  end;
edtMale.text:= inttostr(vintMale);
edtFemale.text:= inttostr(vintFemale);
end;


procedure TfrmClinicReports.CalcNationality;
var vintEur, vintAfr, vintPue, vintMex, vintCol, vintSal, vintDom,
    vintHon, vintGua, vintCub, vintRus, vintUkr, vintArm, vintRom,
    vintIra, vintKur, vintLeb, vintSom, vintSud, vintBos, vintKos, vintCro,
    vintSer, vintVie, vintFil, vintOth,
    vintAmI, vintBhu, vintBur, vintBuru, vintCon, vintEri, vintInd,
    vintIsr, vintIta, vintKor, vintLib, vintNep, vintSau,
    vintSwa, vintTan, vintTha, vintTog, vintTur, vintPer: integer;
begin
vintEur:= 0;
vintAfr:= 0;
vintPue:= 0;
vintMex:= 0;
vintCol:= 0;
vintSal:= 0;
vintDom:= 0;
vintHon:= 0;
vintGua:= 0;
vintCub:= 0;
vintRus:= 0;
vintUkr:= 0;
vintArm:= 0;
vintRom:= 0;
vintIra:= 0;
vintKur:= 0;
vintLeb:= 0;
vintSom:= 0;
vintSud:= 0;
vintBos:= 0;
vintKos:= 0;
vintCro:= 0;
vintSer:= 0;
vintVie:= 0;
vintFil:= 0;
vintOth:= 0;
vintAmI:= 0;
vintBhu:= 0;
vintBur:= 0;
vintBuru:= 0;
vintCon:= 0;
vintEri:= 0;
vintInd:= 0;
vintIsr:= 0;
vintIta:= 0;
vintKor:= 0;
vintLib:= 0;
vintNep:= 0;
vintPer:= 0;
vintSau:= 0;
vintSwa:= 0;
vintTan:= 0;
vintTha:= 0;
vintTog:= 0;
vintTur:= 0;

qryReptProgram.first;
while not qryReptProgram.eof do
  begin
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Eur' then
     inc(vintEur)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Afr' then
     inc(vintAfr)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Pue' then
     inc(vintPue)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Mex' then
     inc(vintMex)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Col' then
     inc(vintCol)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Sal' then
     inc(vintSal)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Dom' then
     inc(vintDom)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Hon' then
     inc(vintHon)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Gua' then
     inc(vintGua)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Cub' then
     inc(vintCub)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Rus' then
     inc(vintRus)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Ukr' then
     inc(vintUkr)
  else
//  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Arm' then
//     inc(vintArm)
//  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Rom' then
     inc(vintRom)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,4)='Iraq' then
     inc(vintIra)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Kur' then
     inc(vintKur)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Leb' then
     inc(vintLeb)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Som' then
     inc(vintSom)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Sud' then
     inc(vintSud)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Bos' then
     inc(vintBos)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Kos' then
     inc(vintKos)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Alb' then
     inc(vintKos)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Cro' then
     inc(vintCro)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Ser' then
     inc(vintSer)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Vie' then
     inc(vintVie)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Ame' then
     inc(vintAmI)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Bhu' then
     inc(vintBhu)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,4)='Burm' then
     inc(vintBur)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,4)='Buru' then
     inc(vintBuru)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Con' then
     inc(vintCon)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Eri' then
     inc(vintEri)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Ind' then
     inc(vintInd)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Isr' then
     inc(vintIsr)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Ita' then
     inc(vintIta)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Kor' then
     inc(vintKor)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Lib' then
     inc(vintLib)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Nep' then
     inc(vintNep)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Sau' then
     inc(vintSau)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Swa' then
     inc(vintSwa)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Tan' then
     inc(vintTan)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Tha' then
     inc(vintTha)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Tog' then
     inc(vintTog)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Tur' then
     inc(vintTur)
  else
  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Per' then
     inc(vintPer)
//  If copy(qryReptProgram.fieldbyname('ProgramNationality').asstring,1,3)='Fil' then
//     inc(vintFil)
//  else
  else
     inc(vintOth);
  qryReptProgram.next;
  end;

qryReptClinic.first;
while not qryReptClinic.eof do
  begin
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Eur' then
     inc(vintEur)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Afr' then
     inc(vintAfr)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Pue' then
     inc(vintPue)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Mex' then
     inc(vintMex)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Col' then
     inc(vintCol)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Sal' then
     inc(vintSal)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Dom' then
     inc(vintDom)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Hon' then
     inc(vintHon)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Gua' then
     inc(vintGua)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Cub' then
     inc(vintCub)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Rus' then
     inc(vintRus)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Ukr' then
     inc(vintUkr)
  else
//  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Arm' then
//     inc(vintArm)
//  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Rom' then
     inc(vintRom)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,4)='Iraq' then
     inc(vintIra)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Kur' then
     inc(vintKur)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Leb' then
     inc(vintLeb)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Som' then
     inc(vintSom)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Sud' then
     inc(vintSud)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Bos' then
     inc(vintBos)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Kos' then
     inc(vintKos)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Alb' then
     inc(vintKos)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Cro' then
     inc(vintCro)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Ser' then
     inc(vintSer)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Vie' then
     inc(vintVie)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Ame' then
     inc(vintAmI)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Bhu' then
     inc(vintBhu)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,4)='Burm' then
     inc(vintBur)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,4)='Buru' then
     inc(vintBuru)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Con' then
     inc(vintCon)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Eri' then
     inc(vintEri)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Ind' then
     inc(vintInd)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Isr' then
     inc(vintIsr)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Ita' then
     inc(vintIta)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Kor' then
     inc(vintKor)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Lib' then
     inc(vintLib)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Nep' then
     inc(vintNep)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Sau' then
     inc(vintSau)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Swa' then
     inc(vintSwa)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Tan' then
     inc(vintTan)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Tha' then
     inc(vintTha)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Tog' then
     inc(vintTog)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Tur' then
     inc(vintTur)
  else
  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Per' then
     inc(vintPer)
//  else
//  If copy(qryReptClinic.fieldbyname('PatientNationality').asstring,1,3)='Fil' then
//     inc(vintFil)
  else
     inc(vintOth);
  qryReptClinic.next;
  end;

edtEuro.text:= inttostr(vintEur);
edtAfrican.text:= inttostr(vintAfr);
edtPuertoRican.text:= inttostr(vintPue);
edtMexican.text:= inttostr(vintMex);
edtColumbian.text:= inttostr(vintCol);
edtSalvadoran.text:= inttostr(vintSal);
edtDominican.text:= inttostr(vintDom);
edtHonduran.text:= inttostr(vintHon);
edtGuatemalan.text:= inttostr(vintGua);
edtCuban.text:= inttostr(vintCub);
edtRussian.text:= inttostr(vintRus);
edtUkranian.text:= inttostr(vintUkr);
//edtArmenian.text:= inttostr(vintArm);
edtRomanian.text:= inttostr(vintRom);
edtIraqi.text:= inttostr(vintIra);
edtKurdish.text:= inttostr(vintKur);
edtLebanese.text:= inttostr(vintLeb);
edtSomalian.text:= inttostr(vintSom);
edtSudanese.text:= inttostr(vintSud);
edtBosnian.text:= inttostr(vintBos);
edtKosovo.text:= inttostr(vintKos);
edtCroatian.text:= inttostr(vintCro);
edtSerbian.text:= inttostr(vintSer);
edtVietnamese.text:= inttostr(vintVie);
//edtFilipinos.text:= inttostr(vintFil);
edtOther.text:= inttostr(vintOth);
//
edtTanzanian.text:= inttostr(vintTan);
edtAmerInd.text:= inttostr(vintAmI);
edtBhutan.text:= inttostr(vintBhu);
edtBurmese.text:= inttostr(vintBur);
edtBurundi.text:= inttostr(vintBuru);
edtCongo.text:= inttostr(vintCon);
edtEritrean.text:= inttostr(vintEri);
edtIndia.text:= inttostr(vintInd);
edtIsreal.text:= inttostr(vintIsr);
edtItalian.text:= inttostr(vintIta);
edtKoren.text:= inttostr(vintKor);
edtLiberian.text:= inttostr(vintLib);
edtNepal.text:= inttostr(vintNep);
edtPersian.text:= inttostr(vintPer);
edtSaudi.text:= inttostr(vintSau);
edtThai.text:= inttostr(vintTha);
edtTogo.text:= inttostr(vintTog);
edtTurkish.text:= inttostr(vintTur);
edtSwahili.text:= inttostr(vintSwa);
end;

procedure TfrmClinicReports.CalcClinic;
var vintAid, vintBeh, vintLea, vintPre, vintSug, vintBre, vintCli,
    vintChr, vintMas, vintDA, vintDeR, vintDeT, vintEPS, vintHea, vintHem,
    vintHom, vintHos, vintImi, vintImu, vintPap, vintPos, vintSpe, vintTB,
    vintUri, vintVis, vintWIC, vintPho: integer;
begin
vintAid:= 0;
vintBeh:= 0;
vintLea:= 0;
vintPre:= 0;
vintSug:= 0;
vintBre:= 0;
vintCli:= 0;
vintChr:= 0;
vintMas:= 0;
vintDA:= 0;
vintDeR:= 0;
vintDeT:= 0;
vintEPS:= 0;
vintHea:= 0;
vintHem:= 0;
vintHom:= 0;
vintHos:= 0;
vintImi:= 0;
vintImu:= 0;
vintPap:= 0;
vintPos:= 0;
vintSpe:= 0;
vintTB:= 0;
vintUri:= 0;
vintVis:=0;
vintWIC:= 0;
vintPho:= 0;

qryReptClinic.first;
while not qryReptClinic.eof do
  begin
  If copy(qryReptClinic.fieldbyname('ApptVisitCategory').asstring,1,3)='AID' then
     inc(vintAid)
  else
  If copy(qryReptClinic.fieldbyname('ApptVisitCategory').asstring,1,3)='Beh' then
     inc(vintBeh)
  else
  If copy(qryReptClinic.fieldbyname('ApptVisitCategory').asstring,1,8)='Blood  L' then
     inc(vintLea)
  else
  If copy(qryReptClinic.fieldbyname('ApptVisitCategory').asstring,1,7)='Blood P' then
     inc(vintPre)
  else
  If copy(qryReptClinic.fieldbyname('ApptVisitCategory').asstring,1,7)='Blood S' then
     inc(vintSug)
  else
  If copy(qryReptClinic.fieldbyname('ApptVisitCategory').asstring,1,3)='Bre' then
     inc(vintBre)
  else
  If copy(qryReptClinic.fieldbyname('ApptVisitCategory').asstring,1,3)='Cli' then
     inc(vintCli)
  else
  If copy(qryReptClinic.fieldbyname('ApptVisitCategory').asstring,1,3)='Chr' then
     inc(vintChr)
  else
  If copy(qryReptClinic.fieldbyname('ApptVisitCategory').asstring,1,3)='Mas' then
     inc(vintMas)
  else
  If copy(qryReptClinic.fieldbyname('ApptVisitCategory').asstring,1,3)='D /' then
     inc(vintDA)
  else
  If copy(qryReptClinic.fieldbyname('ApptVisitCategory').asstring,1,8)='Dental R' then
     inc(vintDeR)
  else
  If copy(qryReptClinic.fieldbyname('ApptVisitCategory').asstring,1,8)='Dental T' then
     inc(vintDeT)
  else
  If copy(qryReptClinic.fieldbyname('ApptVisitCategory').asstring,1,3)='EPS' then
     inc(vintEPS)
  else
  If copy(qryReptClinic.fieldbyname('ApptVisitCategory').asstring,1,3)='Hea' then
     inc(vintHea)
  else
  If copy(qryReptClinic.fieldbyname('ApptVisitCategory').asstring,1,3)='Hem' then
     inc(vintHem)
  else
  If copy(qryReptClinic.fieldbyname('ApptVisitCategory').asstring,1,3)='Hom' then
     inc(vintHom)
  else
  If copy(qryReptClinic.fieldbyname('ApptVisitCategory').asstring,1,3)='Hos' then
     inc(vintHos)
  else
  If copy(qryReptClinic.fieldbyname('ApptVisitCategory').asstring,1,4)='Immi' then
     inc(vintImi)
  else
  If copy(qryReptClinic.fieldbyname('ApptVisitCategory').asstring,1,4)='Immu' then
     inc(vintImu)
  else
  If copy(qryReptClinic.fieldbyname('ApptVisitCategory').asstring,1,3)='Pho' then
     inc(vintPho)
  else
  If copy(qryReptClinic.fieldbyname('ApptVisitCategory').asstring,1,3)='Pap' then
     inc(vintPap)
  else
  If copy(qryReptClinic.fieldbyname('ApptVisitCategory').asstring,1,3)='Pos' then
     inc(vintPos)
  else
  If copy(qryReptClinic.fieldbyname('ApptVisitCategory').asstring,1,3)='Spe' then
     inc(vintSpe)
  else
  If copy(qryReptClinic.fieldbyname('ApptVisitCategory').asstring,1,3)='TB ' then
     inc(vintTB)
  else
  If copy(qryReptClinic.fieldbyname('ApptVisitCategory').asstring,1,3)='Uri' then
     inc(vintUri)
  else
  If copy(qryReptClinic.fieldbyname('ApptVisitCategory').asstring,1,3)='Vis' then
     inc(vintVis)
  else
  If copy(qryReptClinic.fieldbyname('ApptVisitCategory').asstring,1,3)='WIC' then
     inc(vintWic);
  qryReptClinic.next;
  end;

edtClinAIDS.text:= inttostr(vintAid);
edtClinBeha.text:= inttostr(vintBeh);
edtClinLead.text:= inttostr(vintLea);
edtClinPres.text:= inttostr(vintPre);
edtClinSuga.text:= inttostr(vintSug);
edtClinBrea.text:= inttostr(vintBre);
edtClinClin.text:= inttostr(vintCli);
edtClinChrr.text:= inttostr(vintChr);
edtClinMass.text:= inttostr(vintMas);
edtClinDA.text :=  inttostr(vintDA);
edtClinDena.text:= inttostr(vintDeR);
edtClinDtra.text:= inttostr(vintDeT);
edtClinEPSD.text:= inttostr(vintEPS);
edtClinHear.text:= inttostr(vintHea);
edtClinHema.text:= inttostr(vintHem);
edtClinHome.text:= inttostr(vintHom);
edtClinHosp.text:= inttostr(vintHos);
edtClinImmi.text:= inttostr(vintImi);
edtClinImmu.text:= inttostr(vintImu);
edtClinPap.text:=  inttostr(vintPap);
edtClinNata.text:= inttostr(vintPos);
edtClinSpec.text:= inttostr(vintSpe);
edtClinTB.text:=   inttostr(vintTB);
edtClinUrin.text:= inttostr(vintUri);
edtClinVisi.text:= inttostr(vintVis);
edtClinWIC.text:=  inttostr(vintWIC);
edtClinPhon.text:= inttostr(vintPho);
end;

procedure TfrmClinicReports.CalcPrograms;
var vintAbs, vintECD, vintNWP, vintSaf, vintTob, vintFol, vintASI,
    vintASF: integer;
begin
vintAbs:= 0;
vintECD:= 0;
vintNWP:= 0;
vintSaf:= 0;
vintTob:= 0;
vintFol:= 0;
vintASI:= 0;
vintASF:= 0;

qryReptProgram.first;
while not qryReptProgram.eof do
  begin
  If copy(qryReptProgram.fieldbyname('ProgramName').asstring,1,1)='9' then
     inc(vintAbs)
  else
  If copy(qryReptProgram.fieldbyname('ProgramName').asstring,1,1)='A' then
     inc(vintECD)
  else
  If copy(qryReptProgram.fieldbyname('ProgramName').asstring,1,1)='B' then
     inc(vintNWP)
  else
  If copy(qryReptProgram.fieldbyname('ProgramName').asstring,1,1)='C' then
     inc(vintSaf)
  else
  If copy(qryReptProgram.fieldbyname('ProgramName').asstring,1,1)='D' then
     inc(vintTob)
  else
  If copy(qryReptProgram.fieldbyname('ProgramName').asstring,1,1)='E' then
     inc(vintFol)
  else
  If copy(qryReptProgram.fieldbyname('ProgramName').asstring,1,1)='F' then
     inc(vintASI)
  else
  If copy(qryReptProgram.fieldbyname('ProgramName').asstring,1,1)='G' then
     inc(vintASF);
  qryReptProgram.next;
  end;

edtAbstainence.text:= inttostr(vintAbs);
edtECHD.text:= inttostr(vintECD);
edtHIV.text:= inttostr(vintNWP);
edtSafenet.text:= inttostr(vintSaf);
edtTobacco.text:= inttostr(vintTob);
edtFolic.text:= inttostr(vintFol);
edtAfterInd.text:= inttostr(vintASI);
edtAfterFam.text:= inttostr(vintASF);

end;

procedure TfrmClinicReports.cmdPrintApptClick(Sender: TObject);
var vintLoop, vintLoop2: integer;
    vstrMonth: string;
begin
If strtoint(edtRptMonth.text) = 1 then
   vstrMonth:= 'January'
else
If strtoint(edtRptMonth.text) = 2 then
   vstrMonth:= 'February'
else
If strtoint(edtRptMonth.text) = 3 then
   vstrMonth:= 'March'
else
If strtoint(edtRptMonth.text) = 4 then
   vstrMonth:= 'April'
else
If strtoint(edtRptMonth.text) = 5 then
   vstrMonth:= 'May'
else
If strtoint(edtRptMonth.text) = 6 then
   vstrMonth:= 'June'
else
If strtoint(edtRptMonth.text) = 7 then
   vstrMonth:= 'July'
else
If strtoint(edtRptMonth.text) = 8 then
   vstrMonth:= 'August'
else
If strtoint(edtRptMonth.text) = 9 then
   vstrMonth:= 'September'
else
If strtoint(edtRptMonth.text) = 10 then
   vstrMonth:= 'October'
else
If strtoint(edtRptMonth.text) = 11 then
   vstrMonth:= 'November'
else
If strtoint(edtRptMonth.text) = 12 then
   vstrMonth:= 'December';

rptUnitedWay := TrptUnitedWay.Create(nil);
rptUnitedWay.qrlabel4.caption:= vstrMonth + ' ' + edtRptYear.text;
try
for vintLoop:= 0 to componentCount - 1 do
  for vintLoop2:= 0 to rptUnitedWay.componentcount - 1 do
      If tedit(Components[vintLoop]).name =
                         tqrlabel(rptUnitedWay.Components[vintLoop2]).name then
           tqrlabel(rptUnitedWay.Components[vintLoop2]).caption:=
                                             tedit(Components[vintLoop]).text;
for vintLoop:= 0 to componentCount - 1 do
  for vintLoop2:= 0 to rptUnitedWay.componentcount - 1 do
      If tedit(Components[vintLoop]).name =
                    tqrlabel(rptUnitedWay.Components[vintLoop2]).name + 'A' then
           begin
             try
             tqrlabel(rptUnitedWay.Components[vintLoop2]).caption:=
             inttostr(strtoint(tqrlabel(rptUnitedWay.Components[vintLoop2]).caption) +
                                             strtoint(tedit(Components[vintLoop]).text));
             except
             tqrlabel(rptUnitedWay.Components[vintLoop2]).caption:=
                                             tedit(Components[vintLoop]).text;
                 end;
           end;
    rptUnitedWay.Preview;
  finally
    rptUnitedWay.free;
    rptUnitedWay := nil;
  end;

rptUnitedWay1a := TrptUnitedWay1a.Create(nil);
try
for vintLoop:= 0 to componentCount - 1 do
  for vintLoop2:= 0 to rptUnitedWay1a.componentcount - 1 do
      If tedit(Components[vintLoop]).name =
                         tqrlabel(rptUnitedWay1a.Components[vintLoop2]).name then
           tqrlabel(rptUnitedWay1a.Components[vintLoop2]).caption:=
                                             tedit(Components[vintLoop]).text;
for vintLoop:= 0 to componentCount - 1 do
  for vintLoop2:= 0 to rptUnitedWay1a.componentcount - 1 do
      If tedit(Components[vintLoop]).name =
                    tqrlabel(rptUnitedWay1a.Components[vintLoop2]).name + 'A' then
           begin
             try
             tqrlabel(rptUnitedWay1a.Components[vintLoop2]).caption:=
             inttostr(strtoint(tqrlabel(rptUnitedWay1a.Components[vintLoop2]).caption) +
                                             strtoint(tedit(Components[vintLoop]).text));
             except
             tqrlabel(rptUnitedWay1a.Components[vintLoop2]).caption:=
                                             tedit(Components[vintLoop]).text;
                 end;
           end;
    rptUnitedWay1a.Preview;
  finally
    rptUnitedWay1a.free;
    rptUnitedWay1a := nil;
  end;

rptUnitedWay2 := TrptUnitedWay2.Create(nil);
rptUnitedWay2.qrlabel4.caption:= vstrMonth + ' ' + edtRptYear.text;
try

If (strtoint(edtRptYear.Text) > 2004) then
       rptUnitedWay2.qrband2.enabled:= false
else
       rptUnitedWay2.qrband2.enabled:= true;

for vintLoop:= 0 to componentCount - 1 do
  for vintLoop2:= 0 to rptUnitedWay2.componentcount - 1 do
      If tedit(Components[vintLoop]).name =
                         tqrlabel(rptUnitedWay2.Components[vintLoop2]).name then
           tqrlabel(rptUnitedWay2.Components[vintLoop2]).caption:=
                                             tedit(Components[vintLoop]).text;
for vintLoop:= 0 to componentCount - 1 do
  for vintLoop2:= 0 to rptUnitedWay2.componentcount - 1 do
      If tedit(Components[vintLoop]).name =
                    tqrlabel(rptUnitedWay2.Components[vintLoop2]).name + 'A' then
           begin
             try
             tqrlabel(rptUnitedWay2.Components[vintLoop2]).caption:=
             inttostr(strtoint(tqrlabel(rptUnitedWay2.Components[vintLoop2]).caption) +
                                             strtoint(tedit(Components[vintLoop]).text));
             except
             tqrlabel(rptUnitedWay2.Components[vintLoop2]).caption:=
                                             tedit(Components[vintLoop]).text;
                 end;
           end;
    rptUnitedWay2.Refresh;
    rptUnitedWay2.Preview;
  finally
    rptUnitedWay2.free;
    rptUnitedWay2 := nil;
  end;

If (strtoint(edtRptYear.Text) > 2004) then
  begin
  rptUnitedWay2b := TrptUnitedWay2b.Create(nil);
  rptUnitedWay2b.qrlabel4.caption:= vstrMonth + ' ' + edtRptYear.text;
  try

  vintLoop:=0;
  while (vintLoop < grdInterpret.RowCount) and (vintLoop < 57) do
    begin
    rptUnitedWay2b.qrmInterpret1.Lines.Add(grdInterpret.Cells[0,vintLoop]);
    rptUnitedWay2b.qrmInterpret2.Lines.Add(grdInterpret.Cells[1,vintLoop]);
    rptUnitedWay2b.qrmInterpret3.Lines.Add(grdInterpret.Cells[2,vintLoop]);
    inc(vintLoop);
    end;

  while (vintLoop < grdInterpret.RowCount) do
    begin
    rptUnitedWay2b.qrmInterpret4.Lines.Add(grdInterpret.Cells[0,vintLoop]);
    rptUnitedWay2b.qrmInterpret5.Lines.Add(grdInterpret.Cells[1,vintLoop]);
    rptUnitedWay2b.qrmInterpret6.Lines.Add(grdInterpret.Cells[2,vintLoop]);
    inc(vintLoop);
    end;

    rptUnitedWay2b.Refresh;
    rptUnitedWay2b.Preview;
  finally
    rptUnitedWay2b.free;
    rptUnitedWay2b := nil;
  end;
  end;

rptUnitedWay3 := TrptUnitedWay3.Create(nil);
rptUnitedWay3.qrlabel4.caption:= vstrMonth + ' ' + edtRptYear.text;try
for vintLoop:= 0 to componentCount - 1 do
  for vintLoop2:= 0 to rptUnitedWay3.componentcount - 1 do
      If tedit(Components[vintLoop]).name =
                         tqrlabel(rptUnitedWay3.Components[vintLoop2]).name then
           tqrlabel(rptUnitedWay3.Components[vintLoop2]).caption:=
                                             tedit(Components[vintLoop]).text;
for vintLoop:= 0 to componentCount - 1 do
  for vintLoop2:= 0 to rptUnitedWay3.componentcount - 1 do
      If tedit(Components[vintLoop]).name =
                    tqrlabel(rptUnitedWay3.Components[vintLoop2]).name + 'A' then
           begin
             try
             tqrlabel(rptUnitedWay3.Components[vintLoop2]).caption:=
             inttostr(strtoint(tqrlabel(rptUnitedWay3.Components[vintLoop2]).caption) +
                                             strtoint(tedit(Components[vintLoop]).text));
             except
             tqrlabel(rptUnitedWay3.Components[vintLoop2]).caption:=
                                             tedit(Components[vintLoop]).text;
                 end;
           end;
    rptUnitedWay3.Preview;
  finally
    rptUnitedWay3.free;
    rptUnitedWay3 := nil;
  end;

end;
end.
