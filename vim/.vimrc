set nocompatible

if has('python3')
  silent! python3 1
endif

call plug#begin("~/.vim/plugged")

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'vim-syntastic/syntastic'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdcommenter'
Plug 'ervandew/supertab'
Plug 'mustache/vim-mustache-handlebars'
Plug 'pangloss/vim-javascript'
Plug 'elmcast/elm-vim'
Plug 'elixir-editors/vim-elixir'
Plug 'junegunn/vader.vim'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'jparise/vim-graphql'
Plug 'evanleck/vim-svelte'
Plug 'HerringtonDarkholme/yats.vim'
call plug#end()

filetype plugin indent on

"set term=screen-256color
if !exists("g:syntax_on")
    syntax enable
endif

syntax on
"filetype off
"filetype plugin indent on

let &path.="/usr/local/include,"

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

" highlight trailing whitespace in red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" number lines relative to current line
" but give real current line number
set number
set relativenumber

" don't wrap
set nowrap

set encoding=utf-8

" keep 3 lines above or below the cursor 
" when near the top or bottom of the screen
set scrolloff=999

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
"set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

"
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

" map fd to esc in insert
inoremap fd <esc>

" open a file
nnoremap <Leader>o :CtrlP<CR>

" save a file
nnoremap <leader>w :w<cr>

set clipboard=unnamed,unnamedplus
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

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 5

let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libc++'

nnoremap <leader>sr <esc>:SyntasticReset<cr>

" disable syntastic for html
let syntastic_mode_map = { 'passive_filetypes': ['html'] }

let g:syntastic_cucumber_cucumber_args="--profile syntastic"

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode': 'LightlineMode',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

function! LightlineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightlineFilename()
  let fname = expand('%:p:h:t') . '/' . expand('%:t')
  return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let branch = fugitive#head()
      return branch !=# '' ? mark.branch : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END

function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

let g:syntastic_disabled_filetypes=['java']

"let g:unite_force_overwrite_statusline = 0
"let g:vimfiler_force_overwrite_statusline = 0
"let g:vimshell_force_overwrite_statusline = 0

"if has('statusline')
"  set laststatus=2
"  " Broken down into easily includeable segments
"  set statusline=%<%f\    " Filename
"  set statusline+=%w%h%m%r " Options
"  set statusline+=%{fugitive#statusline()} "  Git Hotness
"  set statusline+=\ [%{&ff}/%Y]            " filetype
"  set statusline+=\ [%{getcwd()}]          " current dir
"  set statusline+=%#warningmsg#
"  set statusline+=%{SyntasticStatuslineFlag()}
"  set statusline+=%*
"  let g:syntastic_enable_signs=1
"  set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
"endif

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

nnoremap <c-p> :FZF<cr>
let g:fzf_action = {
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

set rtp+=/usr/local/opt/fzf

let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!*.{min.js,swp,o,zip}" 
  \ -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)
" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
