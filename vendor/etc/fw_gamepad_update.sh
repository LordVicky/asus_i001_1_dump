#!/vendor/bin/sh

type=`getprop vendor.asus.gamepad.type`
retry=0

DONGLE_FW_PATH="/vendor/asusfw/gamepad/LBA1008_dongle.bin"
HOLDER_FW_PATH="/vendor/asusfw/gamepad/LBA1008_holder.bin"
LEFT_FW_PATH="/vendor/asusfw/gamepad/LBA1008_left.bin"

function fw_update(){

	echo "[Gamepad fw update] fw_gamepad_update, fw_update type $type" > /dev/kmsg

	if [ "$type" == "left_handle" ]; then
		fw_ver=`getprop sys.gamepad.left_fwver`  #version in ic
		asus_fw_ver=`getprop sys.asusfw.gamepad.left_fwver`  #verison in phone
		echo "[Gamepad fw update] fw_gamepad_update,fw_ver=$fw_ver asus_fw_ver=$asus_fw_ver, need update." > /dev/kmsg

		/vendor/bin/gamepad_fw_update  -s 0b05:7900 -u 2e2c:7900 -f "$LEFT_FW_PATH"
		result="$?"
		if [ "$result" == 0 ]; then
			sleep 1
			/vendor/bin/gamepad_serialnum_get -a
			fw_ver=`getprop sys.gamepad.left_fwver` 
			while [ "$retry" -lt 5 ]
			do
				retry=$(($retry+1))
				if [ "$fw_ver" == "$asus_fw_ver" ]; then
					break;
				fi
				sleep 1
				/vendor/bin/gamepad_serialnum_get -a
				fw_ver=`getprop sys.gamepad.left_fwver`
			done

			if [ "$fw_ver" == "$asus_fw_ver" ]; then
				echo "[Gamepad fw update] fw_gamepad_update,after update, fw_ver=$fw_ver asus_fw_ver=$asus_fw_ver " > /dev/kmsg
				setprop sys.gamepad.left_fwupdate 0
			else
				echo "[Gamepad fw update] fw_gamepad_update, after update, fw_ver=$fw_ver asus_fw_ver=$asus_fw_ver $type update fail" > /dev/kmsg
				setprop sys.gamepad.left_fwupdate 2
			fi
		elif [ "$result" == "1" ]; then
			echo "[Gamepad fw update] fw_gamepad_update, after left update result is 1, update failed." > /dev/kmsg
			setprop sys.gamepad.left_fwupdate 2
		elif [ "$result" == "2" ]; then
			echo "[Gamepad fw update] fw_gamepad_update, after left update result is 2, the update was interrupted." > /dev/kmsg
			setprop sys.gamepad.left_fwupdate 3
		fi

	elif [ "$type" == "holder_usb" ]; then
		fw_ver=`getprop sys.gamepad.holder_fwver`  #version in ic
		asus_fw_ver=`getprop sys.asusfw.gamepad.holder_fwver`  #verison in phone
		echo "[Gamepad fw update] fw_gamepad_update,fw_ver=$fw_ver asus_fw_ver=$asus_fw_ver, need update." > /dev/kmsg

		/vendor/bin/gamepad_fw_update -s 0b05:7901 -u 2e2c:7901  -f "$HOLDER_FW_PATH"
		result="$?"
		if [ "$result" == 0 ]; then
			sleep 1
			/vendor/bin/gamepad_serialnum_get -a

			fw_ver=`getprop sys.gamepad.holder_fwver`
			while [ "$retry" -lt 5 ]
			do
				retry=$(($retry+1))
				if [ "$fw_ver" == "$asus_fw_ver" ]; then
					break;
				fi
				sleep 1
				/vendor/bin/gamepad_serialnum_get -a
				fw_ver=`getprop sys.gamepad.holder_fwver`
			done

			if [ "$fw_ver" == "$asus_fw_ver" ]; then
				echo "[Gamepad fw update] fw_gamepad_update,after update, fw_ver=$fw_ver asus_fw_ver=$asus_fw_ver " > /dev/kmsg
				setprop sys.gamepad.holder_fwupdate 0
			else
				echo "[Gamepad fw update] fw_gamepad_update, after update, fw_ver=$fw_ver asus_fw_ver=$asus_fw_ver  $type update fail" > /dev/kmsg
				setprop sys.gamepad.holder_fwupdate 2
			fi
		elif [ "$result" == "1" ]; then
			echo "[Gamepad fw update] fw_gamepad_update, after host update result is 1, update failed." > /dev/kmsg
			setprop sys.gamepad.holder_fwupdate 2
		elif [ "$result" == "2" ]; then
			echo "[Gamepad fw update] fw_gamepad_update, after host update result is 2, the update was interrupted." > /dev/kmsg
			setprop sys.gamepad.holder_fwupdate 3
		fi
	
	elif [ "$type" == "holder_wireless" ]; then
		fw_ver=`getprop sys.gamepad.wireless_fwver`  #version in ic
		asus_fw_ver=`getprop sys.asusfw.gamepad.wireless_fwver`  #verison in phone
		echo "[Gamepad fw update] fw_gamepad_update,fw_ver=$fw_ver asus_fw_ver=$asus_fw_ver, need update." > /dev/kmsg

		/vendor/bin/gamepad_fw_update -s 0b05:7903 -u 040b:6875 -e 6575 -f "$DONGLE_FW_PATH"
		result="$?"
		if [ "$result" == 0 ]; then
			sleep 1
			/vendor/bin/gamepad_serialnum_get -a

			fw_ver=`getprop sys.gamepad.wireless_fwver`
			while [ "$retry" -lt 5 ]
			do
				retry=$(($retry+1))
				if [ "$fw_ver" == "$asus_fw_ver" ]; then
					break;
				fi
				sleep 1
				/vendor/bin/gamepad_serialnum_get -a
				fw_ver=`getprop sys.gamepad.wireless_fwver`
			done

			if [ "$fw_ver" == "$asus_fw_ver" ]; then
				echo "[Gamepad fw update] fw_gamepad_update,after update, fw_ver=$fw_ver asus_fw_ver=$asus_fw_ver " > /dev/kmsg
				setprop sys.gamepad.wireless_fwupdate 0
			else
				echo "[Gamepad fw update] fw_gamepad_update, after update, fw_ver=$fw_ver asus_fw_ver=$asus_fw_ver  $type update fail" > /dev/kmsg
				setprop sys.gamepad.wireless_fwupdate 2
			fi
		elif [ "$result" == "1" ]; then
			echo "[Gamepad fw update] fw_gamepad_update, after dongle update result is 1, update failed." > /dev/kmsg
			setprop sys.gamepad.wireless_fwupdate 2
		elif [ "$result" == "2" ]; then
			echo "[Gamepad fw update] fw_gamepad_update, after dongle update result is 2, the update was interrupted." > /dev/kmsg
			setprop sys.gamepad.wireless_fwupdate 3		
		fi
	fi
	#fix TT#1337172--remove the device before select "update".
	if [ "$type" == "none" ]; then
		echo "[Gamepad fw update] fw_gamepad_update, trigger update after remove." > /dev/kmsg
		setprop sys.gamepad.left_fwupdate 2
		setprop sys.gamepad.holder_fwupdate 2
		setprop sys.gamepad.wireless_fwupdate 2
	fi
	echo "[Gamepad switch] fw_gamepad_update done." > /dev/kmsg
}

fw_update
setprop sys.asus.accy.fw_status3 000000




