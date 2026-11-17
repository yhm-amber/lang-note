

#: N of pdN from: 
Get-Partition -DriveLetter O | Select-Object DiskNumber  #. need pwsh
#: 卸载卷（数据层）
mountvol O: /P
#: 停转，听它减速安静下来
smartctl -d sat -s standby,now /dev/pd1
#: 设备层弹出
RemoveDrive.exe O:



#: X of sdX knows by: 
lsblk
#: 卷层：卸载（数据安全）
udisksctl unmount -b /dev/sdb1
#: 物理层：停转、磁头 park
hdparm -y /dev/sdb  #. -Y send SLEEP IMMEDIATE but may not supported; -y send STANDBY IMMEDIATE and could be awake by query command.
#: 设备层：退出系统 + 端口 suspend
udisksctl power-off -b /dev/sdb 
