#!/bin/bash

FROM_CONFIG=$1
TO_CONFIG=$2
LOGFILE_PATH=$PWD/logs

if [[ ! -d "$LOGFILE_PATH" ]]; then
    mkdir $LOGFILE_PATH
fi


if [ -n "$FROM_CONFIG" ] || [ -n "$TO_CONFIG" ]; then
    SAFE_LOGFILENAME=$(echo $FROM_CONFIG-$TO_CONFIG | tr " " _  | tr ":" _  | tr "/" _)
    COMMAND="rclone --log-file \"$LOGFILE_PATH/disk-to-disk-$SAFE_LOGFILENAME.log\" -vv copy \"$FROM_CONFIG\" \"$TO_CONFIG\" -P --drive-skip-gdocs"
    echo "[Running Command]: $COMMAND
    "
    if [[ -n "$TEST_MODE" ]]; then
        eval $COMMAND
    else
        eval "screen -dmS up-$SAFE_FOLDERNAME $COMMAND"
    fi
else
    echo "Missing config: ./migrate-from-disk-to-disk <from-config> <to-config>"
fi