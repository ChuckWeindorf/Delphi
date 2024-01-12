unit dataReference;
{Author: Chuck Weindorf
 Description: This datamodule holds all reference tables in read-only,
  unidirectional mode for speed.  This is a placeholder only and should not
  contain business logic.

 Date: 08/04/1999 - CEW - New

  }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db;

type
  TdtmReference = class(TDataModule)
    datReference: TDatabase;
    qryMmomFiles: TQuery;
    qryMmomFields: TQuery;
    dtsMmomFiles: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmReference: TdtmReference;

implementation

{$R *.DFM}

end.
