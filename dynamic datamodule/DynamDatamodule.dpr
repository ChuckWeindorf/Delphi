program DynamDatamodule;
{
Created By:
  Charles Weindorf
  Techcellence
  Email: mudsox@erie.net
  "Specializing in creating, improving and maintaining Delphi applications"

NOTE: This source code may be used by anyone - consider it open source with no
      copyright.  I would appreciate any comments on the usefullness of this
      technique.  I will respond to questions as time permits - As I'm sure you
      understand, my paying clients come first.

      If you have a system that you would like to have converted to this
      technique please contact me to find out how our programming team can help.

Chuck's Dynamic Datmodule Example

The datamodule was a great addition to the Delphi 32 bit environment because it
allowed us to centralize databases, queries and datasources in a non-visual
form that could be shared by many visible forms.  The components and business
code would only need to appear one time - within this datamodule and not appear
on each form.

There are two drawbacks to this approach:
1. Since all components can be in one datamodule, each form has access to all
tables and business code.  However, each form in your system should only need
access to certain tables.  For each form that is created, there is some excess
datamodule code that will be created as well.
2. If you create multiple instances of forms, you may need to create an instance
of the datamodule to point at diffecent records.  Not only does each form have
wasted code in the datamodule, the business code is duplicated for each instance
of the datamodule.

This is one method of creating a dynamic datamodule without wasted or duplicated
components and business code:
1. A main form controls the creation of the detailed forms in the system
2. On creation of each instance of a form, a tailored datamodule that matches
   the needs of the form is created.
3. There are no components or source code within the datamodule!
4. A procedure unit sets up the components within the blank datamodule based on
   the form's requirements.
5. Any business code is in a procedure unit and acts only on the instance of
   the datamodule that is attached to the form.

Forms:
   frmMainMenu - The top form of the example that allows the user to select the
      information within the database.
   frmCustomer - The detail form for customer information.
   frmFinancial - The detail form for financial info related to Customer.
   frmOrder - The detail from each customer order.

Datamodule:
    dtmDynamicDatamodule - The blank datamodule that holds the dynamically-
       created components.

Procedure modules:
   prmDatamoduleManager - Contains the code to determine the required components
      for a datamodule instance.
   prmBusinessCode - Contains the business code to act on the data within the
      individual tables.

Tables:
   (101 in TAG field) DD_Entity - Master search index for customer
   (102 in TAG field) DD_Address - Addresses for customers
   (103 in TAG field) DD_Financial - Customer financial information
   (104 in TAG field) DD_Order - Orders for customer
   (105 in TAG field) DD_Items - Items within each order
}
uses
  Forms,
  bde,
  dbtables,
  MainMenu in 'MainMenu.pas' {frmMainMenu},
  Customer in 'Customer.pas' {frmCustomer},
  Datamodule in 'Datamodule.pas' {dtmDynamicDatamod: TDataModule},
  prmDatamoduleManager in 'prmDatamoduleManager.pas',
  prmBusinessCode in 'prmBusinessCode.pas',
  Financial in 'Financial.pas' {frmFinancial},
  Order in 'Order.pas' {frmOrder};

{$R *.RES}

begin
  Application.Initialize;
  bde.DbiInit(nil);
  {Assign the Alias to be used by all instances of the Dynamic Datamoule}
  Session.ConfigMode := cmSession;
  Session.AddStandardAlias('DD_Test',
          '.',
          'PARADOX');
  Session.ConfigMode := cmAll;
  {Create and show the main form that will control the creation of additional
  forms}
  Application.CreateForm(TfrmMainMenu, frmMainMenu);
  Application.Run;
end.
