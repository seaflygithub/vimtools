set history=700
syntax enable		"syntax switch enable
syntax on		    "syntax switch on
set nocp		    "vi compatible mode
set hlsearch        "set nohlsearch
colorscheme evening	"Set colorscheme (Default evening)
set encoding=utf8
set ffs=unix,dos,mac    " Use Unix as the standard file type
set completeopt=longest,menu	" Close preview window
set autoread " Set to auto read when a file is changed from the outside
set wildignore=*.o,*~,*.pyc " Ignore compiled files
set ruler "Always show current position
set ignorecase " Ignore case when searching
set smartcase " When searching try to be smart about cases 
set magic " For regular expressions turn magic on
set nobackup " Turn backup off, since most stuff is in SVN, git et.c anyway...
set nowb
set noswapfile
set expandtab " Use spaces instead of tabs
set smarttab " Be smart when using tabs ;)
set shiftwidth=4 " 1 tab == 4 spaces
set softtabstop=4
set backspace=2
set tabstop=4
set showmatch
set showcmd
set nowrap
set sidescroll=1
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
"let  mapleader = “,”  default was "\" as value of mapleader:
let mapleader = "," "usage: ESC + , + m
let g:mapleader = ","


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



set tabstop=4         "设置 tab 的宽度
set softtabstop=4     "设置 删除 tab 的宽度
set shiftwidth=4      "设置 智能缩进的宽度
set expandtab         "设置 将 tab 转换为 4 个空格
set hlsearch        "高亮搜索
set incsearch       "在输入要搜索的文字时，实时匹配


"set mouse=a                    " 在任何模式下启用鼠标
"set t_Co=256                   " 在终端启用256色
set backspace=2                " 设置退格键可用


" -----------------------------------------------
"  < 编码配置 >
" -----------------------------------------------
" 注：使用utf-8格式后，软件与程序源码、文件路径不能有中文，否则报错
set encoding=utf-8                                    "设置gvim内部编码，默认不更改
set fileencoding=utf-8                                "设置当前文件编码，可以更改，如：gbk（同cp936）
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1     "设置支持打开的文件的编码

" 文件格式，默认 ffs=dos,unix
set fileformat=unix                                   "设置新（当前）文件的<EOL>格式，可以更改，如：dos（windows系统常用）
set fileformats=unix,dos,mac                          "给出文件的<EOL>格式类型



" ------------------------------------------
"  < 编写文件时的配置 >
" ------------------------------------------
filetype on                                           "启用文件类型侦测
filetype plugin on                                    "针对不同的文件类型加载对应的插件
filetype plugin indent on                             "启用缩进
set smartindent                                       "启用智能对齐方式
set expandtab                                         "将Tab键转换为空格
set tabstop=4                                         "设置Tab键的宽度，可以更改，如：宽度为2
set shiftwidth=4                                      "换行时自动缩进宽度，可更改（宽度同tabstop）
set smarttab                                          "指定按一次backspace就删除shiftwidth宽度
set foldenable                                        "启用折叠
set foldmethod=indent                                 "indent 折叠方式
set foldlevel=9999                                    " 折叠的层次，打开文件时默认不折叠



" 常规模式下用空格键来开关光标行所在折叠（注：zR 展开所有折叠，zM 关闭所有折叠）
"nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" 当文件在外部被修改，自动更新该文件
set autoread

" 常规模式下输入 cS 清除行尾空格
nmap cS :%s/\s\+$//g<CR>:noh<CR>

" 常规模式下输入 cM 清除行尾 ^M 符号
nmap cM :%s/\r$//g<CR>:noh<CR>

set ignorecase   "搜索模式里忽略大小写
set smartcase    "如果搜索模式包含大写字符，不使用 'ignorecase' 选项，只有在输入搜索模式并且打开 'ignorecase' 选项时才会使用
" set noincsearch   "在输入要搜索的文字时，取消实时匹配

" Ctrl + K 插入模式下光标向上移动
imap <c-k> <Up>

" Ctrl + J 插入模式下光标向下移动
imap <c-j> <Down>

" Ctrl + H 插入模式下光标向左移动
imap <c-h> <Left>

" Ctrl + L 插入模式下光标向右移动
imap <c-l> <Right>

" Ctrl + f 光标跳转到行头
"imap <c-f> <ESC>0i
"imap <c-e> <ESC>$i
" Ctrl + e 光标跳转到行尾

" 全选
nmap <c-a> ggVG$
imap <c-a> <ESC>ggVG$


" 启用每行超过80列的字符提示（字体变蓝并加下划线），不启用就注释掉
au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)

" -----------------------------------------------------------------------------
"  < 界面配置 >
" -----------------------------------------------------------------------------
set number                                            "显示行号,set nonumber
set laststatus=2                                      "启用状态栏信息
set cmdheight=1                                       "设置命令行的高度为2，默认为1
set cursorline                                        "突出显示当前行
" set guifont=YaHei_Consolas_Hybrid:h10                 "设置字体:字号（字体名称空格用下划线代替）
set nowrap                                            "设置不自动换行
"set shortmess=atI                                     "去掉欢迎界面
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ [POS:%l/%L,%c]
