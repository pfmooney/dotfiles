#!/bin/sh


if [ $(uname) = 'Darwin' ]; then
	open "$1"
fi

if [ $(uname) = 'Linux' ]; then
	if [ "$DISPLAY" -a -f /usr/bin/firefox ]; then
		/usr/bin/firefox "$1"
	fi
fi
