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
    pt_error "Usage: $0 <SD card> (SD CARD: /dev/sdX  or /dev/mmcblkX where X is your sd card number)"
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
pt_info "Formating sd card $out ..."

part_position=24576   # KiB
boot_size=100          # MiB
# Create beginning of disk
pt_info "Zeroing mbr on $out ..."
dd if=/dev/zero bs=1M count=$((part_position/1024)) of="$out"
sync

pt_info "Creating partition on $out ..."
# Add partition table
cat <<EOF | fdisk "$out"
o
n
p
1
$((part_position*2))
+${boot_size}M
t
83
n
p
2
$((part_position*2 + boot_size*1024*2))

t
2
83
w
EOF

sleep 1
sync
partprobe -s ${out}
sync

pt_warn "Formating $out ..."
# Create boot file system (VFAT)
dd if=/dev/zero bs=1M count=${boot_size} of=${out}${part}1
mkfs.ext4 -F -b 4096 -E stride=2,stripe-width=1024 -L boot ${out}${part}1

# Create ext4 file system for rootfs
mkfs.ext4 -F -b 4096 -E stride=2,stripe-width=1024 -L rootfs ${out}${part}2
sync
#sudo tune2fs -O ^has_journal ${out}${part}2
#sync

pt_ok "Done - Geometry created and sd card '$out' formatted, now flash the image with ./flash_sd_ng.sh"

