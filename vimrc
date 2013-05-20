""set bg=dark

" Wrapping and tabs.
""set tw=78 ts=4 sw=4 sta et sts=4 ai

" More syntax highlighting.
"let python_highlight_all = 1

" Smart indenting
" set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
""filetype plugin indent on
" Wrap at 72 chars for comments.
""set formatoptions=cq textwidth=72 foldignore= wildignore+=*.py[co]

" Highlight end of line whitespace.
" highlight WhitespaceEOL ctermbg=red guibg=red
" match WhitespaceEOL /\s\+$/


set nocompatible        " no vi-compatibility (aka: cool functions on)
set nobackup            " don't create backup files
set ruler                       " display the cursor position
set bg=dark                     " black terminal background
set nohlsearch          " don't highlight search terms
set bs=2                        " allow useful backspace in insert mode
" set visible tab-width to 4 characters
set tabstop=4
set shiftwidth=4
syntax on                       " syntax highlighting is what the cool kids do

execute pathogen#infect()
" Enable fun indenting/functions
set nosi
set autoindent
filetype plugin indent on

" support 256 color terminals
if &term =~ "xterm" || &term =~ "256color"
     set t_Co=256
endif

" Fix crappy Pmenu colors
hi Pmenu ctermfg=Gray
hi PmenuSel ctermfg=Gray

" map space-bar to toggle folding
noremap <space> za

" settings for useful python editing
function! PythonSettings()
        " insert spaces for tabs
        setlocal tabstop=4
        setlocal softtabstop=4
        setlocal shiftwidth=4
        setlocal smarttab
        setlocal expandtab
        setlocal textwidth=80
        setlocal nosmartindent
        " fold blocks, but only 2-deep (classes/methods)
        setlocal foldmethod=indent
        setlocal foldnestmax=2
endfunction
autocmd FileType python call PythonSettings()

