" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules according to the
" detected filetype. Per default Debian Vim only load filetype specific
" plugins.
if has("autocmd")
  filetype indent on
endif

set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
set mouse=
set scrolloff=3

" Source a global configuration file if available
" XXX Deprecated, please move your changes here in /etc/vim/vimrc
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

command! -bang -nargs=* W w<bang> <args>
command! -bang -nargs=* Q q<bang> <args>
command! -bang -nargs=* Wq wq<bang> <args>
command! -bang -nargs=* WQ wq<bang> <args>
command! -bang -nargs=* Set set<bang> <args>
set si ai
set expandtab
set tabstop=4
set shiftwidth=4
set nonu

" use apostrophe for anchors
nnoremap ' `
nnoremap ` '

" remember some stuff after quiting vim:
" marks, registers, searches, buffer list
set viminfo='20,<50,s10,h,%

"autocmd FileType html
"  \ setlocal noexpandtab
"autocmd FileType javascript
"  \ setlocal noexpandtab
"autocmd FileType htmldjango
"  \ setlocal noexpandtab

autocmd FileType python set tabstop=4 softtabstop=4 shiftwidth=4 expandtab nosi

" fancy window switching
nmap <c-h> <c-w>h<c-w><Bar>
nmap <c-l> <c-w>l<c-w><Bar>

inoremap kj <Esc>
filetype plugin on
set completeopt=menu,longest
"autocmd FileType python inoremap . .<C-X><C-O>

au BufWinLeave ?* mkview
au BufWinEnter ?* silent loadview

nnoremap z{ f{zf%

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

set backspace=2         " more powerful backspacing
