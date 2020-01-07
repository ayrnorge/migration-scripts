#!/bin/bash

TO_SOURCE="google-1:/"
FILE_DIRECTORY=/media/disk/minimeis
LOGFILE_PATH=/media/disk

echo -n "name of this migration: "
read userInput
if [[ -n "$userInput" ]]; then
    
    COMMAND="rclone --log-file \"$LOGFILE_PATH/upload-$userInput.log\" -vv copy $FILE_DIRECTORY $TO_SOURCE -P"
    echo "[Running Command]: $COMMAND
    "
    if [[ -n "$TEST_MODE" ]]; then
        eval $COMMAND
    else
        eval "screen -dmS migration-$userInput $COMMAND"
    fi
fi