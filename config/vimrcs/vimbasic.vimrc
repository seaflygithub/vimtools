set history=700
syntax enable		"syntax switch enable
syntax on		    "syntax switch on
set nocp		    "vi compatible mode
filetype plugin on 	"Allow file type check
filetype plugin indent on 	"Allow indent file type check
filetype indent on
set number		    "Show line number
"set nonumber		"Don't show line number
set hlsearch
"set nohlsearch 	"No high light search key word(s)
colorscheme evening	"Set colorscheme (Default evening)
" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
" Use Unix as the standard file type
set ffs=unix,dos,mac
set completeopt=longest,menu	""Close preview window
" Set to auto read when a file is changed from the outside
set autoread
" Ignore compiled files
set wildignore=*.o,*~,*.pyc
"Always show current position
set ruler
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases 
set smartcase
" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch
" For regular expressions turn magic on
set magic
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile
" Use spaces instead of tabs
set expandtab
" Be smart when using tabs ;)
set smarttab
" 1 tab == 4 spaces
set shiftwidth=4
set softtabstop=4
set backspace=2
set tabstop=4
set showmatch
set showcmd
set incsearch
set nowrap
set sidescroll=1
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
"let  mapleader = “,”  default was "\" as value of mapleader:
let mapleader = "," "usage: ESC + , + m
let g:mapleader = ","
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ [POS:%l/%L,%c]
set laststatus=2
set ruler

"fast reloading of the .vimrc:
map <silent> <leader>ss :source ~/.vimrc<cr>
"fast editing of .vimrc:
map <silent> <leader>ee :e ~/.vimrc<cr>
"when .vimrc is edited, reload it:
autocmd! bufwritepost .vimrc source ~/.vimrc 

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
"set viminfo^=%

set list lcs=tab:\¦\
set lcs=tab:\¦\
set list
