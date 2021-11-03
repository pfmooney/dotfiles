
set nocompatible
filetype off

call plug#begin(stdpath('data') . '/plugged')

" Visual appearance
Plug 'pfmooney/vim-pmolokai', { 'commit': 'c3a0477fd7ac91bd9a4983ba1f1f472315c05a10' }
Plug 'itchyny/lightline.vim', { 'commit': 'f7dd47eb55aed259cbc3e913f78c4ab21b3504bf' }

" Language support
Plug 'rust-lang/rust.vim', { 'commit': '8293adcd9c5645379133bea4d77de30b1476528c' }
Plug 'cespare/vim-toml', { 'commit': '897cb4eaa81a0366bc859effe14116660d4015cd' }

" Utilties
Plug 'tpope/vim-fugitive', { 'commit': '2a53d7924877b38b3d82fba188fd9053bfbc646e' }
Plug 'tpope/vim-commentary', { 'commit': 'f8238d70f873969fb41bf6a6b07ca63a4c0b82b1' }

" LSP
Plug 'neovim/nvim-lspconfig', { 'commit': '443b6a8f87ef52ac252b982d9bd1afb8092e3e24' }

" Telescope (and more)
Plug 'nvim-lua/popup.nvim', { 'commit': '5e3bece7b4b4905f4ec89bee74c09cfd8172a16a' }
Plug 'nvim-lua/plenary.nvim', { 'commit': '8bae2c1fadc9ed5bfcfb5ecbd0c0c4d7d40cb974' }
Plug 'nvim-telescope/telescope.nvim', { 'commit': 'b13306e5cc6da855f77e02b37e807a4b7e32b761' }

call plug#end()
filetype plugin indent on

runtime config.lua

syntax on
