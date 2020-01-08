#!/bin/bash

FROM_SOURCE="dropbox:"
FILE_DIRECTORY=/media/disk/files
LOGFILE_PATH=/media/disk

echo -n "folder name: "
read folderName
if [[ -n "$folderName" ]]; then
    SAFE_FOLDERNAME=$(echo $folderName | tr " " _)
    mkdir $FILE_DIRECTORY/$SAFE_FOLDERNAME
    COMMAND="rclone --log-file \"$LOGFILE_PATH/upload-$SAFE_FOLDERNAME.log\" -vv copy \"$FROM_SOURCE/$folderName\" \"$FILE_DIRECTORY/$SAFE_FOLDERNAME\"  -P"
    echo "[Running Command]: $COMMAND
    "
    if [[ -n "$TEST_MODE" ]]; then
        eval $COMMAND
    else
        eval "screen -dmS down-$SAFE_FOLDERNAME $COMMAND"
    fi
fi