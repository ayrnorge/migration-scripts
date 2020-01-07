#!/bin/bash

TO_SOURCE="google-1:/"
FILE_DIRECTORY=/media/disk/minimeis


echo -n "name of this migration: "
read userInput
if [[ -n "$userInput" ]]; then
    LOG_FILE=/media/disk/upload-$userInput.log
    screen -dmS migration-up rclone --log-file $LOGFILE copy \
        $FILE_DIRECTORY \
        $TO_SOURCE \
        -P
fi