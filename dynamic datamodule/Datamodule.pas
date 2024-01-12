unit Datamodule;
{
Created By:
  Charles Weindorf
  Techcellence
  Email: mudsox@erie.net
  "Specializing in creating, improving and maintaining Delphi applications"

As you can see, this datamodule is all but empty.  The code that takes action
to create the queries, datasources and manipulate data are in
prmDatamoduleManager and prmBusinessCode.
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db;

type
  TdtmDynamicDatamod = class(TDataModule)
  private
    { Private declarations }
  public
    { These public declarations are actually created within the
    pmDatamoduleManager.  Only the ones used by the matching form will be
    created for the instance.}
    datMain: tDatabase;
    qryCustomer: tQuery;
    qryFinancial: tQuery;
    qryAddress: tQuery;
    qryOrder: tQuery;
    dtsCustomer: tDatasource;
    dtsFinancial: tDatasource;
    dtsAddress: tDatasource;
    dtsOrder: tDatasource;
  end;

var
  dtmDynamicDatamod: TdtmDynamicDatamod;

implementation

{$R *.DFM}

end.
