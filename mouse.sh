#!/bin/bash

# Buttons for my G305:
# 0	Left Click	(button 1)
# 1	Right click	(button 2)
# 2	Middle button	(button 3)
# 3 *	Backward button	(button 4)
# 4 *	Forward button	(button 5)
# 5	Center button	(macro +KEY_LEFTMETA +KEY_LEFTSHIFT KEY_SPACE -KEY_LEFTMETA -KEY_LEFTSHIFT)


# Get device id
device_id=$(ratbagctl list | awk '{print $NF}')


if [ $device_id = "G305" ];then
	# Set rate to 1600
	ratbagctl $device_id dpi set 1600
	
	
	# We are about to change buttons 4 and 3 as they are the most convinient for another "profile"


	check_button_3=$(ratbagctl $device_id button 3 get | awk '{print $NF}')
	check_button_4=$(ratbagctl $device_id button 4 get | awk '{print $NF}')

	if [[ $check_button_3 != "4'" ]] || [[ $check_button_4 != "5'" ]];then
		echo "Setting button 4 to 'Forward button'"
		ratbagctl $device_id button 4 action set button 5

		echo "Setting button 3 to 'Backward button'"
		ratbagctl $device_id button 3 action set button 4
	else
		# DOOM Eternal
		if pgrep DOOMEternalx64v > /dev/null; then
			echo "Setting keybindings for DOOM Eternal"

			echo "Setting button 4 to 'R'"
			ratbagctl $device_id button 4 action set macro KEY_R

			echo "Setting button 4 to 'G'"
			ratbagctl $device_id button 3 action set macro KEY_G
		fi
	fi
fi
