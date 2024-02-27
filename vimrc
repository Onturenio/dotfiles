" figure out hostname
if hostname() =~ 'bull'
  let g:system = 'ECMWF'
elseif hostname() =~ 'pangea'
  let g:system = 'PANGEA'
elseif hostname() =~ 'bender2'
  let g:system = 'BENDER2'
elseif hostname() =~ 'AEMET'
  let g:system = 'AEMET'
else
  let g:system = 'OTRO'
endif

if g:system =~ 'ECMWF'
  let g:coc_node_path = '/home/sp4e/SOFTWARE/bin/node'
  let g:copilot_node_command = '/home/sp4e/SOFTWARE/bin/node'
endif

let mapleader = ","


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPPINGS AND OTHER GENERAL STUFF TO FACILITATE EDITION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
" map leader key
let mapleader = ","

" Mouse setup
"
set mouse=a
function ToggleMouse()
  if &mouse == 'a'
    set mouse=
    echo "Mouse disabled"
  else
    set mouse=a
    echo "Mouse enabled"
  endif
endfunction
nnoremap <silent> <leader>m :call ToggleMouse()<CR>

set mousemodel=popup
noremap <ScrollWheelUp> <C-Y>
noremap <ScrollWheelDown> <C-E>
inoremap <ScrollWheelUp> <C-O><C-Y>
inoremap <ScrollWheelDown> <C-O><C-E>
noremap <C-ScrollWheelUp> 3<C-Y>
noremap <C-ScrollWheelDown> 3<C-E>
inoremap <C-ScrollWheelUp> <C-O>3<C-Y>
inoremap <C-ScrollWheelDown> <C-O>3<C-E>

tnoremap <ScrollWheelUp> <C-\><C-n>


"intuitive cursor movement in insert and visual modes
set whichwrap=h,l,<,>,[,],s
" inoremap <UP> <C-O>gk
" inoremap <DOWN> <C-O>gj
" vnoremap <LEFT> h
" vnoremap <RIGHT> l
" vnoremap <UP> k
" vnoremap <DOWN> j

" fast enter to visual mode with shift key
inoremap <S-RIGHT> <ESC>lve
inoremap <S-LEFT> <ESC>lvb
nnoremap <S-RIGHT> <ESC>ve
nnoremap <S-LEFT> <ESC>vb

