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
