#!/bin/bash

function check_prereqs() {
	if [[ -z $DISPLAY ]]; then
		echo "Works only under X" 1>&2
		return 1
	fi

	if ! which xinput 2>&1 > /dev/null; then
		echo "xinput(1) not found" 1>&2
		return 1
	fi
	return 0
}

function set_state() {
	local act=$1
	local keys=$(xinput list --short | awk '
		/Yubico/ {
			if (match($0, /id=[0-9]+/)) {
				id = substr($0, RSTART+3, RLENGTH - 3);
				print id
			}
		}')

	if [[ -n $keys ]]; then
		for key in $keys; do
			xinput $act $key
		done
	fi
}

function print_usage() {
	cat << EOF
usage: ykeys <action>
	disable|off	- disable input from Yubikey devices
	enable|on	- enable input from Yubikey devices
EOF
}


if [[ -z "$@" ]]; then
	print_usage
	exit 0
else
	check_prereqs
	if [[ $1 = "enable" || $1 == "on" ]]; then
		set_state 'enable'
	elif [[ $1 = "disable" || $1 == "off" ]]; then
		set_state 'disable'
	else
		usage
		exit 1
	fi
fi
