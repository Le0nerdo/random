#!/bin/bash

#MIT License
#
#Copyright (c) 2022 Leo Becker
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.

# CAUTION
# This script erases the content of a drive.
# You can remove all other drives for the time of the installation.

# GUIDE
# This script follows https://wiki.archlinux.org/title/installation_guide .
# There is no quarantee that this script is up to date and you should check it.
# 1. Follow the instructions on the website to boot into the live environment.
# 2. Set your keyboard layout with the command 'laodkeys'
# 3. Make sure that you are in the boot mode by checking that
#    /sys/firmware/efi/efivars has content.
# 4. Make sure that you have internet access by pinging some server.
# 5. download this file (below is a example with curl).
#    curl https://raw.githubusercontent.com/Le0nerdo/random/main/gobosarch.sh --output gobosarch.sh
# 6. Make sure that variables under the following headers are correct.
#    1. DRIVE
#    2. USER
#    3. LOCALIZATION
#    4. DEVICES
#    5. PROGRAMS
# 7. Make the script executeable with 'chmod +x gobosarch.sh'.
# 8. run the script with './gobosarch.sh'.

# 1 DRIVE
# if HOME_SIZE is 0 it uses the rest of the DRIVE
DRIVE_NAME="/dev/nvme0n1"
NVME="1" # 1 for true and 0 for false
BOOT_SIZE="1024M"
SWAP_SIZE="16G"
ROOT_SIZE="35G"
HOME_SIZE="0"

# 2 USER

# 3 LOCALIZATION
KEYBOARD_LAYOUT="fi"

# 4 DEVICES

# 5 PROGRAMS

# AUTOMATICALLY SET VARIABLES
[ "$NVME" == "1" ] && PART1="$DRIVE_NAME"p1 || PART1="$DRIVE_NAME"1
[ "$NVME" == "1" ] && PART2="$DRIVE_NAME"p2 || PART2="$DRIVE_NAME"2
[ "$NVME" == "1" ] && PART3="$DRIVE_NAME"p3 || PART3="$DRIVE_NAME"3
[ "$NVME" == "1" ] && PART4="$DRIVE_NAME"p4 || PART4="$DRIVE_NAME"4

main() {
  timedatectl set-ntp true
	prepare_drive
	install_linux
	basic_configuration
	network_configuration
	user_configuration
	boot_loader_configuration
	gpu_configuration
}

prepare_drive() {
	# Zaps, partitions, formats and mounts the drive.
	echo "Preparing drive..."

	# Zap
	sgdisk -Z /env/"$DRIVE_NAME"

	# Partition
	sgdisk -n 1:0:+"$BOOT_SIZE" -c 1:boot -t 1:ef00 "$DRIVE_NAME"
	sgdisk -n 2:0:+"$SWAP_SIZE" -c 2:boot -t 2:8200 "$DRIVE_NAME"
	sgdisk -n 3:0:+"$ROOT_SIZE" -c 3:boot -t 3:8300 "$DRIVE_NAME"
	sgdisk -n 4:0:+"$HOME_SIZE" -c 4:boot -t 4:8300 "$DRIVE_NAME"

	# Format
	mkfs.fat -F32 "$PART1"
	mkswap "$PART2"
	swapon "$PART2"
	mkfs.ext4 "$PART3"
	mkfs.ext4 "$PART4"

	# Mount
	mount "$PART3" /mnt
	mkdir /mnt/boot
	mkdir /mnt/home
	mount "$PART1" /mnt/boot
	mount "$PART4" /mnt/home

	echo "Completed preparing drive."
}

install_linux() {
	echo "install_linux is not yet implemented."
}

basic_configuration () {
	echo "basic_configuration is not yet implemented."
}

network_configuration () {
	echo "network_configuration is not yet implemented."
}

user_configuration () {
	echo "user_configuration is not yet implemented."
}

boot_loader_configuration () {
	echo "boot_loader_configuration is not yet implemented."
}

gpu_configuration () {
	echo "gpu_configuration is not yet implemented."
}

main
