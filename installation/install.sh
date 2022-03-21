#!/bin/sh

export target_device="/dev/sda"
export target_mount_point="/mnt"
export hostname="leninovo"
export root_part_size="80G"
export swap_part_size="8G"
export home_part_size=""
export zoneinfo_region="Europe"
export zoneinfo_city="Prague"

part_disk() {
	sfdisk -q --force --delete "$target_device"
	[ -b "$target_device" ] && printf ",300M,0c,*\n,%s,S,\n,%s,L,\n,%s,H," "$swap_part_size" "$root_part_size" "$home_part_size" | sfdisk -q --label dos "$target_device"
}

format_disk() {
	mkfs.fat -F32 "${target_device}1"    
	mkswap "${target_device}2"    
	swapon "${target_device}2"    
	mkfs.ext4 -F "${target_device}3"    
	mkfs.ext4 -F "${target_device}4"
}

mount_disk() {
	mount "${target_device}3" "$target_mount_point"
	mkdir "${target_mount_point}/boot"
	mkdir "${target_mount_point}/home"
	mount "${target_device}1" "${target_mount_point}/boot"
	mount "${target_device}4" "${target_mount_point}/home"
}

setup_disk() {
	part_disk
	format_disk
	mount_disk
}

install_system() {
	basestrap "$target_mount_point" base base-devel linux linux-firmware openrc elogind-openrc vim networkmanager networkmanager-openrc grub
	fstabgen -U /mnt >> "${target_mount_point}/etc/fstab"
}


postinstall_clean() {
	umount -R "$target_mount_point"
}

setup_disk
install_system
artix-chroot "$target_mount_point" bash << '_exit'

config_time() {
	ln -sf "/usr/share/zoneinfo/${zoneinfo_region}/${zoneinfo_city}" /etc/localtime
	hwclock --systohc    
}

config_lang() {
	echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen    
	echo "en_US ISO-8859-1" >> /etc/locale.gen
	locale-gen    
	echo "LANG=en_US.UTF-8" > /etc/locale.conf    
}

config_host() {
	echo "$hostname" > /etc/hostname    
	printf "127.0.0.1\tlocalhost" >> /etc/hosts
	printf "::1\t\tlocalhost" >> /etc/hosts
	printf "127.0.0.1\t${hostname}.localdomain $hostname" >> /etc/hosts
}

setup_bootloader() {
	grub-install --target=i386-pc "$target_device"
	grub-mkconfig -o /boot/grub/grub.cfg
}

config_system() {
	config_time
	config_lang
	rc-update add NetworkManager    
	config_host
	setup_bootloader
}

set_root_pw() {
	echo "Set password fot root..."
	passwd
}

config_system
set_root_pw
_exit
postinstall_clean

exit 0
