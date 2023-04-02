
set nocompatible
filetype off

call plug#begin(stdpath('data') . '/plugged')

" Visual appearance
Plug 'pfmooney/vim-pmolokai', { 'commit': 'c3a0477fd7ac91bd9a4983ba1f1f472315c05a10' }
Plug 'itchyny/lightline.vim', { 'commit': 'b1e91b41f5028d65fa3d31a425ff21591d5d957f' }

" Language support
Plug 'rust-lang/rust.vim', { 'commit': '8293adcd9c5645379133bea4d77de30b1476528c' }

" Utilties
Plug 'tpope/vim-fugitive', { 'commit': '96c1009fcf8ce60161cc938d149dd5a66d570756' }
Plug 'tpope/vim-commentary', { 'commit': 'f8238d70f873969fb41bf6a6b07ca63a4c0b82b1' }

" LSP
Plug 'neovim/nvim-lspconfig', { 'commit': '443b6a8f87ef52ac252b982d9bd1afb8092e3e24' }
Plug 'j-hui/fidget.nvim', { 'commit': '0ba1e16d07627532b6cae915cc992ecac249fb97' }

" Telescope (and more)
Plug 'nvim-lua/popup.nvim', { 'commit': 'b7404d35d5d3548a82149238289fa71f7f6de4ac' }
Plug 'nvim-lua/plenary.nvim', { 'commit': '253d34830709d690f013daf2853a9d21ad7accab' }
Plug 'nvim-telescope/telescope.nvim', { 'commit': '942fe5faef47b21241e970551eba407bc10d9547' }

call plug#end()
filetype plugin indent on

runtime config.lua

syntax on
