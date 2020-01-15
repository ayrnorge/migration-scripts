#!/bin/bash

FILE_DIRECTORY=$1
LOGFILE_PATH=/var/root/tools/logs

if [[ -d "$FILE_DIRECTORY" ]]; then
    echo -n "config name: "
    read configName
    if [[ -n "$configName" ]]; then
        COMMAND="rclone --log-file \"$LOGFILE_PATH/download-$SAFE_FOLDERNAME.log\" -vv copy \"$FILE_DIRECTORY\" \"$configName\"  -P"
        echo "[Running Command]: $COMMAND
        "
        if [[ -n "$TEST_MODE" ]]; then
            eval $COMMAND
        else
            eval "screen -dmS up-$SAFE_FOLDERNAME $COMMAND"
        fi
    fi
fi