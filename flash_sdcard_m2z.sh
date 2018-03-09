#!/bin/bash

function pt_error()
{
    echo -e "\033[1;31mERROR: $*\033[0m"
}

function pt_warn()
{
    echo -e "\033[1;31mWARN: $*\033[0m"
}

function pt_info()
{
    echo -e "\033[1;32mINFO: $*\033[0m"
}

function pt_ok()
{
    echo -e "\033[1;33mOK: $*\033[0m"
}

mmc="mmcblk"
out="$1"

if [ -z "$out" ]; then
    pt_error "Usage: $0 <SD card> (SD CARD: /dev/sdX  where X is your sd card letter or /dev/mmcblkY  where Y your device number)"
    exit 1
fi

if [ $UID -ne 0 ]
    then
    pt_error "Please run as root."
    exit
fi

if [[ $out == *$mmc* ]]; 
then
part="p"
else
part=""
fi


pt_info "Umounting $out, please wait..."
sync
umount ${out}* >/dev/null 2>&1
sleep 1
sync

set -e

pt_info "Reading partition..."
sudo partprobe
sleep 2
sync
sudo partprobe ${out}
sleep 2

set -e
pt_warn "Flashing $out...."
dd if=./bootloader_m2z.bin conv=notrunc bs=1k seek=8 of=$out

pt_info "Decompressing rootfs to $out$part"2", please wait... (takes some time)"
mkdir -p erootfs
sudo partprobe ${out}
sleep 2
sync
sudo mount $out$part"2" erootfs
tar -xvpzf rootfs_m2z.tar.gz -C ./erootfs --numeric-ow
sync
sudo umount erootfs
rm -fR erootfs
sync
set +e
mkdir eboot
sudo mount $out$part"1" eboot
tar -xvpzf boot_m2z.tar.gz -C ./eboot  --numeric-ow
sync
sudo umount eboot
rm -fR eboot
sync
pt_ok "Finished flashing $out!"
pt_ok "You can remove the SD card and boot the board with this new OS image. Enjoy!"


