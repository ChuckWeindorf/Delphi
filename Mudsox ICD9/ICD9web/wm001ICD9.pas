unit wm001ICD9;
{
^ and #170    Link
^ and #171    Include
^ and #172    Exclude
^ and #173    Notes
^ and #174    4 digit
^ and #175    5 digit
^ and #176    Chapter
^ and #177    Section
^ and #178    Verify- Lowest Level
^ and #179    Bolding
}

interface

uses
  Windows, Messages, SysUtils, Classes, HTTPApp, Psock, forms,
  ExtCtrls, DSProd, procicd9search, classICD9Search;

type
  TwmICD9 = class(TWebModule)
    pgpChapter:     TPageProducer;
    pgpSearch:      TPageProducer;
    pgpDefault:     TPageProducer;
    pgpCode:        TPageProducer;
    pgpSectionList: TPageProducer;
    pgpSection:     TPageProducer;
    pgpRange: TPageProducer;
    pgpDetail: TPageProducer;
    pgpIndexDetail: TPageProducer;
    pgpAlphaHeader: TPageProducer;
    pgpIndexSummary: TPageProducer;
    pgpIndexAlpha: TPageProducer;
    pgpBugForm: TPageProducer;
    pgpShowBookmarks: TPageProducer;
    pgpBugResponse: TPageProducer;
    pgpTemplate: TPageProducer;
    procedure WebModuleCreate(Sender: TObject);
    procedure pgpChapterHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: String; TagParams: TStrings;
      var ReplaceText: String);
    procedure pgpSearchHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: String; TagParams: TStrings;
      var ReplaceText: String);
    procedure pgpCodeHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: String; TagParams: TStrings;
      var ReplaceText: String);
    procedure wmICD9actSearchAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure wmICD9actCodeAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure pgpSectionListHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: String; TagParams: TStrings;
      var ReplaceText: String);
    procedure wmICD9actSectionListAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure wmICD9actSectionAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure pgpSectionHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: String; TagParams: TStrings;
      var ReplaceText: String);
    procedure wmICD9actRangeAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure pgpRangeHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: String; TagParams: TStrings;
      var ReplaceText: String);
    procedure pgpDetailHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: String; TagParams: TStrings;
      var ReplaceText: String);
    procedure wmICD9actDetailAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure wmICD9actBugReportAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure pgpBugResponseHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: String; TagParams: TStrings;
      var ReplaceText: String);
    procedure wmICD9actSetBookmarkAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure wmICD9actShowbookmarksAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure pgpDefaultHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: String; TagParams: TStrings;
      var ReplaceText: String);
    procedure WebModuleDestroy(Sender: TObject);
    procedure wmICD9actChapterAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure wmICD9actRedirectAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure wmICD9actIndexDetailAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure pgpIndexDetailHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: String; TagParams: TStrings;
      var ReplaceText: String);
    procedure pgpIndexSummaryHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: String; TagParams: TStrings;
      var ReplaceText: String);
    procedure wmICD9actIndexSummaryAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure pgpAlphaHeaderHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: String; TagParams: TStrings;
      var ReplaceText: String);
    procedure wmICD9actIndexAlphaAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure pgpIndexAlphaHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: String; TagParams: TStrings;
      var ReplaceText: String);
    procedure pgpBugFormHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: String; TagParams: TStrings;
      var ReplaceText: String);
    procedure wmICD9actBugFormAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure pgpTemplateHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: String; TagParams: TStrings;
      var ReplaceText: String);
    procedure pgpShowBookmarksHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: String; TagParams: TStrings;
      var ReplaceText: String);
    procedure wmICD9actSetSkinAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
    ICD9process: tICD9processes;
  public
    { Public declarations }
  end;

var
  wmICD9: TwmICD9;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{Creation and Destroy Logic}
procedure TwmICD9.WebModuleCreate(Sender: TObject);
  var vpcrPath: array[0..MAX_PATH - 1] of Char;
      vintIndex, vintLoop: integer;
      vstrTest: string;
begin
try
  ICD9process:= tICD9processes.create;
  If length(vstrPath) = 0 then
     begin
     SetString(vstrPath,
               vpcrPath,
               GetModuleFileName(Hinstance, vpcrPath, SizeOf(vpcrPath)));
     if procICD9search.ICD9LoadAndPrepare(ExtractFilePath(vstrPath)) then
        begin
        ICD9process.vbolLogToggle:= true;
        ICD9process.vbolNoLog:= true;
        {place markers in the array for the starting location of each 2 letter
         combination.  AA = 1, ZZ=676}
        for vintLoop:= 1 to vstlICD9index.Count - 1 do
          begin
          vintIndex:= ICD9process.IndexArrayLocate(vstlICD9index[vintLoop]);
          If vintIndex > 0 then
             {The value has not bee set by a prior 2 digit combo}
             If varrIndex[vintIndex] = 0 then
                {Some index words in the table are out-of-order - ignore}
              If vstrTest <= uppercase(copy(vstlICD9index[vintLoop+1],1,2)) then
                 varrIndex[vintIndex]:= vintLoop;
          end;
        end;
     end;
  {set up the advertising file}
  ICD9process.vstlSearchAnswer:= tstringlist.create;
  ICD9process.vstlLinks:= tstringlist.create;
  ICD9process.vstlAds:= tstringlist.create;
  ICD9process.vstlCurrentSkin:= tstringlist.create;
  ICD9process.vstlAds.loadfromfile
                              (vstrRootFolder + '\data\mudsox_adfile.txt');

  {Load the default SKIN for the site}
  ICD9process.vstlCurrentSkin.text:= ICD9process.LoadSkin('default.htm');
  ICD9process.vstrHoldCurrentSkin:= 'DEFAULT.HTM';

  ICD9process.vintBigAd:= 0;
  ICD9process.vintLittleAd:= 0;
  ICD9process.vbolSearch:= false;
  ICD9process.vbolCode:= false;
except
  on
  E: Exception do
     begin
     ICD9process.LogIT('Error in WebModuleCreate: ' + E.Message);
     end;
  end;
end;

procedure TwmICD9.WebModuleDestroy(Sender: TObject);
begin
  ICD9process.LogCheck;
  ICD9process.ICD9Free;
  ICD9process.vstlAds.free;
  ICD9process.vstlSearchAnswer.free;
  ICD9process.vstlLinks.free;
  ICD9process.vstlCurrentSkin.free;
end;
{------------------------------------------------------------------------------}

{All action methods on entering the Web broker}
procedure TwmICD9.wmICD9actChapterAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
try
  ICD9process.vreqICD9:= Request;
  ICD9process.CheckCurrentSkin
                             (Request.CookieFields.Values['SKIN'], pgpTemplate);
  ICD9process.vstrCurrentAction:= 'ChapterList';
  Response.Content:= pgpTemplate.content;
  Response.LogMessage:= 'ChapterList';
