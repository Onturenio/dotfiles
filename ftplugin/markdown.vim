nnoremap <F5> :w<CR>:Pandoc! pdf --highlight-style pygments.theme --include-in-header inline_code.tex --include-in-header quote.tex --include-in-header enum.tex -V geometry:margin=2cm -V geometry:a4paper -V linkcolor:blue<CR>