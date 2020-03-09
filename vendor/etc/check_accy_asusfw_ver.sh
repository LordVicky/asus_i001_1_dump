#!/vendor/bin/sh

#prop_type=`getprop sys.asus.dongletype`

FW_VER=`cat /vendor/asusfw/FW_version.txt | grep Inbox_FW | cut -d ':' -f 2`
setprop sys.asusfw.inbox.aura_fwver "$FW_VER"
#setprop sys.asusfw.station.aura_fwver $FW_VER

#ASUS_SZ_BSP Cassie: add excpected fw version of DT to properties
FW_VER=`cat /vendor/asusfw/FW_version.txt | grep DT_aura_FW | cut -d ':' -f 2`
setprop sys.asusfw.dt.aura_fwver $FW_VER

#ASUS_SZ_BSP Cassie: add excpected fw version of station's aura to properties
FW_VER=`cat /vendor/asusfw/FW_version.txt | grep Station_aura_FW | cut -d ':' -f 2`
setprop sys.asusfw.station.aura_fwver $FW_VER

FW_VER=`cat /vendor/asusfw/FW_version.txt | grep DT_Power_FW | cut -d ':' -f 2`
setprop sys.asusfw.dt.power_fwver $FW_VER

FW_VER=`cat /vendor/asusfw/FW_version.txt | grep Station_EC_FW | cut -d ':' -f 2`
setprop sys.asusfw.station.ec_fwver $FW_VER

FW_VER=`cat /vendor/asusfw/FW_version.txt | grep DT_Hub1_FW | cut -d ':' -f 2`
setprop sys.asusfw.dt.hub1_fwver $FW_VER

FW_VER=`cat /vendor/asusfw/FW_version.txt | grep DT_Hub2_FW | cut -d ':' -f 2`
setprop sys.asusfw.dt.hub2_fwver $FW_VER

FW_VER=`cat /vendor/asusfw/FW_version.txt | grep Station_PD_FW | cut -d ':' -f 2`
setprop sys.asusfw.station.pd_fwver $FW_VER

FW_VER=`cat /vendor/asusfw/FW_version.txt | grep DT_PD_FW | cut -d ':' -f 2`
setprop sys.asusfw.dt.pd_fwver $FW_VER

#ASUS_SZ_BSP Cassie: add asusfw version for gamepad+++
FW_VER=`cat /vendor/asusfw/FW_version.txt | grep gamepad_left | cut -d ':' -f 2`
setprop sys.asusfw.gamepad.left_fwver $FW_VER

FW_VER=`cat /vendor/asusfw/FW_version.txt | grep gamepad_holder | cut -d ':' -f 2`
setprop sys.asusfw.gamepad.holder_fwver $FW_VER

FW_VER=`cat /vendor/asusfw/FW_version.txt | grep gamepad_dongle | cut -d ':' -f 2`
setprop sys.asusfw.gamepad.wireless_fwver $FW_VER
#ASUS_SZ_BSP Cassie: add asusfw version for gamepad---

setprop sys.dt.updatepdon 1
setprop sys.station.updatepdon 1

echo "[ACCY] Check Accy AsusFW Ver Done" > /dev/kmsg
