#!/bin/bash
flag="$@"

function relink() {
	ln -s -v $flag $2 $1
}

DOTFILES=~/.dotfiles

cd

relink .bash_profile $DOTFILES/bash_profile
relink .bashrc	$DOTFILES/bashrc

relink .gitconfig	$DOTFILES/gitconfig

relink .tmux.conf	$DOTFILES/tmux.conf

relink .vim	$DOTFILES/vim
relink .vimrc	$DOTFILES/vimrc
