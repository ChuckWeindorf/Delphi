unit formSchedule2;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TrptSchedule2 = class(TQuickRep)
    bndTitle: TQRBand;
    imgLogo2: TQRImage;
    imgLogo1: TQRImage;
    lbl_100007: TQRLabel;
    lbl_100008: TQRLabel;
    lbl_100001: TQRLabel;
    bndDetails: TQRSubDetail;
    lbl_100003: TQRDBText;
    box_1: TQRShape;
    box_2: TQRShape;
    box_3: TQRShape;
    box_4: TQRShape;
    box_5: TQRShape;
    box_6: TQRShape;
    box_7: TQRShape;
    box_8: TQRShape;
    box_9: TQRShape;
    box_10: TQRShape;
    QRBand1: TQRBand;
    lbl_000001: TQRLabel;
    lbl_20001: TQRLabel;
    lbl_20002: TQRLabel;
    lbl_20003: TQRLabel;
    lbl_20004: TQRLabel;
    lbl_20005: TQRLabel;
    lbl_20006: TQRLabel;
    lbl_20007: TQRLabel;
    lbl_20008: TQRLabel;
    lbl_20009: TQRLabel;
    lin_1: TQRShape;
    lin_2: TQRShape;
    lin_3: TQRShape;
    lin_4: TQRShape;
    lin_5: TQRShape;
    lin_6: TQRShape;
    lin_7: TQRShape;
    lin_8: TQRShape;
    lin_9: TQRShape;
    lbl_20010: TQRLabel;
    lin_10: TQRShape;
    lin_Time: TQRShape;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure bndDetailsBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    varrBoxes: array [1..10] of tQRshape;
    varrSlots: array [1..10] of integer;
  public
    constructor create(Aowner : TComponent); override;

  end;

var
  rptSchedule2: TrptSchedule2;

implementation

uses procSharedDatamoduleCalls, dataScheduler;

{$R *.DFM}
constructor TrptSchedule2.Create(AOwner: TComponent);
begin
  {Create all form components and other start-up activities}
  Inherited create(AOwner);
  imgLogo1.Picture.LoadFromFile(vstrApplicationDirectory +
                                                'Pictures\Mheds_no_border.bmp');
  imgLogo2.Picture.LoadFromFile(vstrApplicationDirectory +
                                               'Pictures\Mheds2_no_border.bmp');
end;

procedure TrptSchedule2.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
var vintLoop1, vintLoop2: integer;
begin
  varrBoxes[1] := box_1;
  varrBoxes[2] := box_2;
  varrBoxes[3] := box_3;
  varrBoxes[4] := box_4;
  varrBoxes[5] := box_5;
  varrBoxes[6] := box_6;
  varrBoxes[7] := box_7;
  varrBoxes[8] := box_8;
  varrBoxes[9] := box_9;
  varrBoxes[10] := box_10;
  for vintLoop1:= 1 to 10 do
    begin
    varrSlots[vintLoop1]:= 0;
    for vintLoop2:= 0 to rptSchedule2.ComponentCount - 1 do
      begin
      If rptSchedule2.Components[vintLoop2].Tag = vintLoop1 then
         begin
         If Components[vintLoop2] is TQRlabel then
            If dtmScheduler.varrEntity[vintLoop1] > 0 then
               TQRlabel(Components[vintLoop2]).caption:=
                                                dtmScheduler.varrName[vintLoop1]
            else
               TQRlabel(Components[vintLoop2]).caption:= '';
         If Components[vintLoop2] is TQRShape then
            If dtmScheduler.varrEntity[vintLoop1] = 0 then
               TQRShape(Components[vintLoop2]).height := 0;
         end;
      end;
    end;
end;

procedure TrptSchedule2.bndDetailsBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var vreaDateTime: tdatetime;
    vintLoop: integer;
begin
vreaDateTime:= strtodate(lbl_100008.caption) +
               vqryQuickReport.fieldbyname('ApptTime').asdatetime;
for vintLoop:= 1 to 10 do
  begin
  If dtmScheduler.varrEntity[vintLoop] = 0 then
     begin
     lin_time.Width:= (vintLoop * 50);
     break;
     end;
  If varrSlots[vintLoop] > 0 then
     begin
     varrSlots[vintLoop]:= varrSlots[vintLoop] - 1;
     varrBoxes[vintLoop].brush.Color := clBlue;
     end
  else
  If vqryQuickReport2.locate('ApptDateTime;Entity',
              VarArrayOf([vreaDateTime, dtmScheduler.varrEntity[vintLoop]]),
              []) then
     begin
     varrBoxes[vintLoop].brush.Color := clBlue;
     try
     varrSlots[vintLoop]:=
      round((vqryQuickReport2.fieldbyName('ApptDuration').asinteger - 15) / 15);
       except
       varrSlots[vintLoop]:=0;
       end;
     end
  else
     varrBoxes[vintLoop].brush.Color := clWhite;
  end;

end;

end.
