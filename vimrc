""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"GENERAL OPTIONS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  filetype plugin on"{{{
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
:let fortran_free_source=1"}}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPPINGS AND OTHER GENERAL STUFF TO FACILITATE EDITION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"color scheme"{{{
colorscheme vibrantink
" map leader key
let mapleader = ","

" Mouse setup
set mouse=a
set mousemodel=popup
noremap <ScrollWheelUp> 3<C-Y>
noremap <ScrollWheelDown> 3<C-E>
inoremap <ScrollWheelUp> <esc>3<C-Y>a
inoremap <ScrollWheelDown> <esc>3<C-E>a
noremap <C-ScrollWheelUp> <C-Y>
noremap <C-ScrollWheelDown> <C-E>
inoremap <C-ScrollWheelUp> <esc><C-Y>a
inoremap <C-ScrollWheelDown> <esc><C-E>a

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
nnoremap <c-right> >>
nnoremap <c-left> <<
vnoremap <c-right> >
vnoremap <c-left> <

" easy fold/unfold with space key
nnoremap <space> za
vnoremap <space> zf

" window navigation
nnoremap <c-j> <c-w>w
nnoremap <c-k> <c-w>W
nnoremap <c-h> :bp<CR>
nnoremap <c-l> :bn<CR>
nnoremap <leader>+ <c-w>+
nnoremap <leader>- <c-w>-
nnoremap <leader>0 <c-w>=

" shortcuts to exit
inoremap jk <esc>
inoremap ZZ <esc>ZZ

" exit normal mode
inoremap <esc> <nop>
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
augroup NoSimultaneousEdits
  autocmd!
  autocmd  SwapExists  *  :let v:swapchoice = 'q'
augroup END

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
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
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
