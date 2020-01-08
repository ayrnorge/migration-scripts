#!/bin/bash

FROM_SOURCE="dropbox:"
FILE_DIRECTORY=/media/disk/files
LOGFILE_PATH=/media/disk

detect() {
  # Return normalized string, all lower and with spaces as separators
  arg=( "${@:-}" )
  helper=""
  for i in '_' '-' ' '; do
    if [[ ${arg[*]} == *$i* ]]; then
      helper="yes"
      echo "${arg[*]}" | tr '[:upper:]' '[:lower:]' | tr -s "${i}" ' '
    fi
  done
  # If '_','-' and ' ' are not used as a separator try by case
  if [[ -z $helper ]] && [[ ${arg[0]} != '' ]]; then
    dif_case "${@:-}" | tr '[:upper:]' '[:lower:]'
  fi
}

replace() {
  # Read from stdin and replace ' ' with $1
  cat | tr -s ' ' "${1}"
}

kebab() {
  detect "${@:-}" | replace '-'
}

echo -n "folder name: "
read folderName
if [[ -n "$folderName" ]]; then
    SAFE_FOLDERNAME=$(kebab $folderName)
    COMMAND="rclone --log-file \"$LOGFILE_PATH/upload-$SAFE_FOLDERNAME.log\" -vv copy \"$FROM_SOURCE/$folderName\" \"$FILE_DIRECTORY/$folderName\"  -P"
    echo "[Running Command]: $COMMAND
    "
    if [[ -n "$TEST_MODE" ]]; then
        eval $COMMAND
    else
        eval "screen -dmS down-$SAFE_FOLDERNAME $COMMAND"
    fi
fi