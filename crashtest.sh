#!/bin/bash

if [ $# -eq 0 ]; then
    echo "HOW TO USE"
    echo "INPUT = is the result folder from AFLnet"
    echo "OUTPUT = is the filename for the output"
    echo "Protocol = is the protocol for the target"
    echo "Port = port for the target"
    echo "Target = Target application (e.g. ./dcmtk/build/bin/dcmqrscp)"
    echo "Target_Options = options for the target application (e.g. in dcmtk "--single-process")"
    exit 0
fi

export INPUT=$1
export OUTPUT=$2
export PROTOCOL=$3
export PORT=$4
export TARGET=$5
export TARGET_OPTIONS=$6

# HOW TO USE
# INPUT = is the result folder from AFLnet
# OUTPUT = is the filename for the output
# Protocol = is the protocol for the target
# Port = port for the target
# Target = Target application (e.g. ./dcmtk/build/bin/dcmqrscp)
# Target_Options = options for the target application (e.g. in dcmtk "--single-process")

for f in $(echo $INPUT/replayable-crashes/id:*); do
    echo "=========================================================================================================="
    echo "$f"
    echo ""

    aflnet-replay $f $PROTOCOL $PORT 10 100 > /dev/null 2>&1 &
    timeout -k 15 5s $TARGET $TARGET_OPTIONS >> $OUTPUT 2>&1

    echo ""
    echo "=========================================================================================================="
    wait
done >> $OUTPUT 2>&1