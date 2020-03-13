#!/vendor/bin/sh
echo "Vibrator_control service start ..." > /dev/kmsg
type=`getprop vendor.asus.vibrator_control`
channel=`cat /sys/class/leds/vibrator/channel`
LOG_TAG="vibrator_control"
if [ "${channel}" == "Channel=0x1" ]; then
#BOT_VIB
	echo "$LOG_TAG:$type > /sys/asus_vib_ctrl/bot_vib_control" > /dev/kmsg
	echo $type > "/sys/asus_vib_ctrl/bot_vib_control"
elif [ "${channel}" == "Channel=0x2" ]; 
then
#TOP_VIB
	echo "$LOG_TAG:$type > /sys/asus_vib_ctrl/top_vib_control" > /dev/kmsg
	echo $type > "/sys/asus_vib_ctrl/top_vib_control"
elif [ "${channel}" == "Channel=0x3" ]; 
then
#TOP_VIB
	echo "$LOG_TAG:$type > /sys/asus_vib_ctrl/top_vib_control" > /dev/kmsg
	echo $type > "/sys/asus_vib_ctrl/top_vib_control" &
#BOT_VIB
	echo "$LOG_TAG:$type > /sys/asus_vib_ctrl/bot_vib_control" > /dev/kmsg
	echo $type > "/sys/asus_vib_ctrl/bot_vib_control"
else
	echo "Channel error!"
fi
