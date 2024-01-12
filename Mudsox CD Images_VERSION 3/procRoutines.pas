unit procRoutines;

interface
uses Classes, registry;

var
  vstlNewHTML, vstlOldHTML, vstlNewImages, vstlEmailImages: tstringlist;

function ReadRegistry(const cstrSection, cstrIdent, cstrKey: string): string;
procedure WriteRegistry
                     (const cstrSection, cstrIdent, cstrKey, cstrValue: string);

implementation

function ReadRegistry(const cstrSection, cstrIdent, cstrKey: string): string;
var vregRegistry: TRegInifile;
begin
vregRegistry:= treginifile.create(cstrSection);
try
Result := vregRegistry.Readstring(cstrIdent, cstrKey, '');
  finally
  vregRegistry.free;
  end;
end;

procedure WriteRegistry
                     (const cstrSection, cstrIdent, cstrKey, cstrValue: string);
var vregRegistry: TRegInifile;
begin
vregRegistry:= treginifile.create(cstrSection);
try
vregRegistry.Writestring(cstrIdent, cstrKey, cstrValue);
  finally
  vregRegistry.free;
  end;
end;

end.
