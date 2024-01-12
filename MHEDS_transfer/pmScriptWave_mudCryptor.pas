unit pmScriptWave_mudCryptor;

interface
uses  classes, sysutils, pmVariablesConstants, Blowfish;
 {-----------------------------------------------------------------}
 procedure mudCryptorSetup;
 procedure oldCryptorFile(const cstrNormal: string;
                       const cstrEncrypted: string);
 function CryptorFile(const cstrNormal: string;
                      const cstrEncrypted: string): boolean;
 procedure oldUnCryptorFile(const cstrNormal: string;
                         const cstrEncrypted: string);
 procedure UnCryptorFile(const cstrNormal: string;
                         const cstrEncrypted: string);
 function CryptorString(const cstrCry: string): string;
 function UnCryptorString(const cstrCry: string): string;
 function MudcryptorString(const cintCode: integer): string;
 procedure mudCryptorShutdown;
 
 implementation

 var  vstrMudCrypt: string;
      cryBlowfish: TBlowfish;

{------------------------------------------------------------------------------}

{Encryption Component}
procedure mudCryptorSetup;
begin
cryBlowfish:= TBlowfish.Create(nil);
vstrMudcrypt := cstrScam01 + cstrScam02 + cstrScam03 + cstrScam04 +cstrScam05
              + cstrScam06 + cstrScam07 + cstrScam08 + cstrScam09 +cstrScam10
              + cstrScam11 + cstrScam12 + cstrScam13 + cstrScam14 +cstrScam15
              + cstrScam16 + cstrScam17 + cstrScam18 + cstrScam19 +cstrScam20;
end;

procedure mudCryptorShutdown;
begin
cryBlowfish.free;
end;

function CryptorFile(const cstrNormal: string;
                                          const cstrEncrypted: string): boolean;
  var vintKey1, vintKey2: integer;
      vfilIn, vfilOut: tfilestream;
      vintLoop, vintLoop2: integer;
      vintReverse: integer;
      vintLen: longint;
      vbytBuffer: array [1..1024] of char;
      vbytBufferNew: array [1..1024] of char;
      vstrWork: string;
begin
Result:= true;
try
randomize;
{Select random numbers to generate Mudcryptor strings}
vintKey1:= random(44) + 1;
vintKey2:= random(44) + 1;
cryBlowfish.LoadIVString(MudcryptorString(vintKey1));
cryBlowfish.InitialiseString(MudcryptorString(vintKey2));
{Pass 1 encryption}
cryBlowfish.EncFile(cstrNormal, cstrNormal + '1');

{Place the seed numbers in the first 4 positions of the encrypted file}
vfilIn:= tfileStream.create(cstrNormal + '1',fmOpenRead + fmShareDenyWrite);
vfilOut:= tfileStream.create(cstrNormal + '2', fmCreate);
vstrWork:= format('%.2d', [vintKey1]) + format('%.2d', [vintKey2]);
vbytBuffer[1]:= copy(vstrWork,1,1)[1];
vbytBuffer[2]:= copy(vstrWork,2,1)[1];
vbytBuffer[3]:= copy(vstrWork,3,1)[1];
vbytBuffer[4]:= copy(vstrWork,4,1)[1];
vfilOut.write(vbytBuffer, 4);
try
for vintLoop := 1 to round(int(vfilIn.Size/1024)) + 1 do
 begin
 vintLen:= vfilIn.Read(vbytBuffer,1024);
 vintReverse:= 1;
 for vintLoop2 := vintLen downto 1 do
   begin
   vbytBufferNew[vintReverse]:= vbytBuffer[vintLoop2];
   inc(vintReverse);
   end;
 vfilOut.write(vbytBuffer,vintLen);
 end;
finally
 vfilIn.free;
 vfilOut.free;
 end;

cryBlowfish.LoadIVString(vstrTranscriptionistID);
cryBlowfish.InitialiseString(vstrTranscriptionistID);
cryBlowfish.EncFile(cstrNormal + '2', cstrEncrypted);
cryBlowfish.Burn;

except
  Result:= false;
  end;
If fileexists(cstrNormal + '1') then
   deletefile(cstrNormal + '1');