except
  on
  E: Exception do
     begin
     ICD9process.LogIT('Error in wmICD9actChapterAction: ' + E.Message);
     end;
  end;
end;

procedure TwmICD9.wmICD9actSearchAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
try
  ICD9process.vreqICD9:= Request;
  ICD9process.CheckCurrentSkin
                             (Request.CookieFields.Values['SKIN'], pgpTemplate);
  ICD9process.vbolSearch:= true;
  ICD9process.vstrSearchString:= Request.ContentFields.Values['WordSearch'];
  If length(ICD9process.vstrSearchString) = 0 then
     ICD9process.vstrSearchString:= Request.QueryFields.Values['Search'];
  {For an attempt at an exact code, try the code text}
  If (length(ICD9process.vstrSearchString) > 2) and
     (length(ICD9process.vstrSearchString) < 7) and
     (ICD9process.vstrSearchString[1] in ['V', 'E', '0'..'9']) and
     (ICD9process.vstrSearchString[2] in ['0'..'9']) and
     (ICD9process.vstrSearchString[3] in ['0'..'9']) then
     begin
     ICD9process.vbolCode:= true;
     ICD9process.vstrCodeString:= ICD9process.vstrSearchString;
     ICD9process.vbolBookmarked:= ICD9process.TestBookmark(Request);
     ICD9process.vstrCurrentAction:= 'Code';
     end
  else
     begin
     ICD9process.vstrCurrentAction:= 'Search';
     ICD9process.FindAndProcessSearchResult(ICD9process.vstrSearchString,
                             ICD9process.vstlSearchAnswer,
                             ICD9process.vstlLinks,
                             ICD9process.vintUnitMatch);
     end;

  Response.Content:= pgpTemplate.content;
  Response.LogMessage:= 'Search=' + ICD9process.vstrSearchString;
  ICD9process.vbolCode:= false;
except
  on
  E: Exception do
     begin
     ICD9process.LogIT('Error in wmICD9actSearchAction: ' + E.Message);
     end;
  end;
end;

procedure TwmICD9.wmICD9actSectionListAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
try
  ICD9process.vreqICD9:= Request;
  ICD9process.CheckCurrentSkin
                             (Request.CookieFields.Values['SKIN'], pgpTemplate);
  ICD9process.vstrSearchString:= Request.QueryFields.Values['Chapter'];
  ICD9process.vstrCurrentAction:= 'SectionList';
  Response.Content:= pgpTemplate.content;
except
  on
  E: Exception do
     begin
     ICD9process.LogIT('Error in wmICD9actSectionListAction: ' + E.Message);
     end;
  end;
end;

procedure TwmICD9.wmICD9actSectionAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
try
  ICD9process.vreqICD9:= Request;
  ICD9process.CheckCurrentSkin(Request.CookieFields.Values['SKIN'], pgpTemplate);
  ICD9process.vstrSearchString:= Request.QueryFields.Values['Section'];
  ICD9process.vstrCurrentAction:= 'Section';
  Response.Content:= pgpTemplate.content;
except
  on
  E: Exception do
     begin
     ICD9process.LogIT('Error in wmICD9actSectionAction: ' + E.Message);
     end;
  end;
end;

procedure TwmICD9.wmICD9actRangeAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
try
  ICD9process.vreqICD9:= Request;
  ICD9process.CheckCurrentSkin
                             (Request.CookieFields.Values['SKIN'], pgpTemplate);
  ICD9process.vstrSearchString:= Request.QueryFields.Values['Range'];
  ICD9process.vstrCurrentAction:= 'Range';
  Response.Content:= pgpTemplate.content;
except
  on
  E: Exception do
     begin
     ICD9process.LogIT('Error in wmICD9actRangeAction: ' + E.Message);
     end;
  end;
end;

procedure TwmICD9.wmICD9actCodeAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
try
  ICD9process.vreqICD9:= Request;
  ICD9process.CheckCurrentSkin
                             (Request.CookieFields.Values['SKIN'], pgpTemplate);
  ICD9process.vbolCode:= true;
  ICD9process.vstrCodeString:= Request.ContentFields.Values['GetCode'];
  If length(ICD9process.vstrCodeString) = 0 then
     ICD9process.vstrCodeString:= Request.QueryFields.Values['Code'];
  ICD9process.vbolBookmarked:= ICD9process.TestBookmark(Request);
  ICD9process.vstrCurrentAction:= 'Code';
  Response.Content:= pgpTemplate.content;
except
  on
  E: Exception do
     begin
     ICD9process.LogIT('Error in wmICD9actCodeAction: ' + E.Message);
     end;
  end;
end;

procedure TwmICD9.wmICD9actDetailAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
try
  ICD9process.vreqICD9:= Request;
  ICD9process.CheckCurrentSkin
                             (Request.CookieFields.Values['SKIN'], pgpTemplate);
  ICD9process.vstrSearchString:= Request.QueryFields.Values['Detail'];
  ICD9process.vstrCurrentAction:= 'Detail';
  Response.Content:= pgpTemplate.content;
except
  on
  E: Exception do
     begin
     ICD9process.LogIT('Error in wmICD9actDetailAction: ' + E.Message);
     end;
  end;
end;

procedure TwmICD9.wmICD9actIndexAlphaAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
try
  ICD9process.vreqICD9:= Request;
  ICD9process.CheckCurrentSkin
                             (Request.CookieFields.Values['SKIN'], pgpTemplate);
  ICD9process.vstrSearchString:= Request.QueryFields.Values['Letters'];
  ICD9process.vstrCurrentAction:= 'IndexAlpha';
  Response.Content:= pgpTemplate.content;
except
  on
  E: Exception do
     begin
     ICD9process.LogIT('Error in wmICD9actIndexAlphaAction: ' + E.Message);
     end;
  end;

end;

procedure TwmICD9.wmICD9actIndexSummaryAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
try
  ICD9process.vreqICD9:= Request;
  ICD9process.CheckCurrentSkin
                             (Request.CookieFields.Values['SKIN'], pgpTemplate);
  ICD9process.vstrCurrentAction:= 'IndexSummary';
  Response.Content:= pgpTemplate.content;
except
  on
  E: Exception do
     begin
     ICD9process.LogIT('Error in wmICD9actIndexSummaryAction: ' + E.Message);
     end;
  end;
end;

procedure TwmICD9.wmICD9actIndexDetailAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
try
  ICD9process.vreqICD9:= Request;
  ICD9process.CheckCurrentSkin
                             (Request.CookieFields.Values['SKIN'], pgpTemplate);
  ICD9process.vstrSearchString:= Request.QueryFields.Values['Detail'];
  ICD9process.vstrCurrentAction:= 'IndexDetail';
  Response.Content:= pgpTemplate.content;
except
  on
  E: Exception do
     begin
     ICD9process.LogIT('Error in wmICD9actIndexDetailAction: ' + E.Message);
     end;
  end;
