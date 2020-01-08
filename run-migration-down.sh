#!/bin/bash

FROM_SOURCE="dropbox:"
FILE_DIRECTORY=/media/disk/files
LOGFILE_PATH=/media/disk

echo -n "folder name: "
read folderName
if [[ -n "$folderName" ]]; then
    SAFE_FOLDERNAME=$(echo $folderName | tr " " _)
    COMMAND="rclone --log-file \"$LOGFILE_PATH/upload-$SAFE_FOLDERNAME.log\" -vv copy \"$FROM_SOURCE/$folderName\" \"$FILE_DIRECTORY/$folderName\"  -P"
    echo "[Running Command]: $COMMAND
    "
    if [[ -n "$TEST_MODE" ]]; then
        eval $COMMAND
    else
        eval "screen -dmS down-$SAFE_FOLDERNAME $COMMAND"
    fi
fi