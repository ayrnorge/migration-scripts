#!/bin/bash

FOLDER_NAME=/media/disk/

echo "First task at hand, let's mount our drive."

lsblk

echo -n "what is the name of the drive (sdb?): "
read driveName
if [[ -n "$driveName" ]]; then
    echo "Okey then, let's format this thing!"
    mkfs.ext4 -m 0 -F -E lazy_itable_init=0,lazy_journal_init=0,discard "/dev/$driveName"

    echo "Creating the folder to mount!"
    mkdir -p $FOLDER_NAME

    echo "Mounting .."
    sudo mount -o discard,defaults /dev/$driveName $FOLDER_NAME
    sudo chmod a+w $FOLDER_NAME

    sudo mkdir $FOLDER_NAME/files

    echo "WARNING: This drive will not auto mount on reboot. Normally, we don't want to, since the servers should be short-lived."

    export PATH="$PATH:$PWD"
    echo "PATH=\"\$PATH:$PWD\"" >> ~/.bashrc
    
    echo "Installing rclone!";
    curl https://rclone.org/install.sh | sudo bash

    echo "We are ready – now run this: rclone config"
else
    echo "Okey then, I will not do anything then"
fi