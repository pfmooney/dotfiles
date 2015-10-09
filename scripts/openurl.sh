#!/bin/sh


if [ $(uname) = 'Darwin' ]; then
	open "$1"
fi

if [ $(uname) = 'Linux' ]; then
	if [ "$DISPLAY" -a -f /usr/bin/google-chrome ]; then
		/usr/bin/google-chrome "$1"
	fi
fi
