" default to vim
" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vim/vimrc

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd!

endif

set encoding=utf8

let g:python3_host_prog='/usr/bin/python3'

call plug#begin('~/.config/nvim/plugged')
"File Search:
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"File Browser:
Plug 'scrooloose/nerdtree'
Plug 'mkitt/tabline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'ctrlpvim/ctrlp.vim'
"Golang:
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"SML:
Plug 'jez/vim-better-sml'
"Idris"
Plug 'idris-hackers/idris-vim'
"Autocomplete:
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-go'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-bufword'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'stamblerre/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
"Snippets:
Plug 'ncm2/ncm2-ultisnips'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"Git:
Plug 'tpope/vim-fugitive'
"Plug 'airblade/vim-gitgutter' not vim-go friendly
"Var:
Plug 'scrooloose/nerdcommenter'
Plug 'itchyny/lightline.vim'
"Todo
Plug 'pangloss/vim-javascript'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'dense-analysis/ale'

call plug#end()

set clipboard=unnamed,unnamedplus
"COPY/PASTE:
"-----------
"Increases the memory limit from 50 lines to 1000 lines
:set viminfo='100,<1000,s10,h

"NUMBERING:
"----------
:set number

"INDENTATION:
"------------
"Highlights code for multiple indents without reselecting
vnoremap < <gv
vnoremap > >gv

"COLOR:
"------
colorscheme molokai

"AUTO IMPORT:
"------------
let g:go_fmt_command = "goimports"

"AUTOCOMPLETE:
"-------------
augroup ncm2
  au!
  autocmd BufEnter * call ncm2#enable_for_buffer()
  set completeopt=noinsert,menuone,noselect
  au User Ncm2PopupOpen set completeopt=noinsert,menuone,noselect
  au User Ncm2PopupClose set completeopt=menuone
