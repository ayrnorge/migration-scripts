#!/bin/bash

FROM_SOURCE="google-1:/"
FILE_DIRECTORY=/media/disk/minimeis
LOGFILE_PATH=/media/disk

echo -n "name of this migration: "
read userInput
if [[ -n "$userInput" ]]; then
    
    COMMAND="rclone --log-file \"$LOGFILE_PATH/upload-$userInput.log\" -vv copy $FROM_SOURCE $FILE_DIRECTORY  -P"
    echo "[Running Command]: $COMMAND
    "
    if [[ -n "$TEST_MODE" ]]; then
        eval $COMMAND
    else
        eval "screen -dmS down-$userInput $COMMAND"
    fi
fi