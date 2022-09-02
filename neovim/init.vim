
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
Plug 'tpope/vim-fugitive', { 'commit': '96c1009fcf8ce60161cc938d149dd5a66d570756' }
Plug 'tpope/vim-commentary', { 'commit': 'f8238d70f873969fb41bf6a6b07ca63a4c0b82b1' }

" LSP
Plug 'neovim/nvim-lspconfig', { 'commit': '443b6a8f87ef52ac252b982d9bd1afb8092e3e24' }

" Telescope (and more)
Plug 'nvim-lua/popup.nvim', { 'commit': 'b7404d35d5d3548a82149238289fa71f7f6de4ac' }
Plug 'nvim-lua/plenary.nvim', { 'commit': '1da13add868968802157a0234136d5b1fbc34dfe' }
Plug 'nvim-telescope/telescope.nvim', { 'commit': '1a91238a6ad7a1f77fabdbee7225692a04b20d48' }

call plug#end()
filetype plugin indent on

runtime config.lua

syntax on
