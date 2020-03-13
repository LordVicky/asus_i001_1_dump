#!/vendor/bin/sh

echo "[Gamepad switch] YodaGamepadSwitch entry" > /dev/kmsg

function reset_accy_fw_ver(){
	#setprop sys.asus.accy.fw_status3 000000
	#setprop sys.gamepad.left_fwupdate 0
	#setprop sys.gamepad.holder_fwupdate 0
	#setprop sys.gamepad.wireless_fwupdate 0
	setprop sys.gamepad.left_fwver 0
	setprop sys.gamepad.holder_fwver 0 
	setprop sys.gamepad.wireless_fwver 0
	setprop vendor.asus.gamepad.type none
}


function check_accy_fw_ver(){

	echo "[Gamepad switch] YodaGamepadSwitch, check_accy_fw_ver type $type" > /dev/kmsg

	if [ "$type" == "left_handle" ]; then
		fw_ver=`getprop sys.gamepad.left_fwver`  #version in ic
		asus_fw_ver=`getprop sys.asusfw.gamepad.left_fwver`  #verison in phone

		if [ "$fw_ver" == ""  -o "$fw_ver" == "0" ]; then
			echo "[Gamepad switch] YodaGamepadSwitch, check_accy_fw_ver fw_ver=$fw_ver" > /dev/kmsg
			/vendor/bin/gamepad_serialnum_get -a
			sleep 1
			fw_ver=`getprop sys.gamepad.left_fwver`  #version in ic
			echo "[Gamepad switch] YodaGamepadSwitch, check_accy_fw_ver fw_ver=$fw_ver after retry check 1st" > /dev/kmsg
			if [ "$fw_ver" == ""  -o "$fw_ver" == "0" ]; then
				/vendor/bin/gamepad_serialnum_get -a
				sleep 1
				fw_ver=`getprop sys.gamepad.left_fwver`  #version in ic
				echo "[Gamepad switch] YodaGamepadSwitch, check_accy_fw_ver fw_ver=$fw_ver after retry check 2nd" > /dev/kmsg
				if [ "$fw_ver" == ""  -o "$fw_ver" == "0" ]; then
					setprop sys.asus.accy.fw_status3 000000
					echo "[Gamepad switch] YodaGamepadSwitch, check_accy_fw_ver , do nothing. exit" > /dev/kmsg
					exit 0
				fi
			fi
		fi

		fw_vern_num=${fw_ver:1:1}${fw_ver:3:1}${fw_ver:5:1}
		asus_fw_ver_num=${asus_fw_ver:1:1}${asus_fw_ver:3:1}${asus_fw_ver:5:1}

		if [ "$fw_ver" == "$asus_fw_ver" ]; then
			echo "[Gamepad fw update] fw_gamepad_update fw_ver=$fw_ver asus_fw_ver=$asus_fw_ver, fw_vern_num=$fw_vern_num no need update "> /dev/kmsg
			setprop sys.asus.accy.fw_status3 000000
		else
			if [[ "$fw_vern_num" < "$asus_fw_ver_num" ]]; then
				echo "[Gamepad fw update] fw_gamepad_update fw_ver=$fw_vern_num asus_fw_ver=$asus_fw_ver_num need update "> /dev/kmsg
				setprop sys.asus.accy.fw_status3 100000
			fi
		fi

	elif [ "$type" == "holder_usb" ]; then
		fw_ver=`getprop sys.gamepad.holder_fwver`  #version in ic
		asus_fw_ver=`getprop sys.asusfw.gamepad.holder_fwver`  #verison in phone

		if [ "$fw_ver" == ""  -o "$fw_ver" == "0" ]; then
			echo "[Gamepad switch] YodaGamepadSwitch, check_accy_fw_ver fw_ver=$fw_ver" > /dev/kmsg
			/vendor/bin/gamepad_serialnum_get -a
			sleep 1
			fw_ver=`getprop sys.gamepad.holder_fwver`  #version in ic
			echo "[Gamepad switch] YodaGamepadSwitch, check_accy_fw_ver fw_ver=$fw_ver after retry check 1st" > /dev/kmsg
			if [ "$fw_ver" == ""  -o "$fw_ver" == "0" ]; then
				/vendor/bin/gamepad_serialnum_get -a
				sleep 1
				fw_ver=`getprop sys.gamepad.holder_fwver`  #version in ic
				echo "[Gamepad switch] YodaGamepadSwitch, check_accy_fw_ver fw_ver=$fw_ver after retry check 2nd" > /dev/kmsg
				if [ "$fw_ver" == ""  -o "$fw_ver" == "0" ]; then
					setprop sys.asus.accy.fw_status3 000000
					echo "[Gamepad switch] YodaGamepadSwitch, check_accy_fw_ver , do nothing. exit" > /dev/kmsg
					exit 0
				fi
			fi
		fi

		fw_vern_num=${fw_ver:1:1}${fw_ver:3:1}${fw_ver:5:1}
		asus_fw_ver_num=${asus_fw_ver:1:1}${asus_fw_ver:3:1}${asus_fw_ver:5:1}

		if [ "$fw_ver" == "$asus_fw_ver" ]; then
			echo "[Gamepad fw update] fw_gamepad_update fw_ver=$fw_ver asus_fw_ver=$asus_fw_ver no need update "> /dev/kmsg
			setprop sys.asus.accy.fw_status3 000000
		else
			if [[ "$fw_vern_num" < "$asus_fw_ver_num" ]]; then
				echo "[Gamepad fw update] fw_gamepad_update fw_ver=$fw_vern_num asus_fw_ver=$asus_fw_ver_num need update "> /dev/kmsg
				setprop sys.asus.accy.fw_status3 010000
			fi
		fi
	
	elif [ "$type" == "holder_wireless" ]; then

		fw_ver=`getprop sys.gamepad.wireless_fwver`  #version in ic
		asus_fw_ver=`getprop sys.asusfw.gamepad.wireless_fwver`  #verison in phone

		if [ "$fw_ver" == ""  -o "$fw_ver" == "0" ]; then
			echo "[Gamepad switch] YodaGamepadSwitch, check_accy_fw_ver fw_ver=$fw_ver" > /dev/kmsg
			/vendor/bin/gamepad_serialnum_get -a
			sleep 1
			fw_ver=`getprop sys.gamepad.wireless_fwver`  #version in ic
			echo "[Gamepad switch] YodaGamepadSwitch, check_accy_fw_ver fw_ver=$fw_ver after retry check 1st" > /dev/kmsg
			if [ "$fw_ver" == ""  -o "$fw_ver" == "0" ]; then
				/vendor/bin/gamepad_serialnum_get -a
				sleep 1
				fw_ver=`getprop sys.gamepad.wireless_fwver`  #version in ic
				echo "[Gamepad switch] YodaGamepadSwitch, check_accy_fw_ver fw_ver=$fw_ver after retry check 2nd" > /dev/kmsg
				if [ "$fw_ver" == ""  -o "$fw_ver" == "0" ]; then
					setprop sys.asus.accy.fw_status3 000000
					echo "[Gamepad switch] YodaGamepadSwitch, check_accy_fw_ver , do nothing. exit" > /dev/kmsg
					exit 0
				fi
			fi
		fi

		fw_vern_num=${fw_ver:1:1}${fw_ver:3:1}${fw_ver:5:1}
		asus_fw_ver_num=${asus_fw_ver:1:1}${asus_fw_ver:3:1}${asus_fw_ver:5:1}


		if [ "$fw_ver" == "$asus_fw_ver" ]; then
			echo "[Gamepad fw update] fw_gamepad_update fw_ver=$fw_ver asus_fw_ver=$asus_fw_ver no need update "> /dev/kmsg
			setprop sys.asus.accy.fw_status3 000000
		else
			if [[ "$fw_vern_num" < "$asus_fw_ver_num" ]]; then
				echo "[Gamepad fw update] fw_gamepad_update fw_ver=$fw_vern_num asus_fw_ver=$asus_fw_ver_num need update "> /dev/kmsg
				setprop sys.asus.accy.fw_status3 001000
			fi
		fi
	fi 
	echo "[Gamepad fw update] Get Gamepad FW Ver done." > /dev/kmsg
}


