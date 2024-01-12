unit formICD9ads;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ToolWin, ComCtrls;

type
  Tfrm1 = class(TForm)
    tbr1: TToolBar;
    pnl1: TPanel;
    cmdSave: TSpeedButton;
    lst1: TListBox;
    edtAd: TEdit;
    edtFileName: TEdit;
    edtRedirect: TEdit;
    edtImpress: TEdit;
    edtOverride: TEdit;
    cmdAdd: TSpeedButton;
    cmdDelete: TSpeedButton;
    Splitter1: TSplitter;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    rad1: TRadioGroup;
    rad2: TRadioGroup;
    lbl6: TLabel;
    edtSearch: TEdit;
    lbl7: TLabel;
    edtText: TEdit;
    rad3: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lst1Click(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdDeleteClick(Sender: TObject);
    procedure cmdAddClick(Sender: TObject);
    procedure edtAdChange(Sender: TObject);
    procedure edtFileNameChange(Sender: TObject);
    procedure edtRedirectChange(Sender: TObject);
    procedure edtImpressChange(Sender: TObject);
    procedure edtOverrideChange(Sender: TObject);
    procedure rad1Click(Sender: TObject);
    procedure edtTextChange(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure rad3Click(Sender: TObject);
    procedure rad2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm1: Tfrm1;
   vstlAds: tstringlist;
implementation

{$R *.DFM}

procedure Tfrm1.FormCreate(Sender: TObject);
var vintLoop: integer;
begin
vstlAds:= tstringlist.create;
vstlAds.Loadfromfile('mudsox_adfile.txt');
for vintLoop:= 0 to vstlAds.count - 1 do
   lst1.Items.Add(copy(vstlAds[vintLoop],
                  4,
                  pos('^2^', vstlAds[vintLoop]) - 4));
end;

procedure Tfrm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
vstlAds.free;
end;

procedure Tfrm1.lst1Click(Sender: TObject);
begin
   edtAd.text:= copy(vstlAds[lst1.itemindex],
                  4,
                  pos('^2^', vstlAds[lst1.itemindex]) - 4);
   edtFileName.text:= copy(vstlAds[lst1.itemindex],
                  pos('^2^', vstlAds[lst1.itemindex]) + 3,
                  pos('^3^', vstlAds[lst1.itemindex]) - 3
                                         - pos('^2^', vstlAds[lst1.itemindex]));
   edtRedirect.text:= copy(vstlAds[lst1.itemindex],
                  pos('^3^', vstlAds[lst1.itemindex]) + 3,
                  pos('^4^', vstlAds[lst1.itemindex]) - 3
                                         - pos('^3^', vstlAds[lst1.itemindex]));
   edtImpress.text:= copy(vstlAds[lst1.itemindex],
                  pos('^4^', vstlAds[lst1.itemindex]) + 3,
                  pos('^5^', vstlAds[lst1.itemindex]) - 3
                                         - pos('^4^', vstlAds[lst1.itemindex]));
   edtText.text:= copy(vstlAds[lst1.itemindex],
                  pos('^5^', vstlAds[lst1.itemindex]) + 3,
                  pos('^6^', vstlAds[lst1.itemindex]) - 3
                                         - pos('^5^', vstlAds[lst1.itemindex]));
   edtOverride.text:= copy(vstlAds[lst1.itemindex],
                  pos('^6^', vstlAds[lst1.itemindex]) + 3,
                  pos('^7^', vstlAds[lst1.itemindex]) - 3
                                         - pos('^6^', vstlAds[lst1.itemindex]));
   edtSearch.text:= copy(vstlAds[lst1.itemindex],
                  pos('^7^', vstlAds[lst1.itemindex]) + 3,
                  pos('^8^', vstlAds[lst1.itemindex]) - 3
                                         - pos('^7^', vstlAds[lst1.itemindex]));

   If copy(vstlAds[lst1.itemindex],
                  pos('^8^', vstlAds[lst1.itemindex]) + 3,
                  1) = 'S' then
        rad1.ItemIndex:= 0
   else
        rad1.Itemindex:= 1;
   If copy(vstlAds[lst1.itemindex],
                  pos('^9^', vstlAds[lst1.itemindex]) + 3,
                  1) = 'T' then
        rad2.ItemIndex:= 0
   else
        rad2.Itemindex:= 1;
   If copy(vstlAds[lst1.itemindex],
                  pos('^10^', vstlAds[lst1.itemindex]) + 4,
                  1) = 'T' then
        rad3.ItemIndex:= 0
   else
        rad3.Itemindex:= 1;
end;

procedure Tfrm1.cmdSaveClick(Sender: TObject);
begin
vstlAds.savetofile('mudsox_adfile.txt');
end;

procedure Tfrm1.cmdDeleteClick(Sender: TObject);
begin
If lst1.itemindex < 0 then exit;
vstlAds.Delete(lst1.itemindex);
lst1.items.delete(lst1.ItemIndex);
edtAd.text:= '';
edtFileName.text:= '';
edtRedirect.text:= '';
edtImpress.text:= '';
edtText.text:= '';
edtOverride.text:= '';
edtSearch.text:= '';
rad1.Itemindex:= -1;
rad2.Itemindex:= -1;
rad3.Itemindex:= -1;
end;

procedure Tfrm1.cmdAddClick(Sender: TObject);
begin
vstlAds.add('');
lst1.items.add('NEW');
lst1.itemindex:= lst1.items.count-1;
edtAd.text:= '';
edtFileName.text:= '';
edtRedirect.text:= '';
edtImpress.text:= '';
edtText.text:= '';
edtOverride.text:= '';
edtSearch.text:= '';
rad1.Itemindex:= -1;
rad2.Itemindex:= -1;
rad3.Itemindex:= -1;
end;

procedure Tfrm1.edtAdChange(Sender: TObject);
begin
If lst1.itemindex = -1 then exit;
  vstlAds[lst1.itemindex]:= copy(vstlAds[lst1.itemindex], 1, 3) + edtAd.text +
         copy(vstlAds[lst1.itemindex], pos('^2^', vstlAds[lst1.itemindex]),999);
end;

procedure Tfrm1.edtFileNameChange(Sender: TObject);
begin
If lst1.itemindex = -1 then exit;
vstlAds[lst1.itemindex]:=
       copy(vstlAds[lst1.itemindex], 1, pos('^2^', vstlAds[lst1.itemindex]) + 2)
       + edtFileName.text +
       copy(vstlAds[lst1.itemindex], pos('^3^', vstlAds[lst1.itemindex]),999);
end;

procedure Tfrm1.edtRedirectChange(Sender: TObject);
begin
If lst1.itemindex = -1 then exit;
   vstlAds[lst1.itemindex]:=
       copy(vstlAds[lst1.itemindex], 1, pos('^3^', vstlAds[lst1.itemindex]) + 2)
       + edtRedirect.text +
       copy(vstlAds[lst1.itemindex], pos('^4^', vstlAds[lst1.itemindex]),999);
end;

procedure Tfrm1.edtImpressChange(Sender: TObject);
begin
If lst1.itemindex = -1 then exit;
   vstlAds[lst1.itemindex]:=
       copy(vstlAds[lst1.itemindex], 1, pos('^4^', vstlAds[lst1.itemindex]) + 2)
       + edtImpress.text +
       copy(vstlAds[lst1.itemindex], pos('^5^', vstlAds[lst1.itemindex]),999);
end;

procedure Tfrm1.edtTextChange(Sender: TObject);
begin
If lst1.itemindex = -1 then exit;
   vstlAds[lst1.itemindex]:=
       copy(vstlAds[lst1.itemindex], 1, pos('^5^', vstlAds[lst1.itemindex]) + 2)
       + edtText.text +
       copy(vstlAds[lst1.itemindex], pos('^6^', vstlAds[lst1.itemindex]),999);
end;

procedure Tfrm1.edtOverrideChange(Sender: TObject);
begin
If lst1.itemindex = -1 then exit;
   vstlAds[lst1.itemindex]:=
       copy(vstlAds[lst1.itemindex], 1, pos('^6^', vstlAds[lst1.itemindex]) + 2)
       + edtOverride.text +
       copy(vstlAds[lst1.itemindex], pos('^7^', vstlAds[lst1.itemindex]),999);
end;

procedure Tfrm1.edtSearchChange(Sender: TObject);
begin
If lst1.itemindex = -1 then exit;
   vstlAds[lst1.itemindex]:=
       copy(vstlAds[lst1.itemindex], 1, pos('^7^', vstlAds[lst1.itemindex]) + 2)
       + edtSearch.text +
       copy(vstlAds[lst1.itemindex], pos('^8^', vstlAds[lst1.itemindex]),999);
end;

procedure Tfrm1.rad1Click(Sender: TObject);
begin
If lst1.itemindex = -1 then exit;
 If rad1.itemindex = 0 then
   vstlAds[lst1.itemindex]:=
       copy(vstlAds[lst1.itemindex], 1, pos('^8^', vstlAds[lst1.itemindex]) + 2)
       + 'S' +
       copy(vstlAds[lst1.itemindex], pos('^9^', vstlAds[lst1.itemindex]),999)
 else
   vstlAds[lst1.itemindex]:=
       copy(vstlAds[lst1.itemindex], 1, pos('^8^', vstlAds[lst1.itemindex]) + 2)
       + 'L' +
       copy(vstlAds[lst1.itemindex], pos('^9^', vstlAds[lst1.itemindex]),999);
end;

procedure Tfrm1.rad2Click(Sender: TObject);
begin
If lst1.itemindex = -1 then exit;
 If rad2.itemindex = 0 then
   vstlAds[lst1.itemindex]:=
       copy(vstlAds[lst1.itemindex], 1, pos('^9^', vstlAds[lst1.itemindex]) + 2)
       + 'T' +
       copy(vstlAds[lst1.itemindex], pos('^10^', vstlAds[lst1.itemindex]),999)
 else
   vstlAds[lst1.itemindex]:=
       copy(vstlAds[lst1.itemindex], 1, pos('^9^', vstlAds[lst1.itemindex]) + 2)
       + 'B' +
       copy(vstlAds[lst1.itemindex], pos('^10^', vstlAds[lst1.itemindex]),999);
end;

procedure Tfrm1.rad3Click(Sender: TObject);
begin
If lst1.itemindex = -1 then exit;
 If rad3.itemindex = 0 then
   vstlAds[lst1.itemindex]:=
     copy(vstlAds[lst1.itemindex], 1, length(vstlAds[lst1.itemindex]) -1) + 'T'
 else
   vstlAds[lst1.itemindex]:=
     copy(vstlAds[lst1.itemindex], 1, length(vstlAds[lst1.itemindex]) -1) + 'A'
end;

end.
