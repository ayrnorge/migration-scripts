#!/bin/bash

screen -dmS migration rclone --log-file /media/disk/download-log.log copy \
    "dropbox-1:/Minimeis delt" \
    /media/disk/minimeis \
    -P