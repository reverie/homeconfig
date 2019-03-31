" Source a global configuration file if available
if filereadable("/etc/vim/vimrc")
  source /etc/vim/vimrc.local
endif

syntax on
set background=dark
filetype plugin indent on

set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set scrolloff=3
set backspace=2         " more powerful backspacing
set visualbell " No beeping
set smartindent 
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set nonu

command! -bang -nargs=* W w<bang> <args>
command! -bang -nargs=* Q q<bang> <args>
command! -bang -nargs=* Wq wq<bang> <args>
command! -bang -nargs=* WQ wq<bang> <args>
command! -bang -nargs=* Set set<bang> <args>
command! -bang -nargs=* Vs vs<bang> <args>

" use apostrophe for anchors
nnoremap ' `
nnoremap ` '

" remember some stuff after quiting vim:
" marks, registers, searches, buffer list
set viminfo='20,<50,s10,h,%

au BufNewFile,BufRead *.elm set filetype=elm
au BufNewFile,BufRead *.tsx set filetype=typescript
let g:syntastic_typescript_tsc_args = "--jsx react"

" https://github.com/scrooloose/syntastic/issues/341
let g:syntastic_always_populate_loc_list = 1


autocmd FileType python set tabstop=4 softtabstop=4 shiftwidth=4 expandtab nosmartindent
autocmd FileType typescript set tabstop=4 softtabstop=4 shiftwidth=4 expandtab nosmartindent
autocmd FileType coffee set tabstop=2 softtabstop=2 shiftwidth=2 expandtab nosmartindent
autocmd FileType html set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd FileType htmldjango set tabstop=2 softtabstop=2 shiftwidth=2 expandtab nosmartindent inde=
autocmd FileType django set tabstop=2 softtabstop=2 shiftwidth=2 expandtab nosmartindent inde=
autocmd FileType css set tabstop=2 softtabstop=2 shiftwidth=2 expandtab nosmartindent
autocmd FileType less set tabstop=2 softtabstop=2 shiftwidth=2 expandtab nosmartindent
autocmd FileType scss set tabstop=2 softtabstop=2 shiftwidth=2 expandtab nosmartindent
autocmd FileType cabal set tabstop=2 softtabstop=2 shiftwidth=2 expandtab nosmartindent
autocmd FileType elm set tabstop=2 softtabstop=2 shiftwidth=2 expandtab nosmartindent

au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
au BufNewFile,BufRead *.tag setlocal ft=javascript

" easy window moving
nmap <c-h> <c-w>h
nmap <c-l> <c-w>l
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k

" swap words with `gw`
nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>

set completeopt=menu,longest

" Go to last-edited spot when opening a file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
\| exe "normal g'\"" | endif

au BufWinLeave ?* mkview
au BufWinEnter ?* silent loadview

augroup filetypedetect 
  au! BufRead,BufNewFile *.m,*.oct set filetype=octave 
augroup END 

let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=0
