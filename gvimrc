set guifont=Monaco:h12.00
colorscheme peaksea
set go-=T
set go-=r
set go-=L
set bg=dark
set nofu
set fu
if &background == "dark"
    hi normal guibg=black
    hi normal guifg=white
endif
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
set fdc=2
highlight FoldColumn guibg=black
"match OverLength /\%81v.\+/
