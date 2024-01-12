unit classICD9Search;
{DLL for all process instances}

interface

uses SysUtils, procICD9Search, HTTPApp, classes, windows, forms;

type
  tICD9processes = class
  private
  public
    vstrHoldCurrentSkin: string;
    vstrSearchString: string;
    vstrCodeString: string;
    vstrSmallLink: string;
    vstrBigLink: string;
    vstrSmallImg: string;
    vstrBigImg: string;
    vstrSmallText: string;
    vstrBigText: string;
    vstrCurrentAction: string;
    vstrHoldLogName: string;

    vbolBookmarked: boolean;
    vbolSearch: boolean;
    vbolCode: boolean;
    vbolNoLog: boolean;
    vbolLogToggle: boolean;

    vintUnitMatch: integer;
    vintBigAd: integer;
    vintLittleAd: integer;
    vintTableSize: integer;
    vintTotalColumns: integer;
    
    vstlAds: tstringlist;
    vstlSearchAnswer: tstringlist;
    vstlLinks: tstringlist;
    vstlCurrentSkin: tstringlist;

    vreqICD9: TWebRequest;

   Procedure BuildAdInfo(const cstrType: string);
   Procedure AssignAd(const cstrType: string;
                     var vstrLink: string;
                     var vstrImg: string;
                     var vstrText: string;
                     var vintLoc: integer);
   Procedure LinkLineToHTML(var vstrLink: string; const cstrPalm: string);
   Procedure LinkToHTML
                          (var vstlDetail: tstringlist; const cstrPalm: string);
   Procedure ConvertToStringList(const cstrLongString: string;
                                      var vstlCode: tstringlist);
   Procedure CodeToHTML(var vstrCodeDesc: string);
   Procedure IndexToHTML(var vstrCodeDesc: string);
   procedure IndexSummaryToHTML(var vstlAlpha: tstringlist);
   function TestBookmark(vreqWeb: TwebRequest): boolean;
   Procedure FindAndProcessSearchResult(const vstrSearchString: string;
                                        var vstlSearchAnswer: tstringlist;
                                        var vstlLinks: tstringlist;
                                        var vintMatch: integer);
  Procedure CheckCurrentSkin( const cstrSkin: string;
                              var pgpTemplate: TPageProducer);
  Procedure InitializeCookies(const Request: TWebRequest;
                              var Response: TwebResponse);
  Procedure ProcessNeoplasm(var vstrCodeDesc: string);
  function ICD9GetCode(const cstrCode: string;
                     const cbolShortCode: boolean;
                     var vstlMoreKeys: tstringlist): string;
  function ICD9Search(const cstrText: string;
                     var vstlAnswers: tstringlist;
                     var vstlLinks: tstringlist): integer;
  Procedure ICD9Chapter(var vstlAnswers: tstringlist);
  Procedure ICD9SectionList(const cstrChapter: string;
                          var vstlAnswers: tstringlist);
  Procedure ICD9Section(const cstrSection: string;
                      var vstlAnswers: tstringlist);
  Procedure ICD9CodeRange(const cstrRange: string;
                      var vstlAnswers: tstringlist);
  function GetOneLine(const cintLine: integer): string;
  Procedure Mixcase(var vstrUpper: string);
  Procedure TrimCodes(var vstrTrim: string; const vbolLink: boolean);
  Procedure LogIT(const cstrMessage: string);
  Procedure LogCheck;
  Procedure ICD9free;
  Procedure ICD9IndexLetter(const cstrLetter: string;
                          var vstlAnswers: tstringlist);
  Procedure ICD9IndexWordSearch(const cstrWord: string;
                          var vstlAnswers: tstringlist);
  function IndexArrayLocate(const cstrSearch: string): integer;
  Function FindIndexAbbreviation(const cstrTest: string): string;
  function LoadSkin(vstrSkinName: string):string;
  
  end;

implementation

{------------------------------------------------------------------------------}
{Support routines for the action and page producers}
Procedure tICD9processes.FindAndProcessSearchResult
                                            (const vstrSearchString: string;
                                             var vstlSearchAnswer: tstringlist;
                                             var vstlLinks: tstringlist;
                                             var vintMatch: integer);
  var vstlSearch, vstlChapter: tstringlist;
      vintLoop: integer;
      vstrWork, vstrPrefix, vstrChapterText: string;
