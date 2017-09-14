#!/system/bin/sh
line="------------------------------------------------------------------"
equal="=================================================================="
echo ""
echo $line
echo "                    Welcome to Root-AIO-script"
echo $line
sleep 1
echo "                   Checking root priviledges..."
if [ ! "`id | grep =0`" ]; then
   echo ""
   echo "                  This script must be run as root"
   echo ""
   sleep 1
   exit
fi
echo "                       Checking busybox..."
if [ ! -f "/system/xbin/busybox" ] && [ ! -f "/xbin/busybox" ] && [ ! -f "/system/bin/busybox" ] && [ ! -f "/bin/busybox" ] && [ ! -f "/system/sbin/busybox" ] && [ ! -f "/sbin/busybox" ]; then
   echo ""
   echo "                         Busybox not found"
   echo ""
   sleep 1
   exit
fi
echo "                       Mounting /system..."
mount -o remount,rw -t ext4 /dev/block/mmcblk0p9 /system
while :
do
clear
echo $line
echo "                          Root-AIO-script"
echo $line
echo ""
echo $equal
echo " 1. Reboot"
echo " 2. Backup/restore /efs"
echo " 3. Wipe battery stats"
echo " 4. Dump logcat to /sdcard/logcat.txt"
echo " 5. Wipe dalvik cache"
echo " 6. Disable/enable bootanimation"
echo " 7. Disable/enable camera shutter sound"
echo " 8. Fix app permissions"
echo " 9. Exit"
echo $equal
echo -n " What do you want to do: "
read selection
case $selection in
#Reboot
  1)echo ""
	echo " 1. Reboot"
	echo " 2. Reboot to recovery"
	echo " 3. Reboot to bootloader"
	echo " 4. Power off"
	echo " 5. Back to main menu"
	echo ""
	echo -n " How do you want to reboot: "
	read rebootselection
	case $rebootselection in
	  1)reboot;;
	  2)reboot recovery;;
	  3)reboot bootloader;;
	  4)poweroff;;
	  5);;
	  *)echo ""
		echo " Invalid entry!"
		echo ""
		sleep 1;;
	esac;;
#Backup/restore /efs
  2)echo ""
	echo " 1. Backup /efs"
	echo " 2. Restore /efs from /sdcard/efs.tar.gz"
	echo " 3. Back to main menu"
	echo ""
	echo -n " What do you want to do: "
	read efsselection
	case $efsselection in
	  1)echo ""
		echo " Backing up /efs to /sdcard/efs.tar.gz..."
		if test -e /mnt/sdcard/efs.tar.gz ; then
		   sleep 1 
		   echo ""
		   echo " Old backup found, overwriting..."
		   rm -r /mnt/sdcard/efs.tar.gz
		fi
		sleep 1
		tar pzcf /sdcard/efs.tar.gz /efs
		echo ""
		echo " Done"
		sleep 1;;
	  2)echo ""
		echo " Restoring /efs from /sdcard/efs.tar.gz..."
		sleep 1
		tar pxf /sdcard/efs.tar.gz /efs
		echo ""
		echo " Done"
		sleep 1;;
	  3);;
	  *)echo ""
		echo " Invalid entry!"
		echo ""
		sleep 1;;
	esac;;
#Wipe battery stats
  3)echo ""
	echo " Wiping battery stats... "
	sleep 1
	rm /data/system/batterystats.bin
	echo ""
	echo " Done"
	sleep 1;;
#Dump logcat to /sdcard/logcat.txt
  4)if test -e /mnt/sdcard/logcat.txt ; then
	   echo ""
	   echo " Old logcat-dump found, overwriting..."
	   sleep 1
	   rm /mnt/sdcard/logcat.txt
	fi
	echo ""
	echo " Dumping logcat..."
	logcat -f /mnt/sdcard/logcat.txt;;
#Wipe dalvik cache
  5)echo ""
	echo " Wiping dalvik cache..."
	sleep 1
	rm -r /data/dalvik-cache
	echo ""
	echo " Dalvik cache wiped"
	sleep 1;;
#Disable/enable bootanimation
  6)echo ""
	echo " 1. Disable bootanimation"
	echo " 2. Enable/revert bootanimation"
	echo " 3. Back to main menu"
	echo ""
	echo -n " What do you want to do: "
	read bootanimselection
	case $bootanimselection in
	  1)echo ""
		echo " Disabling user-bootanim (changing to stock-android)..."
		sleep 1
		if test -e /system/media/bootanim.zip ; then
		   mv /system/media/bootanim.zip /system/media/bootanim.zip.bak
		   echo ""
		   echo " Done"
		else
		   echo ""
		   echo " User-bootanim not found!"
		   echo ""
		fi
		sleep 1;;
	  2)echo ""
		echo " Enabling/reverting user-bootanim..."
		sleep 1
		if test -e /system/media/bootanim.zip.bak ; then
		   mv /system/media/bootanim.zip.bak /system/media/bootanim.zip
		   echo ""
		   echo " Done"
		else
		   echo ""
		   echo " User-bootanim backup not found!"
		   echo ""
		fi
		sleep 1;;
	  3);;
	  *)echo ""
		echo " Invalid entry!"
		echo ""
		sleep 1;;
	esac;;
#Disable/enable camera shutter sound
  7)echo ""
	echo " 1. Disable camera shutter sound"
	echo " 2. Enable/revert camera shutter sound"
	echo " 3. Back to main menu"
	echo ""
	echo -n " What do you want to do: "
	read camerashutterselection
	case $camerashutterselection in
	  1)echo ""
		echo " Disabling camera shutter sounds (click+focus)..."
		sleep 1
		if test -e /system/media/audio/ui/camera_click.ogg ; then
		   mv /system/media/audio/ui/camera_click.ogg /system/media/audio/ui/camera_click.ogg.bak
		   echo ""
		   echo " Click disabled"
		else
		   echo ""
		   echo " Click not found/already disabled!"
		fi
		if test -e /system/media/audio/ui/camera_focus.ogg ; then
		   mv /system/media/audio/ui/camera_focus.ogg /system/media/audio/ui/camera_focus.ogg.bak
		   echo ""
		   echo " Focus disabled"
		else
		   echo ""
		   echo " Focus not found/already disabled!"
		fi
		sleep 1;;
	  2)echo ""
	    echo " Enabling/reverting camera shutter sounds (click+focus)..."
		sleep 1
		if test -e /system/media/audio/ui/camera_click.ogg.bak ; then
		   mv /system/media/audio/ui/camera_click.ogg.bak /system/media/audio/ui/camera_click.ogg
		   echo ""
		   echo " Click enabled"
		else
		   echo ""
		   echo " Click backup not found!"
		fi
		if test -e /system/media/audio/ui/camera_focus.ogg.bak ; then
		   mv /system/media/audio/ui/camera_focus.ogg.bak /system/media/audio/ui/camera_focus.ogg
		   echo ""
		   echo " Focus enabled"
		else
		   echo ""
		   echo " Focus backup not found!"
		fi
		sleep 1;;
	  3);;
	  *)echo ""
		echo " Invalid entry!"
		echo ""
		sleep 1;;
	esac;;
#Fix app permissions
  8)echo ""
	echo " Fixing app permissions for /system..."
	sleep 1
	chmod -R 644 /system/app/*
	echo ""
	echo " Fixing app permissions for /data..."
	sleep 1
	chmod -R 644 /data/app/*
	echo ""
	echo " Done"
	sleep 1;;
#Exit
  9)clear
	exit;;
#Invalid entry
  *)echo ""
	echo " Invalid entry!"
	echo ""
	sleep 1;;
esac
done

#4rm45
