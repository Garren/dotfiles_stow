set nocompatible

call plug#begin("~/.vim/plugged")

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'vim-syntastic/syntastic'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'altercation/vim-colors-solarized'

call plug#end()

filetype off

filetype plugin indent on

if !exists("g:syntax_on")
    syntax enable
endif

"syntax on
"filetype off
"filetype plugin indent on

set modelines=0

" visual spaces per tab
set tabstop=4

" number of spaces in tab when editing
set softtabstop=4

" tabs are spaces
set expandtab

set shiftwidth=4

" use a purty scheme
color molokai

" highlight the line the cursor is currently on 
set cursorline

" case insensitive search
set ignorecase

" if search string is all upper then
" assume a case sensitive search
set smartcase

" highlight matches
set hlsearch

" search as characters are entered 
set incsearch

" match parens
set showmatch

" number lines relative to current line
" but give real current line number
set number
set relativenumber

" don't wrap
set nowrap

set encoding=utf-8

" keep 3 lines above or below the cursor 
" when near the top or bottom of the screen
set scrolloff=3

" use the indent for the last line for the 
" next line
"set autoindent

" show the mode (insert, normal, visual) in the 
" last line
set showmode

" show things like lines or chars selected, etc.
set showcmd

" opening a new file when the current buffer has
" unwritten changes will 'hide' the current buffer 
" instead of forcing you to save or undo the changes.
" switching back the the hidden buffer will preserve
" any changes and undo history
set hidden

" 'enhanced' tab completion for commands
set wildmenu
set wildmode=list:longest

" don't beep
set visualbell

" enable ful 256 colors
if !has('gui_running')
  set t_Co=256
endif

" highlight the 80 column
set colorcolumn=80

" bold the current cursor line
highlight CursorLine term=bold cterm=bold guibg=Grey40

" selected in visual mode should stand out
highlight Visual term=reverse cterm=reverse guibg=Grey

" optimize for a fast terminal connection
set ttyfast

" don't redraw in the middle of a macro
set lazyredraw

" show the line and column number of the cursor
set ruler

" indent  allow backspacing over autoindent
" eol     allow backspacing over line breaks (join lines)
" start   allow backspacing over the start of insert; CTRL-W and CTRL-U
"         stop once at the start of insert.
set backspace=indent,eol,start

" always display the status line 
set laststatus=2

" Useful status information at bottom of screen
" needs fugitive
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

" use an undo file (default location is 
" current directory)
set undofile
set undodir=./.undo,~/.undo,/tmp

" don't create a backup file
set nobackup

" don't make a backup before writing a file
set nowritebackup

" if using backup then don't keep them in the 
" current directory
set backupdir=./.backup,~/.backup,/tmp

" don't use a swap file
set noswapfile

" if using a swap file don't use the current
" directory
set directory=./.swap,~/.swap,/tmp

" vertical splits happen below the active window
set splitbelow

" set the titlestring on buffer open
:auto BufEnter * let &titlestring = hostname() . "/" . expand("%:p")

" display the titlestring as the terminal title
" in gui environment
:set title titlestring=%<%F%=%l/%L-%P titlelen=70

"easier buffer navigating
nnoremap <Leader>bb :buffers<CR>:buffer<Space>
nnoremap <Leader>bn :bn<CR>
nnoremap <Leader>bp :bp<CR>

" map jj to esc in insert
inoremap jj <esc>

let mapleader = "\<space>"
let maplocalleader = "\\"

" open a file
nnoremap <Leader>o :CtrlP<CR>

" save a file
nnoremap <leader>w :w<cr>

" copy and paste to system clipboard
" <leader>p <leader>y
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

vnoremap <leader>" c"<C-r>""<esc>

" never use naked *map
" move the current line up and down
" in all modes
noremap <leader>- ddp
noremap <leader>_ ddkkp

" upcase previous word (note: iunmap)
inoremap <c-u> <esc>viwU
nnoremap <c-u> viwU

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

iabbrev ssig --<cr>Adam Garren<cr>me@adamgarren.net

" viw   : hightlight current word
" <esc> : leave visual 
" a"    : append a quote after word
" <esc> : leave insert
" hbi"  : right one, beginning of word, insert quote
" <esc> : leave insert
" lel   : left one, end of word, left one
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

" syntastic - recommended
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 5
nnoremap <leader>sr <esc>:SyntasticReset<cr>
" disable syntastic for html
let syntastic_mode_map = { 'passive_filetypes': ['html'] }

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
