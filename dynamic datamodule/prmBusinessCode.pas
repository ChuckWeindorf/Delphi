unit prmBusinessCode;
{
Created By:
  Charles Weindorf
  Techcellence
  Email: mudsox@erie.net
  "Specializing in creating, improving and maintaining Delphi applications"

This unit contains business code that could take action on any instance of the
a datamodule or the components of a form.}
interface
 uses dbtables, db, dbgrids, Graphics;

{Shared logic for all instances of the customer screen}
Procedure LocateCorrectAddress(var vqryAddress: Tquery;
                               const cstrType: string);

{Shared logic for all instances of the financial screen}
Procedure HighLightBank(var vcolCurrent: TColumn;
                        const cintColumn: integer);

{Shared logic for all instances of the order screen}
Procedure FindRightBank(var vqryOrder, vqryFinancial: tQuery);

implementation

Procedure LocateCorrectAddress(var vqryAddress: Tquery;
                               const cstrType: string);
 begin
 {Put business code in at this level to find the correct verison of the address}
 vqryAddress.Locate('CustomerNumber;AddressType',
                    VarArrayOf([vqryAddress['CustomerNumber'], cstrType]),
                    []);
 {Add all sorts of business logic in this unit to keep from having the code
 appear in every instance of the calling form.}
 end;

{Highlight certain bank values to make them stand out}
Procedure HighLightBank(var vcolCurrent: TColumn;
                        const cintColumn: integer);
  begin
  If cintColumn = 2 then
    If pos('Big', vcolCurrent.Field.asstring) > 0 then
       vcolCurrent.Color := clAqua
    else
    If pos('Com', vcolCurrent.Field.asstring) > 0 then
       vcolCurrent.Color := clRed;
 {Add all sorts of business logic in this unit to keep from having the code
 appear in every instance of the calling form.}
  end;

Procedure FindRightBank(var vqryOrder, vqryFinancial: tQuery);
 begin
 {Put business code in at this level to find the correct bank for the credit
 card on the current order record}
 vqryFinancial.Locate('CustomerNumber;CreditCard',
                    VarArrayOf([vqryOrder['CustomerNumber'],
                                vqryOrder['CreditCard']]),
                    []);
 {Add all sorts of business logic in this unit to keep from having the code
 appear in every instance of the calling form.}
 end;

end.
