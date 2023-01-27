" nnoremap <F5> :w<CR>:Latexmk<CR>
" inoremap <F5> <ESC>:w<CR>:Latexmk<CR>

" nnoremap <F6> :LatexView<CR>

let g:LatexBox_show_warnings=0
imap <buffer> [[ \begin{
imap <buffer> ]] <Plug>LatexCloseCurEnv
" vmap <buffer> <F7>   <Plug>LatexWrapSelection
" nnoremap <F4> <Plug>LatexChangeEnv
vnoremap <leader>a "ac\alert{<C-r>a}<esc>
vnoremap <leader>i "ac\textit{<C-r>a}<esc>
vnoremap <leader>b "ac\textbf{<C-r>a}<esc>
" nnoremap <leader>a bi\alert{<esc>ea}<esc>
" nnoremap <leader>i bi\textit{<esc>ea}<esc>
" nnoremap <leader>b bi\textbf{<esc>ea}<esc>
"
nnoremap <C-C><C-C> :w<CR> :Latexmk<CR>
nnoremap <C-X><C-X> :LatexView<CR>
