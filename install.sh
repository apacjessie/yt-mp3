#!/bin/bash

BASHRC_FILE="$HOME/.bashrc"
ALIAS_COMMAND="$HOME/.local/share/yt-mp3/yt-mp3.sh"
DIR="$HOME/.local/share/yt-mp3"

check_ytdlp() {
	if command -v yt-dlp &>/dev/null; then
		echo "yt-dlp is already installed."
		return 0
	else
		echo "Installing yt-dlp"
		return 1
	fi
}

install_ytdlp() {
	if check_ytdlp; then
		return
	fi
	echo "Installing yt-dlp..."
	sudo wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O ~/.local/bin/yt-dlp
	sudo chmod a+rx ~/.local/bin/yt-dlp
}

copy_script() {
	echo "Copying yt-mp3 script"
	sudo mkdir $DIR
	sudo cp ./yt-mp3.sh $ALIAS_COMMAND
	sudo chmod -R a+rw $DIR && sudo chmod +x $ALIAS_COMMAND
}

setup_alias() {
	if ! grep -q "alias yt-mp3='$ALIAS_COMMAND'" "$BASHRC_FILE"; then
		echo "alias yt-mp3='$ALIAS_COMMAND'" >>"$BASHRC_FILE"
		source "$BASHRC_FILE"
		echo "Alias has been set up."
	else
		echo "Alias already exists. Skipping."
	fi

}

main() {
	install_ytdlp
	copy_script
	setup_alias
	echo "Installation complete."
}

main
