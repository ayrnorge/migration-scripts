#!/bin/bash

screen -dmS migration rclone copy "dropbox-1:/Minimeis delt" /media/disk/minimeis -P --log-file /media/disk/upload-log.log