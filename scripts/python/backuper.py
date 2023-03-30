#!/usr/bin/env python3
from subprocess import run
def runs(a):
    run(a,shell=True)

runs("sudo umount ~/mnt-home")
runs("sudo umount ~/manjaro-home")
runs("sudo umount /mnt")

runs("sudo cryptsetup open /dev/disk/by-uuid/9b6717bc-7042-4e58-93ca-9595ea954faf BACKUP")
runs("sudo mount -o noatime,compress=zstd,space_cache=v2,discard=async,ssd,subvol=@BACKUPS /dev/mapper/BACKUP /BACKUPS/")
runs("lsblk")
print()
print('Disks are ready')
while True:
    resp=input('Do you want to proceed? [y/n]: ')
    if resp in 'YyYESyesYes':
        print()
        print('Starting Backup...')
        runs('rsync -av /home/ /BACKUPS/')
        print('Backup Complete')
        break
    elif resp in 'NnNOnoNo':
        print()
        print('Cancelling Backup...')
        exit()
        break
    else:
        print()
        print('Invalid response...')
        continue

