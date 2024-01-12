unit cgiMudsoxMail1;

interface

uses
  Windows, Messages, SysUtils, Classes, HTTPApp, Psock, NMsmtp;

type
  TwebModuleMail = class(TWebModule)
    smtpMail: TNMSMTP;
    procedure WebModule1actMailAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  webModuleMail: TwebModuleMail;

implementation

{$R *.DFM}

procedure TwebModuleMail.WebModule1actMailAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  var
  vintResult : Integer;
  srcSearchRec : TSearchRec;
  vstrFileName : String;
     function ProcessMailFile: boolean;
        var vstlMail: tstringlist;
        begin
        try
        Result:=true;
        vstlMail:= tstringlist.create;
        try
        vstlMail.loadfromfile(vstrFileName);
        smtpMail.Host := copy(vstlMail[0], pos('=', vstlMail[0]) + 1, 999);
        smtpMail.postmessage.FromAddress:=
                         copy(vstlMail[1], pos('=', vstlMail[1]) + 1, 999);
        smtpMail.PostMessage.ToAddress.text:=
                         copy(vstlMail[2], pos('=', vstlMail[2]) + 1, 999);
        smtpMail.PostMessage.LocalProgram:=
                         copy(vstlMail[3], pos('=', vstlMail[3]) + 1, 999);
        smtpMail.TimeOut:=
                strtoint(copy(vstlMail[4], pos('=', vstlMail[4]) + 1, 999));
        smtpMail.postmessage.Subject :=
                         copy(vstlMail[5], pos('=', vstlMail[5]) + 1, 999);
        smtpMail.postmessage.FromName:=
                         copy(vstlMail[6], pos('=', vstlMail[6]) + 1, 999);
        smtpMail.postmessage.ReplyTo:=
                         copy(vstlMail[7], pos('=', vstlMail[7]) + 1, 999);
        smtpMail.postmessage.Body.text:=
                      copy(vstlMail.text, pos('Body=', vstlMail.text) + 5, 999);
        smtpMail.connect;
        smtpMail.SendMail;
        smtpMail.Disconnect;
          finally
          vstlMail.free;
          end;
        except
          Result:=false;
          end;
        end;
begin
{Search for all eligible .mail text files and send them based on the parameters
in the text file.}
vintResult := FindFirst('', faAnyFile, srcSearchRec);
try
try
 while vintResult = 0 DO
   BEGIN
   vstrFileName  := srcSearchRec.Name;
   If pos('.mail', vstrFileName) > 0 then
      If ProcessMailFile then
          DeleteFile(vstrFileName);
   vintResult := FindNext(srcSearchRec);
   END;
finally
  FindClose(srcSearchRec);
  end;
  Response.Content:= 'Messages Sent!';
except
  on
  e: exception do
     Response.Content:= 'an exception has occurred: ' + e.Message;
  end;

end;

end.
