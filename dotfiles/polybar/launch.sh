#!/usr/bin/sh

killall -q polybar

launch_bar() {
	echo "launching $1..."
	polybar $1 2>&1 | tee -a /tmp/polybar.log & disown
}

launch_bar workspaces
launch_bar topright
launch_bar down

echo "polybar launched!"
