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
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set showmatch
set vb
set incsearch
set hls
set backspace=indent,eol,start
set expandtab
set pastetoggle=<F2>
set hidden
set wildmenu

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
" MAPPINGS AND OTHER GENERAL STUFF TO FACILITATE EDITION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"color scheme"{{{
"colorscheme solarized
"let g:solarized_termcolors=256
colorscheme summerfruit256
" map leader key
let mapleader = ","

" Mouse setup
set mouse=a
set mousemodel=popup
noremap <ScrollWheelUp> <C-Y>
noremap <ScrollWheelDown> <C-E>
inoremap <ScrollWheelUp> <esc><C-Y>a
inoremap <ScrollWheelDown> <esc><C-E>a
noremap <C-ScrollWheelUp> 3<C-Y>
noremap <C-ScrollWheelDown> 3<C-E>
inoremap <C-ScrollWheelUp> <esc>3<C-Y>a
inoremap <C-ScrollWheelDown> <esc>3<C-E>a

"intuitive cursor movement
noremap <A-UP> gk
noremap <A-DOWN> gj
inoremap <A-UP> <c-o>gk
inoremap <A-DOWN> <c-o>gj
set whichwrap=h,l,<,>,[,],s

" Remember folding
"au BufWinLeave * mkview
"au BufWinEnter * silent loadview


" move lines up-down with cursor keys
noremap <c-up> ddkP
noremap <c-down> ddp

" indent with cursor keys
nnoremap <c-right> ma>>`all
nnoremap <c-left> ma<<`ahh
vnoremap <c-right> >
vnoremap <c-left> <

" easy fold/unfold with space key
nnoremap <space> za
vnoremap <space> zf

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
nnoremap <c-j> <c-w>w
nnoremap <c-k> <c-w>W
nnoremap <c-h> :bp<CR>
nnoremap <c-l> :bn<CR>
nnoremap <leader>+ <c-w>+
nnoremap <leader>- <c-w>-
nnoremap <leader>0 <c-w>=

" shortcuts to exit
inoremap ZZ <esc>ZZ

" exit normal mode
"inoremap <esc> <nop>
inoremap jk <esc>l
inoremap <c-up> <esc>
inoremap <c-down> <esc>
vnoremap <c-up> <esc>
vnoremap <c-down> <esc>
"noremap <left> <nop>
"noremap <right> <nop>
"noremap <up> <nop>
"noremap <down> <nop>


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
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>

" function to toggle comments
function! ToggleComment(commentchar)
  let line = getline(".")
  if (line == "")
    return ""
  endif
  let leadingchar = matchstr(line,'\S')
  if (leadingchar == a:commentchar)
    call setline(".", substitute(line, '\(\s*\)\S', '\1', ""))
  else
    call setline(".", a:commentchar . line)
  endif
endfunction

" function to set comments
function! SetComment(commentchar)
  let line = getline(".")
  if (line == "")
    return ""
  endif
  let leadingchar = matchstr(line,'\S')
  if (leadingchar != a:commentchar)
    call setline(".", a:commentchar . line)
  endif
endfunction

" function to unset comments
function! UnsetComment(commentchar)
  let line = getline(".")
  let leadingchar = matchstr(line,'\S')
  if (leadingchar == a:commentchar)
    call setline(".", substitute(line, '\(\s*\)\S', '\1', ""))
  endif
endfunction

noremap <c-d> :call ToggleComment(b:commentchar)<cr>
noremap <leader>c :call SetComment(b:commentchar)<cr>
noremap <leader>C :call UnsetComment(b:commentchar)<cr>

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
    execute "normal j" . cont . "\<c-a>"
    let line += 1
    let cont += 1
  endwhile
endfunction

vnoremap <leader><c-a> :call Increase()<CR>"}}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM FILES HACKINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
augroup VimFile
  autocmd Filetype vim let b:commentchar = '"'
  autocmd Filetype vim set foldmethod=marker
augroup END

:nnoremap <leader>ev :split $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>

" Avoid opening already opened documents in other vim sesion
"augroup NoSimultaneousEdits
"  autocmd!
"  autocmd  SwapExists  *  :let v:swapchoice = 'q'
"augroup END

