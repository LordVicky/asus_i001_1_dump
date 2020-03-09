#!/vendor/bin/sh

type=`getprop sys.asus.dongletype`
fw_upate=`getprop sys.station.fwupdate`

echo "[EC_HID] YodaDongleRemove, type $type" > /dev/kmsg

echo "[EC_HID][Remove] No Dongle" > /dev/kmsg

echo "[EC_HID][Remove] stop YodaDongleSwitch" > /dev/kmsg
stop YodaDongleSwitch

# Define rmmod function
function remove_mod(){

	if [ -n "$1" ]; then
		echo "[EC_HID] remove_mod $1" > /dev/kmsg
	else
		exit
	fi

	test=1
	retry=1
	while [ "$test" == 1 -a "$retry" -le "5" ]
	do
		rmmod $1
		ret=`lsmod | grep $1`
		if [ "$ret" == "" ]; then
			echo "[EC_HID] rmmod $1 success" > /dev/kmsg
			test=0
		else
			echo "[EC_HID] rmmod $1 fail" > /dev/kmsg
			test=1
			sleep 0.5
		fi
		((retry++))
	done
}

if [ "$fw_upate" == "1" ]; then
	echo "[EC_HID] Detect EC udpate on going, stop process & reset all config!!!" > /dev/kmsg
	#setprop sys.station.fwupdate 0
	#stop StationFWupdate
	#echo 0 > /sys/class/ec_hid/dongle/device/lock
	#echo 0 > /sys/fs/selinux/ec
fi

lock_remove=`cat /sys/class/ec_hid/dongle/device/is_ec_has_removed`

if [ "$lock_remove" == "0" ]; then
	echo 1 > /sys/class/ec_hid/dongle/device/pogo_sync_key

	echo 0 > /sys/class/ec_i2c/dongle/device/duty
	echo "[EC_HID][ec_i2c_rmmod][STATION_FAN]disable fan" > /dev/kmsg

	remove_mod station_key
	remove_mod ene_6k582_station
	remove_mod station_goodix_touch

	setprop sys.station.ec_fwver 0
	setprop sys.station.aura_fwver 0
	setprop sys.station.tp_fwver 0
	setprop sys.station.dp_fwver 0
	setprop sys.station.pd_fwver 0
	setprop sys.asusfw.station.tp_fwver ""

	setprop sys.asus.accy.fw_status 000000
	setprop sys.asus.accy.fw_status2 000000


	echo 13 > /sys/class/ec_hid/dongle/device/sync_state

	echo 0 > /sys/class/ec_hid/dongle/device/pogo_sync_key

	echo 1 > /sys/class/ec_hid/dongle/device/is_ec_has_removed
fi

# Remove all driver
#echo 0 > /sys/bus/i2c/devices/2-0022/lightup
#setprop sys.stn.regenfw 0
#remove_mod station_focaltech_touch
#remove_mod station_goodix_touch
#echo 0 > /proc/driver/tfa9894_fw_load
remove_mod ml51fb9ae_inbox
#remove_mod ene_8k41_station
remove_mod ene_8k41_dt
remove_mod ene_8k41_power
remove_mod nct7802
remove_mod ene_8k41_inbox
#remove_mod ene_8k41_pogo
#remove_mod station_key
#remove_mod ene_6k582_station

remove_mod ec_i2c_interface

# Enable Phone aura
echo 1 > /sys/class/leds/aura_sync/VDD
sleep 0.5

#phone_aura=`cat /sys/class/leds/aura_sync/fw_ver`
#setprop sys.phone.aura_fwver $phone_aura

# do not add any action behind here
setprop sys.aura.donglechmod 0

# force reset accy FW
setprop sys.inbox.aura_fwver 0
#setprop sys.station.ec_fwver 0
#setprop sys.station.aura_fwver 0
#setprop sys.station.tp_fwver 0
#setprop sys.station.dp_fwver 0
setprop sys.dt.aura_fwver 0
setprop sys.dt.power_fwver 0
#setprop sys.station.pd_fwver 0
setprop sys.dt.pd_fwver 0
setprop sys.dt.hub1_fwupdate 0
setprop sys.dt.hub2_fwupdate 0
setprop sys.dt.hub1_fwver ''
setprop sys.dt.hub2_fwver ''
setprop sys.asus.accy.fw_status 000000
setprop sys.asus.accy.fw_status2 000000
setprop vendor.oem.asus.inboxid 0
setprop vendor.oem.asus.stationid 0
setprop vendor.oem.asus.dtid 0
setprop vendor.dt.landetect 0
#setprop sys.asus.dt.ac_power "none"

# reset HID keyboard state
#echo 0 > /sys/class/ec_hid/dongle/device/keyboard_enable

# Send uevent to FrameWork
echo 0 > /sys/class/ec_hid/dongle/device/sync_state
