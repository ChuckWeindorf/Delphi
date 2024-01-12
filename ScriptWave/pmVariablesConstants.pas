unit pmVariablesConstants;

interface
uses classes, SBSimpleSftp;

 var
 vstrIP: string;
 vstrEmergencyIP: string;
 vstrLogin: string;
 vstrPassword: string;
 vstrTranscriptionist: string;
 vstrTranscriptionistID: string;
 vstrPhysician: string;
 vstrPhysicianID: string;
 vstrTypist: string;
 vstrTypistID: string;

 vstrMasterDoc: string;
 vstrMessages: string;
 vstrFTP: string;
 vstrArchive: string;

 vstrConfigFile: string;

 {----Preferences---}
 vstrTransmitFolder: string;
 vstrReceiveFolder: string;
 vstrAudioPlayer: string;
 vbolAutomatic: boolean;
 vbolDeleteImport: boolean;
 vbolRenameImport: boolean;
 vbolAutoPrint: boolean;

 vbolPurge: boolean;
 vstrPurgeMaster: string;
 vstrPurgeImport: string;
 vstrPurgeTranscription: string;
 vstrPrintCommand: string;
 vstrPrintParameter: string;

 vstrLastImport: string;
 vintLastImportSeq: integer;

 {-------------------------}
 vbolFTPCompletion: boolean;
 vbolFTP: boolean;
 vbolEmergencyNow: boolean;

 {-------------------------}
 vstlDir: tstringlist;
 vstlDirDateStamp: tstringlist;

 {-------------------------}

  ftpThreadTransfer: TElSimpleSFTPClient;
  ftpCheckEmergency: TElSimpleSFTPClient;

 const
 cintFTPDirOffset: integer = 11;
 //cstrFTPSystem: string = '/ScriptWave/';
 cstrFTPSystem: string = '/home/mudsoxco/ScriptWave/';
 //cstrCheckDate: string = '02/08/2008';









{VERY IMPORTANT _ DO NOT CHANGE ANY CHARACTER OF THESE CONSTANTS.  Mudcryptor
will not be able to decrypt created with the prior version of the contant.}
 cstrScam01: string = '@#^&O*ui56$%7R12wr340-=!TYeU}|(89op[]\QWE)_+qtIP{y';
 cstrScam02: string = 'DFJK4L./ghGHj>asvndf;=AS?1b278:klZXCVBNM<"zxcm356,';
 cstrScam03: string = ')_wefrWE!@+q#}90p]-=^&*(|a[sjkt$%RTYUIOP{yuio\dghQ';
 cstrScam04: string = '"zvb=nM<SDxcF7l;XV=AJKL:89C0#$mGH>?123456,./ZB-!@N';
 cstrScam05: string = 'yup[D]{}()io_l%^YI&*wert;=UAHJQ+qasdfghjkWERTOSFGP';
 cstrScam06: string = '/ZVB)N78zxXCc%KL24:"nm,.^&3*qwMvb90-=!@#$<>?15(_+6';
 cstrScam07: string = 'RTIOxPl;uiYUoKerfhty]QWEL:g=bn{p[=ASDFGHJ}asdjzcvk';
 cstrScam08: string = '?145i6%^ZX23Cem,=@./NM<>rt!y[]7VB&*()_+qw890-#uop$';
 cstrScam09: string = '|afg/hHJRTsdYb\QADWEOP{}nmS,CVjUIKL:"zxcvkl;=F.ZXG';
 cstrScam10: string = '89=!E@qw>?0-1[BN*)M<4567]\(QYU#23ertyuiop$%^&_WRT+';
 cstrScam11: string = 'klAS<Dcv}|;=aCIOL"P{fghjVB:N12Fsdbnm,./ZXGHJKzM>?x';
 cstrScam12: string = '$%*({)op78^&9Y34ry56=!@#UItOas_0-[]\QWERT+qweuP}|i';
 cstrScam13: string = 'GHL:6"ZXjkJKl1dfn,ghASDF23m490z;=CVBNM<>?xcvb.578/';
 cstrScam14: string = '+qrtkyTY#$we%d-=]W!@*()_fgQh=Au^&UIOP{}asiop[Ejl;R';
 cstrScam15: string = 'vb,.$/12HJnmK-SDN<FG"zxc=!M@&*ZL:34567890XCVB>#%^?';
 cstrScam16: string = 'p[QWGEasqw]\e=()O{_+yuioASPDKLRrtdfghjkl;TYUI}FHJ|';
 cstrScam17: string = 'XCNM+<90cvVBb&:"46zx,./Z*(5)er>nm-=!@#$%^?1237_qw8';
 cstrScam18: string = 'TYOPx{l;opUI[KtyfhuiQWERL:g"bn}]\=ASDFGHJ|asdjzcvk';
 cstrScam19: string = '?145i6%^ZX23Cem,=@./NM<>rt!y[]7VB&*()_+qw890-#uop$';
 cstrScam20: string = 'sdhjXkKLTYfgUmQWDGERP{}a,.F/BNlIO:"zxcvbn;=ASHZCVJ';

implementation

end.