If fileexists(cstrNormal + '2') then
   deletefile(cstrNormal + '2');
end;

procedure UnCryptorFile(const cstrNormal: string;
                                                const cstrEncrypted: string);
  var vintKey1, vintKey2: integer;
      vfilIn, vfilOut: tfilestream;
      vintLoop, vintLoop2: integer;
      vintReverse: integer;
      vintLen: longint;
      vbytBuffer: array [1..32000] of char;
      vbytBufferNew: array [1..32000] of char;
begin
cryBlowfish.LoadIVString(vstrTranscriptionistID);
cryBlowfish.InitialiseString(vstrTranscriptionistID);
cryBlowfish.DecFile(cstrEncrypted, cstrNormal + '1');
cryBlowfish.Burn;

{Place the seed numbers in the first 4 positions of the encrypted file}
vfilIn:= tfileStream.create(cstrNormal + '1',fmOpenRead + fmShareDenyWrite);
vfilOut:= tfileStream.create(cstrNormal + '2', fmCreate);
try
vfilIn.Read(vbytBuffer,4);
try
  vintKey1:= strtoint(vbytBuffer[1] + vbytBuffer[2]);
  vintKey2:= strtoint(vbytBuffer[3] + vbytBuffer[4]);
  except
  oldUncryptorFile(cstrNormal, cstrEncrypted);
  deletefile(cstrNormal + '1');
  exit;
  end;
for vintLoop := 1 to round(int((vfilIn.Size-4)/1024)) + 1 do
 begin
 vintLen:= vfilIn.Read(vbytBuffer,1024);
 vintReverse:= 1;
 for vintLoop2 := vintLen downto 1 do
   begin
   vbytBufferNew[vintReverse]:= vbytBuffer[vintLoop2];
   inc(vintReverse);
   end;
 vfilOut.write(vbytBuffer,vintLen);
 end;
finally
 vfilIn.free;
 vfilOut.free;
 end;

cryBlowfish.LoadIVString(MudcryptorString(vintKey1));
cryBlowfish.InitialiseString(MudcryptorString(vintKey2));
cryBlowfish.DecFile(cstrNormal + '2', cstrNormal);

If fileexists(cstrNormal + '1') then
   deletefile(cstrNormal + '1');
If fileexists(cstrNormal + '2') then
   deletefile(cstrNormal + '2');
end;


{Encryption Component}
procedure oldCryptorFile(const cstrNormal: string;
                                             const cstrEncrypted: string);
begin
cryBlowfish.LoadIVString(MudcryptorString(12));
cryBlowfish.InitialiseString(MudcryptorString(17));
cryBlowfish.EncFile(cstrNormal, cstrEncrypted);
cryBlowfish.Burn;
end;

{Encryption Component}
function CryptorString(const cstrCry: string): string;
begin
cryBlowfish.LoadIVString(MudcryptorString(12));
cryBlowfish.InitialiseString(MudcryptorString(17));
cryBlowfish.EncString(cstrCry, Result);
cryBlowfish.Burn;
end;

procedure oldUnCryptorFile(const cstrNormal: string;
                                               const cstrEncrypted: string);
begin
cryBlowfish.LoadIVString(MudcryptorString(12));
cryBlowfish.InitialiseString(MudcryptorString(17));
cryBlowfish.DecFile(cstrEncrypted, cstrNormal);
cryBlowfish.Burn;
end;

function UnCryptorString(const cstrCry: string): string;
begin
cryBlowfish.LoadIVString(MudcryptorString(12));
cryBlowfish.InitialiseString(MudcryptorString(17));
cryBlowfish.DecString(cstrCry, Result);
cryBlowfish.Burn;
end;

function MudcryptorString(const cintCode: integer): string;
var vintLocation: integer;
    vintLoop: integer;
    vstrWork: string;
begin
vintLocation:= cintCode;
for vintLoop := 1 to 50 do
  begin
  vstrWork := vstrWork + vstrMudCrypt[vintLocation];
  vintLocation := vintLocation + cintCode;
  If vintLocation > 1000 then
     vintLocation := vintLocation - 1000;
  end;
result:= vstrwork;
end;

{DONE encryption}

end.
