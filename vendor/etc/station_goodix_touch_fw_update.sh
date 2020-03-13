#!/vendor/bin/sh

device_PATH="/sys/devices/platform/goodix_ts_station.0/"
fw_verion_now=`cat $device_PATH/chip_info|sed -n '3 p' |awk -F ":" '{print $NF}'`
fw_verion_new=`cat sys/devices/platform/goodix_ts.0/chip_info|sed -n '3 p' |awk -F ":" '{print $NF}'`
station_tp_cfg=`cat $device_PATH/read_cfg|sed -n '1 p'|awk 'BEGIN{FS=" "}{print $1}'`

IC_init=`cat $device_PATH/goodix_init`
if [ "$IC_init" = "" ]; then
	echo "[Touch][station][goodix] not goodix touch" > /dev/kmsg
	exit
fi

retry=1

echo "[Touch][station][goodix] firmware version now = $fw_verion_now ,new version = $fw_verion_new" > /dev/kmsg
if [ "$IC_init" = "0" ];then
	echo "[Touch][station][goodix] touch IC init =0 fail!" > /dev/kmsg
elif [ "$fw_verion_now" = "$fw_verion_new" ];then
	echo "[Touch][station][goodix] FW is new didn't upgrade!" > /dev/kmsg
else
	echo 1 > $device_PATH/fw_update
	echo "[Touch][station][goodix] FW need upgrade!" > /dev/kmsg
	sleep 1
	fw_upgrate_progress=`cat $device_PATH/fwupdate/progress`
	while [ "$fw_upgrate_progress" -ne 100 -a "$retry" -le "10" ]
	do
		echo "[Touch][station][goodix] fw updating..." > /dev/kmsg
		sleep 1
		fw_upgrate_progress=`cat $device_PATH/fwupdate/progress`
		((retry++))
	done

	if [ "$retry" -eq "11" ]; then
		echo "[Touch][station][goodix] update fail!!" > /dev/kmsg
		setprop sys.station.tp_fwupdate 2
		exit
	fi
fi

sleep 1

fw_verion_now=`cat $device_PATH/chip_info|sed -n '3 p' |awk -F ":" '{print $NF}'`
if [ "$fw_verion_now" = "$fw_verion_new" ];then
	echo "[Touch][station][goodix] update successfully" > /dev/kmsg
	station_tp_cfg=`cat $device_PATH/read_cfg|sed -n '1 p'|awk 'BEGIN{FS=" "}{print $1}'`
	setprop sys.station.tp_fwver "$fw_verion_now CFG:$((16#$station_tp_cfg))"
	setprop sys.station.tp_fwupdate 0
else
	echo "[Touch][station][goodix] update fail!!" > /dev/kmsg
	setprop sys.station.tp_fwupdate 2
fi
