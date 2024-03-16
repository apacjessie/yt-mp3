#!/bin/bash

download_youtube_audio() {
	video_url="$1"
	yt-dlp -x --audio-format mp3 --audio-quality 0 "$video_url"
}

if [ -z "$1" ]; then
	echo "Insert Youtube Video URL"
	exit 1
fi

download_youtube_audio "$1"
