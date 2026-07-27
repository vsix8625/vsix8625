let mapleader = " "

set background=dark
if (has("termguicolors"))
  set termguicolors
endif

syntax on

set timeoutlen=1000
set ttimeoutlen=10

set nocompatible
set cursorline
set noswapfile
set encoding=utf-8

set visualbell
set incsearch
set hlsearch
set smartcase
set showmatch

set expandtab
set shiftwidth=4
set softtabstop=4

set ruler
set number
set relativenumber
set laststatus=2
set showmode
set showcmd

set statusline=%f\ %m%r%h%w\ %=[%l,%c]\ [%L]\ %y

set ttyfast
set lazyredraw

set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

nnoremap Y y$
nnoremap <leader>w :w<CR>
nnoremap <F12> :wq<CR>

nnoremap <leader>c :let @/=''<cr> " clear search

colorscheme catppuccin
