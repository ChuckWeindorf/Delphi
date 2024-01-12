object wmICD9: TwmICD9
  OldCreateOrder = False
  OnCreate = WebModuleCreate
  OnDestroy = WebModuleDestroy
  Actions = <
    item
      Default = True
      Name = 'actDefault'
      PathInfo = '/'
      Producer = pgpDefault
    end
    item
      Name = 'actChapter'
      PathInfo = '/Chapter'
      OnAction = wmICD9actChapterAction
    end
    item
      Name = 'actSearch'
      PathInfo = '/Search'
      OnAction = wmICD9actSearchAction
    end
    item
      Name = 'actSectionList'
      PathInfo = '/SectionList'
      OnAction = wmICD9actSectionListAction
    end
    item
      Name = 'actSection'
      PathInfo = '/Section'
      OnAction = wmICD9actSectionAction
    end
    item
      Name = 'actRange'
      PathInfo = '/CodeRange'
      OnAction = wmICD9actRangeAction
    end
    item
      Name = 'actCode'
      PathInfo = '/Code'
      OnAction = wmICD9actCodeAction
    end
    item
      Name = 'actDetail'
      PathInfo = '/Detail'
      OnAction = wmICD9actDetailAction
    end
    item
      Name = 'actIndexAlpha'
      PathInfo = '/IndexAlpha'
      OnAction = wmICD9actIndexAlphaAction
    end
    item
      Name = 'actIndexSummary'
      PathInfo = '/IndexSummary'
      OnAction = wmICD9actIndexSummaryAction
    end
    item
      Name = 'actIndexDetail'
      PathInfo = '/IndexDetail'
      OnAction = wmICD9actIndexDetailAction
    end
    item
      Name = 'actSetBookmark'
      PathInfo = '/Setbookmark'
      OnAction = wmICD9actSetBookmarkAction
    end
    item
      Name = 'actShowbookmarks'
      PathInfo = '/Showbookmarks'
      OnAction = wmICD9actShowbookmarksAction
    end
    item
      Name = 'actSetSkin'
      PathInfo = '/SetSkin'
      OnAction = wmICD9actSetSkinAction
    end
    item
      Name = 'actBugForm'
      PathInfo = '/BugForm'
      OnAction = wmICD9actBugFormAction
    end
    item
      Name = 'actBugReport'
      PathInfo = '/bugreport'
      OnAction = wmICD9actBugReportAction
    end
    item
      Name = 'actRedirect'
      PathInfo = '/Redirect'
      OnAction = wmICD9actRedirectAction
    end>
  Left = 261
  Top = 29
  Height = 584
  Width = 493
  object pgpChapter: TPageProducer
    HTMLDoc.Strings = (
      '<#Chapter>')
    OnHTMLTag = pgpChapterHTMLTag
    Left = 120
    Top = 8
  end
  object pgpSearch: TPageProducer
    HTMLDoc.Strings = (
      '<#Search>')
    OnHTMLTag = pgpSearchHTMLTag
    Left = 120
    Top = 56
  end
  object pgpDefault: TPageProducer
    HTMLDoc.Strings = (
      '<HTML>'
      'This is no matching action to this call.<br>'
      'Please let us know how about this '
      
        '<a href="http://<#IP>/cgi-bin/MudsoxICD9.DLL/BugForm">problem.</' +
        'a>'
      '</HTML>')
    OnHTMLTag = pgpDefaultHTMLTag
    Left = 208
    Top = 392
  end
  object pgpCode: TPageProducer
    HTMLDoc.Strings = (
      '<#Code>')
    OnHTMLTag = pgpCodeHTMLTag
    Left = 120
    Top = 104
  end
  object pgpSectionList: TPageProducer
    HTMLDoc.Strings = (
      '<#SectionList>')
    OnHTMLTag = pgpSectionListHTMLTag
    Left = 120
    Top = 200
  end
  object pgpSection: TPageProducer
    HTMLDoc.Strings = (
      '<#Section>')
    OnHTMLTag = pgpSectionHTMLTag
    Left = 120
    Top = 152
  end
  object pgpRange: TPageProducer
    HTMLDoc.Strings = (
      '<#CodeRange>')
    OnHTMLTag = pgpRangeHTMLTag
    Left = 120
    Top = 248
  end
  object pgpDetail: TPageProducer
    HTMLDoc.Strings = (
      '<#Detail>')
    OnHTMLTag = pgpDetailHTMLTag
    Left = 120
    Top = 296
  end
  object pgpIndexDetail: TPageProducer
    HTMLDoc.Strings = (
      '<#Detail>')
    OnHTMLTag = pgpIndexDetailHTMLTag
    Left = 208
    Top = 56
  end
  object pgpAlphaHeader: TPageProducer
    HTMLDoc.Strings = (
      
        '<a href="http://<#IP>/cgi-bin/MudsoxICD9.DLL/IndexAlpha?Letters=' +
        'A">A</a>&nbsp;'
      
        '<a href="http://<#IP>/cgi-bin/MudsoxICD9.DLL/IndexAlpha?Letters=' +
        'B">B</a>&nbsp;'
      
        '<a href="http://<#IP>/cgi-bin/MudsoxICD9.DLL/IndexAlpha?Letters=' +
        'C">C</a>&nbsp;'
      
        '<a href="http://<#IP>/cgi-bin/MudsoxICD9.DLL/IndexAlpha?Letters=' +
        'D">D</a>&nbsp;'
      
        '<a href="http://<#IP>/cgi-bin/MudsoxICD9.DLL/IndexAlpha?Letters=' +
        'E">E</a>&nbsp;'
      
        '<a href="http://<#IP>/cgi-bin/MudsoxICD9.DLL/IndexAlpha?Letters=' +
        'F">F</a>&nbsp;'
      
        '<a href="http://<#IP>/cgi-bin/MudsoxICD9.DLL/IndexAlpha?Letters=' +
        'G">G</a>&nbsp;'
      
        '<a href="http://<#IP>/cgi-bin/MudsoxICD9.DLL/IndexAlpha?Letters=' +
        'H">H</a>&nbsp;'
      
        '<a href="http://<#IP>/cgi-bin/MudsoxICD9.DLL/IndexAlpha?Letters=' +
        'I">I</a>&nbsp;'
      
        '<a href="http://<#IP>/cgi-bin/MudsoxICD9.DLL/IndexAlpha?Letters=' +
        'J">J</a>&nbsp;'
      
        '<a href="http://<#IP>/cgi-bin/MudsoxICD9.DLL/IndexAlpha?Letters=' +
        'K">K</a>&nbsp;'
      
        '<a href="http://<#IP>/cgi-bin/MudsoxICD9.DLL/IndexAlpha?Letters=' +
        'L">L</a>&nbsp;'
      
        '<a href="http://<#IP>/cgi-bin/MudsoxICD9.DLL/IndexAlpha?Letters=' +
        'M">M</a>&nbsp;'
      
        '<a href="http://<#IP>/cgi-bin/MudsoxICD9.DLL/IndexAlpha?Letters=' +
        'N">N</a>&nbsp;'
      
        '<a href="http://<#IP>/cgi-bin/MudsoxICD9.DLL/IndexAlpha?Letters=' +
        'O">O</a>&nbsp;'
      
        '<a href="http://<#IP>/cgi-bin/MudsoxICD9.DLL/IndexAlpha?Letters=' +
        'P">P</a>&nbsp;'
      
        '<a href="http://<#IP>/cgi-bin/MudsoxICD9.DLL/IndexAlpha?Letters=' +
        'Q">Q</a>&nbsp;'
      
        '<a href="http://<#IP>/cgi-bin/MudsoxICD9.DLL/IndexAlpha?Letters=' +
        'R">R</a>&nbsp;'
      
        '<a href="http://<#IP>/cgi-bin/MudsoxICD9.DLL/IndexAlpha?Letters=' +
        'S">S</a>&nbsp;'
      
        '<a href="http://<#IP>/cgi-bin/MudsoxICD9.DLL/IndexAlpha?Letters=' +
        'T">T</a>&nbsp;'
      
        '<a href="http://<#IP>/cgi-bin/MudsoxICD9.DLL/IndexAlpha?Letters=' +
        'U">U</a>&nbsp;'
      
        '<a href="http://<#IP>/cgi-bin/MudsoxICD9.DLL/IndexAlpha?Letters=' +
        'V">V</a>&nbsp;'
      
        '<a href="http://<#IP>/cgi-bin/MudsoxICD9.DLL/IndexAlpha?Letters=' +
        'W">W</a>&nbsp;'
      
        '<a href="http://<#IP>/cgi-bin/MudsoxICD9.DLL/IndexAlpha?Letters=' +
        'X">X</a>&nbsp;'
      
        '<a href="http://<#IP>/cgi-bin/MudsoxICD9.DLL/IndexAlpha?Letters=' +
        'Y">Y</a>&nbsp;'
      
        '<a href="http://<#IP>/cgi-bin/MudsoxICD9.DLL/IndexAlpha?Letters=' +
        'Z">Z</a>&nbsp;')
    OnHTMLTag = pgpAlphaHeaderHTMLTag
    Left = 208
    Top = 200
  end
  object pgpIndexSummary: TPageProducer
    HTMLDoc.Strings = (
      '<#Summary>')
    OnHTMLTag = pgpIndexSummaryHTMLTag
    Left = 208
    Top = 8
  end
  object pgpIndexAlpha: TPageProducer
    HTMLDoc.Strings = (
      '<#Alpha>')
    OnHTMLTag = pgpIndexAlphaHTMLTag
    Left = 208
    Top = 104
  end
  object pgpBugForm: TPageProducer
    HTMLDoc.Strings = (
      
        '<form action="http://<#IP>/cgi-bin/MudsoxICD9.DLL/bugreport" met' +
        'hod="POST">'
      '  <blockquote>'
      
        '  <p align="left"><b><font color="#000000"><font size="3">We app' +
        'reciate your help in improving the'
      'quality of <i>ICD9scope</i>.</font><br>'
      '  <br>'
      
        '  ICD9 Code:</font></b> <font color="#000000"> <input type="text' +
        '" size="13" maxlength="256" name="Subject">'
      '  </font>'
      
        '  <p align="left"><strong><font color="#000000">Please describe ' +
        'the problem in'
      '  the space provided below:</font></strong></p>'
      
        '  <p align="left"><font color="#000000"><textarea name="Comments' +
        '" rows="5" cols="45"></textarea>'
      '  </font>'
      
        '  <p align="left"><strong><font color="#000000">Fill in the foll' +
        'owing if you'
      '  would like a response:</font></strong></p>'
      '      <table>'
      '        <tr>'
      '          <td>'
      
        '            <p align="left"><font color="#000000"><b>Name</b></f' +
        'ont>'
      '          <td>'
      
        '            <p align="left"><font color="#000000"><input type="t' +
        'ext" size="35" maxlength="256" name="Username">'
      '            </font>'
      '        </tr>'
      '        <tr>'
      '          <td>'
      
        '            <p align="left"><font color="#000000"><b>E-mail</b><' +
        '/font>'
      '          <td>'
      
        '            <p align="left"><font color="#000000"><input type="t' +
        'ext" size="35" maxlength="256" name="UserEmail">'
      '            </font>'
      '        </tr>'
      '      </table>'
      
        '  <p><font color="#000000"><input type="submit" value="Submit Bu' +
        'g"></font> </p>'
      '  </blockquote>'
      '</form>')
    OnHTMLTag = pgpBugFormHTMLTag
    Left = 120
    Top = 392
  end
  object pgpShowBookmarks: TPageProducer
    HTMLDoc.Strings = (
      '<#Showbookmarks>')
    OnHTMLTag = pgpShowBookmarksHTMLTag
    Left = 120
    Top = 344
  end
  object pgpBugResponse: TPageProducer
    HTMLDoc.Strings = (
      '<#BugThanks>')
    OnHTMLTag = pgpBugResponseHTMLTag
    Left = 120
    Top = 440
  end
  object pgpTemplate: TPageProducer
    OnHTMLTag = pgpTemplateHTMLTag
    Left = 32
    Top = 8
  end
end
