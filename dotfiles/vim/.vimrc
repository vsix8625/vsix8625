let mapleader = " "

set background=dark
if (has("termguicolors"))
  set termguicolors
endif

syntax on
colorscheme catppuccin

set nocompatible
set cursorline
set noswapfile
set encoding=utf-8

set incsearch
set hlsearch

set expandtab
set shiftwidth=4
set softtabstop=4

set number
set relativenumber
set laststatus=2

nnoremap Y y$
nnoremap <leader>w :w<CR>
nnoremap <F12> :wq<CR>
