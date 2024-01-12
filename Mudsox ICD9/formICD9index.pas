unit formICD9index;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, OleCtrls, SHDocVw;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
  txtIN, txtOut: TextFile;
  vstrLine, vstrPrefix, vstrNewLine, vstrRawLine: string;
  vbolStart: boolean;
  procedure StripDoubleBracket;
    var vintLoop: integer;
        vstrTemp: string;
        vbolStop: boolean;
    begin
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
          vintLoop:= vintLoop + 5;
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
       vstrLine:= vstrTemp;
    end;
begin
  AssignFile(txtIn, 'dindex01.rtf');
  AssignFile(txtOut, 'ICD9index.txt');
  Reset(txtIn);
  Rewrite(txtOut);
  vbolStart:= false;
  vstrPrefix:='';
  vstrNewLine:= '';
  vstrRawLine:= '';
  vstrLine:= '';

  while not Eof(txtIn) do
      begin
      {Reading the rtf file directly brings in some partial lines that must be
      glued together for processing
        3 strings used in the process
          1. vstrRawLine - the result of the read statement
          2. vstrLine - multiple lines glued together before formatting
          3. vstrNewLine - combined lines for an entire detail record}
      Readln(txtIn, vstrRawLine);
      {Remove until I figure this out......}
      If vstrRawLine = '\par Neoplasm, neoplastic' then
         vbolStart:= false
      else
      If vstrRawLine = '\par Nephrorrhagia 593.81' then
         vbolStart:= true
      {}
      else
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
          If vbolStart and (length(vstrNewLine) > 0) then
            begin
            writeln(txtOut, vstrNewLine);
            end;
          {This is the major control break - start a new detail line}
          vstrNewLine:= '';
          vstrPrefix:= '';
          end
        else
        {18 thru 21 are the left margin indents}
        If pos('\s18\', vstrLine) > 0 then
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
        as a control break.  vstrPrefix = '' means \s17\ was last}
        If vbolStart
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

        If pos('1033 {', vstrLine) > 0 then
            vstrLine:= copy(vstrLine, pos('1033 {', vstrLine) + 6, 999);

        If pos('\par }{', vstrLine) > 0 then
            vstrLine:= copy(vstrLine, pos('\par }{', vstrLine) + 7, 999)
        else
        If pos('\par ', vstrLine) > 0 then
            vstrLine:= copy(vstrLine, pos('\par ', vstrLine) + 5, 999);

        {Elimate any line with the \s26\ format - all formatting no detail}
        If pos('\s26\', vstrLine) > 0 then
            vstrLine:= '';

        {Take out other control codes and \tab and \line stuff}
        StripDoubleBracket;

        {Append all of the current line to the multi-line detail record}
        If vbolStart and (length(vstrLine) > 0) then
           vstrNewLine:= vstrNewLine + vstrPrefix + vstrLine;
        end;
      vstrLine:= vstrRawLine;
      end;
    {cath the last line of the file as a control break and close}
    writeln(txtOut, vstrNewLine);
    CloseFile(txtIn);
    CloseFile(txtOut);

end;

end.
