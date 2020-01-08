#!/bin/bash
FILE_DIRECTORY=$1
LOGFILE_PATH=/media/disk

if [ -f "$FILE_DIRECTORY" ]; then
    echo -n "config name: "
    read userInput
    if [[ -n "$userInput" ]]; then
        
        COMMAND="rclone --log-file \"$LOGFILE_PATH/upload-$userInput.log\" -vv copy $FILE_DIRECTORY $userInput:/ -P"
        echo "[Running Command]: $COMMAND
        "
        if [[ -n "$TEST_MODE" ]]; then
            eval $COMMAND
        else
            eval "screen -dmS up-$userInput $COMMAND"
        fi
    fi
else
    echo "Folder not found! eg: run-migration-up fish"
fi