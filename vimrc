" Turn off compatibility mode
set nocompatible

" Autoload vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug start
call plug#begin('~/.vim/plugged')

" vim-plug addons
Plug 'scrooloose/syntastic'
Plug 'tomasr/molokai'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'majutsushi/tagbar'
Plug 'valloric/youcompleteme', { 'do': './install.py --clang-completer' }

" vim-plug end
call plug#end()

" Stop filetype from overriding tab settings
filetype indent off

" Syntastic recommended settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Personal Syntastic settings
let g:syntastic_cpp_check_header = 1

" Make backspace work normally on older machines
set backspace=indent,eol,start

" Tabbing
set tabstop=2 shiftwidth=2 expandtab
set autoindent smartindent

" Searching
" Case insensitive search
set ignorecase
" Case sensitive search when an uppercase letter is present
set smartcase

" Appearance
set nu
syntax on
colorscheme molokai

" Menu options
set wildmode=list:longest,full
set wildmenu

" Filetypes
augroup filetypes
  autocmd!
  " Set .md to be treated as markdown files
  autocmd BufRead,BufNewFile *.md set filetype=markdown
augroup END

" Put swap and backup files in the .vim directory
set directory=$HOME/.vim/swap//
set backupdir=$HOME/.vim/backup//

