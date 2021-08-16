scriptencoding utf-8

runtime ./plug.vim
runtime ./maps.vim


set number
syntax enable
set termguicolors
colorscheme moonfly

set encoding=utf-8
set title
set autoindent
set background=dark
set nobackup
set hlsearch
set showcmd
set cmdheight=1
set laststatus=2
set scrolloff=10
set expandtab
set shell=fish
set backupskip=/tmp/*

set inccommand=split

set nosc noru nosm
set lazyredraw
set ignorecase
set smarttab

filetype plugin indent on
set shiftwidth=2
set tabstop=2
set ai
set si
set nowrap
set backspace=start,eol,indent
set path+=**
set wildignore+=*/node_modules/*

set cursorline

set mouse=a

runtime! lua/*.lua
