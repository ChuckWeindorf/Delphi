unit prmDatamoduleManager;
{
Created By:
  Charles Weindorf
  Techcellence
  Email: mudsox@erie.net
  "Specializing in creating, improving and maintaining Delphi applications"

Based on the identity of the calling form, create a datamodule that matches the
needed datasources of the form.}

interface

uses SysUtils, forms, dbtables, db, DBCtrls, dbgrids,
     {The Blank Datamodule Unit} Datamodule;

{At Customr, Financial and Order form creation, build the dynamic datamodule}
procedure SetUpDatamodule(const vfrmForm: Tform;
                            var vdtmDynamicDatamod: TdtmDynamicDatamod;
                          const vintCustomer: integer);

implementation

var vintDatamoduleCount: integer;

{Use the tag number of the form to determine which components to add to the
datamodule.  The customer number is used to direct the table to the correct
locations}
procedure SetUpDatamodule(const vfrmForm: Tform;
                            var vdtmDynamicDatamod: TdtmDynamicDatamod;
                          const vintCustomer: integer);
  var vintLoop2: integer;
       {---- Create one query and its datasource ----}
       {This is called many times from within the main SetUpDatamodule routine.
       The query and datasource receive needed configuration before being used.
       The tags on the component array of the form allow us to attach the
       dbcomponent to the datasource.}
       procedure CreateDataSetPair(vqryCreate: tquery;
                                   vdtsCreate: tdatasource;
                                   vstrSQL: string;
                                   vintTag: integer);
          var vintLoop: integer;
          begin
          {Create the query component in the dynamic datamodule}
          vqryCreate.databasename := vdtmDynamicDatamod.datMain.databasename;
          vqryCreate.SQL.text := vstrSQL;
          vqryCreate.active := true;
          {Create the matching datasource for the query}
          vdtsCreate.dataset := vqryCreate;
          {Loop through the TAG fields in the form to build the link to the
           dynamic datamodule's new datasource}
          For vintLoop := 0 to vfrmForm.ComponentCount - 1 do
            {Only go on if the tag on the component matches the current tag for
            the datasource}
            If vfrmForm.Components[vintLoop].tag = vintTag then
               {Check for the Dbedit component}
               If vfrmForm.Components[vintLoop] is tdbEdit then
                {Bingo - assign the datasource!}
                 tdbedit(vfrmForm.Components[vintLoop]).datasource := vdtsCreate
               else
               {Check for the dbGrid component}
               If vfrmForm.Components[vintLoop] is tdbGrid then
                {Bingo - assign the datasource!}
                tdbgrid(vfrmForm.Components[vintLoop]).datasource := vdtsCreate;
          end;
  {---------------The main routine for SetUpDatamodule----------------}
  begin
  {All datamodules have an instance of tdatabase}
  vdtmDynamicDatamod.datMain:= tdatabase.create(vdtmDynamicDatamod);
  {  ....  Place any database properties here  ...}
  {The alias and the compoment name of the database}
  vdtmDynamicDatamod.datMain.aliasname := 'DD_Test';
  vdtmDynamicDatamod.datMain.name := 'datDatabase';
  inc(vintDatamoduleCount);
  {Multiple datamodules in the same aapplication will need unique
  database names to be distinguished from each other with the BDE.  Use a
  counter to modify the name slightly for each new dynamic datamodule instance}
  vdtmDynamicDatamod.datMain.databasename := 'Database'
                                            + inttostr(vintDatamoduleCount);

  {All queries and their datasources are generated based on the value in the
  TAG fields in the form visual components}
  For vintLoop2 := 0 to vfrmForm.ComponentCount - 1 do
     {If the tag on the visual component is 101, create the Customer query}
     If (vfrmForm.Components[vintLoop2].tag = 101) and
        {Only create this component if we have not done so before.}
        (vdtmDynamicDatamod.qryCustomer = nil) then
        begin
        {Create query and datasource}
        vdtmDynamicDatamod.qryCustomer:= Tquery.Create(vdtmDynamicDatamod);
        vdtmDynamicDatamod.dtsCustomer:= Tdatasource.Create(vdtmDynamicDatamod);
        {Assign query and datasource properties and link the form fields to the
        datasource. Note the variable customer number in the SQL statement}
        CreateDataSetPair(vdtmDynamicDatamod.qryCustomer,
                          vdtmDynamicDatamod.dtsCustomer,
                          'Select * from DD_Customer where CustomerNumber = '
                            + inttostr(vintCustomer),
                          101);
        end
     else
     {If the tag on the visual component is 102, create the address query}
     If (vfrmForm.Components[vintLoop2].tag = 102) and
        {Only create this component if we have not done so before.}
        (vdtmDynamicDatamod.qryAddress = nil) then
        begin
        {Create query and datasource}
        vdtmDynamicDatamod.qryAddress:= Tquery.Create(vdtmDynamicDatamod);
        vdtmDynamicDatamod.dtsAddress:= Tdatasource.Create(vdtmDynamicDatamod);
        {Assign query and datasource properties and link the form fields to the
        datasource. Note the variable customer number in the SQL statement}
        CreateDataSetPair(vdtmDynamicDatamod.qryAddress,
                          vdtmDynamicDatamod.dtsAddress,
                          'Select * from DD_Address where CustomerNumber = '
                            + inttostr(vintCustomer),
                          102);
        end
     else
     {If the tag on the visual component is 103, create the Financial query}
     If (vfrmForm.Components[vintLoop2].tag = 103) and
        {Only create this component if we have not done so before.}
        (vdtmDynamicDatamod.qryFinancial = nil) then
       begin
        {Create query and datasource}
        vdtmDynamicDatamod.qryFinancial:= Tquery.Create(vdtmDynamicDatamod);
        vdtmDynamicDatamod.dtsFinancial:=
                                         Tdatasource.Create(vdtmDynamicDatamod);
        {Assign query and datasource properties and link the form fields to the
        datasource. Note the variable customer number in the SQL statement}
        CreateDataSetPair(vdtmDynamicDatamod.qryFinancial,
                          vdtmDynamicDatamod.dtsFinancial,
                          'Select * from DD_Financial where CustomerNumber = '
                            + inttostr(vintCustomer),
                          103);
        end
     else
     {If the tag on the visual component is 104, create the Order query}
     If (vfrmForm.Components[vintLoop2].tag = 104) and
        {Only create this component if we have not done so before.}
        (vdtmDynamicDatamod.qryOrder = nil) then
       begin
        {Create query and datasource}
        vdtmDynamicDatamod.qryOrder:= Tquery.Create(vdtmDynamicDatamod);
        vdtmDynamicDatamod.dtsOrder:= Tdatasource.Create(vdtmDynamicDatamod);
        {Assign query and datasource properties and link the form fields to the
        datasource. Note the variable customer number in the SQL statement}
        CreateDataSetPair(vdtmDynamicDatamod.qryOrder,
                          vdtmDynamicDatamod.dtsOrder,
                          'Select * from DD_Order where CustomerNumber = '
                            + inttostr(vintCustomer),
                          104);
        end;
  end;
end.
