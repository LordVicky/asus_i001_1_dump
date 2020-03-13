#!/vendor/bin/sh

type=`getprop vendor.asus.gamepad.type`
echo "[Gamepad Remove] YodaGamepadRemove, type $type" > /dev/kmsg

stop YodaGamepadSwitch

#setprop sys.asus.accy.fw_status3 000000
#setprop sys.gamepad.left_fwupdate 0
#setprop sys.gamepad.holder_fwupdate 0
#setprop sys.gamepad.wireless_fwupdate 0
setprop sys.gamepad.left_fwver 0
setprop sys.gamepad.holder_fwver 0 
setprop sys.gamepad.wireless_fwver 0
setprop vendor.asus.gamepad.type none


#for case set fw_status3 already but remove+++++
wireless_fwupdate=`getprop sys.gamepad.wireless_fwupdate`
left_fwupdate=`getprop sys.gamepad.left_fwupdate`
holder_fwupdate=`getprop sys.gamepad.holder_fwupdate`
fw_status3=`getprop sys.asus.accy.fw_status3`

if [ "$fw_status3" == "100000" -a  "$left_fwupdate" != "1"];then
	setprop sys.asus.accy.fw_status3 000000
if
if [ "$fw_status3" == "010000" -a  "$holder_fwupdate" != "1"];then
	setprop sys.asus.accy.fw_status3 000000
if
if [ "$fw_status3" == "001000" -a  "$wireless_fwupdate" != "1"];then
	setprop sys.asus.accy.fw_status3 000000
if
#for case set fw_status3 already but remove+++++