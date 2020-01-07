#!/bin/bash

FROM_SOURCE="dropbox-1:/Minimeis delt"
FILE_DIRECTORY=/media/disk/minimeis


echo -n "name of this migration: "
read userInput
if [[ -n "$userInput" ]]
    LOG_FILE=/media/disk/upload-$userInput.log
    screen -dmS migration-up rclone copy \
        $FROM_SOURCE \
        $FILE_DIRECTORY \
        -P --log-file $LOGFILE
fi