#!../../bin/rhel7-x86_64/newtest
#- You may have to change test to something else
#- everywhere it appears in this file

< envPaths

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

iocInit

cd $(TOP)
dbl

## Start any sequence programs
#seq sncxxx,"user=klauer"