end;

procedure TwmICD9.wmICD9actSetBookmarkAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  var
      vintLoop: integer;
      vbolDuplicate: boolean;
begin
try
  ICD9process.vreqICD9:= Request;
  ICD9process.LogIT('Set bookmark: ' + Request.QueryFields.Values['Code']);
  ICD9process.CheckCurrentSkin
                             (Request.CookieFields.Values['SKIN'], pgpTemplate);

  ICD9process.InitializeCookies(Request, Response);

  {Check for duplicates}
  vbolDuplicate:= false;
  For vintLoop:= 0 to 9 do
      If Request.QueryFields.Values['Code'] =
                                     Response.Cookies[vintLoop].Value then
        begin
        vbolDuplicate:= true;
        break;
        end;

  {Rotate bookmarks bown, fill slot 0.}
  If not vbolDuplicate then
     begin
     For vintLoop:= 9 downto 1 do
          Response.Cookies[vintLoop].Value:= Response.Cookies[vintLoop-1].Value;
     Response.Cookies[0].Value:= Request.QueryFields.Values['Code'];
     end;

  ICD9process.vbolBookmarked:= true;
  ICD9process.vstrCodeString:= Request.QueryFields.Values['Code'];
  ICD9process.vstrCurrentAction:= 'Code';
  Response.Content:= pgpTemplate.content;
  Response.LogMessage:= ',Bookmark';

except
  on
  E: Exception do
     begin
     ICD9process.LogIT('Error in wmICD9actSetBookmarkAction: ' + E.Message);
     end;
  end;
end;

procedure TwmICD9.wmICD9actShowbookmarksAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
try
ICD9process.vreqICD9:= Request;
ICD9process.InitializeCookies(Request, Response);
ICD9process.CheckCurrentSkin(Request.CookieFields.Values['SKIN'], pgpTemplate);
ICD9process.vstrCurrentAction:= 'Showbookmarks';
Response.Content:= pgpTemplate.content;
Response.LogMessage:= 'Showbookmarks';
except
  on
  E: Exception do
     begin
     ICD9process.LogIT('Error in wmICD9actShowbookmarksAction: ' + E.Message);
     end;
  end;
end;

procedure TwmICD9.wmICD9actSetSkinAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
try
ICD9process.vreqICD9:= Request;
ICD9process.InitializeCookies(Request, Response);
ICD9process.CheckCurrentSkin(Request.QueryFields.Values['Skin'], pgpTemplate);
ICD9process.vstrCurrentAction:= 'SetSkin';
Response.Content:= pgpTemplate.content;
Response.Cookies[10].Value:= Request.QueryFields.Values['Skin'];
except
  on
  E: Exception do
     begin
     ICD9process.LogIT('Error in wmICD9actSetSkinAction: ' + E.Message);
     end;
  end;
end;

procedure TwmICD9.wmICD9actBugFormAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
try
  ICD9process.vreqICD9:= Request;
  ICD9process.CheckCurrentSkin
                             (Request.CookieFields.Values['SKIN'], pgpTemplate);
  ICD9process.vstrCurrentAction:= 'Bugform';
  Response.Content:= pgpTemplate.content;
except
  on
  E: Exception do
     begin
     ICD9process.LogIT('Error in wmICD9actBugFormAction: ' + E.Message);
     end;
  end;
end;

procedure TwmICD9.wmICD9actBugReportAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
try
  ICD9process.vreqICD9:= Request;
  ICD9process.CheckCurrentSkin
                             (Request.CookieFields.Values['SKIN'], pgpTemplate);
  ICD9process.vstrCurrentAction:= 'BugThanks';
  Response.Content:= pgpTemplate.content;
  Response.LogMessage:= 'Bugreport';
except
  on
  E: Exception do
     begin
     ICD9process.LogIT('Error in wmICD9actBugReportAction: ' + E.Message);
     end;
  end;
end;

procedure TwmICD9.wmICD9actRedirectAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
try
{Accept the parameter and redirect to it}
ICD9process.vreqICD9:= Request;
ICD9process.LogIT('Click-through: ' + Request.QueryFields.Values['Site']);
Response.SendRedirect(Request.QueryFields.Values['Site']);
except
  on
  E: Exception do
     begin
     ICD9process.LogIT('Error in wmICD9actRedirectAction: ' + E.Message);
     end;
  end;

end;

{------------------------------------------------------------------------------}

{This is the main logic routine to place all text over the tags placed by the
client for the ICD9scope.}
procedure TwmICD9.pgpTemplateHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: String; TagParams: TStrings; var ReplaceText: String);
begin
try
{Each of the tags possible in the template are handled here.}
If TagString = 'GetAds' then
   begin
   ReplaceText:= '';
   ICD9process.BuildAdInfo('Regular');
   end
else
If TagString = 'Cleanup' then
   begin
   ICD9process.vstlSearchAnswer.clear;
   ICD9process.vstlLinks.clear;
   ICD9process.vstrSearchString:= '';
   ICD9process.vstrCodeString:= '';
   ICD9process.vstrSmallLink:= '';
   ICD9process.vstrBigLink:= '';
   ICD9process.vstrSmallImg:= '';
   ICD9process.vstrBigImg:= '';
   ICD9process.vstrSmallText:= '';
   ICD9process.vstrBigText:= '';
   ReplaceText:= '';
   end
else
If TagString = 'BigAd' then
   begin
   ReplaceText:=
      '<a href="http://' +
      vstrWebAddress +
      '/cgi-bin/MudsoxICD9.DLL/Redirect?Site=' +
      ICD9process.vstrBigLink +
      '"><img border="0" src="http://' +
      vstrWebAddress +
      '/' +
      ICD9process.vstrBigImg +
      '"></a>';
   end
else
If TagString = 'SmallAd' then
   begin
   ReplaceText:=
      '<a href="http://' +
      vstrWebAddress +
      '/cgi-bin/MudsoxICD9.DLL/Redirect?Site=' +
      ICD9process.vstrSmallLink +
      '"><img border="0" src="http://' +
      vstrWebAddress +
      '/' +
      ICD9process.vstrSmallImg +
      '"></a>';
   end
else
If TagString = 'BigText' then
  ReplaceText:= ICD9process.vstrBigText
else
If TagString = 'AlphaLine' then
  ReplaceText:= pgpAlphaHeader.Content
else
If TagString = 'IndexWords' then
  begin
  If ICD9process.vstlLinks.count > 0 then
     begin
     ReplaceText:= ReplaceText + '<BR>Full word search:<BR><font size="2">' +
                ICD9process.vstlLinks.text;
     ICD9process.vstlLinks.clear;
     end; 
  end
