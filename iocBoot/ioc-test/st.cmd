#!../../bin/rhel7-x86_64/newtest
# arbitrary change 1

#- You may have to change test to something else
#- everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/test.dbd"
test_registerRecordDeviceDriver pdbbase

## Load record instances
dbLoadRecords("missing_dbfile.db","user=klauer")

cd "${TOP}/iocBoot/${IOC}"
dbLoadRecords("test.db","user=klauer")

iocInit

## Start any sequence programs
#seq sncxxx,"user=klauer"
