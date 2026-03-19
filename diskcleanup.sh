#!/bin/bash

# Script to clean up the system

echo "Script started at $(date)"
# Show current free space
echo "-------------------------------------------------------------"
df -h -t ext4
echo "-------------------------------------------------------------"

# Step 1: Remove packages that are no longer needed
echo "Removing packages that are no longer needed..."
sudo apt-get autoremove -y --purge
echo "Done."
echo ""

# Step 2: Clean the apt cache
echo "Cleaning the apt cache..."
size=$(sudo du -sh /var/cache/apt | awk '{print $1}')
echo "Cache size before clean = $size"
sudo apt-get clean
size=$(sudo du -sh /var/cache/apt | awk '{print $1}')
echo "Cache size after clean = $size"
echo "Done."
echo ""

# Step 3: Clear systemd journal logs except for the last week
echo "Clearing systemd journal logs except for the last week..."
journalctl --disk-usage
sudo journalctl --vacuum-time=1weeks
journalctl --disk-usage
echo "Done."
echo ""

# Uncomment this section if running Ubuntu with snap
# Step 4: Run cleansnap script
#echo "Running script to clean snap packages..."
#size=$(sudo du -sh /var/lib/snapd/snaps /var/lib/snapd/snaps/partial)
#size_snaps=$(echo "$size" | grep "/var/lib/snapd/snaps$" | awk '{print $1}')
#size_partial=$(echo "$size" | grep "/var/lib/snapd/snaps/partial$" | awk '{print $1}')
#echo "Snap package size before clean = $size_snaps"
#if [ -n "$size_partial" ]; then
#	echo "Partial snap package size before clean = $size_partial"
#fi
#sudo /home/dondre/script/cleansnap.sh
#size=$(sudo du -sh /var/lib/snapd/snaps /var/lib/snapd/snaps/partial)
#size_snaps=$(echo "$size" | grep "/var/lib/snapd/snaps$" | awk '{print $1}')
#size_partial=$(echo "$size" | grep "/var/lib/snapd/snaps/partial$" | awk '{print $1}')
#echo "Snap package size after clean = $size_snaps"
#if [ -n "$size_partial" ]; then
#	echo "Partial snap package size after clean = $size_partial"
#fi
#echo ""

# Uncomment below to remove old linux headers
# Step 5: Clean up old Linux headers
#echo "Clean old linux headers"
#echo "Current linux kernel version is:"
#echo "*******************"
#uname -r
#echo "*******************"
#echo "Old versions are:"
#dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d'

#read -p "ONLY CONTINUE IF THE CURRENT VERSION IS NOT LISTED!!! Continue?(y/n)" cont
#case "$cont" in 
#	y) 
#		dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge
#		;;
#	*)
#		echo "skipped"
#		;;
#esac
echo""

# show free space again
echo "Script ended at $(date)"
echo "-------------------------------------------------------------"
df -h -t ext4
echo "-------------------------------------------------------------"
echo "Done."

