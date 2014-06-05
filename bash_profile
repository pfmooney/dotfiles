#!/bin/bash
set -o vi
export EDITOR='vim'
export PAGER='less -d'
export HISTSIZE=10000

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Work-related functions
alias dtterm='export TERM=dtterm'
# Easy detection for other configs about old vim/python/etc
export IS_RHEL6_HOST=`uname -r | awk -F- '{ if ($1 == "2.6.32") { print "YES" }}'`
alias ll='ls -l'

# OSX-specific configuration
if [ $(uname) = 'Darwin' ]; then
	# Setup NVM
	source $(brew --prefix nvm)/nvm.sh
	# Allow easy access to manta setup
	function mantaenv() {
		if [ "$1" ]; then
			export MANTA_USER=$1
		else
			export MANTA_USER=patrick.mooney
		fi
		export MANTA_KEY_ID=`ssh-keygen -l -f ~/.ssh/id_rsa.pub | awk '{print $2}' | tr -d '\n'`
		export MANTA_URL=https://us-east.manta.joyent.com
	}
	mantaenv
fi
