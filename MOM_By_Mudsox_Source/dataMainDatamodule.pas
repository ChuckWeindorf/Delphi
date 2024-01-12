unit dataMainDatamodule;
{Author: Chuck Weindorf
 Description: The datamodule is a placeholder for the creation of a series of
 SQL tables and datasources for use by one form, tab or report within the

 Date: 08/04/1999 - CEW - New
  }
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, DB;
type
  TdtmMain = class(TDataModule)
    dbsMain: TDatabase;
  private
    { Private declarations }
  public
    { Public declarations }
    qryAddress: Tquery;
    qryAppointment: Tquery;
    qry1500Form: Tquery;
    qryAppt1500Detail: Tquery;
    qryEntity: Tquery;
    qryEntityHousehold: Tquery;
    qryEquipment: Tquery;
    qryFacilityRoom: Tquery;
    qryApptBilling: Tquery;
    qryApptAccount: Tquery;
    qryHouseHold: Tquery;
    qryImmunization: Tquery;
    qryInsurance: Tquery;
    qryMedication: Tquery;
    qryLabwork: Tquery;
    qryOutsideResource: Tquery;
    qryPatient: Tquery;
    qryPatientChronic: Tquery;
    qryPhoneNumber: Tquery;
    qryPicture: Tquery;
    qryProgram: Tquery;
    qryReferral: Tquery;
    qryReminder: Tquery;
    //qryUnScheduled: Tquery;
    //qryScheduleEntity: Tquery;
    qryStaff: Tquery;
    qrySurvey: Tquery;
    qrySurveyAnswer: Tquery;
    qrySurveyRule: Tquery;
    qrySurveyQuestion: Tquery;
    qrySQLquery: Tquery;
    qrySQLexecute: Tquery;
    qrySQLfieldList: Tquery;
    qrySQLpickList: Tquery;
    dtsAddress: TDataSource;
    dtsAppointment: TDataSource;
    dts1500Form: TDataSource;
    dtsAppt1500Detail: TDataSource;
    dtsEntity: TDataSource;
    dtsEntityHousehold: TDataSource;
    dtsEquipment: TDataSource;
    dtsFacilityRoom: TDataSource;
    dtsApptBilling: TDataSource;
    dtsApptAccount: TDataSource;
    dtsHouseHold: TDataSource;
    dtsImmunization: TDataSource;
    dtsInsurance: TDataSource;
    dtsMedication: TDataSource;
    dtsLabwork: TDataSource;
    dtsOutsideResource: TDataSource;
    dtsPatient: TDataSource;
    dtsPatientChronic: TDataSource;
    dtsPhoneNumber: TDataSource;
    dtsPicture: TDataSource;
    dtsProgram: TDataSource;
    dtsReferral: TDataSource;
    dtsReminder: TDataSource;
    dtsUnScheduled: TDataSource;
    dtsScheduleEntity: TDataSource;
    dtsStaff: TDataSource;
    dtsSurvey: TDataSource;
    dtsSurveyAnswer: TDataSource;
    dtsSurveyRule: TDataSource;
    dtsSurveyQuestion: TDataSource;
    dtsSQLquery: TDataSource;
    dtsSQLexecute: TDataSource;
    dtsSQLfieldList: TDataSource;
    dtsSQLpickList: TDataSource;
    vbolTransactionActive: boolean;
  published
  end;
var
  dtmMain: TdtmMain;
implementation
  uses procSharedDatamoduleCalls;
{$R *.DFM}
end.
