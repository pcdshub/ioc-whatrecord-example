#!../../bin/rhel7-x86_64/test
# Note: This isn't really intended to be a functional IOC.
# It's merely for showing off some of whatrecord's inspection utilities
# and the frontend.

< envPaths

epicsEnvSet( "ENGINEER", "Engineer" )
epicsEnvSet( "LOCATION", "Location" )
epicsEnvSet( "IOCSH_PS1", "ioc-useless-test> " )

# Some configuration for this example:
epicsEnvSet "STREAM_PROTOCOL_PATH", "."

## Register all support components
dbLoadDatabase "../../dbd/test.dbd"
test_registerRecordDeviceDriver pdbbase

asSetFilename("example.acf")

## Load record instances
dbLoadRecords("missing_dbfile.db","user=klauer")
dbLoadRecords("test.db","P=IOC:TEST:,user=klauer")

# Access control example:
dbLoadRecords("acf.db","P=IOC:ACF:,user=klauer")

# StreamDevice example:
drvAsynIPPortConfigure("terminal", "localhost:40000")
dbLoadRecords("stream.db","P=IOC:STREAM:")

# Motors + dbLoadTemplate
pmacAsynIPConfigure("PMAC_S1", "8.6.7.5:309")
pmacAsynMotorCreate("PMAC_S1", 0, 0, 8)
drvAsynMotorConfigure("PMAC1", "pmacAsynMotor", 0, 9)
dbLoadRecords("asyn.db","P=IOC:MOTOR:")
dbLoadTemplate "motor.substitutions"

# Non-functional autosave
set_savefile_path("", "autosave")
set_pass0_restoreFile("info_positions.sav")
set_pass0_restoreFile("info_settings.sav")
set_pass1_restoreFile("info_settings.sav")
iocInit

cd $(TOP)
dbl

## Start any sequence programs
#seq sncxxx,"user=klauer"
