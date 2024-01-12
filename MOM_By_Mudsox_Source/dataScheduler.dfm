object dtmScheduler: TdtmScheduler
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 248
  Top = 107
  Height = 596
  Width = 722
  object tblEntity: TTable
    DatabaseName = 'dbsScheduler'
    ReadOnly = True
    TableName = 'Entity'
    Left = 24
    Top = 24
  end
  object tblPatient: TTable
    DatabaseName = 'dbsScheduler'
    ReadOnly = True
    TableName = 'Patient'
    Left = 24
    Top = 72
  end
  object tblHousehold: TTable
    DatabaseName = 'dbsScheduler'
    ReadOnly = True
    TableName = 'Household'
    Left = 24
    Top = 120
  end
  object tblAppointmentTicket: TTable
    DatabaseName = 'dbsScheduler'
    TableName = 'Appointment'
    Left = 224
    Top = 152
  end
  object dtsEntity: TDataSource
    AutoEdit = False
    DataSet = tblEntity
    Left = 88
    Top = 24
  end
  object dtsPatient: TDataSource
    AutoEdit = False
    DataSet = tblPatient
    Left = 88
    Top = 72
  end
  object tblScheduleEntity: TTable
    DatabaseName = 'dbsScheduler'
    TableName = 'ScheduleEntity'
    Left = 224
    Top = 72
  end
  object dtsAppointment: TDataSource
    AutoEdit = False
    DataSet = tblAppointment
    Left = 304
    Top = 24
  end
  object qryUnscheduled: TQuery
    Tag = 33
    DatabaseName = 'dbsScheduler'
    RequestLive = True
    SQL.Strings = (
      'Select ApptTicket, ApptScheduled, ApptSchedulePend, '
      
        '           Entity,ApptComplaint, ApptComplaintText, ApptDateTime' +
        ', ApptDuration'
      '   from Appointment'
      '   Where ApptSchedulePend = true')
    Left = 64
    Top = 216
  end
  object qryEntity: TQuery
    DatabaseName = 'dbsScheduler'
    SQL.Strings = (
      'Select Entity, EntityDescription From Entity'
      '(replace)')
    UniDirectional = True
    Left = 160
    Top = 216
  end
  object dbsScheduler: TDatabase
    AliasName = 'mmom_maindatabase'
    Connected = True
    DatabaseName = 'dbsScheduler'
    SessionName = 'Default'
    TransIsolation = tiDirtyRead
    Left = 152
    Top = 8
  end
  object dtsSearchEntity: TDataSource
    AutoEdit = False
    DataSet = qryEntity
    Left = 232
    Top = 216
  end
  object tblAppointment: TTable
    DatabaseName = 'dbsScheduler'
    TableName = 'Appointment'
    Left = 224
    Top = 24
  end
  object tblApptYear: TTable
    DatabaseName = 'dbsScheduler'
    IndexName = 'Entity'
    ReadOnly = True
    TableName = 'Appointment.DB'
    Left = 160
    Top = 288
  end
end