begin
  vstlSearch:= tstringlist.create;
  vstlChapter:= tstringlist.create;
  try
  vintMatch:= ICD9Search(vstrSearchString,vstlSearch,vstlLinks);
  for vintLoop:= 0 to vstlSearch.count - 1 do
      begin
      vstrWork:= copy(vstlSearch[vintLoop],
                 1, pos('~~', vstlSearch[vintLoop])-1);
      vstrPrefix:= copy(vstlSearch[vintLoop],
                 pos('~~', vstlSearch[vintLoop])+2,999);
      {Set bolding for the matched word}
      while pos('^' + #179, vstrWork) > 0 do
        vstrWork:= copy(vstrWork, 1, pos('^' + #179, vstrWork) -1) + '<b>'
               + copy(vstrWork, pos('^' + #179, vstrWork) + 2, 999);
      while pos(#179 + '^', vstrWork) > 0 do
        vstrWork:= copy(vstrWork, 1, pos(#179 + '^', vstrWork) -1) + '</b>'
               + copy(vstrWork, pos(#179 + '^', vstrWork) + 2, 999);
      {Done with bolding}
      vstrWork:= '<tr><td width="60">'
               + '<a href="http://' + vstrWebAddress
               + '/cgi-bin/MudsoxICD9.DLL/Code?Code='
               + copy(vstrWork, 1, pos(' ', vstrWork) - 1) + '">'
               + copy(vstrWork, 1, pos(' ', vstrWork) - 1)
               + '</a></td>'
               + '</td><td width="'
               + inttostr(vintTableSize-60) + '">'
               + copy(vstrWork, pos(' ', vstrWork) + 1,99999)
               + '</td></tr>';
      vstlSearch[vintLoop]:= vstrWork;
      {Chapter}
      vstrWork:= copy(vstrPrefix,
                 pos('^' + #176, vstrPrefix) + 2,
                 pos(#176 + '^', vstrPrefix) - pos('^' + #176, vstrPrefix) - 2);
      vstrChapterText:= GetOneLine(strtoint(vstrWork));
      TrimCodes(vstrChapterText, false);
      MixCase(vstrChapterText);
      vstrChapterText:=
                '<tr valign=bottom><td width="60"><font size="2">&nbsp'
              + '</td><td width="'
              + inttostr(vintTableSize-60) + '"><font size="2">'
              + '<a href="http://' + vstrWebAddress
              + '/cgi-bin/MudsoxICD9.DLL/SectionList?Chapter='
              + vstrWork + '">'
              + vstrChapterText
              + '</a></td></tr>';
      vstlChapter.add(vstrChapterText);
      end;
  for vintLoop:= 0 to vstlLinks.count - 1 do
     begin
     vstrWork := vstlLinks[vintLoop];
     vstrWork:=
            '&nbsp<a href="http://' + vstrWebAddress
           + '/cgi-bin/MudsoxICD9.DLL/Search?Search='
           + vstrWork + '">' + vstrWork + '</a><BR>';
     vstlLinks[vintLoop]:= vstrWork;
     end;
  {Interlace the search results with the chapter descriptions}
  For vintLoop:= 0 to vstlSearch.Count - 1 do
    vstlSearchAnswer.add(vstlSearch[vintLoop] + vstlChapter[vintLoop]);
  finally
    vstlSearch.free;
    vstlChapter.free;
    end;
end;

Procedure tICD9processes.LinkToHTML
                          (var vstlDetail: tstringlist; const cstrPalm: string);
  var vstrHoldLink: string;
      vintLoop: integer;
begin
try
for vintLoop:= 0 to vstlDetail.count - 1 do
  begin
  vstrHoldLink:= vstlDetail[vintLoop];
  LinkLineToHTML(vstrHoldLink, cstrPalm);
  vstlDetail[vintLoop]:= vstrHoldLink;
  end;
except
  LogIT('Error in LinkToHTML');
  end;
end;

Procedure tICD9processes.LinkLineToHTML
                                 (var vstrLink: string; const cstrPalm: string);
  var vstrWork, vstrHoldLink: string;
      vintLinkPos1A,
      vintLinkPos1B,
      vintLinkPos2A,
      vintLinkPos2B,
      vintStartText: integer;
begin
  {Range links}
  vstrHoldLink:= vstrLink;
  vintLinkPos1B:= pos(#170 + '^-', vstrHoldLink);
  while vintLinkPos1B > 0 do
    begin
    vintLinkPos2A:= vintLinkPos1B;
    while copy(vstrHoldLink, vintLinkPos2A,2) <> '^' + #170 do
        inc(vintLinkPos2A);

    vintLinkPos2B:= vintLinkPos2A;
    while copy(vstrHoldLink, vintLinkPos2B,2) <> #170 + '^' do
        inc(vintLinkPos2B);

    vintLinkPos1A:= vintLinkPos1B;
    while copy(vstrHoldLink,vintLinkPos1A,2) <> '^' + #170 do
      dec(vintLinkPos1A);

    vintStartText:= vintLinkPos1A;
    while (vintStartText > 0) and
        (vstrHoldLink[vintStartText] <> ' ') and
        (vstrHoldLink[vintStartText] <> ';') and
        (vstrHoldLink[vintStartText] <> ',') and
        (vstrHoldLink[vintStartText] <> '(') and
        (vstrHoldLink[vintStartText] <> '[') and
        (vstrHoldLink[vintStartText] <> '>') and
        (vstrHoldLink[vintStartText] <> '|') do
          dec(vintStartText);
    inc(vintStartText);

    {Major copy statement to remove links and apply range HTML link}
    vstrWork:= copy(vstrHoldLink, 1, vintStartText - 1) +
             '<a href="http://' + vstrWebAddress +
             '/cgi-bin/MudsoxICD9.DLL/' +
             cstrPalm +
             'CodeRange?Range=' +
             copy(vstrHoldLink,vintLinkPos1a+2,(vintLinkPos1b-vintLinkPos1a)-2)+
             '-' +
             copy(vstrHoldLink,vintLinkPos2a+2,(vintLinkPos2b-vintLinkPos2a)-2)+
             '">' +
             copy(vstrHoldLink,vintStartText,(vintLinkPos1a-vintStartText)) +
             copy(vstrHoldLink,vintLinkPos1b+2,(vintLinkPos2a-vintLinkPos1b)-2)+
             '</a>' +
             copy(vstrHoldLink, vintLinkPos2b + 2, 999999);

    vstrHoldLink:= vstrWork;
    vintLinkPos1B:= pos(#170 + '^-', vstrHoldLink);
    end;
  {Individual Links}
  vintLinkPos1A:= pos('^' + #170, vstrHoldLink);
  while vintLinkPos1A > 0 do
    begin
    vintLinkPos1B:= pos(#170 + '^', vstrHoldLink);

    vintStartText:= vintLinkPos1A;
    while (vintStartText > 0) and
        (vstrHoldLink[vintStartText] <> ' ') and
        (vstrHoldLink[vintStartText] <> ';') and
        (vstrHoldLink[vintStartText] <> ',') and
        (vstrHoldLink[vintStartText] <> '(') and
        (vstrHoldLink[vintStartText] <> '[') and
        (vstrHoldLink[vintStartText] <> '>') and
        (vstrHoldLink[vintStartText] <> '|') do
          dec(vintStartText);
    inc(vintStartText);
    {Major copy statement to remove links and apply range HTML link}
    vstrWork:= copy(vstrHoldLink, 1, vintStartText - 1) +
             '<a href="http://' + vstrWebAddress +
             '/cgi-bin/MudsoxICD9.DLL/' +
             cstrPalm +
             'Code?Code=' +
             copy(vstrHoldLink,vintStartText,(vintLinkPos1a-vintStartText)) +
             '">' +
             copy(vstrHoldLink,vintStartText,(vintLinkPos1a-vintStartText)) +
             '</a>' +
             copy(vstrHoldLink, vintLinkPos1b + 2, 999999);

    vstrHoldLink:= vstrWork;
    vintLinkPos1A:= pos('^' + #170, vstrHoldLink);
    end;
  vstrLink:= vstrHoldLink;
end;

{Change the single code text into HTML}
Procedure tICD9processes.CodeToHTML(var vstrCodeDesc: string);
  var vintLoop: integer;
      vstrHTML, vstrSingleLine: string;
      vbolMajorBreak, vbolMinorBreak: boolean;

  Procedure ProcessMajorBreak(const cstrBreak: string);
      begin
      If length(vstrSingleLine) = 0 then
         If copy(vstrHTML, length(vstrHTML) - 3, 4) = '<BR>' then
            vstrHTML:= copy(vstrHTML, 1, length(vstrHTML) - 4);
      If vbolMinorBreak then
         begin
         If length(vstrSingleLine) > 0 then
                 vstrSingleLine:= '<dd>' + vstrSingleLine + '</dd>';
         vstrHTML:= vstrHTML + vstrSingleLine + '</dl>';
         vstrSingleLine:= '';
         end;
      If vbolMajorBreak then
         vstrSingleLine:= '<dd>' + vstrSingleLine + '</dd></dl>';
//      vstrSingleLine:= vstrSingleLine + '<dl><b>' + cstrBreak + '</b><dd>';
      vstrSingleLine:= vstrSingleLine + '<dl><b>' + cstrBreak + '</b>';
      vbolMajorBreak:= true;
      vbolMinorBreak:= false;
      vstrHTML:= vstrHTML + vstrSingleLine;
      vstrSingleLine:= '';
      end;

  Procedure ProcessMinorBreak;
      begin
      If length(vstrSingleLine) = 0 then
        If copy(vstrHTML, length(vstrHTML) - 3, 4) = '<BR>' then
           vstrHTML:= copy(vstrHTML, 1, length(vstrHTML) - 4);
      If vbolMinorBreak then
        vstrSingleLine:= '</dd></dl><dl><i>' + vstrSingleLine + ':</i>'
      else
        vstrSingleLine:= '<dl><i>' + vstrSingleLine + ':</i>';
      vbolMinorBreak:= true;
      vstrHTML:= vstrHTML + vstrSingleLine;
      vstrSingleLine:= '';
      end;

  Procedure LineEnd;
      begin
      If Length(vstrSingleLine) > 0 then
        If vbolMinorBreak or vbolMajorBreak then
            vstrSingleLine:= '<dd>' + vstrSingleLine + '</dd>'
        else
            vstrSingleLine:= vstrSingleLine + '<BR>';
      vstrHTML:= vstrHTML + vstrSingleLine;
      vstrSingleLine:= '';
      end;

begin
try
If pos('~~', vstrCodeDesc) > 0 then
    vstrCodeDesc:= copy(vstrCodeDesc, 1, pos('~~', vstrCodeDesc) - 1);

vbolMajorBreak:= false;
vbolMinorBreak:= false;
//  LogIt(vstrCodeDesc);
For vintLoop:= 1 to length(vstrCodeDesc) do
    begin
    If (copy(vstrCodeDesc, vintLoop - 1, 2) = '^|') or
         (copy(vstrCodeDesc, vintLoop - 1, 2) = '^' + #171) or
         (copy(vstrCodeDesc, vintLoop - 1, 2) = '^' + #172) or
         (copy(vstrCodeDesc, vintLoop - 1, 2) = '^' + #173) or
         (copy(vstrCodeDesc, vintLoop - 1, 2) = '^' + #174) or
         (copy(vstrCodeDesc, vintLoop - 1, 2) = '^' + #175) or
         (copy(vstrCodeDesc, vintLoop - 1, 2) = '|' + #174) or
         (copy(vstrCodeDesc, vintLoop - 1, 2) = '|' + #175) then
    else
    If copy(vstrCodeDesc, vintLoop, 2) = '^|' then
       LineEnd
    else
    If copy(vstrCodeDesc, vintLoop, 2) = '^' + #174 then
       LineEnd
    else
    If copy(vstrCodeDesc, vintLoop, 2) = '^' + #175 then
       LineEnd
    else
    If copy(vstrCodeDesc, vintLoop, 2) = '^' + #172 then
       ProcessMajorBreak('Excludes:')
    else
    If copy(vstrCodeDesc, vintLoop, 2) = '^' + #171 then
       ProcessMajorBreak('Includes:')
    else
    If copy(vstrCodeDesc, vintLoop, 2) = '^' + #173 then
       ProcessMajorBreak('Notes:')
    else
    If copy(vstrCodeDesc, vintLoop, 2) = '|' + #174 then
       ProcessMajorBreak('4th digit:')
    else
    If copy(vstrCodeDesc, vintLoop, 2) = '|' + #175 then
       ProcessMajorBreak('5th digit:')
    else
    If copy(vstrCodeDesc, vintLoop, 1) = ':' then
       begin
       If copy(vstrHTML, 1, 5) = '369.9' then
          vstrSingleLine:= vstrSingleLine + '&nbsp;'
       else
          ProcessMinorBreak;
       end
    else
    If copy(vstrCodeDesc, vintLoop, 2) = '  ' then
       vstrSingleLine:= vstrSingleLine + '&nbsp;'
    else
       vstrSingleLine:= vstrSingleLine + copy(vstrCodeDesc, vintLoop, 1);
    end;
{Write any left-over line}
If Length(vstrSingleLine) > 0 then
    LineEnd;
{Close any open DL combinations}
If vbolMinorBreak then
  vstrHTML:= vstrHTML + '</dl>';
If vbolMajorBreak then
  vstrHTML:= vstrHTML + '</dl>';

If copy(vstrHTML, 1, 5) = '369.9' then
    vstrHTML:= copy(vstrHTML, 1, 6) +
              '<font face="Courier New"><font size="1">' +
              copy(vstrHTML, 7, 9999) + '</font>';

vstrCodeDesc:= vstrHTML;
except
  LogIT('Error in CodeToHTML');
  end;
end;

Procedure tICD9processes.ConvertToStringList(const cstrLongString: string;
                                      var vstlCode: tstringlist);
  var vintLoop: longint;
      vstrWork: string;
begin
try
For vintLoop:= 1 to length(cstrLongString) do
    begin
    vstrWork:= vstrWork + copy(cstrLongString,vintLoop,1);
    If (length(vstrWork) > 0) and
       (vintLoop < length(cstrLongString)) and
       (vintLoop > 4) then
      If (uppercase(copy(cstrLongString,vintLoop-3,4)) = '<BR>')
      or (uppercase(copy(cstrLongString,vintLoop-4,5)) = '</TR>')
      or (uppercase(copy(cstrLongString,vintLoop+1,4)) = '<DD>')
       or (uppercase(copy(cstrLongString,vintLoop+1,4)) = '<DL>') then
        begin
        vstlCode.add(vstrWork);
        vstrWork:= '';
        end;
    end;
If length(vstrWork) > 0 then
    vstlCode.add(vstrWork);
except
  LogIT('Error in ConvertToStringList');
  end;
end;

Procedure tICD9processes.ProcessNeoplasm(var vstrCodeDesc: string);
var vintLoop, vintHoldIndent: integer;
    vstrFormatted: string;
    Procedure SetIndent;
      var vintLoop2: integer;
      begin
      For vintLoop2:= 0 to vintHoldIndent do
         vstrFormatted:= vstrFormatted + '&nbsp;&nbsp;&nbsp;&nbsp;';
      end;
begin
{Neoplasm is formatted into a huge table that contains thousands of cross links}
vintLoop:= pos('^|', vstrCodeDesc) + 2;
vstrFormatted:= copy(vstrCodeDesc, 1, pos('^|', vstrCodeDesc) - 1) +
    '<br><TABLE WIDTH="' +
      inttostr(vintTableSize) +
      '" BORDER=0 CELLPADDING=0 CELLSPACING=0>';
{Comments span columns with ^s^ command}
If copy(vstrCodeDesc, vintLoop + 2, 3) = '^s^' then
   vstrFormatted:= vstrFormatted + '<tr><td width=' +
      inttostr(vintTableSize-5) + ' colspan=7><font size="2">'
else
   vstrFormatted:= vstrFormatted + '<tr><td width=295><font size="2">';

while vintLoop <= length(vstrCodeDesc) do
   begin
   If copy(vstrCodeDesc, vintLoop, 2) = '^|' then
     begin
     {Span columns}
     If copy(vstrCodeDesc, vintLoop + 2, 3) = '^s^' then
         vstrFormatted:= vstrFormatted +
                '</font></td></tr><tr><td width="' +
                inttostr(vintTableSize-5) + '" colspan=7><font size="2">'
     else
     {Define all columns}
         vstrFormatted:= vstrFormatted +
                 '</font></td></tr><tr><td width=295><font size="2">';
     vintLoop:= vintLoop + 2;
     end
   else
   {Drop the span code - handled in the last IF}
   If copy(vstrCodeDesc, vintLoop, 3) = '^s^' then
     begin
     vintLoop:= vintLoop + 3;
     end
   else
   If copy(vstrCodeDesc, vintLoop, 3) = '^c^' then
     begin
     vstrFormatted:= vstrFormatted + '</font></td><td width=50><font size="2">';
     vintLoop:= vintLoop + 3;
     end
   else
   If (copy(vstrCodeDesc, vintLoop, 2) = '|i') and
      (copy(vstrCodeDesc, vintLoop + 3, 1) = '|') then
     begin
     vintHoldIndent:= strtoint(copy(vstrCodeDesc, vintLoop + 2, 1));
     SetIndent;
     vintLoop:= vintLoop + 4;
     end
   else
     begin
     vstrFormatted:= vstrFormatted + copy(vstrCodeDesc, vintLoop, 1);
     inc(vintLoop);
     end;
   end;
vstrCodeDesc:= vstrFormatted + '</font></td></tr></table>';
end;

procedure tICD9processes.IndexSummaryToHTML(var vstlAlpha: tstringlist);
var vintLoop, vintLinkLoc: integer;
    vstrWork: string;
begin
  for vintLoop:= 0 to vstlAlpha.count - 1 do
     begin
     vstrWork:= vstlAlpha[vintLoop];
     LinkLineToHTML(vstrWork, '');
     vintLinkLoc:= pos('~~', vstrWork);
     vstrWork:=
       '<a href="http://' + vstrWebAddress +
       '/cgi-bin/MudsoxICD9.DLL/IndexDetail?Detail=' +
        copy(vstrWork, vintLinkLoc + 2, 99999) +
       '">' + copy(vstrWork, 1, vintLinkLoc - 1) +
       '</a><br>';
     vstlAlpha[vintLoop]:= vstrWork;
     end;
end;

Procedure tICD9processes.IndexToHTML(var vstrCodeDesc: string);
var vstrWork: string;
    vintLoop: integer;
    vintHoldIndent: integer;
    Procedure NewIndentLine;
      var vintLoop2: integer;
      begin
      vstrWork:= vstrWork + '<br>';
      For vintLoop2:= 0 to vintHoldIndent do
         vstrWork:= vstrWork + '&nbsp;&nbsp;&nbsp;&nbsp;';
      end;
   function TakeIndexAction: boolean;
      begin
      Result:= false;
      If (copy(vstrCodeDesc, vintLoop, 6) = '|Note|') then
        begin
        NewIndentLine;
        vstrWork:= vstrWork + 'Note: ';
        vintLoop:= vintLoop + 6;
        Result:= true;
        end
      else
      If (copy(vstrCodeDesc, vintLoop, 2) = '^|') and
         (copy(vstrCodeDesc, vintLoop-1, 1) <> #170) then
        begin
        NewIndentLine;
        inc(vintLoop);
        inc(vintLoop);
        Result:= true;
        end
      else
      If (copy(vstrCodeDesc, vintLoop, 2) = '|i') and
         (copy(vstrCodeDesc, vintLoop + 3, 1) = '|') then
        begin
        vintHoldIndent:= strtoint(copy(vstrCodeDesc, vintLoop + 2, 1));
        NewIndentLine;
        vintLoop:= vintLoop + 4;
        Result:= true;
        end;
   end;
begin
try
vintLoop:= 1;
vintHoldIndent:= 0;
while vintLoop <= length(vstrCodeDesc) do
   begin
   While TakeIndexAction do ;
   vstrWork:= vstrWork + copy(vstrCodeDesc, vintLoop, 1);
   inc(vintLoop);
   end;
vstrCodeDesc:= vstrWork;
except
  LogIT('Error in IndexToHTML');
  end;
end;

{Add and rotate the bookmarks for the ICD9 screens and save them as cookies}
function tICD9processes.TestBookmark(vreqWeb: TwebRequest): boolean;
begin
Result:= false;
try
  If pos('=' + vstrCodeString + #13, vreqWeb.CookieFields.Text) > 0 then
      Result:= true;
  except
    LogIT('Error in TestBookmark');
    end;
end;

{-----------------ADVERTISING ROUTINES-----------------------}
Procedure tICD9processes.BuildAdInfo(const cstrType: string);
    begin
    try
      AssignAd('L', vstrBigLink, vstrBigImg, vstrBigText, vintBigAd);
      AssignAd('S', vstrSmallLink, vstrSmallImg, vstrSmallText, vintLittleAd);
    except
      vstrBigLink:=
               'http://' + vstrWebAddress + '/BugReport.html';
      vstrSmallLink:= vstrBigLink;
      vstrBigImg:='';
      vstrSmallImg:= '';
      vstrBigText:='';
      vstrSmallText:= '';
      end;
    end;
Procedure tICD9processes.AssignAd(const cstrType: string;
                     var vstrLink: string;
                     var vstrImg: string;
                     var vstrText: string;
                     var vintLoc: integer);
    var
      vbolSearchDone: boolean;
      vintLoop: integer;
      vstrHoldCodes, vstrCheckString: string;
    begin
    vbolSearchDone:= false;
    vintLoop:= -1;
    If pos('.', vstrCodeString) > 0 then
       vstrCheckString:= copy(vstrCodeString, 1, pos('.', vstrCodeString)-1)
    else
       vstrCheckString:= vstrCodeString;
    {First, see if there is a code override for this page}
    If vbolCode then
      While not vbolSearchDone do
        begin
        inc(vintLoop);
        If vintLoop = vstlAds.count then
           break;
        If pos('^8^' + cstrType, vstlAds[vintLoop]) > 0 then
           begin
           vstrHoldCodes:= copy(vstlAds[vintLoop],
                            pos('^6^',vstlAds[vintLoop]) + 3,
                            pos('^7^',vstlAds[vintLoop]) - 3 -
                                                 pos('^6^',vstlAds[vintLoop]));
           If pos(vstrCheckString, vstrHoldCodes) > 0 then
              begin
              vstrLink:= copy(vstlAds[vintLoop],
                            pos('^3^',vstlAds[vintLoop]) + 3,
                            pos('^4^',vstlAds[vintLoop]) - 3 -
                                                 pos('^3^',vstlAds[vintLoop]));
              vstrText:= copy(vstlAds[vintLoop],
                            pos('^5^',vstlAds[vintLoop]) + 3,
                            pos('^6^',vstlAds[vintLoop]) - 3 -
                                                 pos('^5^',vstlAds[vintLoop]));
              vstrImg:= copy(vstlAds[vintLoop],
                            pos('^2^',vstlAds[vintLoop]) + 3,
                            pos('^3^',vstlAds[vintLoop]) - 3 -
                                                 pos('^2^',vstlAds[vintLoop]));
              vbolSearchDone:= true;
              end;
           end;
        end;
    {Search for the next available ad in the rotation if no match was found
    in the loop above.}
    While not vbolSearchDone do
      begin
      inc(vintLoc);
      If vintLoc = vstlAds.count then
         vintLoc:= 0;
      If pos('^8^' + cstrType, vstlAds[vintLoc]) > 0 then
         begin
         vstrLink:= copy(vstlAds[vintLoc],
                            pos('^3^',vstlAds[vintLoc]) + 3,
                            pos('^4^',vstlAds[vintLoc]) - 3 -
                                                 pos('^3^',vstlAds[vintLoc]));
         vstrText:= copy(vstlAds[vintLoc],
                            pos('^5^',vstlAds[vintLoc]) + 3,
                            pos('^6^',vstlAds[vintLoc]) - 3 -
                                                 pos('^5^',vstlAds[vintLoc]));
         vstrImg:= copy(vstlAds[vintLoc],
                            pos('^2^',vstlAds[vintLoc]) + 3,
                            pos('^3^',vstlAds[vintLoc]) - 3 -
                                                 pos('^2^',vstlAds[vintLoc]));
         vbolSearchDone:= true;
         end;
      end;
    end;

{----------------------------END Advertising---------------------------}

Procedure tICD9processes.CheckCurrentSkin(const cstrSkin: string;
                                          var pgpTemplate: TPageProducer);
  var vstrWork: string;
  begin
  vstrWork:= LoadSkin(cstrSkin);
  If vstrWork > '   A' then
      vstlCurrentSkin.text:= vstrWork;
  pgpTemplate.HTMLDoc.text:= vstlCurrentSkin.text;
  end;

Procedure tICD9processes.InitializeCookies(const Request: TWebRequest;
                                      var Response: TwebResponse);
  var vintLoop: integer;
begin

  Response.SetCookieField(Request.CookieFields, '', '', now + 365, false);

  {If there are no cookies, build the blank cookie list}
  If Request.CookieFields.count < 10 then
     for vintLoop:= Request.CookieFields.count to 9 do
         with Response.Cookies.Add do
            begin
            Name:= 'MARK' + inttostr(vintLoop);
            Value:= 'X';
            end;

  If Response.Cookies.count < 11 then
     with Response.Cookies.Add do
       begin
       Name:= 'SKIN';
       Value:= 'default.htm';
       end
  else
  If Response.Cookies[10].Name <> 'SKIN' then
     begin
     Response.Cookies[10].Name:= 'SKIN';
     Response.Cookies[10].Value:= 'default.htm';
     end;

end;

{------------------------------------------------------------------------------}
function tICD9processes.IndexArrayLocate(const cstrSearch: string): integer;
 var
     vchr1, vchr2: char;
     vint1, vint2: integer;
  begin
  {Translate 2 uppercase letter ASCII values to one integer using
   base 26.}
   Result:= 0;
   If length(cstrSearch) < 2 then
     exit;
   vchr1:= uppercase(copy(cstrSearch,1,1))[1];
   vchr2:= uppercase(copy(cstrSearch,2,1))[1];
   vint1:= ord(vchr1) - 65;
   vint2:= ord(vchr2) - 64;
   {If the codes are in the range 1 to 676, OK}
   If (vint1 > -1) and
      (vint1 < 26) and
      (vint2 > 0) and
      (vint2 < 27) then
        Result:= (vint1*26)+vint2;
  end;

function tICD9processes.ICD9GetCode(const cstrCode: string;
                     const cbolShortCode: boolean;
                     var vstlMoreKeys: tstringlist): string;
 var vintLoop1, vintLoop2, vintStart, vint45: integer;
     vstrTestCode, vstrBuildResponse, vstrWorkPrefix, vstrWork: string;
     vbolTest: boolean;
     function CodeLocate(const cstrCheck: string;
                         const cintStart: integer): boolean;
        begin
        Result:= false;
        vintLoop2:= cintStart;
        try
        while cstrCheck >=
              copy(vstlICD9[vintLoop2], 1, pos(' ', vstlICD9[vintLoop2]) - 1) do
          begin
          If cstrCheck =
            copy(vstlICD9[vintLoop2], 1, pos(' ', vstlICD9[vintLoop2]) - 1) then
            begin
            Result:= true;
            break;
            end
          else
            inc(vintLoop2);
          end;
          except
            Result:= false;
            end;
        end;
begin
try
Result:= 'NOT FOUND';
vstrTestCode:= cstrCode;
If uppercase(copy(vstrTestCode,1,1)) = 'E' then
  begin
  vintLoop1:= strtoint(copy(cstrCode,2,3));
  If (vintLoop1 > 999) or (vintLoop1 < 800) then
     exit;
  vintStart:= varrE[vintLoop1-799];
  vbolTest:= CodeLocate(vstrTestCode, vintStart);
  If not vbolTest then
     If length(vstrTestCode) = 6 then
        begin
        vstrTestCode:= copy(vstrTestCode,1,4);
        vbolTest:= CodeLocate(vstrTestCode, vintStart);
        end;
  end
else
If uppercase(copy(vstrTestCode,1,1)) = 'V' then
  begin
  vintLoop1:= strtoint(copy(cstrCode,2,2));
  If (vintLoop1 > 99) or (vintLoop1 < 1) then
     exit;
  vintStart:= varrV[vintLoop1];
  vbolTest:= CodeLocate(vstrTestCode, vintStart);
  If not vbolTest then
     If length(vstrTestCode) = 6 then
        begin
        vstrTestCode:= copy(vstrTestCode,1,5);
        vbolTest:= CodeLocate(vstrTestCode, vintStart);
        end;
  If not vbolTest then
     If length(vstrTestCode) = 5 then
        begin
        vstrTestCode:= copy(vstrTestCode,1,3);
        vbolTest:= CodeLocate(vstrTestCode, vintStart);
        end;
  end
else
  {Process a regular code}
  begin
  vintLoop1:= strtoint(copy(cstrCode,1,3));
  If (vintLoop1 > 999) or (vintLoop1 < 1) then
     exit;
  vintStart:= varrReg[vintLoop1];
  vbolTest:= CodeLocate(cstrCode, vintStart);
  If not vbolTest then
     If length(vstrTestCode) = 6 then
        begin
        vstrTestCode:= copy(vstrTestCode,1,5);
        vbolTest:= CodeLocate(vstrTestCode, vintStart);
        end;
  If not vbolTest then
     If length(vstrTestCode) = 5 then
        begin
        vstrTestCode:= copy(vstrTestCode,1,3);
        vbolTest:= CodeLocate(vstrTestCode, vintStart);
        end;
  end;
{Did the code find a match?}
If vbolTest then
   begin
   vstrBuildResponse:= vstlICD9[vintLoop2] + ' ';
   If not cbolShortCode then
     begin
     {Append the 4th and 5th digit text to the full-siz request}
     vstrWorkPrefix:= copy(vstlICD9pre[vintLoop2],
                          pos('^', vstlICD9pre[vintLoop2]), 99999);
     If pos('^' + #174, vstrWorkPrefix) > 0 then
        begin
        vint45:= strtoint(copy(vstrWorkPrefix,
                        pos('^' + #174, vstrWorkPrefix) + 2,
                        (pos(#174 + '^', vstrWorkPrefix)
                                - pos('^' + #174, vstrWorkPrefix)) - 2));
        vstrBuildResponse:= vstrBuildResponse + '|'+ #174 + vstlICD9[vint45];
        end;
     If pos('^' + #175, vstrWorkPrefix) > 0 then
        begin
        vint45:= strtoint(copy(vstrWorkPrefix,
                        pos('^' + #175, vstrWorkPrefix) + 2,
                        (pos(#175 + '^', vstrWorkPrefix)
                                - pos('^' + #175, vstrWorkPrefix)) - 2));
        vstrBuildResponse:= vstrBuildResponse + '|' + #175 + vstlICD9[vint45];
        end;
     {Create a code list of any sub-cat codes beneath this one}
     If pos('^' + #178, vstrWorkPrefix) = 0 then
       begin
       inc(vintLoop2);
       while copy(vstlICD9[vintLoop2],1,length(cstrCode)) = cstrCode do
         begin
         vstrWork:= vstlICD9[vintLoop2];
         TrimCodes(vstrWork, false);
         vstlMoreKeys.add(vstrWork);
         inc(vintLoop2);
         end;
      end;
     end
   else
     begin
     TrimCodes(vstrBuildResponse, false);
     end;
   Result:= vstrBuildResponse + '~~' + vstlICD9pre[vintLoop2];
   end;
except
  LogIT('Error in the retrieval of ICD9GetCode ' + cstrCode);
  end;
end;

function tICD9processes.ICD9Search(const cstrText: string;
                     var vstlAnswers: tstringlist;
                     var vstlLinks: tstringlist): integer;
var vintLoop, vintCount, vintLoc: integer;
    vstrSingleLine, vstrLongString: string;
    varrSearchWords: array [1..10] of string;
    {Find a long word that matches the short search word}
    Procedure CheckLink;
      var vstrFullWord, vstrTest: string;
          vintLoop2: integer;
      begin
      vintLoop2:= 1;
      while varrSearchWords[vintLoop2] > '  A' do
        begin
        vstrTest:= '^ ' + vstrSingleLine;
        vintLoc:= pos(varrSearchWords[vintLoop2], vstrTest);
        {Go back to find the beginning of the first word}
        while (copy(vstrTest, vintLoc, 1) > ' ')
            and (copy(vstrTest, vintLoc, 1) <> '(')
            and (copy(vstrTest, vintLoc, 1) <> '[')
            and (copy(vstrTest, vintLoc - 2, 1) <> '^')
            and (vintLoc > 2) do
            dec(vintLoc);
        {Trim off unwanted character from the front}
        If (copy(vstrTest, vintLoc, 1) = ' ') or
           (copy(vstrTest, vintLoc, 1) = '[') or
           (copy(vstrTest, vintLoc, 1) = '(') then
           inc(vintLoc);
        {Go forward to find the end of the first word}
        while (copy(vstrTest, vintLoc, 1) > ' ')
            and (copy(vstrTest, vintLoc, 1) <> '^')
            and (copy(vstrTest, vintLoc, 1) <> ',')
            and (copy(vstrTest, vintLoc, 1) <> ')')
            and (copy(vstrTest, vintLoc, 1) <> ']')
            and (copy(vstrTest, vintLoc, 1) <> ':')
            and (vintLoc <= length(vstrTest)) do
            begin
            vstrFullWord:= vstrFullWord + copy(vstrTest, vintLoc, 1);
            inc(vintLoc);
            end;
        {If the first search word is }
        If length(vstrFullWord) > 2 then
         If lowercase(vstrFullWord)<>lowercase(varrSearchWords[vintLoop2]) then
          If vstlLinks.IndexOf(lowercase(vstrFullWord)) = -1 then
             vstlLinks.add(lowercase(vstrFullWord));
        inc(vintLoop2);
        end;
      end;
    {Test all words against the long string description of the ICD9 line}
    function TestMatchFound: boolean;
      var vintLoop2: integer;
       begin
       Result:= true;
       For vintLoop2:= 1 to 10 do
           begin
           If length(varrSearchWords[vintLoop2]) = 0 then
              break;
           If pos(uppercase(varrSearchWords[vintLoop2]),
                  uppercase(vstrSingleLine)) = 0 then
              begin
              Result:= false;
              break;
              end;
           end;
       end;
      Procedure AddBoldCodes;
        var vintLoop2: integer;
        begin
        vintLoop2:=1;
        while varrSearchWords[vintLoop2] > '  A' do
          begin
          vintLoc:= pos(uppercase(varrSearchWords[vintLoop2]),
                        uppercase(vstrSingleLine));
          If vintLoc > 3 then
             begin
             {This is the tag to assign bold to the matched word}
             vstrSingleLine:= copy(vstrSingleLine,1,
                              vintLoc+length(varrSearchWords[vintLoop2])-1)
                  + #179 + '^' +
                  copy(vstrSingleLine,
                       vintLoc + length(varrSearchWords[vintLoop2]), 999);
             vstrSingleLine:= copy(vstrSingleLine, 1, vintLoc - 1) +
                  '^' + #179 +
                  copy(vstrSingleLine, vintLoc, 999);
             end;
          inc(vintLoop2);
          end;
        end;
begin
vintCount:= 0;
try
vstrLongString:= cstrText;
{Fill in the array of search words and blank out the remaining entries}
For vintLoop:= 1 to 10 do
   begin
   If pos(' ',vstrLongString) = 0 then
      begin
      varrSearchWords[vintLoop]:= vstrLongString;
      vstrLongString:= '';
      end
   else
      begin
      varrSearchWords[vintLoop]:=
         copy(vstrLongString,1,pos(' ',vstrLongString)-1);
      vstrLongString:= copy(vstrLongString,pos(' ',vstrLongString)+1,999);
      end;
   end;
vintLoop:= varrReg[1];
while copy(vstlICD9[vintLoop],1,1) <> '=' do
  begin
  vstrSingleLine:= vstlICD9[vintLoop];
  If TestMatchFound then
    begin
    CheckLink;
    TrimCodes(vstrSingleLine, false);
    AddBoldCodes;
    If vintCount < 20 then
        vstlAnswers.add(vstrSingleLine + '~~' + vstlICD9pre[vintLoop]);
    inc(vintCount);
    end;
  inc(vintLoop);
  end;
except
  LogIT('Error in the retrieval of ICD9Search ' + cstrText);
  end;
Result:= vintCount;
end;

Procedure tICD9processes.ICD9Chapter(var vstlAnswers: tstringlist);
var vintLoop: integer;
    vstrWork: string;
begin
try
vintLoop:= 1;
while copy(vstlICD9[vintLoop],1,1) <> '=' do
  begin
  vstrWork:= vstlICD9[vintLoop];
  TrimCodes(vstrWork, false);
  MixCase(vstrWork);
  If (pos('^' + #173, vstlICD9[vintLoop]) > 0) or
     (pos('^' + #172, vstlICD9[vintLoop]) > 0) or
     (pos('^' + #171, vstlICD9[vintLoop]) > 0) or
     (pos('^|', vstlICD9[vintLoop]) > 0) then
         vstrWork:= vstrWork + '[D';
  vstlAnswers.add(vstrWork);
  inc(vintLoop);
  end;
except
  LogIT('Error in the retrieval of ICD9Chapter');
  end;
end;

Procedure tICD9processes.Mixcase(var vstrUpper: string);
var vintLoop: integer;
begin
try
for vintLoop:= 2 to length(vstrUpper) do
  If (copy(vstrUpper,vintLoop-1,1) = ' ') or
     (copy(vstrUpper,vintLoop-1,1) = '-') or
     (copy(vstrUpper,vintLoop-1,1) = '(') or
     (copy(vstrUpper,vintLoop-1,1) = '^') or
     ((copy(vstrUpper,vintLoop+1,1) = '^') and
      (copy(vstrUpper,vintLoop,1) = 'L')) then
  else
      vstrUpper:= copy(vstrUpper,1,vintLoop-1) +
                  lowercase(copy(vstrUpper,vintLoop,1)) +
                  copy(vstrUpper,vintLoop+1,99999);
except
  LogIT('Error in Mixcase ' + vstrUpper);
  end;
end;

Procedure tICD9processes.TrimCodes
                                (var vstrTrim: string; const vbolLink: boolean);
begin
try
  {|i and |Note| are Index file markers}
  If (pos('|i', vstrTrim) > 0) then
       If copy(vstrTrim, pos('|i', vstrTrim) + 3, 1) = '|' then
           vstrTrim:= copy(vstrTrim, 1, pos('|i', vstrTrim)-1);
  If (pos('|Note|', vstrTrim) > 0) then
           vstrTrim:= copy(vstrTrim, 1, pos('|Note|', vstrTrim)-1);
  {The Data file markers for Notes, Includes and Excludes}
  If pos('^' + #173, vstrTrim) > 0 then
       vstrTrim:= copy(vstrTrim,1,pos('^' + #173, vstrTrim)-1);
  If pos('^' + #172, vstrTrim) > 0 then
       vstrTrim:= copy(vstrTrim,1,pos('^' + #172, vstrTrim)-1);
  If pos('^' + #171, vstrTrim) > 0 then
       vstrTrim:= copy(vstrTrim,1,pos('^' + #171, vstrTrim)-1);
  If pos('^|', vstrTrim) > 0 then
       vstrTrim:= copy(vstrTrim,1,pos('^|', vstrTrim)-1);
  {Strip all link codes of either Data or Index File if Links is false}
  If not vbolLink then
    While pos('^' + #170, vstrTrim) > 0 do
       vstrTrim:= copy(vstrTrim,1,pos('^' + #170, vstrTrim)-1) +
                  copy(vstrTrim,pos(#170 + '^', vstrTrim)+2,999);
except
  LogIT('Error in TrimCodes ' + vstrTrim);
  end;
end;

{Link one chapter number to the list of sections in the chapter}
Procedure tICD9processes.ICD9SectionList(const cstrChapter: string;
                                         var vstlAnswers: tstringlist);
var vintLoop: integer;
    vstrWork: string;
begin
try
vstrWork:= vstlICD9[strtoint(cstrChapter)];
TrimCodes(vstrWork, false);
MixCase(vstrWork);
vstlAnswers.add(vstrWork);
vintLoop:= vintSectionStart + 1;
while copy(vstlICD9[vintLoop],1,4) <> '=4th' do
  begin
  If pos('^' + #176 + cstrChapter + #176 + '^', vstlICD9pre[vintLoop]) > 0 then
     begin
     vstrWork:= vstlICD9[vintLoop];
     TrimCodes(vstrWork, false);
     MixCase(vstrWork);
  If (pos('^' + #173, vstlICD9[vintLoop]) > 0) or
     (pos('^' + #172, vstlICD9[vintLoop]) > 0) or
     (pos('^' + #171, vstlICD9[vintLoop]) > 0) or
     (pos('^|', vstlICD9[vintLoop]) > 0) then
         vstrWork:= vstrWork + '[D' +inttostr(vintLoop) + ']';
     vstlAnswers.add(vstrWork + '^' + #177 + inttostr(vintLoop));
     end;
  inc(vintLoop);
  end;
except
  LogIT('Error in ICD9SectionList ' + cstrChapter);
  end;
end;

Procedure tICD9processes.ICD9Section(const cstrSection: string;
                      var vstlAnswers: tstringlist);
var vintLoop: integer;
    vstrWork, vstrChapterTag, vstrSectionTag, vstrSectionCode: string;
begin
try
{Put the one-line Chapter summary first}
vstrWork:= vstlICD9pre[strtoint(cstrSection)];
vstrChapterTag:= copy(vstrWork,
                     pos('^' + #176, vstrWork) + 2,
                     pos(#176 + '^', vstrWork) - (pos('^' + #176, vstrWork)+2));
vstrWork:= vstlICD9[strtoint(vstrChapterTag)];
TrimCodes(vstrWork, false);
MixCase(vstrWork);
vstlAnswers.add(vstrWork);
{Put the one-line Section summary next}
vstrWork:= vstlICD9pre[strtoint(cstrSection)];
vstrSectionTag:= cstrSection;
vstrWork:= vstlICD9[strtoint(vstrSectionTag)];
TrimCodes(vstrWork, false);
MixCase(vstrWork);
vstlAnswers.add(vstrWork);
{The starting location of the Detail Line for this section}
vintLoop:= vintDetailStart;
while copy(vstlICD9[vintLoop],1,5) <> '=DONE' do
  If pos('^' + #177 + vstrSectionTag + #177 + '^',
                                                 vstlICD9pre[vintLoop]) > 0 then
     break
  else
     inc(vintLoop);
while copy(vstlICD9[vintLoop],1,5) <> '=DONE' do
  begin
  vstrSectionCode:= copy(vstlICD9[vintLoop],1,pos(' ',vstlICD9[vintLoop])-1);
  If pos('.',vstrSectionCode) = 0 then
    If pos('^' + #177 + vstrSectionTag + #177 + '^',
                                                 vstlICD9pre[vintLoop]) > 0 then
       begin
       vstrWork:= vstlICD9[vintLoop];
       TrimCodes(vstrWork, false);
       MixCase(vstrWork);
       vstlAnswers.add(vstrWork + '^' + #177 + inttostr(vintLoop));
       end
    else
       break;
  inc(vintLoop);
  end;
except
  LogIT('Error in ICD9Section ' + cstrSection);
  end;
end;

Procedure tICD9processes.ICD9CodeRange(const cstrRange: string;
                      var vstlAnswers: tstringlist);
var vintCodeStart, vintCodeStop, vintLoop, vintLength: integer;
    vstrWork, vstrShortCode: string;
//    vbolNoDecimal: boolean;
begin
try
vintCodeStart:= strtoint(copy(cstrRange, 1, pos('-', cstrRange) - 1));
vintCodeStop:= strtoint(copy(cstrRange, pos('-', cstrRange) + 1, 99999));
vstrShortCode:= copy(vstlICD9[vintCodeStop], 1,
                              pos(' ', vstlICD9[vintCodeStop])-1);
{Advance the stop position to include all decimals under a main category code}
If pos('.', vstrShortCode) = 0 then
  while vstrShortCode = copy(vstlICD9[vintCodeStop + 1], 1,
                                                       length(vstrShortCode)) do
      inc(vintCodeStop);
{If there is no decimal on the first number in the range, use only matches with
the same number of digits.}
vstrShortCode:= copy(vstlICD9[vintCodeStop], 1,
                              pos(' ', vstlICD9[vintCodeStart])-1);
//vintLength:= 0;
//If pos('.', vstrShortCode) = 0 then
//  begin
//  vbolNoDecimal:= true;
  vintLength:= length(vstrShortCode);
//  end;
//else
//  vbolNoDecimal:= false;
{Loop through and find all code matches}
for vintLoop:= vintCodeStart to vintCodeStop do
  begin
  vstrWork:= vstlICD9[vintLoop];
  {NoDecimal codes should appear only if the first code in the range is no
  decimal}
  If (length(copy(vstrWork,1,pos(' ', vstrWork)-1)) <> vintLength) then
//     and vbolNoDecimal then
  else
     begin
     TrimCodes(vstrWork, false);
     MixCase(vstrWork);
     vstlAnswers.add(vstrWork);
     end;
  end;
except
  LogIT('Error in ICD9CodeRange ' + cstrRange);
  end;
end;

function tICD9processes.GetOneLine(const cintLine: integer): string;
begin
try
Result:= vstlICD9[cintLine];
except
  LogIT('Error in GetOneLine ' + inttostr(cintLine));
  end;
end;

Procedure tICD9processes.LogIT(const cstrMessage: string);
var vstrIP: string;
begin
try
  If vreqICD9 <> nil then
      vstrIP:= vreqICD9.RemoteAddr;
  If vbolLogToggle then
      begin
      vstlLogA.add(datetimetostr(now) + ' ' + vstrIP + ' ' + cstrMessage);
      //If vstlLogA.count > 10 then
          LogCheck;
      end
  else
      begin
      vstlLogB.add(datetimetostr(now) + ' ' + vstrIP + ' ' + cstrMessage);
      //If vstlLogB.count > 10 then
          LogCheck;
      end
  except
     end;
end;

{If there are log events waiting to be writen, switch the active stringlist
to the other toggle and write the inactive stringlist}
Procedure tICD9processes.LogCheck;
var
  vintLoop: integer;
  vtxtLog: textfile;
begin
{No log records in the last minute? Skip the write process.}
{Swap the active log to inactive so we can write all lines}
If vbolLogToggle then
  begin
  vbolLogToggle:= false;
  //vstlLogA.add(datetimetostr(now) + ' B LOG active');
  end
else
  begin
  vbolLogToggle:= true;
  //vstlLogB.add(datetimetostr(now) + ' A LOG active');
  end;
  //All of the log routines had trouble - removing for now
 try
  If vbolNoLog then
     begin
     vstrHoldLogName:= 'mudsox_' + floattostr(int(now*1000000)) + '.log';
     AssignFile(vtxtLog, vstrRootFolder + '\log\' + vstrHoldLogName);
     Rewrite(vtxtLog);
     CloseFile(vtxtLog);
     vbolNoLog:= false;
     end;
  AssignFile(vtxtLog, vstrRootFolder + '\log\' + vstrHoldLogName);
  try
     Append(vtxtLog);
     If vbolLogToggle then
         for vintLoop:= 0 to vstlLogB.count - 1 do
           begin
           writeln(vtxtLog, vstlLogB[vintLoop]);
           end
     else
         for vintLoop:= 0 to vstlLogA.count - 1 do
           begin
           writeln(vtxtLog, vstlLogA[vintLoop]);
           end;
     finally
       CloseFile(vtxtLog);
       end;
 except
   vbolNoLog:= true;
   end;
 If vbolLogToggle then
   vstlLogB.text:= ''
   //vstlLogB.text:= datetimetostr(now) + ' Clear B LOG'
 else
   vstlLogA.text:='';
   //vstlLogA.text:=  datetimetostr(now) + ' Clear A LOG';
 end;

{Free the memory from the stringlist}
Procedure tICD9processes.ICD9free;
begin
  If vstlICD9 <> nil then
     vstlICD9.free;
  vstlICD9:= nil;

  If vstlICD9Pre <> nil then
     vstlICD9Pre.free;
  vstlICD9Pre:= nil;

  If vstlLogA <> nil then
     vstlLogA.free;
  vstlLogA:= nil;

  If vstlLogB <> nil then
     vstlLogB.free;
  vstlLogB:= nil;

end;

{Routines to handle access of the index file}
Procedure tICD9processes.ICD9IndexLetter(const cstrLetter: string;
                          var vstlAnswers: tstringlist);
  var vintStart, vintLoop: integer;
      vstrWork: string;
begin
try
vintLoop:= ((ord(cstrLetter[1]) - 65) * 26) + 1;

while varrIndex[vintLoop] = 0 do
      inc(vintLoop);

vintStart:= varrIndex[vintLoop];
while uppercase(vstlICD9Index[vintStart][1]) = cstrLetter[1] do
     begin
     vstrWork:= FindIndexAbbreviation(vstlICD9Index[vintStart]);
     TrimCodes(vstrWork, true);
     vstlAnswers.add(vstrWork + '~~' + inttostr(vintStart));
     inc(vintStart);
     end;
except
  LogIT('Error in ICD9IndexLetter ' + cstrLetter);
  end;
end;

{Routines to handle access of the index file}
Procedure tICD9processes.ICD9IndexWordSearch(const cstrWord: string;
                                var vstlAnswers: tstringlist);
  var vintStart, vintLoop: integer;
      vstrWork, vstrAbbrev: string;
begin
try
if length(cstrWord) < 2 then
   exit;
vstrAbbrev:= uppercase(copy(cstrWord,1,2));
vintLoop:= IndexArrayLocate(vstrAbbrev);
{If no matches for this 2 letter abbreviation, exit}
if varrIndex[vintLoop] = 0 then
      exit;
{Find all words in the rang}
vintStart:= varrIndex[vintLoop];
while uppercase(copy(vstlICD9Index[vintStart],1,2)) = vstrAbbrev do
     begin
     If uppercase(copy(vstlICD9Index[vintStart],1,length(cstrWord)))
                                                      = uppercase(cstrWord) then
        begin
        vstrWork:= FindIndexAbbreviation(vstlICD9Index[vintStart]);
        TrimCodes(vstrWork, true);
        vstlAnswers.add(vstrWork + '~~' + inttostr(vintStart));
        end;
     inc(vintStart);
     end;
except
  LogIT('Error in ICD9IndexWord ' + cstrWord);
  end;
end;

Function tICD9processes.FindIndexAbbreviation(const cstrTest: string): string;
  var vstrWork: string;
begin
     vstrWork:= cstrTest;
     If pos('^|', vstrWork) > 0 then
        vstrWork:= copy(vstrWork,1,pos('^|', vstrWork)-1);
     If pos('|', vstrWork) > 0 then
        vstrWork:= copy(vstrWork,1,pos('|', vstrWork)-1);
     If pos('(', vstrWork) > 0 then
        vstrWork:= copy(vstrWork,1,pos('(', vstrWork)-1);
     If pos('[', vstrWork) > 0 then
        vstrWork:= copy(vstrWork,1,pos('[', vstrWork)-1);
     If pos(' -', vstrWork) > 0 then
        vstrWork:= copy(vstrWork,1,pos(' -', vstrWork)-1);
     If pos(',', vstrWork) > 0 then
        vstrWork:= copy(vstrWork,1,pos(',', vstrWork)-1);
     If pos('0', vstrWork) > 0 then
        vstrWork:= copy(vstrWork,1,pos('0', vstrWork)-1);
     If pos('1', vstrWork) > 0 then
        vstrWork:= copy(vstrWork,1,pos('1', vstrWork)-1);
     If pos('2', vstrWork) > 0 then
        vstrWork:= copy(vstrWork,1,pos('2', vstrWork)-1);
     If pos('3', vstrWork) > 0 then
        vstrWork:= copy(vstrWork,1,pos('3', vstrWork)-1);
     If pos('4', vstrWork) > 0 then
        vstrWork:= copy(vstrWork,1,pos('4', vstrWork)-1);
     If pos('5', vstrWork) > 0 then
        vstrWork:= copy(vstrWork,1,pos('5', vstrWork)-1);
     If pos('6', vstrWork) > 0 then
        vstrWork:= copy(vstrWork,1,pos('6', vstrWork)-1);
     If pos('7', vstrWork) > 0 then
        vstrWork:= copy(vstrWork,1,pos('7', vstrWork)-1);
     If pos('8', vstrWork) > 0 then
        vstrWork:= copy(vstrWork,1,pos('8', vstrWork)-1);
     If pos('9', vstrWork) > 0 then
        vstrWork:= copy(vstrWork,1,pos('9', vstrWork)-1);
     If (copy(vstrWork, length(vstrWork) - 1, 2) = ' V') or
        (copy(vstrWork, length(vstrWork) - 1, 2) = ' E') then
        vstrWork:= copy(vstrWork, 1, length(vstrWork)-2);
     Result:= trim(vstrWork);
end;

{This routine is used to load a SKIN to be used as the template for all users.
This skin can vary between users, but the default is DEFAULT.HTM}
function tICD9processes.LoadSkin(vstrSkinName: string): string;
  var vstlWork: tstringlist;

  Procedure TagTrimmer;
     var vintLoop: integer;
         vbolDelete: boolean;
         vstrWork: string;
     begin
     vbolDelete:= false;
     For vintLoop:= 0 to vstlWork.Count - 1 do
        begin
        vstrWork:= vstlWork[vintLoop];
        If pos('<!-- <#', vstrWork) > 0 then
           begin
           vstrWork:= copy(vstrWork, pos('<!-- <#', vstrWork) + 5 , 99999);
           vstrWork:= copy(vstrWork, 1, pos(' -->', vstrWork) - 1);
           If pos('SearchWidth=', vstrWork) > 0 then
             begin
             vintTableSize:=
                          strtoint(copy(vstrWork, pos('=', vstrWork) + 1, 999));
             vstrWork:= copy(vstrWork, 1, pos('SearchWidth=', vstrWork)-1);
             end
           else
           If pos('Columns=', vstrWork) > 0 then
             begin
             vintTotalColumns:=
                          strtoint(copy(vstrWork, pos('=', vstrWork) + 1, 999));
             vstrWork:= copy(vstrWork, 1, pos('Columns=', vstrWork)-1);
             end;
           vstlWork[vintLoop]:= vstrWork;
           vbolDelete:= true;
           end
        else
        If pos('<!-- </#', vstrWork) > 0 then
           begin
           vstrWork:= copy(vstrWork, pos('<!-- <#', vstrWork) + 5 , 99999);
           vstrWork:= copy(vstrWork, 1, pos(' -->', vstrWork) - 1);
           vstlWork[vintLoop]:= '';
           vbolDelete:= false;
           end
        else
        If vbolDelete then
           vstlWork[vintLoop]:= '';
        end;
     end;
     {***************************************************************}
  Procedure AbsolutePath;
     var vintLoop, vintTest: integer;
         vstrUpper, vstrFull, vstrBegin, vstrEnd, vstrItem: string;
         Procedure PathReplace;
            begin
            vstrFull:= vstlWork[vintLoop];
            {Isolate the portion up to path}
            vstrBegin:= copy(vstrFull, 1, vintTest + 4);
            vstrFull:= copy(vstrFull, vintTest + 5, 99999);
            vstrItem:= copy(vstrFull, 1, pos('"', vstrFull) - 1);
            vstrEnd:= copy(vstrFull, pos('"', vstrFull), 99999);
            If uppercase(copy(vstrItem, 1, 5)) = 'http:' then
            else
            If copy(vstrItem, 1, 2) = '..' then
                begin
                vstlWork[vintLoop]:= vstrBegin +
                                                      'http://' +
                                                      vstrWebAddress +
                                                      copy(vstrItem, 3, 999) +
                                                      vstrEnd;
                end
            else
            If copy(vstrItem, 1, 1) = '.' then
                begin
                vstlWork[vintLoop]:= vstrBegin +
                                                      'http://' +
                                                      vstrWebAddress +
                                                      copy(vstrItem, 2, 999) +
                                                      vstrEnd;
                end
            else
                begin
                vstlWork[vintLoop]:= vstrBegin +
                                                      'http://' +
                                                      vstrWebAddress + '/' +
                                                      vstrItem +
                                                      vstrEnd;
                end;
            end;
     begin
     For vintLoop:= 0 to vstlWork.Count - 1 do
        begin
        vstrUpper:= uppercase(vstlWork[vintLoop]);
        vintTest:= pos('SRC="', vstrUpper);
        If vintTest > 1 then
           PathReplace;
        vintTest:= pos('UND="', vstrUpper);
        If vintTest > 1 then
           PathReplace;
        vstrUpper:= uppercase(vstlWork[vintLoop]);
        vintTest:= pos('ASE="', vstrUpper);
        If vintTest > 1 then
           PathReplace;
        end;
     end;
begin

If vstrSkinName < '    A' then
   vstrSkinName:= 'default.htm';

//removed to load skin every time for test purposes - could be used
//for production
If vstrHoldCurrentSkin = uppercase(vstrSkinName) then
   exit;
   
Logit('Skin Name: ' + vstrSkinName + ' and OldSkin: ' + vstrHoldCurrentSkin);

{Default values on loading a skin}
vintTotalColumns:= 3;
vintTableSize:= 515;

{If the skin requested does not exist, skip this routine}
If not fileexists(copy(ExtractFilePath(vstrPath), 1,
                  pos('cgi-bin', ExtractFilePath(vstrPath)) - 1) +
                                   vstrSkinName) then
  exit;
vstlWork:= tstringlist.create;
try
 try
 {Skin exists, attempt to load}
 vstlWork.LoadFromFile(
       copy(ExtractFilePath(vstrPath), 1,
            pos('cgi-bin', ExtractFilePath(vstrPath)) - 1) +
                                   vstrSkinName);
{Trim out the comments and replacement tags in order to leave the <#Tag>
 format in the document}
TagTrimmer;
{Take the contents of SRC and Codebase strings and apply an path for the site}
AbsolutePath;
vstrHoldCurrentSkin := uppercase(vstrSkinName);

except
   vstlWork.text:='';
   end;

 Result:= vstlWork.text;

 finally
    vstlWork.free;
    end;
end;

end.
