#!/bin/bash
set -o vi
export EDITOR='vim'
export PAGER='less -d'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
	