else
If TagString = 'SearchResults' then
  begin
  If ICD9process.vstrCurrentAction = 'Detail' then
     ReplaceText:= pgpDetail.content
  else
  If ICD9process.vstrCurrentAction = 'Code' then
     ReplaceText:= pgpCode.content
  else
  If ICD9process.vstrCurrentAction = 'Search' then
     ReplaceText:= pgpSearch.content
  else
  If ICD9process.vstrCurrentAction= 'Range' then
     ReplaceText:= pgpRange.content
  else
  If ICD9process.vstrCurrentAction = 'SectionList' then
     ReplaceText:= pgpSectionList.content
  else
  If ICD9process.vstrCurrentAction = 'Section' then
     ReplaceText:= pgpSection.content
  else
  If ICD9process.vstrCurrentAction = 'ChapterList' then
     ReplaceText:= pgpChapter.content
  else
  If ICD9process.vstrCurrentAction = 'IndexDetail' then
     ReplaceText:= pgpIndexDetail.content
  else
  If ICD9process.vstrCurrentAction = 'IndexSummary' then
     ReplaceText:= pgpIndexSummary.content
  else
  If ICD9process.vstrCurrentAction = 'IndexAlpha' then
     ReplaceText:= pgpIndexAlpha.content
  else
  If ICD9process.vstrCurrentAction = 'Showbookmarks' then
     ReplaceText:= pgpShowbookmarks.content
  else
  If ICD9process.vstrCurrentAction = 'BugThanks' then
     ReplaceText:= pgpBugResponse.content
  else
  If ICD9process.vstrCurrentAction = 'SetSkin' then
     ReplaceText:= 'New skin set'
  else
  If ICD9process.vstrCurrentAction = 'Bugform' then
     ReplaceText:= pgpBugForm.Content;
  ReplaceText:= '<table width=' + inttostr(ICD9process.vintTableSize)
                + '>' + ReplaceText + '</table>';
  end;
except
  on
  E: Exception do
     begin
     ReplaceText:= 'Error in pgpTemplateHTMLTag';
     ICD9process.LogIT('Error in pgpTemplateHTMLTag: ' + E.Message);
     end;
  end;
end;
{---------------------------------------------------------------------}

procedure TwmICD9.pgpChapterHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: String; TagParams: TStrings; var ReplaceText: String);
  var vstlChapter: tstringlist;
      vintLoop: integer;
      vstrWork: string;
begin
try
If TagString = 'Chapter' then
  begin
  ICD9process.LogIT('Chapter list');
  vstlChapter:= tstringlist.create;
  try
  ICD9process.ICD9Chapter(vstlChapter);
  vstlChapter[0]:= '<dl><b>' + vstlChapter[0] + '</b><BR><dd>';
  {Assign Section Links and Range Links for codes}
  for vintLoop:= 1 to vstlChapter.count - 2 do
     begin
     vstrWork:= vstlChapter[vintLoop];
     vstrWork:=
       '<font size="3"><a href="http://' + vstrWebAddress +
       '/cgi-bin/MudsoxICD9.DLL/SectionList?Chapter=' + inttostr(vintLoop + 1) +
       '">' + copy(vstrWork, 1, pos('(', vstrWork)-1) +
       '</a><font size="2">' +
        copy(vstrWork, pos('(', vstrWork), 99999);
      If pos('[D', vstrWork) > 0 then
        vstrWork:= copy(vstrWork, 1, pos('[D', vstrWork) - 1) +
             '<a href="http://' + vstrWebAddress +
             '/cgi-bin/MudsoxICD9.DLL/Detail?Detail=' + inttostr(vintLoop + 1) +
             '"> [Detail]</a>';
      vstrWork:= vstrWork + '<BR>';
      ICD9process.LinkLineToHTML(vstrWork, '');
      vstlChapter[vintLoop]:= vstrWork;
      end;
  {}
  vstlChapter[vstlChapter.count - 1]:= '</dd></dl><b>'
       + vstlChapter[vstlChapter.count - 1] + '</b>';
  ReplaceText:= '<font size="4"><b>ICD9 Chapters</b><BR><font size="3">' +
             vstlChapter.text;
  finally
    vstlChapter.free;
    end;
  end;
except
  on
  E: Exception do
     begin
     ReplaceText:= 'Error in pgpChapterHTMLTag';
     ICD9process.LogIT('Error in pgpChapterHTMLTag: ' + E.Message);
     end;
  end;
end;

{------------------ Display the details of chapter/section line ---------------}
procedure TwmICD9.pgpDetailHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: String; TagParams: TStrings; var ReplaceText: String);
  var vstlDetail: tstringlist;
      vstrWork: string;
begin
try
If TagString = 'Detail' then
  begin
  ICD9process.LogIT('Details: ' + ICD9process.vstrSearchString);
  vstlDetail:= tstringlist.create;
  try
  vstrWork:= ICD9process.GetOneLine(strtoint(ICD9process.vstrSearchString));
  ICD9process.CodeToHTML(vstrWork);
  ICD9process.ConvertToStringList(vstrWork, vstlDetail);
  vstrWork:= vstlDetail[0];
  ICD9process.MixCase(vstrWork);
  vstrWork:= '<b>' + vstrWork + '</b><BR>';
  vstlDetail[0]:= vstrWork;
  ICD9process.LinkToHTML(vstlDetail, '');
  ReplaceText:=
      '<font size="4"><b>Detailed ICD9 Description</b><BR><BR><font size="3">' +
       vstlDetail.text;
  finally
    vstlDetail.free;
    end;
  end;
except
  on
  E: Exception do
     begin
     ReplaceText:= 'Error in pgpDetailHTMLTag';
     ICD9process.LogIT('Error in pgpDetailHTMLTag: ' + E.Message);
     end;
  end;
end;

procedure TwmICD9.pgpSearchHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: String; TagParams: TStrings; var ReplaceText: String);
begin
try
If TagString = 'Search' then
  begin
  ICD9process.LogIT('Search: ' + ICD9process.vstrSearchString);
  try
  ReplaceText:= ReplaceText +
                '<font size="4"><b>Search Results: ' +
                inttostr(ICD9process.vintUnitMatch) +
                ' matches</b><BR><font size="3">' +
                ICD9process.vstlSearchAnswer.text + '</font>';
  {add any index words to the list}
  ICD9process.vstlSearchAnswer.clear;
  ICD9process.ICD9IndexWordSearch
                   (ICD9process.vstrSearchString, ICD9process.vstlSearchAnswer);
  ICD9process.IndexSummaryToHTML(ICD9process.vstlSearchAnswer);
  If ICD9process.vstlSearchAnswer.count > 0 then
      ReplaceText:= ReplaceText +
      '<tr><td width="60">&nbsp;</td><td width="' +
      inttostr(ICD9process.vintTableSize-60) + '"><br><br>' +
      '<font size="3"><b>From the ICD9 Index:</b></font>' +
      '<BR><font size="2">' +
       ICD9process.vstlSearchAnswer.text + '</font></td></tr>';
  finally
    ICD9process.vbolSearch:= false;
    end;
  end;
