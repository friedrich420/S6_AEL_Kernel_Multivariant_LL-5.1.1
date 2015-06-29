#!/system/bin/sh

/sbin/busybox mount -t rootfs -o remount,rw rootfs

sync

/system/xbin/daemonsu --auto-daemon &

# Make internal storage directory.
if [ ! -d /data/.ael ]; then
	mkdir /data/.ael
fi;

# Synapse
busybox mount -t rootfs -o remount,rw rootfs
busybox chmod -R 755 /res/synapse
busybox ln -fs /res/synapse/uci /sbin/uci
/sbin/uci
busybox mount -t rootfs -o remount,ro rootfs

# Init.d
busybox run-parts /system/etc/init.d

/sbin/busybox mount -t rootfs -o remount,ro rootfs
/sbin/busybox mount -o remount,rw /data
