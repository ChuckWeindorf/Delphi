unit procInstallDatabase;

{Author: Chuck Weindorf
 Description: During the installation process, this unit reads MMomFiles and
 MMomFields to create SQL statements.  All read/write tables in the Mmom are
 created not installed

 Date: 08/04/1999 - CEW - New

  }
interface
{Routines called by other units and forms}
Procedure CreateAllReadWriteFiles;

implementation

{Include the reference datamodule that hold the file definition tables of
MmomFiles and MmomFields}
uses dataReference, dbtables, Sysutils, classes;

{Create all of the tables in the MMomMainDatabase.  The files defined here are
not downloaded as part of the installation CD, they are created directly
through SQL.  All indexes and Alternate indexes are included here as well.}
Procedure CreateAllReadWriteFiles;
  {The SQL component that will do all of the table creation}
  var qryCreate: tQuery;
      vintLoop: integer;
      vstlIndexes: tstringlist;

begin
  {Initialize the temporary SQL component for table creation.}
vstlIndexes := tstringlist.create;
qryCreate:= tquery.Create(nil);
  {Protect the creation block to FINALLY free the qryCreate}

Try
  {All use the table in dtmRefernece}
 With dtmReference do
  begin
    {Start from the top of the file list}
  qryMmomFiles.first;
    {Continue to loop through all available files}
  while not qryMmomFiles.eof do
     begin
    {Make sure the temporary query has the  Alias location for the
     Main Database}
     qryCreate.Databasename := qryMMomFiles.fieldbyname
                                                     ('AliasLocation').asstring;
{I NEED TO GET THE PATH FROM THE SESSION FOR THIS ALIAS.....}
     qryCreate.Databasename := 'c:\mmom\maindatabase';
     qryCreate.SQl.Clear;
       {If the table already exists, remove the table before creating the
        new one}
{I NEED TO GET THE PATH FROM THE SESSION FOR THIS ALIAS.....}
     If FileExists('c:\mmom\maindatabase\' +
         qryMMomFiles.fieldbyname('FileName').asstring + '.db') then
            begin
              {Drop Table is the SQL command to eliminate the table and all
               index definitions from disk}
            qryCreate.SQL.Add('Drop Table '
                           + qryMMomFiles.fieldbyname('FileName').asstring);
            qryCreate.ExecSQL;
               {Clean up the SQL stringlist for the next command}
            qryCreate.SQL.Clear;
            end;
     {Start the first portion of the SQL statment to create the new table}
     qryCreate.SQL.Add('Create Table "' +
                      qryMMomFiles.fieldbyname('FileName').asstring + '.db" (');
     {Loop through all fields as listed in the cascaded link in the Fields
      table.  datReference handles this cascade in the datasource parameters.}
     qryMMomFields.First;
     While not qryMMomFields.eof do
        begin
        {Add the field name and type for all fields}
        qryCreate.SQL.Add(qryMMomFields.fieldbyname('FieldName').asstring + ' '
                        + qryMMomFields.fieldbyname('FieldType').asstring);
        {Char field types require a length in Paradox to finist the Axx type
         and length combination}
        If qryMMomFields.fieldbyname('FieldType').asstring = 'Char' then
            {Add the length to the Char literal}
            qryCreate.SQL[qryCreate.SQL.count - 1] :=
             qryCreate.SQL[qryCreate.SQL.count - 1] + '('
             + qryMMomFields.fieldbyname('FieldLength').asstring + ')';
        {Add a comma to the previous line in the SQL stringlist}
        qryCreate.SQL[qryCreate.SQL.count - 1] :=
             qryCreate.SQL[qryCreate.SQL.count - 1] + ',';
        {Continue with the next field definition in the SQL stringlist}
        qryMMomFields.next;
        end;
     {Add all Primary and Alternate Index definitions as the last portion
      for the table definition in SQL}
     qryCreate.SQL.Add(qryMmomFiles.Fieldbyname('PrimaryIndex').asstring);
     qryCreate.SQL.Add(')');
     try
     qryCreate.ExecSQL;
       except {VERY IMPORTANT ERROR HANDLER REQUIRED HERE}
       end;
     {Execute the SQL to create the alternate indexes}
     If length(qryMmomFiles.Fieldbyname('IndexDescription').asstring) > 0 then
       begin
       vstlIndexes.text := qryMmomFiles['IndexDescription'];
       For vintLoop := 0 to vstlIndexes.count -1 do
           begin
           qryCreate.SQL.clear;
           qryCreate.SQL.Add(vstlIndexes[vintLoop]);
           try
           qryCreate.ExecSQL;
             except {VERY IMPORTANT ERROR HANDLER REQUIRED HERE}
             end;
           end;
       end;
     {Get the next available table in the list}
     qryMMomFiles.next;
     end;
  end;
{When the File and Fields loops complete, free the temporary query component}
Finally
  vstlIndexes.free;
  qryCreate.Free;
  end;
end;

end.