reset_accy_fw_ver

#check if it is the update time switch+++++++++++
wireless_fwupdate=`getprop sys.gamepad.wireless_fwupdate`
left_fwupdate=`getprop sys.gamepad.left_fwupdate`
holder_fwupdate=`getprop sys.gamepad.holder_fwupdate`
if [ "$left_fwupdate" == "1" ]; then
	echo "[Gamepad switch] YodaGamepadSwitch it is left update, exit" > /dev/kmsg
	exit 0
fi
if [ "$wireless_fwupdate" == "1" ]; then
	echo "[Gamepad switch] YodaGamepadSwitch it is wireless dongle update, exit" > /dev/kmsg
	exit 0
fi
if [ "$holder_fwupdate" == "1" ]; then
	echo "[Gamepad switch] YodaGamepadSwitch it is holder update, exit" > /dev/kmsg
	exit 0
fi
#check if it is the update time switch-----------

/vendor/bin/gamepad_serialnum_get -a
sleep 1
type=`getprop vendor.asus.gamepad.type`

#check if it is the loader mode,and fwupdate!=1 +++++++++++
ld_check=`lsusb |grep 2e2c:7900`
if [ "$ld_check" != "" ];then
	echo "[Gamepad switch] YodaGamepadSwitch left LD mode " > /dev/kmsg
	setprop sys.asus.accy.fw_status3 100000
	exit 0
fi
ld_check=`lsusb |grep 2e2c:7901`
if [ "$ld_check" != "" ];then
	echo "[Gamepad switch] YodaGamepadSwitch holder LD mode " > /dev/kmsg
	setprop sys.asus.accy.fw_status3 010000
	exit 0
fi
ld_check=`lsusb |grep 040b:6875`
if [ "$ld_check" != "" ];then
	echo "[Gamepad switch] YodaGamepadSwitch wireless LD mode " > /dev/kmsg
	setprop sys.asus.accy.fw_status3 001000
	exit 0
fi
#check if it is the loader mode-----------

#setprop sys.asus.accy.fw_status3 000000



if [ "$type" == "none" ]; then
	echo "[Gamepad switch] YodaGamepadSwitch none " > /dev/kmsg
else
	echo "[Gamepad switch] YodaGamepadSwitch, type $type" > /dev/kmsg
	check_accy_fw_ver
fi
