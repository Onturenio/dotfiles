""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{

" let vim-plugin to handle plugins
call plug#begin('~/.vim/bundle')

" set of standard default options
Plug 'tpope/vim-sensible'
"
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

" Markdown integration
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
let maplocalleader = ','
let g:pandoc#syntax#conceal#use = 0
let g:pandoc#folding#fdc = 0
" let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
" let g:pandoc#filetypes#pandoc_markdown = 0
let g:pandoc#toc#close_after_navigating = 0
if !exists('g:ycm_semantic_triggers')
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.pandoc = ['@']
let g:ycm_filetype_blacklist = {}
let g:pandoc#syntax#codeblocks#embeds#langs = ["r", "python"]

" Toggle comments
Plug 'tpope/vim-commentary'
nmap <C-d> gcc
xmap <C-d> gc


" Static analysis of code with Syntastic
" Plug 'vim-syntastic/syntastic'
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 1
" let g:syntastic_mode_map = {"mode": "active"}
" let g:syntastic_python_chslime'

" Static code analysis of code with ALE
Plug 'dense-analysis/ale'
let g:ale_linters_explicit = 1

" Send lines to a terminal (interactive programing, i.e. REPL)
" Plug 'jpalardy/vim-slime'
" Plug 'Klafyvel/vim-slime-cells'
let g:slime_cells_highlight_from = "CursorLineNr"
let g:slime_cell_delimiter = "#%%"
let g:slime_no_mappings = 1
" nmap <C-C>v <Plug>SlimeConfig
nmap <C-C><C-C> <Plug>SlimeCellsSendAndGoToNext
nmap <C-X><C-X> :SlimeSendCurrentLine<CR>j
nmap <C-C><C-DOWN> <Plug>SlimeCellsNext
nmap <C-C><C-UP> <Plug>SlimeCellsPrev
xmap <C-C> <Plug>SlimeRegionSend

nmap [i <Plug>SlimeCellsPrev
nmap ]i <Plug>SlimeCellsNext

" Autocompletation with YCM
Plug 'Valloric/YouCompleteMe'
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_complete_in_comments = 1

" colores
" Plugin 'xolox/vim-misc'
" Plugin 'xolox/vim-colorscheme-switcher'
" Plugin 'jnurmine/Zenburn'
" Plugin 'altercation/vim-colors-solarized'

" github colors
Plug 'cormacrelf/vim-colors-github'
let g:github_colors_soft = 1
" let g:lightline = { 'colorscheme': 'github' }

" Airline information line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = "dark"
let g:airline#extensions#wordcount#enabled = 0
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline#extensions#branch#format = 2
let g:airline#extensions#bufferline#enabled = 1
let g:airline_detect_modified=0

" additional line with open buffers
" Plug 'bling/vim-bufferline'
" let g:bufferline_echo = 0
" autocmd VimEnter *
"   \ let &statusline='%{bufferline#refresh_status()}'
"     \ .bufferline#get_status_string()


call plug#end()
"'}}}


" figure out hostname
if hostname() =~ 'bull'
  let g:system = 'ECMWF'
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPPINGS AND OTHER GENERAL STUFF TO FACILITATE EDITION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
" map leader key
let mapleader = ","

" Mouse setup
set mouse=a
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
inoremap <UP> <C-O>gk
inoremap <DOWN> <C-O>gj
vnoremap <LEFT> h
vnoremap <RIGHT> l
vnoremap <UP> k
vnoremap <DOWN> j

" fast enter to visual mode with shift key
inoremap <S-RIGHT> <ESC>lve
inoremap <S-LEFT> <ESC>lvb
nnoremap <S-RIGHT> <ESC>ve
nnoremap <S-LEFT> <ESC>vb

" exit to normal mode
inoremap ZZ <ESC>ZZ
inoremap jk <C-[>
vnoremap <C-UP> <ESC>

" jump between changes centering scroll"
nnoremap [c [czz
nnoremap ]c ]czz

" fast normal-insert modes
" inoremap <C-UP> <ESC>
"nnoremap <C-DOWN> i

" train myself to use hjkl in normal mode
" noremap <left> <nop>
" nnoremap <right> <nop>
" nnoremap <up> <nop>
" nnoremap <down> <nop>
" inoremap <esc> <nop>
" inoremap <silent> <expr> <ESC> <nop>

" function! Exit()
"   " let u = rand()
"   " if u < 0.5
"     return "\<ESC>"
"   " else
"     " echo "NO"
"     " return ""
"   " endif
" endfunction

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

" window navigation normal mode
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

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
onoremap { i{
onoremap k i{
onoremap n{ :normal! f{lvi{<cr>
onoremap nk :normal! f{lvi{<cr>

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
vnoremap * :<C-u>call <SID>VSetSearch()<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>
nnoremap * :<C-u>call <SID>NSetSearch()<CR>
vnoremap # :<C-u>call <SID>NSetSearch()<CR>

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

noremap <leader>hc :call HeaderComment()<cr>

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

vnoremap <leader><C-A> :call Increase()<CR>
"}}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTOCLOSE BRACKETS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
" taken from https://www.vim.org/scripts/script.php?script_id=2373

inoremap ( ()<C-G>U<left>
inoremap { {}<C-G>U<left>
inoremap [ []<C-G>U<left>

vnoremap <leader>" "zdi"<C-R>z"<ESC>
vnoremap <leader>' "zdi'<C-R>z'<ESC>
vnoremap <leader>( "zdi(<C-R>z)<ESC>
vnoremap <leader>[ "zdi[<C-R>z]<ESC>
vnoremap <leader>{ "zdi{<C-R>z}<ESC>

inoremap <expr> <bs> <SID>delpair()

inoremap <expr> ) <SID>escapepair(')')
inoremap <expr> } <SID>escapepair('}')
inoremap <expr> ] <SID>escapepair(']')

inoremap <expr> " <SID>pairquotes('"')
inoremap <expr> ' <SID>pairquotes("'")


function! s:delpair()
	let l:lst = ['""',"''",'{}','[]','()']
	let l:col = col('.')
	let l:line = getline('.')
	let l:chr = l:line[l:col-2 : l:col-1]
	if index(l:lst, l:chr) > -1
		return "\<bs>\<del>"
	else
		let l:chr = l:line[l:col-3:l:col-2]
		if (index(l:lst, l:chr)) > - 1
			return "\<bs>\<bs>"
		endif
		return "\<bs>"
endf

function! s:escapepair(right)
	let l:col = col('.')
	let l:chr = getline('.')[l:col-1]
	if a:right == l:chr
		return "\<right>"
	else
		return a:right

endf

function! s:pairquotes(pair)
	let l:col = col('.')
	let l:line = getline('.')
	let l:chr = l:line[l:col-1]
	if a:pair == l:chr
		return "\<right>"
	else
		return a:pair.a:pair."\<left>"

endf"}}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"GENERAL OPTIONS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
filetype plugin on
filetype indent on
set nocompatible
syntax on
set number
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
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

"set timeout ttimeoutlen=50

"set timeout         " Do time out on mappings and others
"set timeoutlen=2000 " Wait {num} ms before timing out a mapping

" When you’re pressing Escape to leave insert mode in the terminal, it will by
" default take a second or another keystroke to leave insert mode completely
" and update the statusline. This fixes that. I got this from:
" https://powerline.readthedocs.org/en/latest/tipstricks.html#vim
"if !has('gui_running')
"  set ttimeoutlen=10
"  augroup FastEscape
"    autocmd!
"    au InsertEnter * set timeoutlen=0
"    au InsertLeave * set timeoutlen=1000
"  augroup END
"endif
 "}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM FILES HACKINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{
 augroup VimFile
   autocmd Filetype vim let b:commentchar = '"'
   autocmd Filetype vim set foldmethod=marker
   autocmd Filetype vim set shiftwidth=2
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
  autocmd FileType python
  \ set tabstop=2
  \     softtabstop=2
  \     shiftwidth=2
else
  "in the rest we use 4"
  autocmd FileType python
  \ set tabstop=4
  \     softtabstop=4
  \     shiftwidth=4
endif

autocmd FileType python
  set   textwidth=79
  \     expandtab
  \     autoindent
  \     fileformat=unix

autocmd FileType python let python_highlight_all=1
autocmd FileType python syntax on
autocmd FileType python hi CellBoundary cterm=underline ctermfg=243 ctermbg=229 gui=underline guifg=#76787b guibg=#fff5b1
autocmd FileType python let g:slime_python_ipython = 1
autocmd FileType python let g:slime_target = "vimterminal"
autocmd FileType python let g:slime_no_mappings = 1
autocmd FileType python let g:slime_vimterminal_cmd = g:ipython_exe
" autocmd FileType python let g:slime_default_config = {"sessionname": "ipython", "windowname": "0"}
" autocmd FileType python let g:slime_dont_ask_default = 1
"
" autocmd FileType python let b:ale_linters = {'python': ['flake8', 'pydocstyle']}
if g:system == 'ECMWF'
  autocmd FileType python let b:ale_linters = {'python': ['flake8']}
  autocmd FileType python let b:ale_python_flake8_options = "--ignore W391,W503,W504,E266,E265,E111"
else
  autocmd FileType python let b:ale_linters = {'python': ['flake8', 'pydocstyle']}
  autocmd FileType python let b:ale_python_flake8_options = "--ignore W391,W503,W504,E266,E265,E111"
endif
autocmd FileType python nnoremap<leader>gf  :YcmCompleter GoToDefinitionElseDeclaration<CR>
autocmd FileType python let g:slime_cell_delimiter = "#%%"
augroup END

"}}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" HANDLE IPYTHON
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
if g:system == 'ECMWF'
  let g:ipython_exe="/usr/local/apps/python3/3.8.8-01/bin/ipython"
else
  let g:ipython_exe="/home/navarro/SOFTWARE/anaconda3/envs/meteoradar/bin/ipython"
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

colorscheme github

