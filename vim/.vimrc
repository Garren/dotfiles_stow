set nocompatible

if has('python3')
  silent! python3 1
endif

set rtp+=/usr/local/opt/fzf

call plug#begin("~/.vim/plugged")

Plug '/usr/local/opt/fzf'

Plug 'junegunn/fzf.vim'
Plug 'junegunn/vader.vim'

" Supertab is used to reconsile tab behavior between ultisnips
" and YCM.
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'ervandew/supertab'
Plug 'Valloric/YouCompleteMe'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdcommenter'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'itchyny/lightline.vim'

Plug 'elixir-editors/vim-elixir'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Typescript/Javascript
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'

Plug 'mustache/vim-mustache-handlebars'
Plug 'pangloss/vim-javascript'
Plug 'elmcast/elm-vim'
Plug 'posva/vim-vue'

Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
call plug#end()

filetype plugin indent on

"set term=screen-256color
if !exists("g:syntax_on")
    syntax enable
endif

syntax on
"filetype off
"filetype plugin indent on

set modelines=0

" visual spaces per tab
set tabstop=8

" tabs are spaces
set expandtab

" indenting is 4 spaces
set shiftwidth=2

" number of spaces in tab when editing
set softtabstop=2

set autoindent

" set smartindent

" set cindent

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
" bold both parens but only highlight the one under the cursor
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta 

" number lines relative to current line
" but give real current line number
set number
set relativenumber

" don't wrap
nnoremap ff :call fzf#run(fzf#wrap({'source': 'git ls-files --exclude-standard --others --cached'}))<Enter>
set nowrap

set encoding=utf-8

" keep 3 lines above or below the cursor 
" when near the top or bottom of the screen
set scrolloff=3

" use the indent for the last line for the 
" next line
"set autoindent

" write the content of a file automatically if 
" you call :make
set autowrite

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

let mapleader = "\<space>"
let maplocalleader = "\\"

"easier buffer navigating
nnoremap <Leader>bb :buffers<CR>:buffer<Space>
nnoremap <Leader>bn :bn<CR>
nnoremap <Leader>bp :bp<CR>
nnoremap <Leader>bd :bd<CR>

" map fd to esc in insert
inoremap fd <esc>

" save a file
nnoremap <leader>w :w<cr>

" copy and paste to system clipboard
set clipboard=unnamed,unnamedplus
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
"inoremap <c-u> <esc>viwU
"nnoremap <c-u> viwU

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

" https://stackoverflow.com/questions/14896327/ultisnips-and-youcompleteme
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

nnoremap <C-p> :Files<CR>
nnoremap <C-e> :Buffers<CR>

let g:fzf_action = {
  \ 'ctrl-e': 'edit',
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Go-related improvements
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

nnoremap <leader>gdd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>grr :YcmCompleter GoToReference<CR>
nnoremap <leader>ycm :YcmCompleter RestartServer<CR>


autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
