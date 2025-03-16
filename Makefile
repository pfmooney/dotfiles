# Setup configs and links with minimal hassle

LN = ln -s
DF = ~/.dotfiles
MD = mkdir -p

ifdef F
    LN += -f
endif

.PHONY: base
base: basic

.PHONY: all
all: basic wm

.PHONY: setup
setup: .gitmodules
	git submodule update --init
	$(MD) ~/.config

.PHONY: basic
basic: setup
	$(LN) $(DF)/bash/profile	~/.bash_profile
	$(LN) $(DF)/bash/rc		~/.bashrc
	$(LN) $(DF)/gitconfig		~/.gitconfig
	$(LN) $(DF)/vim			~/.vim
	$(LN) $(DF)/vim/vimrc		~/.vimrc
	$(LN) $(DF)/neovim		~/.config/nvim
	$(LN) $(DF)/tmux		~/.config/tmux
	$(LN) $(DF)/jj			~/.config/jj

.PHONY: wm
wm: setup
	$(LN) $(DF)/i3			~/.config/i3
	$(LN) $(DF)/i3status		~/.config/i3status
	$(LN) $(DF)/rofi		~/.config/rofi
	$(LN) $(DF)/alacritty		~/.config/alacritty/
	$(LN) $(DF)/wezterm		~/.config/wezterm


# deprecated
.PHONY: mail
mail:
	$(LN) $(DF)/mutt		~/.mutt
	$(LN) $(DF)/mutt/offlineimaprc	~/.offlineimaprc
	$(LN) $(DF)/mutt/msmtprc	~/.msmtprc
	$(LN) $(DF)/mutt/urlview	~/.urlview
	$(LN) $(DF)/mutt/notmuch-config	~/.notmuch-config