" Uset Pathogen
execute pathogen#infect()
"}}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"SHELL FILES CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
augroup ShellMappings
  autocmd!
  autocmd BufNewFile,BufRead *.sh silent! global/^\s\+#/normal ^x0i#
  autocmd BufNewFile,BufRead *.sh imap <expr> <tab> Smart_TabComplete_Bash()
  autocmd BufNewFile,BufRead *.sh let b:commentchar = "#"
  autocmd BufNewFile,BufRead *.sh set foldmethod=marker
  autocmd BufNewFile,BufRead *.sh nnoremap <buffer> <leader>{ viw<esc>a}<esc>hbi{<esc>lel
  autocmd BufNewFile,BufRead *.sh nnoremap <buffer> <leader>} viw<esc>a}<esc>hbi{<esc>lel
  autocmd BufNewFile,BufRead *.sh vnoremap <buffer> $ <esc>`>a}<esc>`<i${<esc>
  autocmd BufNewFile,BufRead *.sh hi myExit ctermbg=yellow  ctermfg=red  
  autocmd BufNewFile,BufRead *.sh match myExit /^\s*\zsexit/
  autocmd Filetype sh set foldmethod=marker
augroup END

function! Smart_TabComplete_Bash()
" if the pop-up window is shown, go down
  if (!exists("b:lastcomplete"))
    let b:lastcomplete=""
  endif
  if(pumvisible())
    if(b:lastcomplete=="file")
      return "\<c-f>"
    endif
    if(b:lastcomplete=="key")
      return "\<c-n>"
    endif
    return "\<down>"
  endif
"   get the line to guess what the user wants
  let line = getline('.')
"   if the line is empty, or last character is an space, return tab
  if(match(line, '\S')==-1 || match(line, '\s$')!=-1)
    noh
    return "  "
  endif
"   find the last word in the line
  let lastword = matchstr(line, '\S*$')
"   if the lastword seems like a folder, file completion
  if(match(lastword,'[/]') != -1)
    noh
    let b:lastcomplete="file"
    return "\<c-x>\<c-f>"
  endif
"   if nothing else works, key completion
  noh
  let b:lastcomplete="key"
  return "\<c-n>"
endfunction
"}}}



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"TEX FILES CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
augroup TexMappings
  autocmd!
  autocmd BufNewFile,BufRead *.tex let b:commentchar = "%"
  autocmd BufNewFile,BufRead *.tex imap <expr> <tab> Smart_TabComplete_Tex()
"  autocmd BufNewFile,BufRead *.tex nnoremap <buffer> <c-up> gqap
"  autocmd BufNewFile,BufRead *.tex nnoremap <buffer> <c-down> gqap
augroup END

function! Smart_TabComplete_Tex()
  " if the pop-up window is shown, go down
  if (!exists("b:lastcomplete"))
    let b:lastcomplete=""
  endif
  if(pumvisible())
    if(b:lastcomplete=="file")
      return "\<c-f>"
    endif
    if(b:lastcomplete=="key")
      return "\<c-n>"
    endif
    if(b:lastcomplete=="omni")
      return "\<c-o>"
    endif
    return "\<down>"
  endif
  " get the line to guess what the user wants
  let line = getline('.')
  " if the line is empty, or last character is an space, return tab
  if(match(line, '\S')==-1 || match(line, '\s$')!=-1)
    noh
    return "  "
  endif
  " find the last word in the line
  let lastword = matchstr(line, '\S*$')
  " if the lastword seems like a folder, file completion
  if(match(lastword,'[/]') != -1)
    noh
    let b:lastcomplete="file"
    return "\<c-x>\<c-f>"
  endif
  " if the last word contains an open bracket, omni completion
  if(match(lastword,'{') != -1)
    noh
    let b:lastcomplete="omni"
    return "\<c-x>\<c-o>"
  endif
  " if nothing else works, key completion
  noh
    let b:lastcomplete="key"
  return "\<c-p>"
endfunction
"}}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"FORTRAN CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
augroup FortranMappings
  autocmd!
  autocmd BufNewFile,BufRead *.f90 let b:commentchar = "!"
  autocmd BufNewFile,BufRead *.f   let b:commentchar = "!"
  autocmd BufNewFile,BufRead *.f03 let b:commentchar = "!"
  autocmd BufNewFile,BufRead *.f90 syn match fortranUnitHeader "type"
  autocmd BufNewFile,BufRead *.f90 syn match fortranUnitHeader "\<end\s*type"
  let fortran_free_source=1
augroup END
"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"NCL CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
augroup nclMappings
  autocmd!
  autocmd BufNewFile,BufRead *.ncl set filetype=ncl
  autocmd BufNewFile,BufRead *.ncl set complete+=k
  autocmd BufNewFile,BufRead *.ncl set dictionary+=~/.vim/dictionaries/ncl
  autocmd BufNewFile,BufRead *.ncl let b:commentchar = ";"
augroup END
"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"FANCY STATUS LINE WITH LIGHTLINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'MyModified',
      \   'readonly': 'MyReadonly',
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \ },
      \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() : 
        \  &ft == 'unite' ? unite#get_status_string() : 
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? '⭠ '._ : ''
  endif
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
"}}}
