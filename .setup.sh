#!/bin/bash
flag="$@"

function relink() {
	ln -s -n -v $flag $2 $1
}

DOTFILES=~/.dotfiles

cd

relink .bash_profile $DOTFILES/bash/profile
relink .bashrc $DOTFILES/bash/rc

relink .gitconfig $DOTFILES/gitconfig

relink .tmux.conf $DOTFILES/tmux/tmux.conf

relink .vim $DOTFILES/vim
relink .vimrc $DOTFILES/vim/vimrc
