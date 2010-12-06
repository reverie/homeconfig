set guifont=Monaco:h12.00
colorscheme peaksea
set go-=T
set go-=r
set go-=L
set bg=dark
if &background == "dark"
    hi normal guibg=black
    hi normal guifg=white
endif
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/
