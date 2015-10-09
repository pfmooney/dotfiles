#!/bin/bash
DOTFILES=~/.dotfiles

flag="$@"
function relink() {
	ln -s -n -v $flag $2 $1
}

# Fetch git submodules
cd $DOTFILES
git submodule update --init


# setup links
cd
relink .bash_profile $DOTFILES/bash/profile
relink .bashrc $DOTFILES/bash/rc

relink .gitconfig $DOTFILES/gitconfig

relink .tmux.conf $DOTFILES/tmux/tmux.conf

relink .vim $DOTFILES/vim
relink .vimrc $DOTFILES/vim/vimrc

relink .i3 $DOTFILES/i3
relink .i3status.conf $DOTFILES/i3/status.conf
relink .config/dunst $DOTFILES/i3

relink .mutt $DOTFILES/mutt
relink .offlineimaprc $DOTFILES/mutt/offlineimaprc
relink .msmtprc $DOTFILES/mutt/msmtprc
relink .urlview $DOTFILES/mutt/urlview
relink .notmuch-config $DOTFILES/mutt/notmuch-config
