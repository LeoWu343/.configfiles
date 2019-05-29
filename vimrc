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
Plug 'valloric/youcompleteme', { 'do': './install.py --clang-completer --go-completer --gocode-completer --tern-completer' }

" for Samsara: Go language support and Prettier (js linter) support
Plug 'fatih/vim-go'
Plug 'prettier/vim-prettier'

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
" Highlight all found strings
set hlsearch

" Appearance
set number
" Show line and column numbers on bottom right
set ruler
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
  " Set .tsx (TypeScript) to be treated as javascript files
  autocmd BufRead,BufNewFile *.tsx set filetype=javascript
augroup END

" Put swap and backup files in the .vim directory
set directory=$HOME/.vim/swap//
set backupdir=$HOME/.vim/backup//

" for Samsara: Go/vim-go options, Prettier/vim-prettier options
" configure go:
let g:go_fmt_command='goimports'
let g:go_def_mode='gopls'
let g:go_metalinter_autosave=1
let g:go_metalinter_autosave_enabled=['vet']
let g:go_jump_to_error=0
augroup go_options
  autocmd!
  autocmd FileType go setlocal tabstop=2|setlocal shiftwidth=2|setlocal softtabstop=2|setlocal noexpandtab
  autocmd FileType go compiler go
  autocmd FileType go nmap gd <Plug>(go-def)
augroup END

" optional go syntax highlighting options
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_arguments = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1

" configure Prettier
let g:prettier#autoformat = 0
augroup prettier
  autocmd!
  autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.graphql,*.md Prettier
augroup END