" exit to normal mode
inoremap ZZ <ESC>ZZ
inoremap jk <C-[>
" vnoremap <C-UP> <ESC>

" jump between changes centering scroll"
nnoremap [c [czz
nnoremap ]c ]czz

" scroll up and down
nnoremap <C-F> <C-D>zz
nnoremap <C-B> <C-U>zz

" train myself to use hjkl in normal mode
" nnoremap <Left>  :echo "Don't use the cursors!"<CR>
" nnoremap <Right> :echo "Don't use the cursors!"<CR>
" nnoremap <Up>    :echo "Don't use the cursors!"<CR>
" nnoremap <Down>  :echo "Don't use the cursors!"<CR>
" inoremap <esc> <nop>
" inoremap <silent> <expr> <ESC> <nop>

" Remember folding
"au BufWinLeave * mkview
"au BufWinEnter * silent loadview

" move lines up-down
noremap <C-UP> ddkP
noremap <C-DOWN> ddp

" fast indent
vnoremap <C-RIGHT> ma>`all
vnoremap <C-LEFT> ma<`ahh
nnoremap <C-RIGHT> ma>>`all
nnoremap <C-LEFT> ma<<`ahh

" easy fold/unfold with space key
nnoremap <SPACE> za
vnoremap <SPACE> zf

" map to invoque Copilot
nnoremap <leader>cp :Copilot<CR>

nnoremap <leader>f :call FoldColumnToggle()<cr>

function! FoldColumnToggle()
  if &foldcolumn
    setlocal foldcolumn=0
  else
    setlocal foldcolumn=4
  endif
endfunction

nnoremap <leader>n :set number!<cr>

" window navigation
nnoremap <leader>+ <C-W>+
nnoremap <leader>- <C-W>-
nnoremap <leader>0 <C-W>=
" nnoremap <TAB> <C-W>w

" " window navigation normal mode -> overrided by vim-tmux-navigator
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>

" window navigation terminal mode
tnoremap <C-J> <C-W>j
tnoremap <C-K> <C-W>k
tnoremap <C-L> <C-W>l
tnoremap <C-H> <C-W>h

" move windows arround
nnoremap <leader><C-J> <C-W>J
nnoremap <leader><C-K> <C-W>K
nnoremap <leader><C-H> <C-W>H
nnoremap <leader><C-L> <C-W>L

" opening buffers and new files wih fzf
nnoremap <leader>b :Buffer<CR>
nnoremap <leader>o :Files<CR>

" mappings for ALE static syntax checker
nnoremap <leader>e :lopen<CR>
nnoremap <leader>E :lclose<CR>
" nmap <silent> <leader>en <Plug>(ale_next_wrap)

" text object mappings
" onoremap { i{
" onoremap k i{
" onoremap n{ :normal! f{lvi{<cr>
" onoremap nk :normal! f{lvi{<cr>

onoremap ( i(
onoremap p i(
onoremap n( :normal! f(lvi(<cr>
onoremap np :normal! f(lvi(<cr>

onoremap " i"
onoremap n" :normal! f"lvi"<cr>
onoremap ' i'
onoremap n' :normal! f"lvi"<cr>

" special mapping for editing here-document in BASH, delimited between EOF's
onoremap E :execute "normal! ?EOF?+1\r:noh\rV/EOF/-1\r"<cr>

" better * and # commands
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

function! s:NSetSearch()
  let @/ = expand("<cword>")
endfunction
" vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
" vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>
vnoremap <silent> * :<C-u>call <SID>VSetSearch()<CR>
vnoremap <silent> # :<C-u>call <SID>VSetSearch()<CR>
nnoremap <silent> * :<C-u>call <SID>NSetSearch()<CR>
vnoremap <silent> # :<C-u>call <SID>NSetSearch()<CR>

" makes posible to use arrows and redo stuff (taken from documentation 'inster.txt')
inoremap <Left>  <C-G>U<Left>
inoremap <Right> <C-G>U<Right>
inoremap <expr> <Home> col('.') == match(getline('.'), '\S') + 1 ?
    \ repeat('<C-G>U<Left>', col('.') - 1) :
    \ (col('.') < match(getline('.'), '\S') ?
    \     repeat('<C-G>U<Right>', match(getline('.'), '\S') + 0) :
    \     repeat('<C-G>U<Left>', col('.') - 1 - match(getline('.'), '\S')))
inoremap <expr> <End> repeat('<C-G>U<Right>', col('$') - col('.'))
"inoremap ( ()<C-G>U<Left>
"inoremap { {}<C-G>U<Left>
"inoremap [ []<C-G>U<Left>

"function to create header comments
function! HeaderComment()
  let line=repeat(b:commentchar,80)
  call SetComment(b:commentchar)
  call setline(".", toupper(getline(".")))
  normal O
  call setline(".", line)
  normal jo
  call setline(".", line)
  normal k
endfunction

noremap <silent> <leader>hc :call HeaderComment()<cr>

" Allows to increase numbers in consecutive lines
function! Increase() range
  execute "normal \<ESC>"
  let line1=a:firstline
  let line2=a:lastline

  let line=line1
  let cont=1
  while line < line2
      execute "normal j" . cont . "\<C-A>"
      let line += 1
      let cont += 1
  endwhile
endfunction

vnoremap <silent>  <leader><C-A> :call Increase()<CR>
"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{

" let vim-plugin to handle plugins
call plug#begin('~/.vim/bundle')

Plug '/home/sp4e/vim-squeue'
let g:squeue_user = 'sp0w'
nnoremap <leader>sq :Squeue!<CR>
nnoremap <leader>mc :Squeue! sp4e<CR>

Plug '/home/sp4e/vim-ecflow'

" useful suround shotcuts
Plug 'tpope/vim-surround'

" show marks before using them
Plug 'junegunn/vim-peekaboo'

" marking paranthesis with colours
Plug 'frazrepo/vim-rainbow'
let g:rainbow_active = 0
" au FileType python,sh echom "hola"| call rainbow#load()

" set of standard default options
Plug 'tpope/vim-sensible'

" useful shortcuts
Plug 'tpope/vim-unimpaired'

" Grep like a pro
Plug 'mhinz/vim-grepper'
let g:grepper = {}
let g:grepper.tools = [ 'ag', 'rg', 'git']

" fzf integration
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
\ 'bg':      ['bg', 'Normal'],
\ 'hl':      ['fg', 'Comment'],
\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
\ 'hl+':     ['fg', 'Statement'],
\ 'info':    ['fg', 'PreProc'],
\ 'border':  ['fg', 'Ignore'],
\ 'prompt':  ['fg', 'Conditional'],
\ 'pointer': ['fg', 'Exception'],
\ 'marker':  ['fg', 'Keyword'],
\ 'spinner': ['fg', 'Label'],
\ 'header':  ['fg', 'Comment'] }

" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
" let g:fzf_layout = { 'down': '40%' }
" disable status ber when opening fzf
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

" Python formatting, indenting and folding
Plug 'Konfekt/FastFold'
Plug 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview = 1
Plug 'vim-scripts/indentpython.vim'

" Latex integration
Plug 'LaTeX-Box-Team/LaTeX-Box'

augroup filetype_latex
  autocmd!
  let g:LatexBox_Folding = 1
  let g:LatexBox_fold_envs = 0
  autocmd Filetype latex,tex nnoremap <buffer> <F5> :w<cR>:Latexmk<CR>
  autocmd Filetype latex,tex nnoremap <buffer> <F6> :LatexView<CR>
  autocmd Filetype latex,tex inoremap <buffer> <F5> <ESC>:w<cR>:Latexmk<CR>
  autocmd Filetype latex,tex inoremap <buffer> <F6> <ESC>:LatexView<CR>
  autocmd Filetype latex,tex nnoremap <buffer> <leader>a viw<ESC>`<i\alert{<ESC>ea}<ESC>
  autocmd Filetype latex,tex vnoremap <buffer> <leader>a <ESC>`>a}<ESC>`<i\alert{<ESC>
augroup END

" Markdown integration
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
auto BufRead,BufNewFile *.md set filetype=markdown.pandoc
let maplocalleader = ','

" Toggle comments
Plug 'tpope/vim-commentary'
nmap <C-d> gcc
xmap <C-d> gc

" Static code analysis with CoC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Send lines to a terminal (interactive programing, i.e. REPL)
Plug 'jpalardy/vim-slime'
let g:slime_no_mappings = 1
Plug 'Klafyvel/vim-slime-cells'
let g:slime_cells_highlight_from = "CursorLineNr"
let g:slime_cell_delimiter = "#%%"

" Slime-related mapings
" xmap <leader>s <Plug>SlimeRegionSend
" nmap <leader>s <Plug>SlimeParagraphSend
" nmap <C-C>v <Plug>SlimeConfig
" nmap <silent> <C-C><C-C> <Plug>SlimeCellsSendAndGoToNext
" nmap <silent> <C-X><C-X> :SlimeSendCurrentLine<CR>j
" nmap <silent> <C-C><C-DOWN> <Plug>SlimeCellsNext
" nmap <silent> <C-C><C-UP> <Plug>SlimeCellsPrev
" xmap <silent> <C-C> <Plug>SlimeRegionSend

nmap <silent> [i <Plug>SlimeCellsPrev
nmap <silent> ]i <Plug>SlimeCellsNext
nmap <leader>s mzvic<ESC>:'<,'>SlimeSend<CR>`z
xmap <leader>s <ESC>:'<,'>SlimeSend<CR>gv
" nmap <C-C>v <Plug>SlimeConfig

" github colors
Plug 'cormacrelf/vim-colors-github'
let g:github_colors_soft = 1
let g:lightline = { 'colorscheme': 'github' }
"
" gruvbox colorscheme
" Plug 'morhetz/gruvbox'
" Plug 'NLKNguyen/papercolor-theme'

" Airline information line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" let g:airline_theme = "dark"
" let g:airline_theme = "gruvbox"
" let g:airline_theme = "atomic"
let g:airline#extensions#wordcount#enabled = 0
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline#extensions#branch#format = 2
let g:airline#extensions#bufferline#enabled = 1
let g:airline_detect_modified=0
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" additional line with open buffers
" Plug 'bling/vim-bufferline'
" let g:bufferline_echo = 0
" autocmd VimEnter *
"   \ let &statusline='%{bufferline#refresh_status()}'
"     \ .bufferline#get_status_string()

Plug 'github/copilot.vim'

let g:copilot_filetypes = {
    \ 'gitcommit': v:true,
    \ 'markdown': v:true,
    \ 'yaml': v:true
    \ }

" vim hardtime
Plug 'takac/vim-hardtime'
let g:hardtime_default_on = 0
let g:hardtime_showmsg = 1

" tmux integration
Plug 'christoomey/vim-tmux-navigator'
Plug 'RyanMillerC/better-vim-tmux-resizer'
nnoremap j :TmuxResizeDown<CR>
nnoremap k :TmuxResizeUp<CR>
nnoremap h :TmuxResizeLeft<CR>
nnoremap l :TmuxResizeRight<CR>

call plug#end()
"'}}}



"tex
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTOCLOSE BRACKETS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
" taken from https://www.vim.org/scripts/script.php?script_id=2373

" inoremap ( ()<C-G>U<left>
" inoremap { {}<C-G>U<left>
" inoremap [ []<C-G>U<left>

" vnoremap <leader>" "zdi"<C-R>z"<ESC>
" vnoremap <leader>' "zdi'<C-R>z'<ESC>
" vnoremap <leader>( "zdi(<C-R>z)<ESC>
" vnoremap <leader>[ "zdi[<C-R>z]<ESC>
" vnoremap <leader>{ "zdi{<C-R>z}<ESC>

" inoremap <expr> <bs> <SID>delpair()

" inoremap <expr> ) <SID>escapepair(')')
" inoremap <expr> } <SID>escapepair('}')
" inoremap <expr> ] <SID>escapepair(']')

" inoremap <expr> " <SID>pairquotes('"')
" inoremap <expr> ' <SID>pairquotes("'")


" function! s:delpair()
" 	let l:lst = ['""',"''",'{}','[]','()']
" 	let l:col = col('.')
" 	let l:line = getline('.')
" 	let l:chr = l:line[l:col-2 : l:col-1]
" 	if index(l:lst, l:chr) > -1
" 		return "\<bs>\<del>"
" 	else
" 		let l:chr = l:line[l:col-3:l:col-2]
" 		if (index(l:lst, l:chr)) > - 1
" 			return "\<bs>\<bs>"
" 		endif
" 		return "\<bs>"
" endf

" function! s:escapepair(right)
" 	let l:col = col('.')
" 	let l:chr = getline('.')[l:col-1]
" 	if a:right == l:chr
" 		return "\<right>"
" 	else
" 		return a:right

" endf

" function! s:pairquotes(pair)
" 	let l:col = col('.')
" 	let l:line = getline('.')
" 	let l:chr = l:line[l:col-1]
" 	if a:pair == l:chr
" 		return "\<right>"
" 	else
" 		return a:pair.a:pair."\<left>"

" endf
"}}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"GENERAL OPTIONS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
set nowrapscan
set wildoptions=pum
filetype plugin on
filetype indent on
set nocompatible
syntax on
set number
set relativenumber
set showcmd
set showmode
set autoindent
set smartindent
set smarttab
set shiftround
set showmatch
set vb
set incsearch
set hlsearch
set backspace=indent,eol,start
set expandtab
set pastetoggle=<F2>
set hidden
set wildmenu
set splitbelow
set termguicolors
set tabstop=4
set softtabstop=4
set shiftwidth=4
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * set nocursorline

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

"Highlight trailing spaces as errors
match Error /\s\+$/
" tell it to use an undo file
" set undofile
" set undodir=~/.vimundo/

" Allow Alt key in Gnome-Shell
" let c='a'
" while c <= 'z'
"   exec "set <A-".c.">=\e".c
"   exec "imap \e".c." <A-".c.">"
"   let c = nr2char(1+char2nr(c))
" endw

" set timeout ttimeoutlen=50

set timeout         " Do time out on mappings and others
set timeoutlen=1000 " Wait {num} ms before timing out a mapping
set ttimeoutlen=50

" When you’re pressing Escape to leave insert mode in the terminal, it will by
" default take a second or another keystroke to leave insert mode completely
" and update the statusline. This fixes that. I got this from:
" https://powerline.readthedocs.org/en/latest/tipstricks.html#vim
if !has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    " au InsertEnter * set timeoutlen=200
    au InsertLeave * set timeoutlen=1000
  augroup END
endif
 "}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM FILES HACKINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{
 augroup VimFile
   autocmd Filetype vim let b:commentchar = '"'
   autocmd Filetype vim set foldmethod=marker
   autocmd Filetype vim setlocal shiftwidth=2
 augroup END

:nnoremap <leader>ev :split $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>

" Avoid opening already opened documents in other vim sesion
"augroup NoSimultaneousEdits
"  autocmd!
"  autocmd  SwapExists  *  :let v:swapchoice = 'q'
"augroup END
"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"FANCY STATUS LINE WITH LIGHTLINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
set laststatus=2
" let g:lightline = {
"       \ 'colorscheme': 'powerline',
"       \ 'mode_map': { 'c': 'NORMAL' },
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
"       \ },
"       \ 'component_function': {
"       \   'modified': 'MyModified',
"       \   'readonly': 'MyReadonly',
"       \   'fugitive': 'MyFugitive',
"       \   'filename': 'MyFilename',
"       \   'fileformat': 'MyFileformat',
"       \   'filetype': 'MyFiletype',
"       \   'fileencoding': 'MyFileencoding',
"       \   'mode': 'MyMode',
"       \ },
"       \ }

" function! MyModified()
"   return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
" endfunction

" function! MyReadonly()
"   return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '' : ''
" endfunction

" function! MyFilename()
"   return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
"         \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
"         \  &ft == 'unite' ? unite#get_status_string() :
"         \  &ft == 'vimshell' ? vimshell#get_status_string() :
"         \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
"         \ ('' != MyModified() ? ' ' . MyModified() : '')
" endfunction

" function! MyFugitive()
"   if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
"     let _ = fugitive#head()
"     return strlen(_) ? '⭠ '._ : ''
"   endif
"   return ''
" endfunction

" function! MyFileformat()
"   return winwidth(0) > 70 ? &fileformat : ''
" endfunction

" function! MyFiletype()
"   return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
" endfunction

" function! MyFileencoding()
"   return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
" endfunction

" function! MyMode()
"   return winwidth(0) > 60 ? lightline#mode() : ''
" endfunction
"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FILETYPE OPTIONS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
augroup filetype_python
  autocmd!
  if g:system == 'ECMWF'
    "in ECMWF we use two spaces"
    autocmd FileType python set tabstop=2 softtabstop=2 shiftwidth=2
  endif

  autocmd FileType python set textwidth=79 expandtab autoindent fileformat=unix

  autocmd FileType python let python_highlight_all=1
  " autocmd FileType python syntax on
  autocmd FileType python hi CellBoundary cterm=underline ctermfg=243 ctermbg=229 gui=underline guifg=#76787b guibg=#fff5b1
  if g:system == "ECMWF"
    autocmd FileType python let g:slime_python_ipython = 1
    autocmd FileType python let g:slime_target = "screen"
    autocmd FileType python let g:slime_no_mappings = 1
    " autocmd FileType python let g:slime_vimterminal_cmd = g:ipython_exe
    autocmd FileType python let g:slime_default_config = {"sessionname": "ipython", "windowname": "0"}
    autocmd FileType python let g:slime_dont_ask_default = 1
  else
    autocmd FileType python let g:slime_python_ipython = 1
    autocmd FileType python let g:slime_target = "tmux"
    " autocmd FileType python let g:slime_target = "vimterminal"
    autocmd FileType python let g:slime_no_mappings = 1
    " autocmd FileType python let g:slime_vimterminal_cmd = g:ipython_exe
    " autocmd FileType python let g:slime_default_config = {"sessionname": "ipython", "windowname": "0"}
    autocmd FileType python let g:slime_default_config = {"socket_name": "default", "target_pane": "0"}
    autocmd FileType python let g:slime_dont_ask_default = 1
  endif

  autocmd FileType python let g:ale_virtualtext_cursor = 'disabled'
  if g:system == 'ECMWF'
    autocmd FileType python let g:ale_linters = {'python': ['ruff']}
    " autocmd FileType python let g:ale_python_flake8_options = "--ignore W391,W503,W504,E266,E265,E111,E114"
  else
    " autocmd FileType python let g:ale_linters = {'python': ['flake8', 'pydocstyle']}
    autocmd FileType python let g:ale_linters = {'python': ['ruff', 'pydocstyle']}
    autocmd FileType python let g:ale_python_flake8_options = "--ignore W391,W503,W504,E266,E265,E111"
  endif
  autocmd FileType python nnoremap<leader>gf  :YcmCompleter GoToDefinitionElseDeclaration<CR>
  autocmd FileType python let g:slime_cell_delimiter = "#%%"
augroup END

augroup pandoc
  autocmd!
  let g:pandoc#syntax#conceal#use = 0
  " let g:pandoc#folding#fdc = 0
  let g:pandoc#modules#disabled = ["folding"]
  let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
  " let g:pandoc#filetypes#pandoc_markdown = 0
  let g:pandoc#toc#close_after_navigating = 0
  let g:pandoc#syntax#codeblocks#embeds#langs = ["r", "python"]
  autocmd Filetype pandoc nmap <silent> <buffer> <F5> :w<CR>:Pandoc pdf<CR>
  autocmd Filetype pandoc nmap <silent> <buffer> <F6> :! evince %:r.pdf &<CR><CR>
augroup END
"}}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" HANDLE IPYTHON
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
if g:system == 'ECMWF'
  let g:ipython_exe="/usr/local/apps/python3/3.8.8-01/bin/ipython"
elseif  g:system == 'PANGEA'
  let g:ipython_exe="/home/radar/SOFTWARE/anaconda3/envs/test2/bin/ipython"
elseif g:system == 'BENDER2'
  let g:ipython_exe="/opt/miniconda3/envs/mr/bin/ipython"
elseif g:system == 'AEMET'
  let g:ipython_exe="/home/navarro/SOFTWARE/anaconda3/envs/AEMET/bin/ipython"
else
  " let g:ipython_exe="/home/navarro/SOFTWARE/anaconda3/envs/test/bin/ipython"
  " let g:ipython_exe="/home/navarro/SOFTWARE/anaconda3/envs/meteoradar/bin/ipython"
  let g:ipython_exe="/home/navarro/SOFTWARE/anaconda3/envs/assistant/bin/ipython"
  " let g:ipython_exe="/home/navarro/SOFTWARE/anaconda3/envs/autobriefing/bin/ipython"
endif

nnoremap <silent> <leader>p :call <SID>ToggleIPython()<CR>
nnoremap <silent> <leader>P :call <SID>CloseIPython()<CR>
autocmd FileType python call <SID>SetIPythonTarget()

function! s:PythonBuffers()
  let python_bufs = []
  for bufnr in getbufinfo()
    if getbufvar(bufnr.bufnr, '&filetype') ==# 'python'
      call add(python_bufs, bufnr.bufnr)
    endif
    if getbufvar(bufnr.bufnr, '&filetype') ==# 'r'
      call add(python_bufs, bufnr.bufnr)
    endif
  endfor
  return python_bufs
endfunction

function! s:SetIPythonTarget()
  if exists("g:ipython_bufnr")
    for bufnr in <SID>PythonBuffers()
      call setbufvar(bufnr, 'slime_config', {'bufnr': g:ipython_bufnr})
    endfor
  endif
endfunction

function! s:OpenIPython()
  if !exists("g:ipython_bufnr")
    execute "botright vertical terminal ++close " . g:ipython_exe
    setlocal nonumber
    let g:ipython_bufnr = getbufinfo("%")[0].bufnr
    wincmd p
    call <SID>SetIPythonTarget()
  endif
endfunction

function! s:CloseIPython()
  if exists("g:ipython_bufnr")
    execute "bdelete! " . g:ipython_bufnr
    unlet g:ipython_bufnr
  endif
endfunction

function! s:ToggleIPython()
  if exists("g:ipython_bufnr")
    if !bufexists(g:ipython_bufnr)
      echo "ipython buffer does not exist. Cleaning g:ipython_bufrn. Try again"
      unlet g:ipython_bufnr
      return ""
    endif
    if getbufinfo(g:ipython_bufnr)[0].hidden
      execute "botright vertical sbuffer" . g:ipython_bufnr
      wincmd p
    else
      for winid in win_findbuf(g:ipython_bufnr)
        execute win_gotoid(winid)
        hide
      endfor
    endif
  else
    call <SID>OpenIPython()
  endif
endfunction

"}}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" HANDLE LATEX
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup LatexFile
  autocmd Filetype tex let b:commentchar = '%'
  autocmd Filetype tex set spell
  autocmd Filetype tex nnoremap <C-C><C-C> :w<CR>:Latexmk<CR>
  autocmd Filetype tex nnoremap <C-X><C-X> :LatexView<CR>
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" HANDLE R
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup RFile
  autocmd!
   autocmd FileType r let g:ipython_exe="/usr/local/apps/R/4.0.4/bin/R"
   autocmd FileType r let g:slime_python_ipython = 1
   autocmd FileType r let g:slime_target = "vimterminal"
   autocmd FileType r let g:slime_no_mappings = 1
   autocmd FileType r let g:slime_vimterminal_cmd = g:ipython_exe
   autocmd FileType r let g:slime_default_config = {"sessionname": "ipython", "windowname": "0"}
   autocmd FileType r let g:slime_dont_ask_default = 1
augroup END



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COC CONF
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300
set signcolumn=yes


" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
" inoremap <silent><expr> <TAB>
"       \ coc#pum#visible() ? coc#pum#next(1) :
"       \ CheckBackspace() ? "\<Tab>" :
"       \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" make <esc> to clear completion item
inoremap <silent><expr> <Esc> coc#pum#visible() ? coc#pum#cancel() : "\<esc>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

let g:copilot_no_tab_map = v:true
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ exists('b:_copilot.suggestions') ? copilot#Accept("\<CR>") :
      \ CheckBackSpace() ? "\<Tab>" :
      \ coc#refresh()

set background=light
colorscheme github
" colorscheme gruvbox
" colorscheme desert
