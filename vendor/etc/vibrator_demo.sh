#!/vendor/bin/sh
echo "VibratorDemo service start ..." > /dev/kmsg
type=`getprop sys.asus.vibratordemo`
LOG_TAG="vibrator_demo"

if [ "$type" == "1" ]; then
	echo "$LOG_TAG:[VIB] demo gamma" > /dev/kmsg
	echo 13 > /sys/dongwoon_haptic_drv/enableVIB
elif [ "$type" == "2" ]; then
	echo "$LOG_TAG:[VIB] demo 0832" > /dev/kmsg
	echo 15 > /sys/dongwoon_haptic_drv/enableVIB_0832
elif [ "$type" == "3" ]; then
	echo "$LOG_TAG:[VIB] demo gamma to 0832" > /dev/kmsg
	echo 12 > /sys/dongwoon_haptic_drv/enableVIB
elif [ "$type" == "4" ]; then
	echo "$LOG_TAG:[VIB] demo 0832 to gamma" > /dev/kmsg
	echo 14 > /sys/dongwoon_haptic_drv/enableVIB_0832
elif [ "$type" == "5" ]; then
	echo "$LOG_TAG:[VIB] demo gun 1" > /dev/kmsg
	echo 16 > /sys/dongwoon_haptic_drv/enableVIB
elif [ "$type" == "6" ]; then
	echo "$LOG_TAG:[VIB] demo gun 2" > /dev/kmsg
	echo 17 > /sys/dongwoon_haptic_drv/enableVIB
elif [ "$type" == "7" ]; then
	echo "$LOG_TAG:[VIB] demo gun 3" > /dev/kmsg
	echo 18 > /sys/dongwoon_haptic_drv/enableVIB_0832
elif [ "$type" == "8" ]; then
	echo "$LOG_TAG:[VIB] gamma trigger mode 1" > /dev/kmsg
	echo 8 > /sys/dongwoon_haptic_drv/enableVIB
elif [ "$type" == "9" ]; then
	echo "$LOG_TAG:[VIB] gamma trigger mode 2" > /dev/kmsg
	echo 9 > /sys/dongwoon_haptic_drv/enableVIB
elif [ "$type" == "10" ]; then
	echo "$LOG_TAG:[VIB] 0836 trigger mode 1" > /dev/kmsg
	echo 8 > /sys/dongwoon_haptic_drv/enableVIB_0832
elif [ "$type" == "11" ]; then
	echo "$LOG_TAG:[VIB] 0836 trigger mode 2" > /dev/kmsg
	echo 9 > /sys/dongwoon_haptic_drv/enableVIB_0832
#video game demo
elif [ "$type" == "101" ]; then
	#echo "$LOG_TAG:[VIB] video demo 1: gamma" > /dev/kmsg
	echo 101 > /sys/dongwoon_haptic_drv/enableVIB &
elif [ "$type" == "102" ]; then
	#echo "$LOG_TAG:[VIB] video demo 2: gamma" > /dev/kmsg
	echo 102 > /sys/dongwoon_haptic_drv/enableVIB &
elif [ "$type" == "103" ]; then
	#echo "$LOG_TAG:[VIB] video demo 3: 0832" > /dev/kmsg
	echo 103 > /sys/dongwoon_haptic_drv/enableVIB_0832 &
elif [ "$type" == "104" ]; then
	#echo "$LOG_TAG:[VIB] video demo 4: gamma" > /dev/kmsg
	echo 104 > /sys/dongwoon_haptic_drv/enableVIB &
elif [ "$type" == "105" ]; then
	#echo "$LOG_TAG:[VIB] video demo 5: 0832" > /dev/kmsg
	echo 105 > /sys/dongwoon_haptic_drv/enableVIB_0832 &
elif [ "$type" == "106" ]; then
	#echo "$LOG_TAG:[VIB] video demo 6: 0832" > /dev/kmsg
	echo 106 > /sys/dongwoon_haptic_drv/enableVIB_0832 &
elif [ "$type" == "107" ]; then
	#echo "$LOG_TAG:[VIB] video demo 7: 0832" > /dev/kmsg
	echo 107 > /sys/dongwoon_haptic_drv/enableVIB_0832 &
elif [ "$type" == "108" ]; then
	#echo "$LOG_TAG:[VIB] video demo 8: gamma" > /dev/kmsg
	echo 108 > /sys/dongwoon_haptic_drv/enableVIB &
elif [ "$type" == "109" ]; then
	#echo "$LOG_TAG:[VIB] video demo 9: 0832" > /dev/kmsg
	echo 109 > /sys/dongwoon_haptic_drv/enableVIB_0832 &
elif [ "$type" == "110" ]; then
	#echo "$LOG_TAG:[VIB] video demo 10: gamma" > /dev/kmsg
	echo 110 > /sys/dongwoon_haptic_drv/enableVIB $
elif [ "$type" == "111" ]; then
	#echo "$LOG_TAG:[VIB] video demo 11: 0832" > /dev/kmsg
	echo 111 > /sys/dongwoon_haptic_drv/enableVIB_0832 &
elif [ "$type" == "112" ]; then
	#echo "$LOG_TAG:[VIB] video demo 12: gamma" > /dev/kmsg
	echo 112 > /sys/dongwoon_haptic_drv/enableVIB &
elif [ "$type" == "113" ]; then
	#echo "$LOG_TAG:[VIB] video demo 13: gamma" > /dev/kmsg
	echo 113 > /sys/dongwoon_haptic_drv/enableVIB &
elif [ "$type" == "114" ]; then
	#echo "$LOG_TAG:[VIB] video demo 14: gamma to 0832" > /dev/kmsg
	echo 114 > /sys/dongwoon_haptic_drv/enableVIB_0832 &
	echo 114 > /sys/dongwoon_haptic_drv/enableVIB &
elif [ "$type" == "115" ]; then
	#echo "$LOG_TAG:[VIB] video demo 15: gamma" > /dev/kmsg
	echo 115 > /sys/dongwoon_haptic_drv/enableVIB &
elif [ "$type" == "116" ]; then
	#echo "$LOG_TAG:[VIB] video demo 16: gamma" > /dev/kmsg &
	echo 116 > /sys/dongwoon_haptic_drv/enableVIB &
else
	echo "$LOG_TAG:[VIB] wait demo command..." > /dev/kmsg
fi
