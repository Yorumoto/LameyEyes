#!/usr/bin/bash
configdir="$HOME/.config"
dotfiles="$(pwd)/dotfiles"
directories=("polybar" "i3" "dunst" "rofi" "gtk-3.0")

echo "the dotfiles' at ${dotfiles}"

for directory in ${directories[@]}; do
	filedir="${dotfiles}/${directory}"
	
	if [[ -d $filedir ]]; then
		rm -rf $filedir
		echo "removed existing dotfiles dir: ${filedir}"
	fi

	cp -r "$configdir/$directory" "$filedir"
	echo "updated dir from .config: $filedir"
done
