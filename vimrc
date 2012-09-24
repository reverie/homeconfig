call pathogen#infect()

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

au BufNewFile,BufRead *.less set filetype=less

autocmd FileType python set tabstop=4 softtabstop=4 shiftwidth=4 expandtab nosmartindent
autocmd FileType coffee set tabstop=2 softtabstop=2 shiftwidth=2 expandtab nosmartindent
autocmd FileType html set tabstop=2 softtabstop=2 shiftwidth=2 expandtab nosmartindent
autocmd FileType css set tabstop=2 softtabstop=2 shiftwidth=2 expandtab nosmartindent
autocmd FileType less set tabstop=2 softtabstop=2 shiftwidth=2 expandtab nosmartindent

" easy
nmap <c-h> <c-w>h
nmap <c-l> <c-w>l

set completeopt=menu,longest

" Go to last-edited spot when opening a file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
\| exe "normal g'\"" | endif

au BufWinLeave ?* mkview
au BufWinEnter ?* silent loadview

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

augroup filetypedetect 
  au! BufRead,BufNewFile *.m,*.oct set filetype=octave 
augroup END 