except
  on
  E: Exception do
     begin
     ReplaceText:= 'Error in pgpSearchHTMLTag';
     ICD9process.LogIT('Error in pgpSearchHTMLTag: ' + E.Message);
     end;
  end;
end;

{Logic for handling direct code calls and displays}
procedure TwmICD9.pgpCodeHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: String; TagParams: TStrings; var ReplaceText: String);
  var vstrWork, vstrWork2, vstrPrefix, vstrChapterText, vstrSectionText: string;
      vstlCode, vstlMoreKeys: tstringlist;
      vintLoop: integer;
begin
try
If TagString = 'Code' then
  begin
  ICD9process.LogIT('Code: ' + ICD9process.vstrCodeString);
  vstlCode:= tstringlist.Create;
  vstlMoreKeys:= tstringlist.Create;
  try
  vstrWork:= ICD9process.ICD9GetCode
                  (ICD9process.vstrCodeString, false, vstlMoreKeys);
  If vstrWork = 'NOT FOUND' then
     begin
     ReplaceText:= 'This code is not found on the ICD9 database<br>';
     end
  else
     begin
     vstrPrefix:= copy(vstrWork, pos('~~', vstrWork) + 2, 99999);
     ICD9process.CodeToHTML(vstrWork);
     ICD9process.ConvertToStringList(vstrWork, vstlCode);
     ICD9process.LinkToHTML(vstlCode, '');
     vstrWork:= vstlCode[0];
     vstlCode[0]:= copy(vstrWork, pos(' ', vstrWork) + 1, 99999);
     vstrWork:= copy(vstrWork, 1, pos(' ', vstrWork) - 1);
     {build the enitre text code area in vstrWork2}
     vstrWork2:= '<font size="4"><b>ICD9 Code </b><font size="2">';
     {If there is no bookmark then allow the user to bookmark}
     If not ICD9process.vbolBookmarked then
         vstrWork2:= vstrWork2
              + '<a href="http://' + vstrWebAddress
              + '/cgi-bin/MudsoxICD9.DLL/Setbookmark?Code='
              + ICD9process.vstrCodeString
              + '">[bookmark this page]</a>'
     else
         vstrWork2:= vstrWork2
              + 'This page has a bookmark';
     vstrWork2:= vstrWork2
              + '<BR><BR><font size="3">'
              + '<tr valign=top><td width="60">'
              + '<b>' + vstrWork + '</b>'
              + '</td><td width="'
              + inttostr(ICD9process.vintTableSize-60) + '">'
              + vstlCode.text
              + '</td></tr>';

     If length(vstlMoreKeys.text) > 0 then
         for vintLoop:= 0 to vstlMoreKeys.count - 1 do
             begin
             vstrWork:= vstlMoreKeys[vintLoop];
             vstrWork:= '<tr valign=top><td width="60">'
                 + '<a href="http://' + vstrWebAddress
                 + '/cgi-bin/MudsoxICD9.DLL/Code?Code='
                 + copy(vstrWork, 1, pos(' ', vstrWork) - 1) + '">'
                 + copy(vstrWork, 1, pos(' ', vstrWork) - 1)
                 + '</a></td><td width="'
                 + inttostr(ICD9process.vintTableSize-60) + '">'
                 + copy(vstrWork, pos(' ', vstrWork) + 1, 999)
                 + '</td></tr>';
             vstlMoreKeys[vintLoop]:= vstrWork;
             end;
      {Chapter}
      vstrWork:= copy(vstrPrefix,
                 pos('^' + #176, vstrPrefix) + 2,
                 pos(#176 + '^', vstrPrefix) - pos('^' + #176, vstrPrefix) - 2);
      vstrChapterText:= ICD9process.GetOneLine(strtoint(vstrWork));
      ICD9process.TrimCodes(vstrChapterText, false);
      ICD9process.MixCase(vstrChapterText);
      vstrChapterText:=
                '<tr valign=bottom><td width="60"><font size="2"><BR>Chapter'
              + '</td><td width="'
              + inttostr(ICD9process.vintTableSize-60) + '"><font size="2">'
              + '<a href="http://' + vstrWebAddress
              + '/cgi-bin/MudsoxICD9.DLL/SectionList?Chapter='
              + vstrWork + '">'
              + vstrChapterText
              + '</a></td></tr>';
      vstlMoreKeys.add(vstrChapterText);
      {Section}
      vstrWork:= copy(vstrPrefix,
                 pos('^' + #177, vstrPrefix) + 2,
                 pos(#177 + '^', vstrPrefix) - pos('^' + #177, vstrPrefix) - 2);
      vstrSectionText:= ICD9process.GetOneLine(strtoint(vstrWork));
      ICD9process.TrimCodes(vstrSectionText, false);
      ICD9process.MixCase(vstrSectionText);
      vstrSectionText:=
                '<tr valign=top><td width="60"><font size="2">Section'
              + '</td><td width="'
              + inttostr(ICD9process.vintTableSize-60) + '"><font size="2">'
              + '<a href="http://' + vstrWebAddress
              + '/cgi-bin/MudsoxICD9.DLL/Section?Section='
              + vstrWork + '">'
              + vstrSectionText
              + '</a></td></tr>';
      vstlMoreKeys.add(vstrSectionText);

      ReplaceText:= vstrWork2 +
                 vstlMoreKeys.text;
      end
  finally
    vstlCode.free;
    vstlMoreKeys.free;
    ICD9process.vbolCode:= false;
    end;
  end;
except
  on
  E: Exception do
     begin
     ReplaceText:= E.Message;
     ICD9process.LogIT('Error in pgpCodeHTMLTag: ' + E.Message);
     end;
  end;
end;
{------------------------------------------------------------------------------}

procedure TwmICD9.pgpRangeHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: String; TagParams: TStrings; var ReplaceText: String);
  var vstlCodeRange: tstringlist;
      vintLoop: integer;
      vstrWork: string;
begin
try
If TagString = 'CodeRange' then
  begin
  ICD9process.LogIT('Code range: ' + ICD9process.vstrSearchString);
  vstlCodeRange:= tstringlist.create;
  try
  ICD9process.ICD9CodeRange(ICD9process.vstrSearchString, vstlCodeRange);
  for vintLoop:= 0 to vstlCodeRange.count - 1 do
     begin
     vstrWork := vstlCodeRange[vintLoop];
     vstrWork:= '<tr><td width="60">'
               + '<a href="http://' + vstrWebAddress
               + '/cgi-bin/MudsoxICD9.DLL/Code?Code='
               + copy(vstrWork, 1, pos(' ', vstrWork) - 1) + '">'
               + copy(vstrWork, 1, pos(' ', vstrWork) - 1)
               + '</a></td>'
               + '<td width="'
               + inttostr(ICD9process.vintTableSize-60) + '">'
               + copy(vstrWork,
                      pos(' ', vstrWork) + 1, 99999)
               + '</td></tr>';
     vstlCodeRange[vintLoop]:= vstrWork;
     end;
  ReplaceText:= '<font size="4"><b>Code List</b><BR><BR><font size="3">' +
             vstlCodeRange.text;
  finally
    vstlCodeRange.free;
    end;
  end;
except
  on
  E: Exception do
     begin
     ReplaceText:= 'Error in pgpRangeHTMLTag';
     ICD9process.LogIT('Error in pgpRangeHTMLTag: ' + E.Message);
     end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TwmICD9.pgpSectionListHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: String; TagParams: TStrings; var ReplaceText: String);
  var vstlSectionList: tstringlist;
      vintLoop: integer;
      vstrWork: string;
begin
try
If TagString = 'SectionList' then
  begin
  ICD9process.LogIT('Section list: ' + ICD9process.vstrSearchString);
  vstlSectionList:= tstringlist.create;
  try
  ICD9process.ICD9SectionList(ICD9process.vstrSearchString, vstlSectionList);
  vstrWork:= vstlSectionList[0];
  //CodeToHTML(vstrWork);
  ICD9process.LinkLineToHTML(vstrWork, '');
  vstlSectionList[0]:= '<dl><b>' + vstrWork + '</b><BR><dd>';
  {This is hard-coded routine for Chapters 4 and 14}
  If pos('(280-289)', vstlSectionList[0]) > 0 then
     begin
     vstlSectionList.add(
             '<a href="http://' + vstrWebAddress +
             '/cgi-bin/MudsoxICD9.DLL/' +
             'CodeRange?Range=2213-2289">Categories 280-289</a>');
     end
  else
  If pos('(740-759)', vstlSectionList[0]) > 0 then
     begin
     vstlSectionList.add(
             '<a href="http://' + vstrWebAddress +
             '/cgi-bin/MudsoxICD9.DLL/' +
             'CodeRange?Range=6668-7121">Categories 740-759</a>');
     end
  else
  begin
  for vintLoop:= 1 to vstlSectionList.count - 1 do
     begin
     vstrWork := vstlSectionList[vintLoop];
     vstrWork:=
         '<font size="3"><a href="http://' + vstrWebAddress +
         '/cgi-bin/MudsoxICD9.DLL/Section?Section=' +
          copy(vstrWork, pos('^' + #177, vstrWork) + 2, 999) +
         '">' + copy(vstrWork, 1, pos('(', vstrWork) - 1) + '</a>' +
         '<font size="2">' + copy(vstrWork, pos('(', vstrWork),
                       pos('^' + #177, vstrWork) - pos('(', vstrWork));
      If pos('[D', vstrWork) > 0 then
        vstrWork:= copy(vstrWork, 1, pos('[D', vstrWork) - 1) +
             '<a href="http://' + vstrWebAddress +
             '/cgi-bin/MudsoxICD9.DLL/Detail?Detail=' +
              copy(vstrWork, pos('[D', vstrWork)+2,
              pos(']', vstrWork) - (pos('[D', vstrWork)+2)) +
             '"> [Detail]</a>';
     vstrWork:= vstrWork  + '<BR>';
     ICD9process.LinkLineToHTML(vstrWork, '');
     vstlSectionList[vintLoop]:= vstrWork;
     end;
  end;
  {Break down the section long text}
  //vstrWork:= vstlSectionList.text;
  //vstlSectionList.clear;
  //ConvertToStringlist(vstrWork, vstlSectionList);
  {Finally, complete the form}
  ReplaceText:= '<font size="4"><b>Section List</b><BR><font size="3">' +
             vstlSectionList.text;
  finally
    vstlSectionList.free;
    end;
  end;
except
  on
  E: Exception do
     begin
     ReplaceText:= 'Error in pgpSectionListHTMLTag';
     ICD9process.LogIT('Error in pgpSectionListHTMLTag: ' + E.Message);
     end;
  end;
end;

procedure TwmICD9.pgpSectionHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: String; TagParams: TStrings; var ReplaceText: String);
  var vstlSection: tstringlist;
      vintLoop: integer;
      vstrWork: string;
begin
try
If TagString = 'Section' then
  begin
  ICD9process.LogIT('Section: ' + ICD9process.vstrSearchString);
  vstlSection:= tstringlist.create;
  try
  ICD9process.ICD9Section(ICD9process.vstrSearchString, vstlSection);
  vstrWork:= vstlSection[0];
  ICD9process.LinkLineToHTML(vstrWork, '');
  vstlSection[0]:= '<dl><b>' + vstrWork + '</b><BR>';
  vstrWork:= vstlSection[1];
  ICD9process.LinkLineToHTML(vstrWork, '');
  vstlSection[1]:= '<dd><b>' + vstrWork + '</b></dd></dl>';
  for vintLoop:= 2 to vstlSection.count - 1 do
     begin
     vstrWork := vstlSection[vintLoop];
     vstrWork:= '<tr><td width="60">'
               + '<a href="http://' + vstrWebAddress
               + '/cgi-bin/MudsoxICD9.DLL/Code?Code='
               + copy(vstrWork, 1, pos(' ', vstrWork) - 1) + '">'
               + copy(vstrWork, 1, pos(' ', vstrWork) - 1)
               + '</a></td>'
               + '<td width="'
               + inttostr(ICD9process.vintTableSize-60) + '">'
               + copy(vstrWork,
                      pos(' ', vstrWork) + 1,
                      pos('^' + #177, vstrWork)- (pos(' ', vstrWork) + 1))
               + '</td></tr>';
     vstlSection[vintLoop]:= vstrWork;
     end;
  ReplaceText:= '<font size="4"><b>Section Detail</b><BR><BR><font size="3">' +
             vstlSection.text;
  finally
    vstlSection.free;
    end;
  end;
except
  on
  E: Exception do
     begin
     ReplaceText:= 'Error in pgpSectionHTMLTag';
     ICD9process.LogIT('Error in pgpSectionHTMLTag: ' + E.Message);
     end;
  end;
end;

procedure TwmICD9.pgpBugResponseHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: String; TagParams: TStrings; var ReplaceText: String);
  //var smtpBugs: tnmsmtp;
  var vstlMail: tstringlist;
begin
try
If TagString = 'BugThanks' then
  begin
  vstlMail:= tstringlist.create;
  try
  vstlMail.Add('Host=smtp.buf.adelphia.net');
  vstlMail.Add('FromAddress=mudsox@adelphia.net');
  vstlMail.Add('ToAddress=ICD9bugs@mudsox.com');
  vstlMail.Add('LocalProgram=MudsoxICD9');
  vstlMail.Add('TimeOut=60000');

  If length(Request.ContentFields.Values['Subject']) = 0 then
    vstlMail.Add('Subject=Bug report on MudsoxICD9 system')
  else
    vstlMail.Add('Subject=' + Request.ContentFields.Values['Subject']);
  If length(Request.ContentFields.Values['Username']) = 0 then
    vstlMail.Add('FromName=Anonymous')
  else
    vstlMail.Add('FromName=' + Request.ContentFields.Values['Username']);
  If length(Request.ContentFields.Values['UserEmail']) = 0 then
    vstlMail.Add('ReplyTo=Anonymous@mudsox.com')
  else
    vstlMail.Add('ReplyTo=' + Request.ContentFields.Values['UserEmail']);

  vstlMail.Add('Body=' + Request.ContentFields.Values['Comments']);

  vstlMail.savetofile(vstrRootFolder + '\log\' +
                      inttostr(round(now*100000)) +
                      '.mail');
    finally
    vstlMail.free;
    end;
  ICD9process.LogIT('Bugreport Submitted');

{  smtpBugs:= tnmsmtp.create(nil);
  try
  smtpBugs.Host := 'smtp.buf.adelphia.net';
  smtpBugs.postmessage.FromAddress:= 'mudsox@adelphia.net';
  smtpBugs.PostMessage.ToAddress.text:= 'ICD9bugs@mudsox.com';
  smtpBugs.PostMessage.LocalProgram:= 'MudsoxICD9';
  smtpBugs.TimeOut:= 60000;
  smtpBugs.postmessage.Subject := Request.ContentFields.Values['Subject'];
  smtpBugs.postmessage.FromName:= Request.ContentFields.Values['Username'];
  smtpBugs.postmessage.ReplyTo:= Request.ContentFields.Values['UserEmail'];
  smtpBugs.postmessage.Body.text:= Request.ContentFields.Values['Comments'];
  If length(smtpBugs.postmessage.Subject) = 0 then
    smtpBugs.postmessage.Subject:= 'Bug report on MudsoxICD9 system';
  If length(smtpBugs.postmessage.FromName) = 0 then
    smtpBugs.postmessage.FromName:= 'Anonymous';
  If length(smtpBugs.postmessage.ReplyTo) = 0 then
    smtpBugs.postmessage.ReplyTo:= 'Anonymous@mudsox.com';
  try
  smtpBugs.connect;
  smtpBugs.SendMail;
  smtpBugs.Disconnect;
  ReplaceText:= 'Thank you for your help!';
  except
    ICD9process.LogIT
               ('Bugreport error: ' + Request.ContentFields.Values['Comments']);
    ReplaceText:= 'Sorry, you are not able to connect to valid SMTP Server';
    end;
  finally
    smtpBugs.free;
    end;}
  ReplaceText:= 'Thank you for your help!';
  end;
except
  on
  E: Exception do
     begin
     ReplaceText:= 'Error in sending automated mail to ICD9 site';
     ICD9process.LogIT('Error in pgpBugResponseHTMLTag: ' + E.Message);
     end;
  end;
end;

procedure TwmICD9.pgpDefaultHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: String; TagParams: TStrings; var ReplaceText: String);
begin
try
If TagString = 'IP' then
  ReplaceText:= vstrWebAddress;
except
  on
  E: Exception do
     begin
     ReplaceText:= 'Error in pgpDefaultHTMLTag';
     ICD9process.LogIT('Error in pgpDefaultHTMLTag: ' + E.Message);
     end;
  end;
end;

{---------Routines to test the index text display--------}
procedure TwmICD9.pgpIndexDetailHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: String; TagParams: TStrings; var ReplaceText: String);
  var vstrWork, vstrHoldTerm: string;
      vstlDetail: tstringlist;
      vintMatch: integer;
begin
try
If TagString = 'Detail' then
  begin
  ICD9process.LogIT('Details: ' + ICD9process.vstrSearchString);
  vstlDetail:= tstringlist.create;
  try
  {Find the Index Detail information}
  vstrWork:= vstlICD9index[strtoint(ICD9process.vstrSearchString)];
  {Save the index search term}
  vstrHoldTerm:= ICD9process.FindIndexAbbreviation(vstrWork);
  If copy(vstrWork, 1, 8) = 'Neoplasm' then
     ICD9process.ProcessNeoplasm(vstrWork)
  else
     ICD9process.IndexToHTML(vstrWork);
  ICD9process.ConvertToStringList(vstrWork, vstlDetail);
  ICD9process.LinkToHTML(vstlDetail, '');
  vstrWork:= vstlDetail[0];
  vstrWork:= '<b>' + vstrWork + '</b>';
  vstlDetail[0]:= vstrWork;
  {Add to the Index Detail the Search information }
  ICD9process.FindAndProcessSearchResult(vstrHoldTerm,
                             ICD9process.vstlSearchAnswer,
                             ICD9process.vstlLinks,
                             vintMatch);
  {Format the entire response}
  ReplaceText:= '<font size="4"><b>Detailed ICD9 Index Description</b>' +
      '<BR><BR><font size="3">' +
       vstlDetail.text;
  If ICD9process.vstlSearchAnswer.count > 0 then
      ReplaceText:= ReplaceText +
       '<br><br>' +
      '<font size="3"><b>See Also: Code Links</b>' +
      '<BR><font size="2">' +
       ICD9process.vstlSearchAnswer.text;
  finally
    vstlDetail.free;
    end;
  end;
except
  on
  E: Exception do
     begin
     ReplaceText:= 'Error in pgpIndexDetailHTMLTag';
     ICD9process.LogIT('Error in pgpIndexDetailHTMLTag: ' + E.Message);
     end;
  end;
end;


procedure TwmICD9.pgpIndexSummaryHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: String; TagParams: TStrings; var ReplaceText: String);
begin
try
If TagString = 'Summary' then
  begin
  ReplaceText:= '<font size="3"><b>Select the first letter of the word</b>' +
      '<BR><BR><font size="3">' +
       pgpAlphaHeader.Content;
  end;
except
  on
  E: Exception do
     begin
     ReplaceText:= 'Error in pgpIndexSummaryHTMLTag';
     ICD9process.LogIT('Error in pgpIndexSummaryHTMLTag: ' + E.Message);
     end;
  end;
end;

procedure TwmICD9.pgpAlphaHeaderHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: String; TagParams: TStrings; var ReplaceText: String);
begin
try
If TagString = 'IP' then
  ReplaceText:= vstrWebAddress;
except
  on
  E: Exception do
     begin
     ReplaceText:= 'Error in pgpAlphaHeaderHTMLTag';
     ICD9process.LogIT('Error in pgpAlphaHeaderHTMLTag: ' + E.Message);
     end;
  end;
end;

procedure TwmICD9.pgpIndexAlphaHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: String; TagParams: TStrings; var ReplaceText: String);
  var vstlAlpha: tstringlist;
      varrColumn: array[1..10] of string;
      vintLoop: integer;
      //vstrColumn1, vstrColumn2, vstrColumn3: string;
      {Split into columns evenly}
      Procedure ColumnSplit(const vintColumn: integer);
        var vintMax, vintStart, vintLines, vintLoop: integer;
        begin
        If vstlAlpha.count = (round(int(vstlAlpha.count
                              / ICD9process.vintTotalColumns))
                              * ICD9process.vintTotalColumns) then
           vintLines:= vstlAlpha.count
        else
           vintLines:= round(int((vstlAlpha.count+ ICD9process.vintTotalColumns)
                                         / ICD9process.vintTotalColumns))
                                         * ICD9process.vintTotalColumns;
        vintStart:= (round(int(vintLines / ICD9process.vintTotalColumns))
                                         * (vintColumn-1));
        vintMax:= (round(int(vintLines/ICD9process.vintTotalColumns))
                                         * vintColumn) - 1;
        If vintStart> vintMax then exit;
        For vintLoop:= vintStart to vintMax do
           begin
           If vintLoop>= vstlAlpha.count then
              break;
           varrColumn[vintColumn]:= varrColumn[vintColumn]+ vstlAlpha[vintLoop];
           end;
        end;
begin
//ICD9process.vintTotalColumns:= 10;
try
If TagString = 'Alpha' then
  begin
  ICD9process.LogIT('IndexLetter: ' + ICD9process.vstrSearchString);
  vstlAlpha:= tstringlist.create;
  try
  ICD9process.ICD9IndexLetter(ICD9process.vstrSearchString, vstlAlpha);
  ICD9process.IndexSummaryToHTML(vstlAlpha);

  for vintLoop:= 1 to ICD9process.vintTotalColumns do
     ColumnSplit(vintLoop);

  ReplaceText:=
        '<font size="4"><b>ICD9 Index Alphabetical Listing for ' +
         ICD9process.vstrSearchString + '</b><BR>' +
        '<table border="0" width="' +
         inttostr(ICD9process.vintTableSize-5) +
         '"><tr>';
  for vintLoop:= 1 to ICD9process.vintTotalColumns do
        ReplaceText:= ReplaceText +
                      '<td width="170" valign="top"><font size="2">' +
                      varrColumn[vintLoop] + '</font></td>';
  ReplaceText:= ReplaceText + '</tr>';
  finally
    vstlAlpha.free;
    end;
  end;
except
  on
  E: Exception do
     begin
     ReplaceText:= 'Error in pgpIndexAlphaHTMLTag';
     ICD9process.LogIT('Error in pgpIndexAlphaHTMLTag: ' + E.Message);
     end;
  end;
end;

procedure TwmICD9.pgpBugFormHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: String; TagParams: TStrings; var ReplaceText: String);
begin
try
If TagString = 'IP' then
  ReplaceText:= vstrWebAddress;
except
  on
  E: Exception do
     begin
     ReplaceText:= 'Error in pgpBugFormHTMLTag';
     ICD9process.LogIT('Error in pgpBugFormHTMLTag: ' + E.Message);
     end;
  end;
end;

procedure TwmICD9.pgpShowBookmarksHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: String; TagParams: TStrings; var ReplaceText: String);
  var vstlBookmarks, vstlChapter: tstringlist;
      vstrWork, vstrPrefix, vstrChapterText: string;
      vintLoop: integer;
begin
try
If TagString = 'Showbookmarks' then
  begin
  ICD9process.LogIT('Show Bookmarks');
  vstlBookmarks:= tstringlist.create;
  vstlChapter:= tstringlist.create;
  try
    vstlBookmarks.text:= Request.CookieFields.Text;
    {Remove the SKIN cookie}
    If vstlBookmarks.Count = 11 then
       vstlBookMarks.Delete(10);
    {Remove the X bookmark placeholders}
    for vintloop:= vstlBookMarks.count-1 downto 0 do
      If pos('=X', vstlBookMarks[vintLoop]) > 0 then
            vstlBookMarks.delete(vintLoop);
    {Whatever is left is real bookmark text}
    If vstlBookMarks.count > 0 then
      begin
      {Generate a summary link for the remaining matches}
      for vintLoop:= 0 to vstlBookmarks.count - 1 do
          begin
          vstrWork:=
             ICD9process.ICD9GetCode(copy(vstlBookmarks[vintLoop],
                              pos('=',vstlBookmarks[vintLoop]) + 1, 999),
                         true,
                         vstlChapter);
             {vstlChapter is null here - needed a dummy stringlist for the call}
          vstrPrefix:= copy(vstrWork, pos('~~', vstrWork) + 2, 999);
          vstrWork:= copy(vstrWork, 1, pos('~~', vstrWork) - 1);
          vstrWork:= '<tr><td width="60">'
               + '<a href="http://' + vstrWebAddress
               + '/cgi-bin/MudsoxICD9.DLL/Code?Code='
               + copy(vstrWork, 1, pos(' ', vstrWork) - 1) + '">'
               + copy(vstrWork, 1, pos(' ', vstrWork) - 1)
               + '</a></td>'
               + '</td><td width="'
               + inttostr(ICD9process.vintTableSize-60) + '">'
               + copy(vstrWork, pos(' ', vstrWork) + 1,99999)
               + '</td></tr>';
          vstlBookmarks[vintLoop]:= vstrWork;
          {Chapter}
          vstrWork:= copy(vstrPrefix,
                 pos('^' + #176, vstrPrefix) + 2,
                 pos(#176 + '^', vstrPrefix) - pos('^' + #176, vstrPrefix) - 2);
          vstrChapterText:= ICD9process.GetOneLine(strtoint(vstrWork));
          ICD9process.TrimCodes(vstrChapterText, false);
          ICD9process.MixCase(vstrChapterText);
          vstrChapterText:=
                '<tr valign=bottom><td width="60"><font size="2">&nbsp'
              + '</td><td width="'
              + inttostr(ICD9process.vintTableSize-60) + '"><font size="2">'
              + '<a href="http://' + vstrWebAddress
              + '/cgi-bin/MudsoxICD9.DLL/SectionList?Chapter='
              + vstrWork + '">'
              + vstrChapterText
              + '</a></td></tr>';
          vstlChapter.add(vstrChapterText);
          end;
      end;
   {Build the bookmark response}
   vstrWork:= '<font size="4"><b>Personal Bookmarks</b><BR><font size="3">';
   {Interlace the bookmarks and chapoter links}
     If vstlBookMarks.count > 0 then
       For vintLoop:= 0 to vstlBookmarks.Count - 1 do
          vstrWork:= vstrWork + vstlBookmarks[vintLoop] + vstlChapter[vintLoop]
     else
          vstrWork:= vstrWork + 'You have no Bookmarks';
   ReplaceText:= vstrWork;
  finally
    vstlChapter.free;
    vstlBookmarks.free;
    end;
  end;
  except
  on
  E: Exception do
     begin
     ReplaceText:= 'Error in wmICD9actShowbookmarksAction';
     ICD9process.LogIT('Error in wmICD9actShowbookmarksAction: ' + E.Message);
     end;
    end;
end;

end.