augroup END
"Press Enter to select item in autocomplete popup
inoremap <silent> <expr> <CR> (pumvisible() ? ncm2_ultisnips#expand_or("\<CR>", 'n') : "\<CR>")
"Cycle through completion entries with tab/shift+tab
inoremap <expr> <TAB> pumvisible() ? "\<c-n>" : "\<TAB>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<TAB>"
"Allow getting out of pop with Down/Up arrow keys
inoremap <expr> <down> pumvisible() ? "\<C-E>" : "\<down>"
inoremap <expr> <up> pumvisible() ? "\<C-E>" : "\<up>"

"ALE:
"----
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '▲'
"let g:airline#extensions#ale#enabled = 1
" Open the loclist if there were errors
let g:ale_open_list = 1
" Only lint on save
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0

"SNIPPETS:
"---------
"Change default expand since TAB is used to cycle options
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsSnippetsDir="~/.config/nvim/snips"
let g:UltiSnipsSnippetDirectories=["snips"]

"FILE SEARCH:
"------------
"allows FZF to open by pressing CTRL-F
noremap <C-f> :FZF<CR>

" Nope. pull the default fzf command from env
"let $FZF_DEFAULT_COMMAND = "find -L"

"FILE BROWSER:
"-------------
"allows NERDTree to open/close by typing 'n' then 't'
"noremap nt :NERDTreeTabsToggle<CR>
noremap nt :NERDTreeToggleVCS<CR>

"Start NERDtree when dir is selected (e.g. "vim .") and start NERDTreeTabs
"let g:nerdtree_tabs_open_on_console_startup=2
"Add a close button in the upper right for tabs
"let g:tablineclosebutton=1
"Automatically find and select currently opened file in NERDTree
let g:nerdtree_tabs_autofind=1
"Add folder icon to directories
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
"Hide expand/collapse arrows
let g:NERDTreeDirArrowExpandable = "\u00a0"
let g:NERDTreeDirArrowCollapsible = "\u00a0"
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
highlight! link NERDTreeFlags NERDTreeDir

" CtrlP ingorables
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

"SHORTCUTS:
"----------
"Open file at same line last closed
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g'\"" | endif
endif

"SOURCING:
"---------
"Automatically reloads neovim configuration file on write (w)
autocmd! bufwritepost init.vim source %

"MOUSE:
"------
"Allow using mouse helpful for switching/resizing windows
set mouse+=a
let os=substitute(system('uname'), '\n', '', '')
if os == 'Linux'
  if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
  endif
endif

"TEXT SEARCH:
"------------
"Makes Search Case Insensitive
set ignorecase

"SWAP:
"-----
set dir=~/.local/share/nvim/swap/

"GIT (FUGITIVE):
"---------------
noremap fgb :Gblame<CR>
noremap fgs :Gstatus<CR>
noremap fgl :Glog<CR>
noremap fgd :Gdiff<CR>
noremap fgc :Gcommit<CR>
noremap fga :Git add %:p<CR>

"SYNTAX HIGHLIGHTING:
"--------------------
syntax on

"HIGHLIGHTING:
"-------------
" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>
" Highlight the current line the cursor is on
set cursorline

au FileType javascript setlocal formatprg=prettier
au FileType javascript.jsx setlocal formatprg=prettier
au FileType typescript setlocal formatprg=prettier\ --parser\ typescript
au FileType html setlocal formatprg=js-beautify\ --type\ html
au FileType scss setlocal formatprg=prettier\ --parser\ css
au FileType css setlocal formatprg=prettier\ --parser\ css

" write the content of a file when you call :make
set autowrite

" ERRORS
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" tabs are spaces
set expandtab
" show existing tabs with 2 space width
set tabstop=2
set softtabstop=2
" when indenting with '>', use 2 space width
set shiftwidth=2

" GO:
"--------------------
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" Let go files use gofmt tabbing
autocmd FileType go setlocal noexpandtab

" building
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
"autocmd FileType go nmap <leader>b <Plug>(go-build)
" running
autocmd FileType go nmap <leader>r <Plug>(go-run)
" testing
autocmd FileType go nmap <leader>t <Plug>(go-test)
" identifier resolution
autocmd FileType go nmap <Leader>i <Plug>(go-info)

" 'alternate' commands
" switch between a file and its test
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
" ...in a vertical split
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
" ...or a horizontal split
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')

let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1

" These might impact performance
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_types = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1

let g:go_auto_sameids = 1

" SML:
" ----
augroup vimbettersml
  au!
  " ----- Keybindings -----
  au FileType sml nnoremap <silent> <buffer> <leader>t :SMLTypeQuery<CR>
  au FileType sml nnoremap <silent> <buffer> gd :SMLJumpToDef<CR>

  " open the REPL terminal buffer
  au FileType sml nnoremap <silent> <buffer> <leader>is :SMLReplStart<CR>
  " close the REPL (mnemonic: k -> kill)
  au FileType sml nnoremap <silent> <buffer> <leader>ik :SMLReplStop<CR>
  " build the project (using CM if possible)
  au FileType sml nnoremap <silent> <buffer> <leader>ib :SMLReplBuild<CR>
  " for opening a structure, not a file
  au FileType sml nnoremap <silent> <buffer> <leader>io :SMLReplOpen<CR>
  " use the current file into the REPL (even if using CM)
  au FileType sml nnoremap <silent> <buffer> <leader>iu :SMLReplUse<CR>
  " clear the REPL screen
  au FileType sml nnoremap <silent> <buffer> <leader>ic :SMLReplClear<CR>
  " set the print depth to 100
  au FileType sml nnoremap <silent> <buffer> <leader>ip :SMLReplPrintDepth<CR>

  " ----- Other settings -----

  " Uncomment to try out conceal characters
  "au FileType sml setlocal conceallevel=2

  " Uncomment to try out same-width conceal characters
  "let g:sml_greek_tyvar_show_tick = 1
augroup END

" GENERAL:
" -----------------------

" case insensitive search
set ignorecase

" if search string is all upper then
" assume a case sensitive search
set smartcase

" highlight matches
set nohlsearch

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

" keep 3 lines above or below the cursor 
" when near the top or bottom of the screen
set scrolloff=3

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
set wildmode=longest,list,full
set wildmenu

" don't beep
set visualbell

set colorcolumn=80

" bold the current cursor line
highlight CursorLine term=bold cterm=bold guibg=Grey40

" selected in visual mode should stand out
highlight Visual term=reverse cterm=reverse guibg=Grey

" optimize for a fast terminal connection
" set ttyfast

" don't redraw in the middle of a macro
" set lazyredraw

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

" turn off wrapping
set nowrap

" set the titlestring on buffer open
:auto BufEnter * let &titlestring = hostname() . "/" . expand("%:p")

" display the titlestring as the terminal title
" in gui environment
:set title titlestring=%<%F%=%l/%L-%P titlelen=70

let mapleader = "\<space>"
let maplocalleader = "\\"

nnoremap <leader>ev :vsplit $HOME/.config/nvim/init.vim<cr>
nnoremap <leader>sv :source $HOME/.config/nvim/init.vim<cr>
nnoremap <Leader>bb :buffers<CR>:buffer<Space>
nnoremap <Leader>bn :bn<CR>
nnoremap <Leader>bp :bp<CR>
nnoremap <Leader>bd :bd<CR>

inoremap fd <esc>
tnoremap fd <C-\><C-n>
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l

" viw   : hightlight current word
" <esc> : leave visual 
" a"    : append a quote after word
" <esc> : leave insert
" hbi"  : right one, beginning of word, insert quote
" <esc> : leave insert
" lel   : left one, end of word, left one
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

if has("autocmd")
autocmd FileType zsh setlocal shiftwidth=2 softtabstop=2 expandtab
endif

