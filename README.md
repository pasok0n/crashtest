# crashtest
A script to replay all crashes found by [AFLnet](https://github.com/aflnet/aflnet) on an uninstrumented target

HOW TO USE
INPUT = is the result folder from AFLnet
OUTPUT = is the filename for the output
Protocol = is the protocol for the target
Port = port for the target
Target = Target application (e.g. ./dcmtk/build/bin/dcmqrscp)
Target_Options = options for the target application (e.g. in dcmtk "--single-process")
Kill_Signal = Optional kill signal if any (e.g. -s SIGUSR1, -s SIGTERM)


Example for dcmtk:
```console
foo@bar:~$ ./crashtest.sh dcmtk-aflnet/ testcrash DICOM 5158 ./dcmtk-replay/build/bin/dcmqrscp --single-process
```

dcmtk-aflnet is the result folder from the fuzzing process with AFLnet.

You have to check the output yourself if the crashes are real or not.

The output looks for e.g. dcmtk looks like this:
```
==========================================================================================================
dcmtk-aflnet//replayable-crashes/id:000000,sig:06,src:000258+000188,op:splice,rep:2

W: DcmItem: Non-standard VR '� ' (e7\00) encountered while parsing element (0010,0020), assuming 2 byte length field
E: DcmElement: PatientID (0010,0020) larger (128) than remaining bytes in file
timeout: the monitored command dumped core
./crashtest.sh: line 18:   902 Segmentation fault      timeout -k 15 5s $TARGET $TARGET_OPTIONS >> $OUTPUT 2>&1

==========================================================================================================
==========================================================================================================
dcmtk-aflnet//replayable-crashes/id:000001,sig:06,src:000257+000107,op:splice,rep:2

W: Invalid length (35) for maximum length item, must be 4
E: DcmElement: PatientID (0010,0020) larger (256) than remaining bytes in file
timeout: the monitored command dumped core
./crashtest.sh: line 18:   905 Segmentation fault      timeout -k 15 5s $TARGET $TARGET_OPTIONS >> $OUTPUT 2>&1

==========================================================================================================
==========================================================================================================
dcmtk-aflnet//replayable-crashes/id:000002,sig:06,src:000207+000358,op:splice,rep:2

W: DcmItem: Non-standard VR 'C_' (43\5f) encountered while parsing element (0008,0052), assuming 2 byte length field
timeout: the monitored command dumped core
./crashtest.sh: line 18:   908 Segmentation fault      timeout -k 15 5s $TARGET $TARGET_OPTIONS >> $OUTPUT 2>&1

==========================================================================================================
==========================================================================================================
dcmtk-aflnet//replayable-crashes/id:000003,sig:06,src:000397+000275,op:splice,rep:4

E: DcmElement: PatientID (0010,0020) larger (12336) than remaining bytes in file
timeout: the monitored command dumped core
./crashtest.sh: line 18:   911 Segmentation fault      timeout -k 15 5s $TARGET $TARGET_OPTIONS >> $OUTPUT 2>&1

==========================================================================================================
```
