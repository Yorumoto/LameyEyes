dir="$HOME/.config/rofi"

# options
shutdown="⏻"
restart=""
sleep=""
lock=""
logout=""

yes=""
no=""

roficmd="rofi -theme $dir/powermenu.rasi"
rofinotify="rofi -theme $dir/notify.rasi"

chosen=$(echo -e "$shutdown\n$restart\n$sleep\n$lock\n$logout" | $roficmd -p "terminating x session..." -dmenu)

if [[ $chosen == '' ]]; then
	exit
fi

response=$(echo -e "$no\n$yes" | $roficmd -p "are you sure?" -dmenu)


if [[ $response != $yes ]]; then
	exit
fi

case $chosen in
	$shutdown)
		systemctl poweroff
	;;
	$restart)
		systemctl reboot
	;;
	$sleep)
		mpc -q pause
		amixer set Master mute
		systemctl suspend
	;;
	$lock)
		if [[ -f /usr/bin/betterlockscreen ]]; then
			betterlockscreen -l
		elif [[ -f /usr/bin/i3lock ]]; then
			i3lock -l
		else
			$rofinotify -p "Please install a screen locker." -dmenu
		fi
	;;
	$logout)
		if [[ "$DESKTOP_SESSION" == "Openbox" ]]; then
			openbox --exit
		elif [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
			bspc quit
		elif [[ "$DESKTOP_SESSION" == "i3" ]]; then
			i3-msg exit
		fi
	;;
esac
