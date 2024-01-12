unit formScheduler;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBGrids, Grids, ExtCtrls, ToolWin, ComCtrls, Buttons, Mask,
  DBCtrls, db, DbTables,
  dataScheduler, procSharedDatamoduleCalls, Menus, formSchedPassword;

type
  TfrmScheduler = class(TForm)
    pnlSchedule: TPanel;
    Panel4: TPanel;
    pnlTime: TPanel;
    lstTime: TStringGrid;
    ScrollBar2: TScrollBar;
    Panel1: TPanel;
    imgSchedule: TImage;
    pnlTop: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lbl_10002: TLabel;
    txtComDes: TMemo;
    txtHousehold: TEdit;
    txtComplaint: TEdit;
    ScrollBar1: TScrollBar;
    lstEntity: TListView;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox1: TCheckBox;
    grdSearch: TDBGrid;
    lstUnscheduled: TListView;
    cmdSetDate: TSpeedButton;
    lbl_00001: TLabel;
    edtSearch: TEdit;
    datCalendar: TMonthCalendar;
    cmdSchedule: TSpeedButton;
    cmdUnschedule: TSpeedButton;
    txtName: TListBox;
    radSearch: TRadioGroup;
    cmdAppointment: TSpeedButton;
    cmdPatient: TSpeedButton;
    cmdHousehold: TSpeedButton;
    mnuPrinting: TPopupMenu;
    cmdSingleSchedulePrint: TMenuItem;
    cmdAllSchedulePrint: TMenuItem;
    cmdSingleApptPrint: TMenuItem;
    cmdAllAppointmentPrint: TMenuItem;
    cmdPrint: TSpeedButton;
    lblPatientName: TLabel;
    tmrClock: TTimer;
    edtTime: TEdit;
    linTime: TShape;
    lblPatientBalance: TLabel;
    lblAnnualAppointment: TLabel;
    procedure ScrollBar1Change(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure lstUnscheduledClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox10Click(Sender: TObject);
    procedure CheckBox11Click(Sender: TObject);
    procedure CheckBox13Click(Sender: TObject);
    procedure CheckBox12Click(Sender: TObject);
    procedure CheckBox14Click(Sender: TObject);
    procedure CheckBox15Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure CheckBox9Click(Sender: TObject);
    procedure cmdScheduleClick(Sender: TObject);
    procedure imgScheduleMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cmdUnscheduleClick(Sender: TObject);
    procedure cmdSetDateClick(Sender: TObject);
    procedure lstTimeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lstTimeMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lstTimeMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cmdAppointmentClick(Sender: TObject);
    procedure cmdPatientClick(Sender: TObject);
    procedure cmdHouseholdClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure datCalendarEnter(Sender: TObject);
    procedure cmdSinglePrintClick(Sender: TObject);
    procedure lstEntitySelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure cmdAllPrintClick(Sender: TObject);
    procedure datCalanderCloseUp(Sender: TObject);
    procedure cmdNewApptClick(Sender: TObject);
    procedure edtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure txtNameClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure cmdSingleApptPrintClick(Sender: TObject);
    procedure cmdAllAppointmentPrintClick(Sender: TObject);
    procedure imgScheduleMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure tmrClockTimer(Sender: TObject);
  private
    vbolselected, vbolchecked, vbolclick, vbolmousedown, vbolMouseFar,
                  vbolReport, vbolFirst: boolean;
    vintCheckAppt, vintnumEntities, vintDocEntity, vintx, vinty,
       vintCallPatient, vintCallHousehold, vintCallAppointment,
       vintLasthover: integer;
    vreaStart, vreaCallDateTime: real;
    varrlastSelected: Array[1..2] of integer;
    Checkboxes: Array [1..15] of Tcheckbox;
    vstrlistEntitiesChecked : TStringlist;
    procedure FindAnnualAppointments;
  public
    constructor Create(AOwner :TComponent); override;
    destructor destroy; override;
    procedure FillEntityList(Start: integer);
    procedure SetCheckboxTag(Comp: integer);
    procedure resetCheckBoxChecks(Start: integer);
    procedure drawScheduleBars;
    procedure fillUnscheduledList;
    procedure clearchecks;
    procedure unselectScheduler;
    function IndexOfEntity(cstr : String):integer;
    function IndexOfEntityNum(cstr:String):integer;
    Function GetDayText(const cdatDate: tdatetime): string;
    Function ShowPassword: boolean;
  end;

var
  frmScheduler: TfrmScheduler;


implementation

uses formSchedule1, formSchedule2, formApptSummQR;

{$R *.DFM}

destructor TfrmScheduler.destroy;
begin
  Inherited destroy;
  dtmScheduler.free;
  dtmScheduler:= nil;
end;

constructor TfrmScheduler.Create(AOwner :TComponent);
var
  vintloop: Integer;
  vqrySchedule: tquery;
  vstrWorkTime: string;
begin
  dtmScheduler:= tdtmScheduler.create(application);
  {Create all form components and other start-up activities}
  Inherited create(AOwner);
  {Set all datasources}
  vstrlistentitiesChecked:=Tstringlist.create;

  //set a variable so that when making calls ato the components it doesn't
  //call the events
  vbolclick:=false;

  //make sure that a component is clicked in stead of running the events
  vbolchecked:=true;
  //check if a bar on the sheduler is selected
  vbolselected:=false;
  //check if the mouse button is down when draging on the time bar
  vbolmousedown:=false;
  //used to slow the draging on the time bar
  vbolmousefar:=false;

  //set up the checkbox array
  Checkboxes[1]:=Checkbox1;
  Checkboxes[2]:=Checkbox2;
  Checkboxes[3]:=Checkbox3;
  Checkboxes[4]:=Checkbox4;
  Checkboxes[5]:=Checkbox5;
  Checkboxes[6]:=Checkbox6;
  Checkboxes[7]:=Checkbox7;
  Checkboxes[8]:=Checkbox8;
  Checkboxes[9]:=Checkbox9;
  Checkboxes[10]:=Checkbox10;
  Checkboxes[11]:=Checkbox11;
  Checkboxes[12]:=Checkbox12;
  Checkboxes[13]:=Checkbox13;
  Checkboxes[14]:=Checkbox14;
  Checkboxes[15]:=Checkbox15;

  //create a query that can check all of the entity component not just
  //sheduleable ones
{  dtmScheduler.tblEntity:= tquery.create(nil);
  dtmScheduler.tblEntity.close;
  dtmScheduler.tblEntity.RequestLive := false;
  dtmScheduler.tblEntity.Unidirectional := true;
  dtmScheduler.tblEntity.Databasename := 'mmom_maindatabase';
  dtmScheduler.tblEntity.SQL.clear;
  dtmScheduler.tblEntity.SQL.add
                          ('Select Entity, EntityCategory, EntityDescription,');
  dtmScheduler.tblEntity.SQL.add('       EntityLastName, EntityHousehold');
  dtmScheduler.tblEntity.SQL.add('From Entity');
  dtmScheduler.tblEntity.SQL.add
                 ('Order by Entity');
  dtmScheduler.tblEntity.Open;  }

  //set the sheduler image size and the scroll bar limits
  vintloop:=1;
  while dtmScheduler.varrEntity[vintloop]<>0 do
    inc(vintloop);
  if vintloop<=16 then
  begin
    ScrollBar1.max:=1;
    imgSchedule.Height:=280;
  end
  else
  begin
    ScrollBar1.max:=vintloop-15;
    imgSchedule.Height:=14*(vintloop-20)+280;
  end;

  {Find the valid table-driven times and fill in the timeline list}
  vqrySchedule:= tquery.create(nil);
  try
   vqrySchedule.DatabaseName:= 'mmom_maindatabase';
   vqrySchedule.SQL.Add('Select * from Schedule');
   vqrySchedule.open;
   dtmScheduler.vtimMin:= vqrySchedule.fieldbyname('ApptTime').asdatetime;
   dtmScheduler.vintStartPoint:= dtmScheduler.TimeToArray(dtmScheduler.vtimMin);
   If vqrySchedule.recordcount > 48 then
      scrollbar2.max := vqrySchedule.recordcount - 49
   else
      scrollbar2.max:= 0;

   vreaStart:= vqrySchedule.fieldbyname('ApptTime').asdatetime;   
   vintLoop:= 0;
   while not vqrySchedule.eof do
   begin
     vstrWorkTime:= FormatDateTime('hh:mm AM/PM',
                    vqrySchedule.fieldbyname('ApptTime').asdatetime);
     lsttime.Cells[vintloop,0]:= copy(vstrWorkTime,1,1);
     lsttime.Cells[vintloop,1]:= copy(vstrWorkTime,2,1);
     lsttime.Cells[vintloop,2]:= copy(vstrWorkTime,4,1);
     lsttime.Cells[vintloop,3]:= copy(vstrWorkTime,5,1);
     lsttime.Cells[vintloop,4]:= copy(vstrWorkTime,7,1);
     lsttime.Cells[vintloop,5]:= copy(vstrWorkTime,8,1);
     inc(vintloop);
     vqrySchedule.next;
     end;
   dtmScheduler.vtimMax:= vqrySchedule.fieldbyname('ApptTime').asdatetime;
   vqrySchedule.close;
  finally
    vqrySchedule.free;
    end;


  {Load all memory resident content and draw initial view}
  dtmScheduler.InitializeEntityScheduler;
  dtmScheduler.LoadEntityScheduler;
  //set the max number of sheduleable entities
  vintnumentities:=vintloop-1;
  //fill the list of shedulable entities
  fillentitylist(1);
  //fill the list of unsheduled appts
  fillUnScheduledList;
  //used to check if that same appt is already selected to not re fill the
  //edit boxes
  vintcheckAppt:=0;
  //load the sheduler data
  dtmScheduler.vdatScheduleDate:= date;
  dtmScheduler.InitializeDayScheduler;
  dtmScheduler.LoadDayScheduler;

  //draw the bars on the scheduled image
  drawScheduleBars;

  //initialize the list of checked entities so that you can scroll through
  //the checks
  vintloop:=1;
  while vintloop<=vintnumEntities do
  begin
    vstrlistEntitiesChecked.Add('0');
    inc(vintloop);
  end;
  //set current date
//  edtDate.text:=DateToStr(date);
  cmdHousehold.Enabled:=false;
  cmdPatient.Enabled:=false;
  cmdAppointment.Enabled:=false;
  cmdUnschedule.Enabled:=false;
  cmdSchedule.Enabled:=false;
  vbolClick:=true;
  vintDocEntity:= 0;
  tmrClockTimer(self);
end;

function TfrmScheduler.ShowPassword: boolean;
begin
  application.Createform(tfrmSchedPassword, frmSchedPassword);
  try
  frmSchedPassword.ShowModal;
  result:= frmSchedPassword.vbolValidPass;
  finally
    frmSchedPassword.Release;
    frmSchedPassword:= nil;
    end;
end;

//procedure to fill the unsheduled list box with the unsheduled appts
procedure TfrmScheduler.fillUnscheduledList;
var
  vintloop: Integer;
begin
  vintloop:=0;
  lstUnscheduled.ReadOnly:= false;
  //clear items in list if a appt was scheduled to take it off the list
  lstUnscheduled.Items.Clear;
  dtmScheduler.qryUnScheduled.Refresh;
  dtmScheduler.qryUnScheduled.First;
  //fill the list from the query
  while vintloop < dtmScheduler.qryUnScheduled.RecordCount do
  begin
    lstUnscheduled.Items.Add;
    dtmScheduler.tblEntity.locate
      ('Entity',dtmScheduler.qryUnScheduled.fieldbyname('Entity').asinteger,[]);
    lstUnscheduled.Items.Item[vintloop].caption:=
               dtmScheduler.tblEntity.fieldbyname('EntityDescription').asstring;
    dtmScheduler.qryUnScheduled.next;
    inc(vintloop);
  end;
  lstunscheduled.Selected:= nil;
  lstUnscheduled.ReadOnly:= true;
end;

//fill the enitity list box with the scheduable entities starting with the top
//entity that is scrolled down to
procedure TfrmScheduler.FillEntityList(Start: Integer);
var
  vintloop: Integer;
begin
  lstEntity.ReadOnly:= false;
  vbolChecked:=false;
  vintloop:=Start+1;
  //fill the list
  while (vintloop<=Start+15)  do
  begin
    if (dtmScheduler.varrEntity[vintloop-start]<>0) then
    begin
      lstEntity.Items.Item[vintloop-1-start].caption:=
                                              dtmScheduler.varrName[vintloop-1];
      lstEntity.Items.item[vintloop-1-start].Stateindex:=
                                            dtmScheduler.varrEntity[vintloop-1];
      checkboxes[vintloop-start].enabled:=true;
    end
    else
    begin
      checkboxes[vintloop-start].enabled:=false;
      lstEntity.Items.Item[vintloop-1-start].caption:='';
      lstEntity.Items.item[vintloop-1-start].Stateindex:=0;
    end;
    inc(vintloop);
  end;
  vbolchecked:=true;
  lstEntity.ReadOnly:= true;
end;

//when the scroll bar chages then change the enitiy list, checks and image
//position verticly
procedure TfrmScheduler.ScrollBar1Change(Sender: TObject);
begin
  vbolclick:=false;
  fillentitylist(ScrollBar1.Position);
  resetCheckBoxChecks(ScrollBar1.Position);
  imgSchedule.top:=(ScrollBar1.Position-1)*(-14);
  vbolclick:=true;
end;

//when the scroll bar changes then moves the time selector and the image horz.
procedure TfrmScheduler.ScrollBar2Change(Sender: TObject);
begin
  ImgSchedule.left:=ScrollBar2.Position*(-15);
  lstTime.left:=ScrollBar2.Position*(-15)
end;

//done when the unsheduled list is clicked to set the info into the edit boxes
procedure TfrmScheduler.lstUnscheduledClick(Sender: TObject);
begin
  //make sure somthing is selected
  if lstunscheduled.Selected<>nil then
  begin
    //clearchecks;
    dtmScheduler.qryUnScheduled.First;
    dtmScheduler.tblEntity.locate
                       ('entityDescription',lstunscheduled.Selected.Caption,[]);
    lblPatientBalance.Caption:= Format('Balance %m',
               [dtmscheduler.tblPatient.fieldbyname('PatientBalance').asfloat]);
    FindAnnualAppointments;
    dtmScheduler.qryUnScheduled.MoveBy(lstunscheduled.selected.Index);

    //check if this appt was already selected so as not to put the same data
    //into the edit boxes and save time
    if dtmScheduler.qryUnScheduled.fieldbyName('Apptticket').asinteger
                                                           <> vintCheckAppt then
    begin
      //put data into the edit boxes
      vintCallPatient:=dtmScheduler.tblEntity.fieldbyName('Entity').asinteger;
      vintCallHousehold:=
                dtmScheduler.tblEntity.fieldbyname('EntityHousehold').asinteger;
      vintCallAppointment:=
                dtmScheduler.qryUnScheduled.fieldbyName('Apptticket').asinteger;
      txtName.Items.Clear;
      txtName.Items.add(
              dtmScheduler.tblEntity.fieldbyName('EntityDescription').asstring +
              ' (' +
              dtmScheduler.tblEntity.fieldbyname('Entity').asstring + ')');
      txtname.Tag:=0;
      txtName.ItemIndex:= 0;
      txtComDes.readonly:= false;
      txtcomplaint.readonly:= false;
      txtcomplaint.text:=
              dtmScheduler.qryUnScheduled.FieldByname('ApptComplaint').asstring;
      txtcomDes.text:=
          dtmScheduler.qryUnScheduled.fieldByname('ApptComplaintText').asstring;
      dtmScheduler.tblEntity.locate
            ('Entity',
            dtmScheduler.tblEntity.fieldbyname('EntityHousehold').asinteger,[]);
      txthousehold.text:=
               dtmScheduler.tblEntity.fieldbyName('EntityDescription').asstring;

      //if a selection was previosly made on the image unselect it
      if vbolselected then
        unselectScheduler;
      vintCheckAppt:=
                dtmScheduler.qryUnScheduled.fieldbyname('ApptTicket').asinteger;
      //clear the checkmarks so as to start a new patient
      //clearChecks;
    end
  else
    begin
    txtComDes.readonly:= true;
    txtcomplaint.readonly:= true;
    end;
    {Force the refresh of the appt data on next schedule click event}

    cmdHousehold.Enabled:=true;
    cmdPatient.Enabled:=true;
    cmdAppointment.Enabled:=true;
    cmdUnschedule.Enabled:=false;
    cmdSchedule.Enabled:=true;

    vintCheckAppt:= 0;
  end;
end;

//done when closed
procedure TfrmScheduler.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  vintloop: Integer;
begin
  dtmScheduler.ShutDownScheduler;
  vintloop:=1;
  while vintloop < 16 do
  begin
    checkboxes[vintloop].free;
    inc(vintloop);
  end;
  vstrlistEntitieschecked.free;
  CloseThisEntity(cintScheduler);
  action := cafree;
end;

//uesed becuase when an entity is checked the enitity # is stored inside the
//component so at to fill the checked list so we know what entities were checked
procedure TfrmScheduler.SetCheckboxTag(Comp: Integer);
begin
  if CheckBoxes[comp].checked then
  begin
    vstrlistEntitiesChecked.strings[Comp+scrollBar1.Position-2]:=
                              InttoStr(lstEntity.items.Item[comp-1].Stateindex);
  end
  else
    vstrlistEntitiesChecked.strings[Comp+scrollBar1.Position-2]:='0';

end;

//when any of the checkboxes are checked set the enitity # in the list
procedure TfrmScheduler.CheckBox1Click(Sender: TObject);
begin
  if vbolchecked then
  SetCheckboxTag(1);
end;

procedure TfrmScheduler.CheckBox10Click(Sender: TObject);
begin
  if vbolchecked then
  SetCheckboxTag(10);
end;

procedure TfrmScheduler.CheckBox11Click(Sender: TObject);
begin
  if vbolchecked then
  SetCheckboxTag(11);
end;

procedure TfrmScheduler.CheckBox13Click(Sender: TObject);
begin
  if vbolchecked then
  SetCheckboxTag(13);
end;

procedure TfrmScheduler.CheckBox12Click(Sender: TObject);
begin
  if vbolchecked then
  SetCheckboxTag(12);
end;

procedure TfrmScheduler.CheckBox14Click(Sender: TObject);
begin
  if vbolchecked then
  SetCheckboxTag(14);
end;

procedure TfrmScheduler.CheckBox15Click(Sender: TObject);
begin
  if vbolchecked then
  SetCheckboxTag(15);
end;


procedure TfrmScheduler.CheckBox2Click(Sender: TObject);
begin
  if vbolchecked then
  SetCheckboxTag(2);
end;

procedure TfrmScheduler.CheckBox3Click(Sender: TObject);
begin
  if vbolchecked then
  SetCheckboxTag(3);
end;

procedure TfrmScheduler.CheckBox4Click(Sender: TObject);
begin
  if vbolchecked then
  SetCheckboxTag(4);
end;

procedure TfrmScheduler.CheckBox5Click(Sender: TObject);
begin
  if vbolchecked then
  SetCheckboxTag(5);
end;

procedure TfrmScheduler.CheckBox6Click(Sender: TObject);
begin
  if vbolchecked then
  SetCheckboxTag(6);
end;

procedure TfrmScheduler.CheckBox7Click(Sender: TObject);
begin
  if vbolchecked then
  SetCheckboxTag(7);
end;

procedure TfrmScheduler.CheckBox8Click(Sender: TObject);
begin
  if vbolchecked then
  SetCheckboxTag(8);
end;

procedure TfrmScheduler.CheckBox9Click(Sender: TObject);
begin
  if vbolchecked then
  SetCheckboxTag(9);
end;

//done when the scrollbar moves so that when the enitity was checked it will
//still be checked when you scroll back
procedure tfrmScheduler.resetCheckBoxChecks(Start: integer);
var
  vintloop: Integer;
begin
  vbolchecked:=false;
  vintloop:=Start;
  while vintloop<=Start+14 do
  begin
    if vstrlistEntitiesChecked.Strings[vintloop-1]<>'0' then
    begin
      checkboxes[vintloop-start+1].checked:=true;
    end
    else
      checkboxes[vintloop-start+1].checked:=false;
    inc(vintloop);
  end;
  vbolchecked:=true;
end;

//done when sheduling a appt
procedure TfrmScheduler.cmdScheduleClick(Sender: TObject);
var
  varrlist: array[0..19] of longint;
  vintloop, vintLoop2, vintloop3, vintPhysician, vintTime: integer;
  vboltest: boolean;
begin
  for vintLoop:= 0 to 19 do
     varrList[vintLoop]:=0;
  //do this only if an unsheduled apt is selected
  if (lstunscheduled.selected <> nil) then
  begin
    vboltest:=false;
    dtmScheduler.qryUnScheduled.first;
    dtmScheduler.qryUnScheduled.MoveBy(lstUnscheduled.Selected.Index);
    vintloop:=0;
    vintLoop2:=0;
    //find out what entities are checked and if any of them can be sheduled
    //  at that time
    While vintloop<vintnumEntities do
    begin
      if vstrlistentitieschecked.Strings[vintloop] <> '0' then
      begin
        vintloop3:=0;
        while vintloop3<=lstTime.Selection.right-lstTime.Selection.left do
          begin
          vintPhysician:=
                    IndexOfEntityNum(vstrlistentitieschecked.strings[vintloop]);
          vintTime:= lstTime.Selection.left
                     + dtmScheduler.vintStartPoint
                     + vintloop3;
          if (dtmScheduler.varrDayschedule[vintPhysician,vintTime,1]<>0)
            and (dtmScheduler.varrDayschedule[vintPhysician,vintTime,2]<>0)
            and (dtmScheduler.varrDayschedule[vintPhysician,vintTime,3]<>0) then
            begin
            MessageDlg('Please select a different time slot.  The entity "' +
                dtmScheduler.varrName[vintPhysician] +
                '" schedule is full.',mtError,[mbOK],0);
           exit;
          end;
          inc(vintloop3);
        end;
        vboltest:=true;
        varrlist[vintLoop2]:=
                            strtoint(vstrlistentitieschecked.strings[vintloop]);
        inc(vintLoop2);
      end;
      inc(vintloop);
    end;

    if not vboltest then
    begin
      MessageDlg('You Must Select at Least one Entity!',mtError,[mbOK],0);
      exit;
    end;
    //shedule the appt
    dtmScheduler.ScheduleAppointment(lstTime.Selection.left
                                    + dtmScheduler.vintStartPoint,
              dtmScheduler.vdatScheduleDate,
              15+(15*(lsttime.selection.Right - lsttime.selection.left)),
              txtComplaint.text,
              txtComDes.text,
              varrlist);
    //redraw the bars with the new appt
    drawScheduleBars;
    //refill the unscheduled list without the sheduled appt
    fillUnscheduledList;
    //nothing is selected so empty the edit boxes
    txtname.items.clear;
    txthousehold.text:='';
    lblPatientBalance.Caption:= '';
    lblAnnualAppointment.Caption:= '';
    txtcomplaint.text:='';
    txtcomDes.Text:='';
    txtComplaint.readonly:= true;
    txtComDes.readonly:= true;
    cmdHousehold.Enabled:=false;
    cmdPatient.Enabled:=false;
    cmdAppointment.Enabled:=false;
    cmdUnschedule.Enabled:=false;
    cmdSchedule.Enabled:=false;
    //clearchecks;
    //make sure if a bar on the image is selected that now it is unselected
    if vbolselected then
      unselectScheduler;
    vbolselected:=false;
    {Force the refresh of the appt data on next schedule click event}
    vintCheckAppt:= 0;
  end;
end;

//used to draw the bars on the shedule image
procedure TfrmScheduler.drawScheduleBars;
var
  vintloop, vintLoop2, vtop, vleft, vleft2: Integer;
  //vstrReuse: string;
begin
  vbolclick:=false;
  imgSchedule.Canvas.Pen.Width := 1;
  imgSchedule.Canvas.Rectangle(imgSchedule.left-1,
                               imgSchedule.top-1,
                               imgSchedule.width+1,
                               imgSchedule.height+1);
  //change font and size so the text will fit
  imgSchedule.Canvas.font.Name:='MS Serif';
  imgSchedule.Canvas.font.Size:=6;
  for vintLoop:= 1 to 50 do
    for vintLoop2:= 1 to 96 do
        If dtmScheduler.varrDayDuration[vintLoop, vintLoop2] > 0 then
           begin
           vLeft:= 13 * (vintLoop2 - dtmScheduler.vintStartPoint) + 1;
           vLeft2:= (dtmScheduler.varrDayDuration[vintLoop, vintLoop2]
                         div 15)*13-2;
           vTop:= (14 * (vintLoop-1)) + 1;
           If dtmScheduler.varrDaySchedule[vintLoop, vintLoop2, 2] <> 0 then
            begin
            imgSchedule.Canvas.Pen.color:= clRed;
            imgSchedule.Canvas.Rectangle(vleft-1,vtop+3,vleft+vleft2+1,vtop+17);
            imgSchedule.Canvas.Pen.color:= clBlack;
            end;                    
           imgSchedule.Canvas.Rectangle(vleft,vtop+4,vleft+vleft2,vtop+16 );
           end;
  vbolclick:=true;
end;

//clear all of the checks
procedure TfrmScheduler.clearchecks;
var
  vintloop: integer;
begin
  vintloop:=1;
  while vintloop<=15 do
  begin
    checkboxes[vintloop].checked:=false;
    inc(vintloop);
  end;
end;

//used to fin the index of the eninty in the varrName
function TfrmScheduler.IndexOfEntity(cstr : String):integer;
var
  vintloop: integer;
begin
  vintloop:=1;
  while dtmScheduler.varrName[vintloop]<> cstr do
    inc(vintloop);
  Result:=vintloop-2;
end;

//used to find the index of the enitity in the varrentity
function TfrmScheduler.IndexOfEntityNum (cstr : String):integer;
var
  vintloop: integer;
begin
  vintloop:=1;
  while dtmScheduler.varrEntity[vintloop]<> StrToInt(cstr) do
    inc(vintloop);
  Result:=vintloop;
end;

//used to select the sheduled appt on the image and fill in the data in the
//edit boxes
procedure TfrmScheduler.imgScheduleMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  vintentnum: integer;
begin
  if vbolclick then
  begin
    //find the index of the slot being selected
    vinty:=(y-3) div 14 + 1;
    vintx:=x div 13 + dtmScheduler.vintStartPoint;
    //check if there is an appt in that slot
    if dtmScheduler.varrDaySchedule[vinty, vintx, 1]<> 0 then
    begin
      dtmScheduler.tblAppointmentTicket.findkey
                                ([dtmScheduler.varrDaySchedule[vinty,vintx,1]]);
      txtName.items.clear;
      dtmScheduler.tblEntity.locate('entity',
          dtmScheduler.tblAppointmentTicket.fieldByName('Entity').asinteger,[]);
      lblPatientBalance.Caption:= Format('Balance %m',
               [dtmscheduler.tblPatient.fieldbyname('PatientBalance').asfloat]);
      FindAnnualAppointments;
      vintCallPatient:=dtmScheduler.tblEntity.fieldbyName('Entity').asinteger;
      vintCallHousehold:=
                dtmScheduler.tblEntity.fieldbyname('EntityHousehold').asinteger;
      vintCallAppointment:=
          dtmScheduler.tblAppointmentTicket.fieldbyName('Apptticket').asinteger;
      vreaCallDateTime:=
       dtmScheduler.tblAppointmentTicket.fieldbyname('ApptDateTime').asdatetime;
      txtName.items.Add(
               dtmScheduler.tblEntity.fieldbyname('EntityDescription').asstring
               + ' (' +
               dtmScheduler.tblEntity.fieldbyname('Entity').asstring + ')');
      txtName.ItemIndex:= 0;
      txtName.Tag:=
          dtmScheduler.tblAppointmentTicket.FieldByname('ApptTicket').asinteger;
      txtComplaint.ReadOnly:= true;
      txtComDes.ReadOnly:= true;
      txtcomplaint.text:=
              dtmScheduler.tblAppointmentTicket.FieldByname
                                                     ('ApptComplaint').asstring;
      txtcomDes.text:=
          dtmScheduler.tblAppointmentTicket.fieldByname
                                                 ('ApptComplaintText').asstring;
      dtmScheduler.tblEntity.locate('Entity',
          dtmScheduler.tblEntity.fieldbyname('EntityHousehold').asinteger,[]);
      txthousehold.text:=
          dtmScheduler.tblEntity.fieldbyName('EntityDescription').asstring;
      dtmScheduler.tblEntity.fieldbyName('EntityDescription').asstring;
      vintCheckAppt:=
                dtmScheduler.tblAppointmentTicket.fieldbyname
                                                       ('ApptTicket').asinteger;
      If dtmScheduler.varrDaySchedule[vinty,vintx,2] <> 0 then
         If dtmScheduler.tblAppointmentTicket.findkey
                            ([dtmScheduler.varrDaySchedule[vinty,vintx,2]]) then
            If dtmScheduler.tblEntity.locate('entity',
                 dtmScheduler.tblAppointmentTicket.fieldByName
                                                   ('Entity').asinteger,[]) then
               txtName.items.Add(
                dtmScheduler.tblEntity.fieldbyname('EntityDescription').asstring
                   + ' (' +
                   dtmScheduler.tblEntity.fieldbyname('Entity').asstring + ')');
      If dtmScheduler.varrDaySchedule[vinty,vintx,3] <> 0 then
         If dtmScheduler.tblAppointmentTicket.findkey
                            ([dtmScheduler.varrDaySchedule[vinty,vintx,3]]) then
            If dtmScheduler.tblEntity.locate('entity',
                 dtmScheduler.tblAppointmentTicket.fieldByName
                                                   ('Entity').asinteger,[]) then
               txtName.items.Add(
                dtmScheduler.tblEntity.fieldbyname('EntityDescription').asstring
                   + ' (' +
                   dtmScheduler.tblEntity.fieldbyname('Entity').asstring + ')');
      lstUnscheduled.Selected:=nil;
      //clear the last selected bar if one was slected
      if vbolselected then
        unselectScheduler;
      //used to undo the slection of a bar at these positions
      varrlastSelected[1]:=vinty;
      varrlastSelected[2]:=vintx;
      //set the color of the slection then select the bar and then put the
      //color back
      imgSchedule.Canvas.Brush.Color:=clteal;
      unselectScheduler;
      imgSchedule.Canvas.Brush.Color:=clwhite;

      clearchecks;
      dtmScheduler.tblScheduleEntity.MasterSource:= nil;
      dtmScheduler.tblScheduleEntity.MasterFields:= '';
      dtmScheduler.tblScheduleEntity.setrange(
                  [dtmScheduler.varrDaySchedule[vinty,vintx,1]],
                  [dtmScheduler.varrDaySchedule[vinty,vintx,1]]);
      dtmScheduler.tblScheduleEntity.First;
      while not dtmScheduler.tblScheduleEntity.EOF do
      begin
        Scrollbar1.Position:=1;
        vintentnum:=IndexOfEntitynum(
                 dtmScheduler.tblScheduleEntity.FieldByName('Entity').asstring);
        if vintentnum <= 20 then
        begin
          checkboxes[vintentnum].checked:=true;
        end
        else
          vstrlistEntitiesChecked.Strings[vintentnum]:=inttostr(vintentnum);

        dtmScheduler.tblScheduleEntity.next;
      end;
      dtmScheduler.tblScheduleEntity.cancelrange;
      dtmScheduler.tblScheduleEntity.MasterSource:= dtmScheduler.dtsAppointment;
      dtmScheduler.tblScheduleEntity.MasterFields:= 'ApptTicket';

      cmdHousehold.Enabled:=true;
      cmdPatient.Enabled:=true;
      cmdAppointment.Enabled:=true;
      cmdUnschedule.Enabled:=true;
      cmdSchedule.Enabled:=false;
      vbolselected:=true;
    end;
  end;
end;

//used to unshedule an appt that was already sheduled
procedure TfrmScheduler.cmdUnscheduleClick(Sender: TObject);
begin
  if txtname.tag<>0 then
  begin
    dtmScheduler.tblAppointmentTicket.findkey([txtname.tag]);
    //unshedule the appt
    dtmScheduler.UnScheduleAppointment(txtname.tag);
    //redraw the bars without the appt
    drawScheduleBars;
    //refill the unsheduled list with the unsheduled appt
    fillunscheduledlist;
    //deselect everything and clear the boxes
    txtname.items.clear;
    txthousehold.text:='';
    lblPatientBalance.Caption:= '';
    lblAnnualAppointment.Caption:= '';
    txtcomplaint.text:='';
    txtcomDes.Text:='';
    txtcomplaint.readonly:= true;
    txtcomDes.readonly:=true;
    cmdHousehold.Enabled:=false;
    cmdPatient.Enabled:=false;
    cmdAppointment.Enabled:=false;
    cmdSchedule.Enabled:=false;
    cmdunschedule.Enabled:=false;
    clearchecks;
    //if a bar was selected unselect it
    vbolselected:=false;
    vintCheckAppt:= 0;
  end;
end;

//set the data for the new date in the edit box
procedure TfrmScheduler.cmdSetDateClick(Sender: TObject);
begin
  fillUnscheduledList;
  dtmScheduler.vdatScheduleDate:= int(datCalendar.date);
//  lbl_10010.caption:= GetDayText(dtmScheduler.vdatScheduleDate);
  dtmScheduler.InitializeDayScheduler;
  dtmScheduler.LoadDayScheduler;
  drawSchedulebars;
  //make sure they cant add appts before today
  if dtmScheduler.vdatScheduleDate<date then
    cmdSchedule.enabled:=false
  else
    cmdSchedule.enabled:=true;

  txtname.items.clear;
  txthousehold.text:='';
  lblPatientBalance.Caption:= '';
  lblAnnualAppointment.Caption:= '';
  txtcomplaint.text:='';
  txtcomDes.Text:='';
  txtcomplaint.readonly:=true;
  txtcomDes.readonly:=true;
  clearchecks;
  cmdHousehold.Enabled:=false;
  cmdPatient.Enabled:=false;
  cmdAppointment.Enabled:=false;
  cmdUnschedule.Enabled:=false;
  cmdSchedule.Enabled:=false;
end;

//redraw the bar that is being selected or unselected
procedure TfrmScheduler.unselectScheduler;
begin
  dtmScheduler.tblAppointmentTicket.findkey
   ([dtmScheduler.varrDaySchedule[varrlastselected[1],varrlastselected[2],1]]);
  imgSchedule.Canvas.Rectangle
          {param1}
          (13* (dtmScheduler.TimetoArray(
             dtmScheduler.tblAppointmentTicket.fieldbyname
                             ('ApptDateTime').asdatetime)
                               - dtmScheduler.vintStartPoint) + 1,
          {param2}
          (varrlastselected[1]-1) * 14 + 5,
          {param3}
           13 * (dtmScheduler.TimetoArray(
             dtmScheduler.tblAppointmentTicket.fieldbyname
                           ('ApptDateTime').asdatetime)
                               - dtmScheduler.vintStartPoint) + 1 +
                  ((dtmScheduler.tblAppointmentTicket.fieldbyname
                                                     ('ApptDuration').asinteger)
                                    div 15)*13-2,
          {param4}
          (varrlastselected[1]-1)*14+17);
end;

//set that the mouse is down and ready for draging
procedure TfrmScheduler.lstTimeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  vbolmousedown:=true;
end;

//done when draging moves the time bar in dragged direction
procedure TfrmScheduler.lstTimeMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
  begin
  if vbolmousedown then
  begin
    if (x >= pnlTime.width-lsttime.left) and vbolmousefar then
    begin
      scrollbar2.Position:=scrollbar2.position+1;
      vbolmousefar:=false;
    end
    else if (x<=-lsttime.left) and vbolmousefar then
    begin
      scrollbar2.Position:=scrollbar2.position-1;
      vbolmousefar:=false;
    end
    else
      vbolmousefar:=true;
  end;
end;

//set that the mouse is now up and not dragging anymore
procedure TfrmScheduler.lstTimeMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  vbolmousedown:=false;
  vbolmousefar:=false;
end;

procedure TfrmScheduler.cmdAppointmentClick(Sender: TObject);
var vbolDummy: boolean;
begin
  vintCurrentApptTicket := vintCallAppointment;
  vintCurrentEntity := vintCallPatient;
  {This is the sneaky way to cann a routine in a form that created you!}
  vbolDummy := false;
  vfrmMainMenu.onclosequery(Sender, vbolDummy);
end;

procedure TfrmScheduler.cmdPatientClick(Sender: TObject);
var vbolDummy: boolean;
begin
  vintCurrentEntity := vintCallPatient;
  {This is the sneaky way to cann a routine in a form that created you!}
  vbolDummy := false;
  vfrmMainMenu.onclosequery(Sender, vbolDummy);
end;

procedure TfrmScheduler.cmdHouseholdClick(Sender: TObject);
var vbolDummy: boolean;
begin
  vintCurrentEntity := vintCallHousehold;
  {This is the sneaky way to cann a routine in a form that created you!}
  vbolDummy := false;
  vfrmMainMenu.onclosequery(Sender, vbolDummy);
end;

procedure TfrmScheduler.FormActivate(Sender: TObject);
begin
If vbolReport then exit;
fillUnscheduledList;
//datCalendar.date:= date;
//lbl_10010.caption:= GetDayText(strtodate(edtDate.text));
// This is the the password controller
If not vbolFirst then
   begin
   vbolFirst:=true;
   If not ShowPassword then
       close;
   end;
end;

procedure TfrmScheduler.datCalendarEnter(Sender: TObject);
begin
//datCalandar.Date := date;
end;

{The Schedule table represented by vqryQuickReport has all valid times and
triggers the report print band to print all times even if there is not appt.
vqryQuickReport2 is the list of appointments for the physician for the day}
procedure TfrmScheduler.cmdSinglePrintClick(Sender: TObject);

begin
If lstEntity.SelCount = 0 then
  lstEntity.Items[0].Selected := true;

If vintDocEntity = 0 then
   begin
   showmessage
          ('Select the Entity for the report from the list on the left margin');
   exit;
   end;
vqryQuickReport:= tquery.create(nil);
vqryQuickReport2:= tquery.create(nil);

try
 vqryQuickReport2.DatabaseName:= 'mmom_maindatabase';
 vqryQuickReport2.SQL.Add('Select Distinct Appointment.ApptDateTime, ' +
                                    'Appointment.ApptComplaint, ' +
                                    'Appointment.ApptDuration, ' +
                                    'Entity.Entity as Patient, ' +
                                    'Entity.EntityDescription, ' +
                                    'ScheduleEntity.Entity');
 vqryQuickReport2.SQL.Add('from Appointment, Entity, ScheduleEntity');
 vqryQuickReport2.SQL.Add
              ('Where (CAST(ApptDateTime AS DATE) = "'
                             + datetostr(dtmScheduler.vdatScheduleDate) + '")');
 vqryQuickReport2.SQL.Add
              ('and (Appointment.Entity = Entity.Entity)');
 vqryQuickReport2.SQL.Add
              ('and (Appointment.ApptTicket = ScheduleEntity.ApptTicket)');

 vqryQuickReport2.SQL.Add('and (Appointment.ApptScheduled = true)');
 vqryQuickReport2.SQL.Add('and (ScheduleEntity.Entity = '
                                               + inttostr(vintDocEntity) + ')');
 vqryQuickReport2.open;
 vqryQuickReport.DatabaseName:= 'mmom_maindatabase';
 vqryQuickReport.SQL.Add('Select * from Schedule');
 vqryQuickReport.open;
 rptSchedule1 := trptSchedule1.Create(nil);
 try
   rptSchedule1.lbl_100009.caption:= lstEntity.Selected.Caption;
   rptSchedule1.lbl_100008.caption:= datetostr(dtmScheduler.vdatScheduleDate);
   rptSchedule1.DataSet := vqryQuickReport;
   rptSchedule1.bndDetails.DataSet := vqryQuickReport;
   rptSchedule1.lbl_ApptTime.DataSet := vqryQuickReport;
   rptSchedule1.Preview;
     finally
     rptSchedule1.free;
     rptSchedule1 := nil;
     end;
 finally
   vqryQuickReport.free;
   vqryQuickReport := nil;
   vqryQuickReport2.free;
   vqryQuickReport2 := nil;
   end;

end;

procedure TfrmScheduler.lstEntitySelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
If item.Caption > ' A' then
  begin
  vintDocEntity:= dtmScheduler.varrEntity[item.index + 1];
  end;
end;

procedure TfrmScheduler.cmdAllPrintClick(Sender: TObject);
begin
vqryQuickReport:= tquery.create(nil);
vqryQuickReport2:= tquery.create(nil);

try
 vqryQuickReport2.DatabaseName:= 'mmom_maindatabase';
 vqryQuickReport2.SQL.Add('Select Distinct Appointment.ApptDateTime, ' +
                                    'Appointment.ApptComplaint, ' +
                                    'Appointment.ApptDuration, ' +
                                    'Entity.EntityDescription, ' +
                                    'ScheduleEntity.Entity');
 vqryQuickReport2.SQL.Add('from Appointment, Entity, ScheduleEntity');
 vqryQuickReport2.SQL.Add
              ('Where (CAST(ApptDateTime AS DATE) = "'
                             + datetostr(dtmScheduler.vdatScheduleDate) + '")');
 vqryQuickReport2.SQL.Add
              ('and (Appointment.Entity = Entity.Entity)');
 vqryQuickReport2.SQL.Add
              ('and (Appointment.ApptTicket = ScheduleEntity.ApptTicket)');

 vqryQuickReport2.SQL.Add('and (Appointment.ApptScheduled = true)');
 vqryQuickReport2.open;
 vqryQuickReport.DatabaseName:= 'mmom_maindatabase';
 vqryQuickReport.SQL.Add('Select * from Schedule');
 vqryQuickReport.open;
 rptSchedule2 := trptSchedule2.Create(nil);
 try
   rptSchedule2.lbl_100008.caption:= datetostr(dtmScheduler.vdatScheduleDate);
   rptSchedule2.DataSet := vqryQuickReport;
   rptSchedule2.bndDetails.DataSet := vqryQuickReport;
   rptSchedule2.lbl_100003.DataSet := vqryQuickReport;
   rptSchedule2.Preview;
     finally
     rptSchedule2.free;
     rptSchedule2 := nil;
     end;
 finally
   vqryQuickReport.free;
   vqryQuickReport := nil;
   vqryQuickReport2.free;
   vqryQuickReport2 := nil;
   end;

end;

procedure TfrmScheduler.datCalanderCloseUp(Sender: TObject);
begin
//edtDate.text := datetostr(datCalander.date);
//lbl_10010.caption:= GetDayText(datCalander.date);
vbolselected:= false;
cmdSetDateClick(self);
end;

Function TfrmScheduler.GetDayText(const cdatDate: tdatetime): string;
var
  varrdays: array[1..7] of string;
begin
  varrdays[1] := 'Sunday';
  varrdays[2] := 'Monday';
  varrdays[3] := 'Tuesday';
  varrdays[4] := 'Wednesday';
  varrdays[5] := 'Thursday';
  varrdays[6] := 'Friday';
  varrdays[7] := 'Saturday';
  Result:= varrdays[DayOfWeek(cdatDate)];
end;

procedure TfrmScheduler.cmdNewApptClick(Sender: TObject);
begin
{Create a new appointment for the selected entity in the search list}
If dtmScheduler.qryEntity.recordcount > 0 then
  begin
  dtmScheduler.NewAppointment;
  fillUnscheduledList;
  end;
end;

procedure TfrmScheduler.edtSearchKeyPress(Sender: TObject; var Key: Char);
begin
If key = #13 then
   begin
   {Do the query and nullify the keystroke}
   dtmScheduler.qryEntity.close;
   If radSearch.Itemindex = 1 then
      dtmScheduler.qryEntity.sql[1] := 'Where EntityLastName like "' +
                                        edtSearch.text + '%"'
   else
      dtmScheduler.qryEntity.sql[1] := 'Where EntityFirstName like "' +
                                        edtSearch.text + '%"';
   dtmScheduler.qryEntity.open;
   Key := #00;
   end;
end;

procedure TfrmScheduler.txtNameClick(Sender: TObject);
begin
If txtName.Items.Count > 0 then
   begin
      dtmScheduler.tblEntity.locate('entity',
                strtoint(copy(txtName.items[txtName.ItemIndex],
                          pos('(',txtName.items[txtName.ItemIndex]) + 1,6)),[]);
      lblPatientBalance.Caption:= Format('Balance %m',
               [dtmscheduler.tblPatient.fieldbyname('PatientBalance').asfloat]);
      FindAnnualAppointments;
      vintCallPatient:=dtmScheduler.tblEntity.fieldbyName('Entity').asinteger;
      vintCallHousehold:=
                dtmScheduler.tblEntity.fieldbyname('EntityHousehold').asinteger;
      txtcomplaint.text:=
              dtmScheduler.tblAppointmentTicket.FieldByname
                                    ('ApptComplaint').asstring;
      txtcomDes.text:=
          dtmScheduler.tblAppointmentTicket.fieldByname
                                ('ApptComplaintText').asstring;
      dtmScheduler.tblEntity.locate('Entity',
            dtmScheduler.tblEntity.fieldbyname('EntityHousehold').asinteger,[]);
      txthousehold.text:=
               dtmScheduler.tblEntity.fieldbyName('EntityDescription').asstring;
      dtmScheduler.tblAppointmentTicket.findkey
            ([dtmScheduler.varrDaySchedule[vinty,vintx,txtName.ItemIndex + 1]]);
      vintCheckAppt:=
                dtmScheduler.tblAppointmentTicket.fieldbyname
                                                       ('ApptTicket').asinteger;
      vintCallAppointment:=
                dtmScheduler.tblAppointmentTicket.fieldbyName
                                                       ('Apptticket').asinteger;
      txtName.Tag:=
                dtmScheduler.tblAppointmentTicket.FieldByname
                                                       ('ApptTicket').asinteger;
      vreaCallDateTime:=
       dtmScheduler.tblAppointmentTicket.fieldbyname('ApptDateTime').asdatetime;
   end;
end;

{Hightlight the appointment and fill in the list of patients in the top section}
procedure TfrmScheduler.FormCreate(Sender: TObject);
begin
datCalendar.Date := Date;
vbolReport:= false;
end;

procedure TfrmScheduler.cmdPrintClick(Sender: TObject);
begin
mnuPrinting.Popup(mouse.cursorpos.x-160, mouse.cursorpos.y);
end;

procedure TfrmScheduler.cmdSingleApptPrintClick(Sender: TObject);
begin

  rptApptSumm := TrptApptSumm.Create(nil);
  rptApptSumm.page.TopMargin:= strtofloat(FillDefault('top_margin'));
  rptApptSumm.vintEntity:= vintCallPatient;
              //dtmScheduler.tblAppointmentTicket.fieldByName('Entity').asinteger;
  rptApptSumm.vdatApptDateTime := vreaCallDateTime;
             //dtmScheduler.tblAppointment.fieldbyname('ApptDateTime').asdatetime;
  try
    rptApptSumm.print;
  finally
    rptApptSumm.free;
    rptApptSumm := nil;
  end;
end;

procedure TfrmScheduler.cmdAllAppointmentPrintClick(Sender: TObject);
  var vintDoctor, vintLoop: integer;
begin
  for vintLoop:= 0 to lstEntity.Items.Count - 1 do
    If checkboxes[vintLoop+1].Checked then
       begin
       vintDoctor:= dtmScheduler.varrEntity[vintLoop+1];
       break;
       end;
  rptApptSumm := TrptApptSumm.Create(nil);
  try
    vbolReport:= true;
    rptApptSumm.page.TopMargin:= strtofloat(FillDefault('top_margin'));
    dtmScheduler.tblAppointment.First;
    while not dtmScheduler.tblAppointment.Eof do
      begin
     if dtmScheduler.tblScheduleEntity['Entity'] = vintDoctor then
       begin
       dtmScheduler.tblEntity.findkey(
         [dtmScheduler.tblAppointment.fieldByName('Entity').asinteger]);
       rptApptSumm.vintEntity:=
              dtmScheduler.tblAppointment.fieldByName('Entity').asinteger;
       rptApptSumm.vdatApptDateTime :=
             dtmScheduler.tblAppointment.fieldbyname('ApptDateTime').asdatetime;
       //rptApptSumm.preview;
       rptApptSumm.print;
       end;
      dtmScheduler.tblAppointment.next;
      end;
  finally
     rptApptSumm.free;
     rptApptSumm := nil;
     vbolReport:= false;
     end;
  dtmScheduler.tblAppointment.first;
end;

procedure TfrmScheduler.imgScheduleMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
    //find the index of the slot being selected
    vinty:=(y-3) div 14 + 1;
    vintx:=x div 13 + dtmScheduler.vintStartPoint;
    //check if there is an appt in that slot
    if dtmScheduler.varrDaySchedule[vinty, vintx, 1] <> 0 then
      begin
      If dtmScheduler.varrDaySchedule[vinty, vintx, 1] = vintLastHover then
         exit;
      vintLasthover:= dtmScheduler.varrDaySchedule[vinty, vintx, 1];
      dtmScheduler.tblAppointmentTicket.findkey([vintLasthover]);
      dtmScheduler.tblEntity.locate('entity',
          dtmScheduler.tblAppointmentTicket.fieldByName('Entity').asinteger,[]);
      lblPatientName.caption :=
               dtmScheduler.tblEntity.fieldbyname('EntityDescription').asstring;
      lblPatientName.Left := x;
      if lblPatientName.left > 500 then
         lblPatientName.left := 500;
      lblPatientName.top := y + 15;
      lblPatientName.visible:= true;
      end
    else
      begin
      lblPatientName.visible:= false;
      vintLasthover:= 0;
      end;

end;
procedure TfrmScheduler.tmrClockTimer(Sender: TObject);
begin
edtTime.text := formatdatetime('hh:mm AM/PM', time);
If time < vreaStart then
  linTime.visible:= false
else
  begin
  linTime.left := round((time - vreastart) * 1250);
  linTime.visible:= true;
  dtmScheduler.InitializeDayScheduler;
  dtmScheduler.LoadDayScheduler;
  drawSchedulebars;
  end;
end;

procedure TfrmScheduler.FindAnnualAppointments;
var
  Year, Month, Day: Word;
  datFrom, datTo: tdatetime;
  vintThisYear: integer;
begin
    DecodeDate(datcalendar.Date, Year, Month, Day);
    If Month < 7 then year := year - 1;
    datFrom:= encodedate(year,07,01);
    datTo:= encodedate(year+1,07,01);
    dtmscheduler.tblApptYear.setrange
                  ([dtmscheduler.tblPatient.fieldbyname('Entity').asstring],
                   [dtmscheduler.tblPatient.fieldbyname('Entity').asstring]);
    dtmscheduler.tblApptYear.first;
    vintThisYear:= 0;
    while not dtmscheduler.tblApptYear.eof do
       begin
       if (dtmscheduler.tblApptYear.fieldbyname('ApptDateTime').asdatetime
                                                                >= datFrom) and
           (dtmscheduler.tblApptYear.fieldbyname('ApptDateTime').asdatetime
                                                                  < datTo) then
           inc(vintThisYear);
       dtmscheduler.tblApptYear.next;
       end;
    lblAnnualAppointment.Caption:= Format('Appt/Year %3.0f',
               [vintThisYear + 0.0001]);
end;

end.
