unit formHarness;


{
Decode and tag the file in the following way:
^ and #170    Link
^ and #171    Include
^ and #172    Exclude
^ and #173    Notes
^ and #174    4 digit
^ and #175    5 digit
^ and #176    Chapter
^ and #177    Section
^ and #178    Verify- Lowest Level
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Buttons, ToolWin;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    memtext: TRichEdit;
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    memResult: TRichEdit;
    Edit1: TEdit;
    SpeedButton2: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton3: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    Procedure BoilTheFile(var vstlRaw, vstlRefined: tstringlist);
    Procedure CrossHatch(var vstlRefined, vstlPrefix: tstringlist);
    Procedure AddLinkTags(vstlRefined: tstringlist;
                             var vstrData: string;
                             const cintStartScan: integer);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  vbol764Code: boolean;

const
  cstrNeoPrefix: string =
               '^c^Malig nant: Primary^c^' +
               'Malig nant: Second ary^c^' +
               'Malig nant: Ca in situ^c^' +
               'Benign^c^' +
               'Uncer tain Behav ior^c^' +
               'Unspeci fied^|';

implementation

{$R *.DFM}

procedure TForm1.SpeedButton1Click(Sender: TObject);
var vstlDown, vstlUp, vstlPrefix: tstringlist;
    vdatTest: tdatetime;
begin
vstlDown:= tstringlist.create;
vstlUp:= tstringlist.create;
vstlPrefix:= tstringlist.create;
vstlDown.loadfromfile('.\ICD9CM03\DTAB03.txt');
{*********}
vdattest:= now;
{*********}
BoilTheFile(vstlDown, vstlUp);
vstlUP.add('=DONE=');
CrossHatch(vstlUp, vstlPrefix);
{*********}
vstlDown.SaveToFile('x.txt');
vstlUp.savetofile('ICD9Data.txt');
vstlPrefix.savetofile('ICD9Prefix.txt');
{*********}
edit1.text:= (floattostr((now - vdatTest)*86400));
edit1.update;
{*********}
memResult.Lines.loadfromfile('ICD9Data.txt');
memText.Lines.loadfromfile('ICD9Prefix.txt');
{*********}
vstlDown.free;
vstlUp.free;
vstlPrefix.free;

end;

procedure TForm1.BoilTheFile(var vstlRaw, vstlRefined: tstringlist);
var vintLoop: integer;
    vstrWork, vstrHold, vstrCode: string;
    vbolAppend, vbolFourthFifth: boolean;
  {In-procedure functions}
  {Test the Title Break}
  function TitleBreak: boolean;
    begin
    Result:= false;
    If copy(vstrWork,1,1) = '~' then
    else
    {Supplementary Chapters are identified here}
    If copy(vstrWork,1,13) = 'SUPPLEMENTARY' then
       Result:= true
    else
    If vstrWork = uppercase(vstrwork) then
      If (copy(vstrwork,3,3) = '.  ') or
         (copy(vstrwork,2,3) = '.  ') then
           Result:= true;
    end;
  {Test the Section Break}
  function SectionBreak: boolean;
    begin
    Result:= false;
    If copy(vstrWork,1,1) = '~' then
    else
    If vstrWork = uppercase(vstrwork) then
     If length(vstrWork) > 5 then
      If pos('(', vstrWork) > 3 then
       If (copy(vstrwork,1,3) <> 'NOS')
         and (copy(vstrwork,1,1) <> '-')
         and (copy(vstrwork,1,2) <> 'IQ')
         and (copy(vstrwork,1,1) <> '[')
         and (copy(vstrwork,1,5) <> 'ACTH ')
         and (copy(vstrwork,1,3) <> '   ') then
             Result:= true;
    end;
  {Test the Break for individual code lines}
  function CodeBreak: boolean;
    begin
    Result:= false;
    If copy(vstrWork,1,1) = '~' then
    else
      begin
      vstrCode:= vstrWork;
      if pos(#94, vstrCode) > 1 then
         vstrCode:= copy(vstrCode,1,pos(#94, vstrCode)-1);
      If pos(#9, vstrCode) > 1 then
         vstrCode:= copy(vstrCode,1,pos(#9, vstrCode)-1);
      try
       If (copy(vstrCode,2,1) >= '0') and (copy(vstrCode,2,1) <= '9') and
          (copy(vstrCode,3,1) >= '0') and (copy(vstrCode,3,1) <= '9') and
          (length(vstrCode) > 2) then
            Result:= true;
      except
        {Fails the numeric/integer test at the required positions}
        end;
      end;
    end;
  {Test the Break for individual code lines}
  function FifthBreak: boolean;
    begin
    Result:= false;
    If copy(vstrWork,1,1) = '~' then
    else
    If ((pos('fourth-digit',vstrWork) > 0) or
        (pos('fifth-digit',vstrWork) > 0)) and
       (pos('The following',vstrWork) > 0) then
      begin
      vstrCode:= vstrWork;
      Result:= true;
      end;
    end;
  {Process line breaks, indents, Excludes, Includes, Notes, etc that are
  appended onto the code, section or chapter lines}
  Procedure AppendNewText(var vstrCurrent: string; const cstrAdd: string);
    begin
    If copy(cstrAdd,1,1) = '~' then
    else
    If vbolFourthFifth then
      begin
      try
        strtoint(copy(cstrAdd,1,1));
        If pos('fourth-digit',vstrCurrent) > 0 then
           vstrCurrent:= vstrCurrent + '^' + #174 + cstrAdd
        else
           vstrCurrent:= vstrCurrent + '^' + #175 + cstrAdd;
        except
        vstrCurrent:= vstrCurrent + '^|' + cstrAdd;
        end;
      end
    else
    If copy(cstrAdd, 1, 10) = 'Includes: ' then
      vstrCurrent:= vstrCurrent + '^' + #171 + copy(cstrAdd, 11, 999)
    else
    If copy(cstrAdd, 1, 10) = 'Excludes: ' then
      vstrCurrent:= vstrCurrent + '^' + #172 + copy(cstrAdd, 11, 999)
    else
    If copy(cstrAdd, 1, 6) = 'Note: ' then
      vstrCurrent:= vstrCurrent + '^' + #173 + copy(cstrAdd, 7, 999)
    else
      vstrCurrent:= vstrCurrent + '^|' + cstrAdd;
    end;
  {Test all breaks...}
  procedure TestBreak;
    begin
    If TitleBreak or SectionBreak or CodeBreak or FifthBreak
       or (copy(vstlRaw[vintLoop],1,1) = '~') then
       begin
      {HARD CODED STUFF -------------------------------------------------}
       If copy(vstrHold, 1, 6) = 'E849.0' then
          begin
          vstlRefined.add('E849 Place of occurence' +
                          '^|The following category is for use to denote ' +
                          'the place where the injury or poisoning occurred.');
          end;
       {-------------------------------------------------}
       If length(vstrHold) > 0 then
          vstlRefined.add(vstrHold);
       vstrHold:= '';
       vbolAppend:= false;
       end
    else
      AppendNewText(vstrHold, vstlRaw[vintLoop]);
    end;
begin
for vintLoop:= 0 to vstlRaw.count - 1 do
  begin
  vstrWork:= vstlRaw[vintloop];
  while pos(#9, vstrWork) > 0 do
     vstrWork[pos(#9, vstrWork)]:= ' ';
  while pos('”', vstrWork) > 0 do
     vstrWork[pos('”', vstrWork)]:= 'o';
  while pos(#132, vstrWork) > 0 do
     vstrWork[pos(#132, vstrWork)]:= 'a';
  while pos(#162, vstrWork) > 0 do
     vstrWork[pos(#162, vstrWork)]:= 'o';
  while pos(#135, vstrWork) > 0 do
     vstrWork[pos(#135, vstrWork)]:= 'c';
  while pos(#129, vstrWork) > 0 do
     vstrWork[pos(#129, vstrWork)]:= 'u';
  //vintTest:= ord(vstrWork[13]);
  //vstrWork:= inttostr(vintTest);
  vstlRaw[vintloop]:= vstrWork;
  end;

{Find Chapter headings}
vstlRefined.add('=CHAPTER ICD9=');
vstlRefined.add(vstlRaw[0]);
vstlRaw[0]:= '~' + vstlRaw[0];
vbolAppend:= false;
vbolFourthFifth:= false;
vstrHold:= '';
for vintLoop:= 1 to vstlRaw.count - 1 do
  begin
  vstrWork:= vstlRaw[vintLoop];

  If vbolAppend then
    {-------------HARD CODE ROUTINE---------------}
    {Exception: Chapters 4 and 14 do not have sections, only details.  To
     store them properly, only 1 line for these 2 chapters are retained and
     then switched off.}
    If (copy(vstrHold,1,4) = '4.  ') or
       (copy(vstrHold,1,4) = '14. ') then
       begin
       If length(vstrHold) > 0 then
          vstlRefined.add(vstrHold);
       vstrHold:= '';
       vbolAppend:= false;
       end
    else
    {---------------------------------------------}
    If SectionBreak then
       begin
       If length(vstrHold) > 0 then
          vstlRefined.add(vstrHold);
       vstrHold:= '';
       vbolAppend:= false;
       end
    else
       AppendNewText(vstrHold, vstlRaw[vintLoop]);

  If TitleBreak then
      begin
      vbolAppend:= true;
      vstrHold:= vstrWork;
      end;

  If vbolAppend then
     vstlRaw[vintLoop]:= '~' + vstlRaw[vintLoop];
  end;

vstlRefined.add(vstlRaw[vstlRaw.count - 2]);
vstlRaw[vstlRaw.count - 2]:= '~' + vstlRaw[vstlRaw.count - 2];

{Find section headings}
vstlRefined.add('=SECTION ICD9=');
vbolAppend:= false;
vstrHold:= '';
for vintLoop:= 0 to vstlRaw.count - 1 do
  begin
  vstrWork:= vstlRaw[vintLoop];

  If vbolAppend then
    TestBreak;

  If SectionBreak then
      begin
      vbolAppend:= true;
      vstrHold:= trim(vstrWork);
      end;

  If vbolAppend then
     vstlRaw[vintLoop]:= '~' + vstlRaw[vintLoop];
  end;

{Find Fourth/Fifth Digits}
vstlRefined.add('=4th/5th DIGITS ICD9=');
vbolFourthFifth:= true;
vbolAppend:= false;
vstrHold:= '';
for vintLoop:= 0 to vstlRaw.count - 1 do
  begin
  vstrWork:= vstlRaw[vintLoop];

  If vbolAppend then
    TestBreak;

  If FifthBreak then
      begin
      vbolAppend:= true;
      vstrHold:= trim(vstrWork);
      end;

  If vbolAppend then
     vstlRaw[vintLoop]:= '~' + vstlRaw[vintLoop];
  end;
vbolFourthFifth:= false;

{Find the Base codes...}
vstlRefined.add('=DETAILS ICD9=');
vbolAppend:= false;
vstrHold:= '';
for vintLoop:= 0 to vstlRaw.count - 1 do
  begin
  edit1.text:= inttostr(vintloop);
  edit1.update;
  
  vstrWork:= vstlRaw[vintLoop];

  If vbolAppend then
    TestBreak;

  If CodeBreak then
      begin
      vbolAppend:= true;
      vstrHold:= vstrWork;
      end;

  If vbolAppend then
     vstlRaw[vintLoop]:= '~' + vstlRaw[vintLoop];
  end;

If length(vstrHold) > 0 then
   vstlRefined.add(vstrHold);

end;

{This routine will place "markers" in the ICD9 records referring to the
displacement of the ICD9 references. This could take a very long time but save
a great deal of processing in the search DLL}
Procedure TForm1.CrossHatch(var vstlRefined, vstlPrefix: tstringlist);
var vintLoop, vintHoldPosition, vintChapterStart,
              vintSectionStart, vint5th: integer;
    vbolChapter, vbolSection, vbol4th_5th, vbolDetails, vbolNext: boolean;
    vstrData, vstrPrefix, vstrTestLink, vstrTestSection: string;
    vreaCode: real;
    {Find: The Linked Chapter, ^ + #176
           The Linked Section, ^ + #177
           The Lowest Level (Valid) ^ + #178
           Fourth-Digit Link, ^ + #174
           Fifth-Digit Link, ^ + #175}
    Procedure BuildPrefix;
      var vbolLowest, vbolTestE, vbolTestV, vbolSecE, vbolSecV: boolean;
          vstrCurrentCode, vstrNextCode, vstrTest5, vstrTest4: string;
          vintLoop, vintTestLink: integer;
          {Use the current 4th digit string to determine if the float code
          is in the range.  If so, return true;}
          function Has4thDigit: boolean;
             var vreaRange1, vreaRange2: real;
                 vbolBuild2: boolean;
                 vstrHold4th: string;
                 vintLoop: integer;
             begin
             Result:= false;
             {HARD-CODED INCLUSIONS - 4th Digit -------------------------}
             If (copy(vstrCurrentCode,1,2) = 'V3') then
                begin
                Result:= true;
                exit;
                end
             {Exclude all NON-E codes}
             else
             If (copy(vstrCurrentCode,1,1) <> 'E') then
                exit;
             {------------------------------------------------------------}
             {Build 2 is used to create the second category code in a range}
             vbolBuild2:= false;
             vreaRange1:=0;
             {Loop through all 5th digits to assemble single codes or ranges}
             for vintLoop:= 1 to length(vstrTest4) do
                begin
                try
                {Skip all E digits to remove the E from the start of cat codes}
                If copy(vstrTest4, vintLoop, 1) = 'E' then
                else
                {A dash mean to save one code and move on to build a second}
                If copy(vstrTest4, vintLoop, 1) = '-' then
                   begin
                   vbolBuild2:= true;
                   vreaRange1:= strtofloat(vstrHold4th);
                   vstrHold4th:='';
                   end
                {a ";", ":", or ' ' requires that a 5th digit check take place}
                else
                If (copy(vstrTest4, vintLoop, 1) = ',') or
                  (copy(vstrTest4, vintLoop, 1) = ' ') then
                   begin
                   {If we are building a range, use the real code and compare}
                   If vbolBuild2 then
                      begin
                      vreaRange2:= strtofloat(vstrHold4th);
                      If (vreaCode >= vreaRange1) and
                         (vreaCode <= vreaRange2) then
                        begin
                        Result:= true;
                        exit;
                        end;
                      end;
                   vbolBuild2:= false;
                   vstrHold4th:= '';
                   end
                else
                   {Continue to accumulate a possible 5th digit check}
                   vstrHold4th:= vstrhold4th + copy(vstrTest4, vintLoop, 1);
                except
                  {an exception in a check may cause the routine to halt. Reset
                  the variables and continue}
                  vbolBuild2:= false;
                  vstrHold4th:= '';
                  end;
                end;
             end;
          {Use the current 5th digit string to determine if the float code
          is in the range.  If so, return true;}
          function Has5thDigit: boolean;
             var vreaRange1, vreaRange2, vreaShortCat: real;
                 vbolBuild2: boolean;
                 vstrHold5th: string;
                 vintLoop: integer;
             begin
             Result:= false;
             {HARD-CODED EXCLUSIONS- NO 5th Digit-------------------------}
             If (vstrCurrentCode = '305') or
                (vstrCurrentCode = '312') or
                (vstrCurrentCode = '342') or
                (vstrCurrentCode = '345') or
                (vstrCurrentCode = '789') or
                (vstrCurrentCode = '805') or
                (vstrCurrentCode = '807') or
                (vstrCurrentCode = '345.2') or
                (vstrCurrentCode = '345.3') or
                (vstrCurrentCode = '789.1') or
                (vstrCurrentCode = '789.2') or
                (vstrCurrentCode = '789.5') or
                (vstrCurrentCode = '789.9') or
                (copy(vstrCurrentCode,1,1) = 'E') or
                (copy(vstrCurrentCode,1,1) = 'V') then
                exit;
             {------------------------------------------------------------}
             {Build 2 is used to create the second category code in a range}
             vbolBuild2:= false;
             vreaRange1:=0;
             {Make a category-level version of the decimal number to check
             against a single 5th digit category (not used in a range check)}
             vreaShortCat:= int(vreaCode);
             {Loop through all 5th digits to assemble single codes or ranges}
             for vintLoop:= 1 to length(vstrTest5) do
                begin
                try
                {A dash mean to save one code and move on to build a second}
                If copy(vstrTest5, vintLoop, 1) = '-' then
                   begin
                   vbolBuild2:= true;
                   vreaRange1:= strtofloat(vstrHold5th);
                   vstrHold5th:='';
                   end
                {a , or ' ' requires that a 5th digit check take place}
                else
                If (copy(vstrTest5, vintLoop, 1) = ',') or
                   (copy(vstrTest5, vintLoop, 1) = ' ') then
                   begin
                   {If we are building a range, use the real code and compare}
                   If vbolBuild2 then
                      begin
                      vreaRange2:= strtofloat(vstrHold5th);
                      If (vreaCode >= vreaRange1) and
                         (vreaCode <= vreaRange2) then
                        begin
                        Result:= true;
                        exit;
                        end;
                      end
                   else
                   {To compare against one category or exact code, check both
                   the integer and float versions of the held code}
                      begin
                      vreaRange1:= strtofloat(vstrHold5th);
                      If (vreaCode = vreaRange1) or
                         (vreaShortCat = vreaRange1) then
                        begin
                        Result:= true;
                        exit;
                        end;
                      end;
                   vbolBuild2:= false;
                   vstrHold5th:= '';
                   end
                else
                   {Continue to accumulate a possible 5th digit check}
                   vstrHold5th:= vstrhold5th + copy(vstrTest5, vintLoop, 1);
                except
                  {an exception in a check may cause the routine to halt. Reset
                  the variables and continue}
                  vbolBuild2:= false;
                  vstrHold5th:= '';
                  end;
                end;
             end;
      {The main routine for Build prefix}
      begin
      If copy(vstrData,1,1) = '=' then exit;
      vstrPrefix:= '';

      {^ + #178 Routine -------------------------------------------------------}
      {Find the Lowest Level switch for Details only}
      If vbolDetails then
        begin
        vstrPrefix:= copy(vstrData,1,pos(' ',vstrData)-1);
        vstrCurrentCode:= copy(vstrData,1,pos(' ',vstrData)-1);
        vstrNextCode:= copy(vstlRefined[vintHoldPosition+1],1,
                                    pos(' ',vstlRefined[vintHoldPosition+1])-1);
        vbolLowest:= false;
        {= lengths or shorter subsequent codes means a change in topics and
        is a lowest level code}
        If length(vstrCurrentCode) >= length(vstrNextCode) then
           vbolLowest:= true
        else
        {If the next topic is shortened to the length of the current and is not
        = then the current is a lowest level}
        If copy(vstrNextCode,1,length(vstrCurrentCode)) <> vstrCurrentCode then
           vbolLowest:= true;
        If vbolLowest then
           vstrPrefix:= vstrPrefix + '^' + #178;
        {Done with lowest level search}
        end;

      {^ + #176 Routine -------------------------------------------------------}
      {Find Chapter location for each Section/Detail record}
      {Handle details by comparing the range of the Chapter Link and the Link
      displacement of the detail.}
      If vbolDetails then
         begin
         vintLoop:= vintChapterStart;
         while copy(vstlRefined[vintLoop],1,1) <> '=' do
            begin
            {The last category in the list is the only match}
             IF copy(vstlRefined[vintLoop],1,3) = 'ICD' then
               begin
               vstrPrefix:= vstrPrefix + '^' + #176
                                        + inttostr(vintLoop-1) + #176 + '^;';
               break
               end;
             {Find the lowest link number in the Chapter}
             vintTestLink:= strtoint(copy(vstlRefined[vintLoop],
                           pos('^'+#170,vstlRefined[vintLoop]) + 2,
                           pos(#170+'^',vstlRefined[vintLoop]) -
                                    pos('^'+#170,vstlRefined[vintLoop]) - 2));
            {The current range for links in the chapter match the detail record
            dosplacement in the string list}
            If vintTestLink > vintHoldPosition then
               begin
               vstrPrefix:= vstrPrefix + '^' + #176
                                           + inttostr(vintLoop-1) + #176 + '^;';
               break;
               end;
            inc(vintLoop);
            end
         end
      else
      {Sections are handled by the ( to - number category without the decimal}
      If vbolSection then
         begin
         vintLoop:= vintChapterStart;
         while copy(vstlRefined[vintLoop],1,1) <> '=' do
            begin
            {The last category in the list is the only match}
            IF copy(vstlRefined[vintLoop],1,3) = 'ICD' then
               begin
               vstrPrefix:= vstrPrefix + '^' + #176
                                           + inttostr(vintLoop-1) + #176 + '^;';
               break;
               end;
            {Find the lowest category number in the Chapter}
            vstrTestLink:= copy(vstlRefined[vintLoop],
                           pos('^',vstlRefined[vintLoop]) - 4 , 4);
            If vstrTestLink[1] = '(' then
                 vstrTestLink:= copy(vstrTestLink,2,999);
            vstrTestSection:= copy(vstrData,
                           pos('^',vstrData) - 4 , 4);
            If vstrTestSection[1] = '(' then
                 vstrTestSection:= copy(vstrTestSection,2,999);
            {The current range for links in the chapter match the detail record
            dosplacement in the string list}
            {-----HARD CODE------ E = 20 and V=19 in prefix}
            If vstrTestSection[1] = 'E' then
                begin
                vstrPrefix:= vstrPrefix + '^' + #176 + '20' + #176 + '^;';
                break;
                end;
            If vstrTestSection[1] = 'V' then
                begin
                vstrPrefix:= vstrPrefix + '^' + #176 + '19' + #176 + '^;';
                break;
                end;
            {----------------------------------------------}
            If vstrTestLink > vstrTestSection then
                begin
                vstrPrefix:= vstrPrefix + '^' + #176
                                           + inttostr(vintLoop-1) + #176 + '^;';
                break;
                end;
            inc(vintLoop);
            end
         end;

      {^ + #177 Routine -------------------------------------------------------}
      {Link the individual detail records back to the Section record}
      If vbolDetails then
         begin
         vintLoop:= vintSectionStart;
         vbolNext:= false;
         while copy(vstlRefined[vintLoop],1,1) <> '=' do
            begin
            {Find the lowest category number in the Chapter}
            vstrTestLink:= trim(copy(vstrData, 1, 4));
            If vstrTestLink[4] = '.' then
               vstrTestLink:= copy(vstrTestLink, 1, 3);
            vstrTestSection:= trim(copy(vstlRefined[vintLoop],
                              pos('^',vstlRefined[vintLoop]) - 4 , 4));
            If vstrTestSection[1] = '(' then
                 vstrTestSection:= copy(vstrTestSection,2,999);
            If vstrTestLink[1] = 'E' Then
               begin
               vbolTestE:= true;
               vstrTestLink:= copy(vstrTestLink,2,999);
               end
            else
               vbolTestE:= false;
            If vstrTestSection[1] = 'E' Then
               begin
               vbolSecE:= true;
               vstrTestSection:= copy(vstrTestSection,2,999);
               end
            else
               vbolSecE:= false;
            If vstrTestLink[1] = 'V' Then
               begin
               vbolTestV:= true;
               vstrTestLink:= copy(vstrTestLink,2,999);
               end
            else
               vbolTestV:= false;
            If vstrTestSection[1] = 'V' Then
               begin
               vbolSecV:= true;
               vstrTestSection:= copy(vstrTestSection,2,999);
               end
            else
               vbolSecV:= false;
            {The prefix digit of V or E must be matched between the detail
            record and the section record.}
            If (vbolTestE <> vbolSecE) or
               (vbolTestV <> vbolSecV) then
               begin
               {If we had just been comparing the section and link codes, assign
               last section link.  This makes sure the last entry in a section
               will get assigned when switching from regular to E to V codes}
               If vbolNext then
                 begin
                 vstrPrefix:= vstrPrefix + '^' + #177
                                           + inttostr(vintLoop-1) + #177 + '^;';
                 vbolNext:= false;
                 break;
                 end;
               end
            else
              begin
              vbolNext:= true;
             {The current range for links in the chapter match the detail record
              dosplacement in the string list}
              If vstrTestLink < vstrTestSection then
                 begin
                 vstrPrefix:= vstrPrefix + '^' + #177
                                     + inttostr(vintLoop-1) + #177 + '^;';
                 vbolNext:= false;
                 break;
                 end;
              end;
            inc(vintLoop);
            end;
         {Last chance to add a valid section link at the end of the records}
         If vbolNext then
            vstrPrefix:= vstrPrefix + '^'  + #177
                                          + inttostr(vintLoop-1)  + #177 + '^;';
         end;
      {^ + #178 Routine -------------------------------------------------------}
      {If a code has a link to a 5th digit definition, add a ^#175   #175^ mark.
      Remove the ^ + #178 lowest level marker if it exists }
      If vbolDetails then
         begin
         vintLoop:= vint5th;
         try
         {The detail records for 5th digit are all numeric...}
         If (copy(vstrCurrentCode,1,1) = 'E') or
            (copy(vstrCurrentCode,1,1) = 'V') then
            vreaCode:= strtofloat(copy(vstrCurrentCode,2,999))
         else
            vreaCode:= strtofloat(vstrCurrentCode);
         while copy(vstlRefined[vintLoop],1,1) <> '=' do
           begin
           if pos('fourth-digit', vstlRefined[vintLoop]) > 0 then
              begin
              {trim down the 4th digit string to leave codes only}
              vstrTest4 := copy(vstlRefined[vintLoop],1,
                              pos('^' + #174, vstlRefined[vintLoop])-1);
              If pos(':', vstrTest5) > 0 then
                vstrTest4 := copy(vstrTest4,1,
                              pos(':', vstrTest4)-1);
              If pos(';', vstrTest5) > 0 then
                vstrTest4 := copy(vstrTest4,1,
                              pos(';', vstrTest4)-1);
              If pos('codes', vstrTest5) > 0 then
                vstrTest4 := copy(vstrTest5,
                              pos('codes', vstrTest4)+6,999);
              If pos('category', vstrTest5) > 0 then
                vstrTest4 := copy(vstrTest5,
                              pos('category', vstrTest4)+9,999);
              If pos('categories', vstrTest5) > 0 then
                vstrTest4 := copy(vstrTest5,
                              pos('categories', vstrTest4)+11,999);
              {Place a last comma to control-break and check the last code
              series on the 5th digit string}
              vstrTest4:= vstrTest4 + ',';
              {Check the current code against the 4th digit line}
              If Has4thDigit then
                 begin
                 {HARD CODE to multi-assign 4th and 5th for V30-V39-----------}
                 If (copy(vstrCurrentCode,1,2) = 'V3') then
                    vstrPrefix:= vstrPrefix + '^' + #174 + '249' + #174
                                            + '^;^' + #175 + '250' + #175+ '^;'
                 else
                    vstrPrefix:= vstrPrefix + '^'  + #174 + inttostr(vintLoop)
                                                                  + #174 + '^;';
                 If pos('^' + #178, vstrPrefix) > 0 then
                    vstrPrefix:= copy(vstrPrefix,1,
                                       pos('^' + #178, vstrPrefix)-1) +
                           copy(vstrPrefix,pos('^' + #178, vstrPrefix)+2, 999);
                 break;
                 end
              end
           else
           if pos('fifth-digit', vstlRefined[vintLoop]) > 0 then
              begin
              {trim down the 5th digit string to leave codes only}
              vstrTest5 := copy(vstlRefined[vintLoop],1,
                              pos('^' + #175, vstlRefined[vintLoop])-1);
              If pos(';', vstrTest5) > 0 then
                vstrTest5 := copy(vstrTest5,1,
                              pos(';', vstrTest5)-1);
              If pos(':', vstrTest5) > 0 then
                vstrTest5 := copy(vstrTest5,1,
                              pos(':', vstrTest5)-1);
              If pos('codes', vstrTest5) > 0 then
                vstrTest5 := copy(vstrTest5,
                              pos('codes', vstrTest5)+6,999);
              If pos('category', vstrTest5) > 0 then
                vstrTest5 := copy(vstrTest5,
                              pos('category', vstrTest5)+9,999);
              If pos('categories', vstrTest5) > 0 then
                vstrTest5 := copy(vstrTest5,
                              pos('categories', vstrTest5)+11,999);
              {Place a last comma to control-break and check the last code
              series on the 5th digit string}
              vstrTest5:= vstrTest5 + ',';
              {Check the current code against the 5th digit line}
              If Has5thDigit then
                 begin
                 vstrPrefix:= vstrPrefix + '^' + #175
                                             + inttostr(vintLoop) + #175 + '^;';
                 If pos('^' + #178, vstrPrefix) > 0 then
                    vstrPrefix:= copy(vstrPrefix,1,pos('^'+#178,vstrPrefix)-1) +
                               copy(vstrPrefix,pos('^'+#178, vstrPrefix)+2,999);
                 break;
                 end
              end;
           inc(vintLoop);
           end;
         except
           end;
         end;
      end;

begin
vintChapterStart:= 2;
vbolChapter:= true;
vbolSection:= true;
vbol4th_5th:= false;
vbolDetails:= false;
for vintLoop:= 0 to vstlRefined.count - 1 do
  begin
  vintHoldPosition:= vintLoop;
  vstrData:=vstlRefined[vintLoop];
  If copy(vstrData, 1, 1) = '=' then
     begin
     If copy(vstrData, 2, 7) = 'SECTION' then
        begin
        vbolChapter:= false;
        vbolSection:= true;
        vintSectionStart:= vintLoop + 1;
        end
     else
     If copy(vstrData, 2, 7) = '4th/5th' then
        begin
        vbol4th_5th:= true;
        vbolSection:= false;
        vint5th:= vintLoop + 1;
        end
     else
     If copy(vstrData, 2, 7) = 'DETAILS' then
        begin
        vbol4th_5th:= false;
        vbolDetails:= true;
        end
     end
  else
  If vbolChapter then
     AddLinkTags(vstlRefined, vstrData, 7)
  else
  If vbol4th_5th then
  else
     begin
     {Hard coded stuff to prevent links on certain codes.}
     If (copy(vstrData, 1, 5) = '369.9') or
        (copy(vstrData, 1, 5) = '766.0') or
        (copy(vstrData, 1, 5) = '766.2') then
     else
         AddLinkTags(vstlRefined, vstrData, 7);
     BuildPrefix;
     end;
  vstlRefined[vintLoop]:= vstrData;
  vstlPrefix.add(vstrPrefix);
  edit1.text:= inttostr(vintloop);
  edit1.update;
  end;
vbol4th_5th:= false;
for vintLoop:= 0 to vstlRefined.count - 1 do
  begin
  vintHoldPosition:= vintLoop;
  vstrPrefix:=vstlPrefix[vintLoop];
  vstrData:= vstlRefined[vintLoop];
  If copy(vstrData, 2, 7) = '4th/5th' then
        vbol4th_5th:= true
  else
  If copy(vstrData, 2, 7) = 'DETAILS' then
        vbol4th_5th:= false;
  If copy(vstrData, 1, 1) = '=' then
  else
  If vbol4th_5th then
     begin
     If pos('764', vstrData) > 0 then
         vbol764Code:= true
     else
         vbol764Code:= false;
     AddLinkTags(vstlRefined, vstrData, 7);
     end;
  vstlPrefix[vintLoop]:= vstrPrefix;
  vstlRefined[vintLoop]:= vstrData;
  edit1.text:= inttostr(vintloop);
  edit1.update;
  end;
end;

{}
Procedure TForm1.AddLinkTags(vstlRefined: tstringlist;
                             var vstrData: string;
                             const cintStartScan: integer);
  var vintLinkCode, vintNum, vintTest: integer;
      vstrLink, vstrDataNew: string;
  Procedure AssignLink;
      var vintLoop: integer;
          vintLength: integer;
      begin
      vstrLink:= trim(vstrLink);
      If (vintNum < 2) or (length(vstrLink) < 3) or
         (length(vstrLink) > 6) or
         ((length(vstrLink) > 4) and (pos('.', vstrLink) = 0)) then
         begin
         vstrLink:= '';
         vintNum:= 0;
         exit;
         end;
      vintLength:= length(vstrLink);
      For vintLoop:= 0 to vstlRefined.count - 1 do
         If copy(vstlRefined[vintLoop], 1, vintLength) = vstrLink then
            begin
            vintLinkCode:= vintLoop;
            break;
            end;
      {try again for a no "." link to a generic category}
      If (vintLinkCode = 0) and (pos('.', vstrLink) > 0) then
         begin
         vstrLink:= copy(vstrLink, 1, pos('.', vstrLink)-1);
         vintLength:= length(vstrLink);
         For vintLoop:= 0 to vstlRefined.count - 1 do
             If copy(vstlRefined[vintLoop],1,vintLength) = vstrLink then
                begin
                vintLinkCode:= vintLoop;
                break;
                end;
         end;
      end;
  Procedure ApplyLink;
      begin
      If vintLinkCode > 0 then
         vstrDataNew:= vstrDataNew
                     + '^'+#170 + inttostr(vintLinkCode) + #170 + '^';
      vintLinkCode:= 0;
      vstrLink:= '';
      vintNum:=0;
      end;
var vintLoop: integer;
begin
vintLinkCode:=0;
vstrLink:='';
vintNum:=0;
vstrDataNew:= copy(vstrData,1,cintStartScan-1);
for vintLoop:= cintStartScan to length(vstrData) do
   begin
   If vbol764Code and (vintLoop > 110) then
   else
   If (copy(vstrData,vintLoop,1) = '(') or
      (copy(vstrData,vintLoop,1) = '|') then
   else
   If (copy(vstrData,vintLoop,1) = ')') or
      (copy(vstrData,vintLoop,1) = ']') or
      (copy(vstrData,vintLoop,1) = ' ') or
      (copy(vstrData,vintLoop,1) = ':') or
      (copy(vstrData,vintLoop,1) = ';') or
      (copy(vstrData,vintLoop,1) = '^') or
      (copy(vstrData,vintLoop,1) = '-') or
      (copy(vstrData,vintLoop,1) = ',') then
      begin
      AssignLink;
      ApplyLink;
      end
   else
      begin
      vstrLink:= vstrLink + copy(vstrData,vintLoop,1);
      try
        vintTest:= strtoint(copy(vstrData,vintLoop,1));
        inc(vintNum);
        except
        end;
      end;
   vstrDataNew:= vstrDataNew + copy(vstrData,vintLoop,1);
   end;
AssignLink;
ApplyLink;
vstrData:= vstrDataNew;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
memtext.lines.loadfromfile('.\ICD9CM03\DTAB03.txt');
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
  var vstlUP, vstlPrefix: tstringlist;
begin
vstlUP:= tstringlist.create;
vstlPrefix:= tstringlist.create;
vstlUp.loadfromfile('ICD9Data.txt');
//vstlUP.add('=DONE=');
CrossHatch(vstlUp, vstlPrefix);
//vstlUp.savetofile('ICD9Data.txt');
vstlPrefix.savetofile('ICD9Prefix.txt');

vstlUP.free;
vstlPrefix.free;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
var
  txtIN, txtOut: TextFile;
  vstrLine, vstrPrefix, vstrNewLine,
                        vstrRawLine, vstrNeoplasmBegin, vstrNeoplasmEnd: string;
  vbolStart, vbolNeoplasm, vbolNeoplasm2: boolean;
  vstlDataFile: tstringlist;
  vintCounter, vintNeoCount: integer;
  procedure StripDoubleBracket;
    var vintLoop: integer;
        vstrTemp: string;
        vbolStop: boolean;
        vbolTabFound: boolean;
    begin
    vbolTabFound:= false;
    vbolStop:= false;
    vintLoop:= 1;
    while vintLoop <= length(vstrLine) do
       begin
       If copy(vstrLine, vintloop, 2) = '}{' then
          If vbolStop then
             begin
             vbolStop:= false;
             inc(vintLoop);
             inc(vintLoop);
             end
          else
             vbolStop:= true;
       If copy(vstrLine, vintLoop, 4) = '\tab' then
          begin
          vbolTabFound:= true;
          vintLoop:= vintLoop + 5;
          If vbolNeoplasm then
             vstrTemp:= vstrTemp + '^c^'
          else
          If copy(vstrTemp, length(vstrTemp), 1) < ' a' then
          else
             vstrTemp:= vstrTemp + ' ';
          end
       else
       If copy(vstrLine, vintLoop, 5) = '\line' then
          begin
          vstrTemp:= vstrTemp + '^|';
          vintLoop:= vintLoop + 6;
          end
       else
       {This is the list of weird-font overrides to pick up unusual letters
       and character sets.  We put in the normal character.}
       {use normal "e"}
       If (copy(vstrLine, vintLoop, 4) = '\''e9') or
          (copy(vstrLine, vintLoop, 4) = '\''e8') or
          (copy(vstrLine, vintLoop, 4) = '\''80') or
          (copy(vstrLine, vintLoop, 4) = '\''eb') then
          begin
          vstrTemp:= vstrTemp + 'e';
          vintLoop:= vintLoop + 4;
          end
       else
       {use normal "o"}
       If (copy(vstrLine, vintLoop, 4) = '\''f6') or
          (copy(vstrLine, vintLoop, 4) = '\''f4') or
          (copy(vstrLine, vintLoop, 4) = '\''f8') or
          (copy(vstrLine, vintLoop, 4) = '\''f3') then
          begin
          vstrTemp:= vstrTemp + 'o';
          vintLoop:= vintLoop + 4;
          end
       else
       {use normal "a"}
       If (copy(vstrLine, vintLoop, 4) = '\''e1') or
          (copy(vstrLine, vintLoop, 4) = '\''e4') or
          (copy(vstrLine, vintLoop, 4) = '\''e0') then
          begin
          vstrTemp:= vstrTemp + 'a';
          vintLoop:= vintLoop + 4;
          end
       else
       {use normal "c"}
       If copy(vstrLine, vintLoop, 4) = '\''e7' then
          begin
          vstrTemp:= vstrTemp + 'c';
          vintLoop:= vintLoop + 4;
          end
       else
       {use normal "O"}
       If copy(vstrLine, vintLoop, 4) = '\''d6' then
          begin
          vstrTemp:= vstrTemp + 'O';
          vintLoop:= vintLoop + 4;
          end
       else
       {use normal "u"}
       If (copy(vstrLine, vintLoop, 4) = '\''fc') or
          (copy(vstrLine, vintLoop, 4) = '\''fa') then
          begin
          vstrTemp:= vstrTemp + 'u';
          vintLoop:= vintLoop + 4;
          end
       else
       {use normal "-"}
       If copy(vstrLine, vintLoop, 4) = '\''ad' then
          begin
          vstrTemp:= vstrTemp + '-';
          vintLoop:= vintLoop + 4;
          end
       else
       {Normal character, continue}
          begin
          If not vbolStop then
             vstrTemp:= vstrTemp + copy(vstrLine, vintLoop, 1);
          inc(vintLoop);
          end;
       end;
       If not vbolTabFound and vbolNeoplasm then
          vstrTemp:= '^s^' + vstrTemp;
       vstrLine:= vstrTemp;
    end;
begin
  vstlDataFile:= tstringList.create;
  try
  vstlDataFile.loadfromfile('ICD9Data.txt');
  AssignFile(txtIn, '.\ICD9CM03\dindex03.rtf');
  AssignFile(txtOut, 'ICD9index.txt');
  Reset(txtIn);
  Rewrite(txtOut);
  vbolStart:= false;
  vbolNeoplasm:= false;
  vbolNeoplasm2:= false;
  vstrPrefix:='';
  vstrNewLine:= '';
  vstrRawLine:= '';
  vstrLine:= '';
  vintCounter:= 0;
  vintNeoCount:= 0;

  while not Eof(txtIn) do
      begin
      {Reading the rtf file directly brings in some partial lines that must be
      glued together for processing
        3 strings used in the process
          1. vstrRawLine - the result of the read statement
          2. vstrLine - multiple lines glued together before formatting
          3. vstrNewLine - combined lines for an entire detail record}
      vstrRawLine:= '';
      while ((pos('\s26\', vstrRawLine) > 0)
          or (pos('\s30\', vstrRawLine) > 0)
          or (length(vstrRawLine) = 0))
             and not EOF(txtIn) do
        Readln(txtIn, vstrRawLine);
      {There are errors in the formatting of the index file - Hard code
      transformations. Double quotes mess up the alpha order - remove in 1st
      position of /s17/ break}
      If pos('"worried well" V65.5', vstrRawLine) > 0 then
         vstrRawLine:= '\par "worried well" V65.5';
      If pos('"Worried well" V65.5', vstrRawLine) > 0 then
         vstrRawLine:= '\par \s17\ 1033 {Worried well V65.5';
      If vstrRawLine = '\par Personality' then
         vstrRawLine:= '\par \s17\ 1033 {Personality';
      If pos('"Infant Hercules"', vstrRawLine) > 0 then
         vstrRawLine:= '\par \s17\ 1033 {Infant Hercules syndrome 255.2';
      If pos('histling face"', vstrRawLine) > 0 then
         vstrRawLine:=
            '\par Whistling face syndrome (craniocarpotarsal dystrophy) 759.89';
      If vstrRawLine = '\par - see Human immunodeficiency ' +
                                    'virus (disease) (illness) (infection)' then
         vstrRawLine:=
            '\par \s18\ 1033 {see Human immunodeficiency ' +
                                    'virus (disease) (illness) (infection)';
      If vstrRawLine = '\par Human papillomavirus 079.4' then
         vstrRawLine:=
            '\par \s17\ 1033 {\par Human papillomavirus 079.4';

      {-----------------------------------------------------------------}

      inc(vintCounter);
      edit1.text:= inttostr(vintCounter);
      application.processmessages;
      If (copy(vstrRawLine, 1, 25) = '\par Neoplasm, neoplastic') and
         (vbolNeoplasm) then
         vbolNeoplasm2:= true
      else
      if vbolNeoplasm and not vbolNeoplasm2 then
         vstrRawLine:= ''
      else
      If vstrRawLine = '\par Neoplasm, neoplastic' then
         begin
         vbolNeoplasm:= true;
         writeln(txtOut, vstrNewLine);
         writeln(txtOut, 'Neonatorum - see condition');
         vstrLine:= '';
         vstrNewLine:= '';
         vstrPrefix:= '';
         vstrRawLine:= '';
         end
      else
      If pos('{Neovascularization', vstrLine) > 0 then
         begin
         vbolNeoplasm:= false;
         writeln(txtOut, 'Neoplasm-' +
                          vstrNeoplasmBegin +
                          ' to ' +
                          vstrNeoplasmEnd +
                          '^|' +
                          cstrNeoPrefix +
                          vstrNewLine);
         vstrNewLine:= '';
         end;
      {}

      {Skip blank lines}
      If length(vstrRawLine) = 0 then
      else
      If (copy(vstrRawLine, 1, 2) <> '\p') and
         (copy(vstrRawLine, 1, 2) <> '{\') and
         (copy(vstrRawLine, 1, 2) <> '\f') and
         (copy(vstrRawLine, 1, 2) <> '\r') and
         (copy(vstrRawLine, 1, 2) <> '\t') and
         (copy(vstrRawLine, 1, 2) <> '\a') and
         (copy(vstrRawLine, 1, 2) <> '\b') and
         (copy(vstrRawLine, 1, 2) <> '\d') and
         (copy(vstrRawLine, 1, 2) <> '\s') then
         begin
         vstrLine:= vstrLine + vstrRawLine;
         end
      else
        begin
        If pos('INDEX TO DISEASES AND INJURIES', vstrLine) > 0 then
           begin
           vstrLine:= 'INDEX TO DISEASES AND INJURIES';
           vbolStart:= true;
           vstrPrefix:= '';
           end;

        {Find the indent levels from the rich text file \s16\ to \s23\}
        If pos('\s16\', vstrLine) > 0 then
            {This is the main letter heading - drop}
            vstrLine:= ''
        else
        If pos('\s17\', vstrLine) > 0 then
          begin
          If vbolStart and (length(vstrNewLine) > 0) and not vbolNeoplasm then
            begin
            writeln(txtOut, vstrNewLine);
            end;
          {This is the major control break - start a new detail line}
          vstrNewLine:= '';
          vstrPrefix:= '';
          end
        else
        {18 thru 24 are the left margin indents}
        If pos('\s18\', vstrLine) > 0 then
           vstrPrefix := '|i1|'
        else
        {This appears only in the Hypertension table}
        If pos('\s29\', vstrLine) > 0 then
           vstrPrefix := '|i1|'
        else
        If pos('\s19\', vstrLine) > 0 then
           vstrPrefix := '|i2|'
        else
        If pos('\s20\', vstrLine) > 0 then
           vstrPrefix := '|i3|'
        else
        If pos('\s21\', vstrLine) > 0 then
           vstrPrefix := '|i4|'
        else
        If pos('\s22\', vstrLine) > 0 then
           vstrPrefix := '|i5|'
        else
        If pos('\s23\', vstrLine) > 0 then
           vstrPrefix := '|i6|'
        else
        If pos('\s24\', vstrLine) > 0 then
           vstrPrefix := '|i7|'
        else
        If pos('\cf2 Note', vstrLine) > 0 then
           begin
          // memo1.Lines.add(vstrLine);
           vstrPrefix := '|Note|';
           end;

        {Weird rule - if the last \s##\ code was \s17\, then write the last line
        as a control break.  vstrPrefix = '' means \s17\ was last
        The \s26\ record breaks the logic in NOTES, so avoid a break in this
        case}
//        If pos('\s26\', vstrLine) > 0 then
//        else
        If vbolStart and not vbolNeoplasm
           and (length(vstrPrefix) = 0)
           and (length(vstrNewLine) > 0) then
            begin
            writeln(txtOut, vstrNewLine);
            vstrNewLine:= '';
            end;

        {The next if strip all contraol codes prior to the meanigful text.  These
        can be trimmed because we have already retained the indent code}
        If pos('\fs20 ', vstrLine) > 0 then
            vstrLine:= copy(vstrLine, pos('\fs20 ', vstrLine) + 6, 999);

        If pos('p1036 ', vstrLine) > 0 then
            vstrLine:= copy(vstrLine, pos('p1036 ', vstrLine) + 6, 999);

        If pos('1033 {\v ', vstrLine) > 0 then
            vstrLine:= copy(vstrLine, pos('1033 {\v ', vstrLine) + 9, 999);

        If pos('1033 {', vstrLine) > 0 then
            vstrLine:= copy(vstrLine, pos('1033 {', vstrLine) + 6, 999);

        If pos('\par }{', vstrLine) > 0 then
            vstrLine:= copy(vstrLine, pos('\par }{', vstrLine) + 7, 999)
        else
        If pos('\par ', vstrLine) > 0 then
            vstrLine:= copy(vstrLine, pos('\par ', vstrLine) + 5, 999);

        If vbolNeoplasm and (pos('\fs20\cf0', vstrLine) > 0) then
            vstrLine:= '';


        {Elimate any line with the \s26\ format - all formatting no detail}
//        If pos('\s26\', vstrLine) > 0 then
//            vstrLine:= '';

        If vbolStart then
          begin
          {Take out other control codes and \tab and \line stuff}
          StripDoubleBracket;
          AddLinkTags(vstlDataFile, vstrLine, 4);
          end;

        {Append all of the current line to the multi-line detail record}
        If length(vstrLine) > 0 then
          If vbolStart and (length(vstrLine) > 0) then
            If vbolNeoplasm then
              begin
              If (copy(vstrLine, 1, 1) > ' a') and
                 (pos('^c^', vstrLine) > 0) then
                 inc(vintNeoCount);

              If vintNeoCount > 29 then
                 begin
                 vintNeoCount:= 1;
                 writeln(txtOut, 'Neoplasm-' +
                                  vstrNeoplasmBegin +
                                  ' to ' +
                                  vstrNeoplasmEnd +
                                  '^|' +
                                  cstrNeoPrefix +
                                  vstrNewLine);
                 vstrNewLine:= '';
                 If pos('^', vstrLine) > 0 then
                     vstrNeoplasmBegin :=
                                        copy(vstrLine, 1, pos('^', vstrLine)-1);
                 If pos(' ', vstrNeoplasmBegin) > 0 then
                     vstrNeoplasmBegin :=
                      copy(vstrNeoplasmBegin, 1, pos(' ', vstrNeoplasmBegin)-1);
                 If pos(',', vstrNeoplasmBegin) > 0 then
                     vstrNeoplasmBegin :=
                      copy(vstrNeoplasmBegin, 1, pos(',', vstrNeoplasmBegin)-1);
                 end
              else
              If (copy(vstrLine, 1, 1) > ' a') and
                 (pos('^c^', vstrLine) > 0) then
                 begin
                 If pos('^', vstrLine) > 0 then
                     vstrNeoplasmEnd := copy(vstrLine, 1, pos('^', vstrLine)-1);
                 If pos(' ', vstrNeoplasmEnd) > 0 then
                     vstrNeoplasmEnd :=
                          copy(vstrNeoplasmEnd, 1, pos(' ', vstrNeoplasmEnd)-1);
                 If pos(',', vstrNeoplasmEnd) > 0 then
                     vstrNeoplasmEnd :=
                          copy(vstrNeoplasmEnd, 1, pos(',', vstrNeoplasmEnd)-1);
                 end;


              {Neoplasm Indents by line}
              If copy(vstrLine,1,16) < '                a' then
                 vstrLine:= '|i3|' + trim(vstrLine)
              else
              If copy(vstrLine,1,12) < '            a' then
                 vstrLine:= '|i2|' + trim(vstrLine)
              else
              If copy(vstrLine,1,8) < '        a' then
                 vstrLine:= '|i1|' + trim(vstrLine);
              {Neoplasm end-of-line if /Line was not present in RTF file}
              If (copy(vstrNewLine, length(vstrNewLine)-1,2) = '^|') or
                 (Length(vstrNewLine) = 0) then
                 vstrNewLine:= vstrNewLine + vstrLine
              else
                 vstrNewLine:= vstrNewLine + '^|' + trim(vstrLine);
              end
            else
              {all Non-Neoplasm lines}
              vstrNewLine:= vstrNewLine + vstrPrefix + trim(vstrLine);
        vstrLine:= vstrRawLine;
        end;
      end;
    {catch the last line of the file as a control break and close}
    writeln(txtOut, vstrNewLine);
    CloseFile(txtIn);
    CloseFile(txtOut);
  finally
    vstlDataFile.free;
    end;
end;

end.
