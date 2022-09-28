# Setup configs and links with minimal hassle

LN = ln -s
DF = ~/.dotfiles
MD = mkdir -p

ifdef F
    LN += -f
endif

.PHONY: base
base: submodules basic

.PHONY: all
all: submodules basic wm mail

.PHONY: submodules
submodules: .gitmodules
	git submodule update --init

.PHONY: base
basic:
	$(LN) $(DF)/bash/profile	~/.bash_profile
	$(LN) $(DF)/bash/rc		~/.bashrc
	$(LN) $(DF)/gitconfig		~/.gitconfig
	$(LN) $(DF)/tmux/tmux.conf	~/.tmux.conf
	$(LN) $(DF)/vim			~/.vim
	$(LN) $(DF)/vim/vimrc		~/.vimrc
	$(LN) $(DF)/neovim		~/.config/nvim

.PHONY: wm
wm:
	$(LN) $(DF)/i3			~/.i3
	$(LN) $(DF)/i3/status.conf	~/.i3status.conf
	$(LN) $(DF)/i3			~/.config/dunst
	$(MD)				~/.config/rofi
	$(LN) $(DF)/i3/rofi.conf	~/.config/rofi/config
	$(LN) $(DF)/i3/rofi.rasi	~/.config/rofi/config.rasi


.PHONY: mail
mail:
	$(LN) $(DF)/mutt		~/.mutt
	$(LN) $(DF)/mutt/offlineimaprc	~/.offlineimaprc
	$(LN) $(DF)/mutt/msmtprc	~/.msmtprc
	$(LN) $(DF)/mutt/urlview	~/.urlview
	$(LN) $(DF)/mutt/notmuch-config	~/.notmuch-config
