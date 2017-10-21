" File              : config/default_vimrc.vimrc
" Author            : SeaflyGithub <seafly0616@qq.com>
" Date              : 2017.08.06
" Last Modified Date: 2017.10.21 15时35分50秒
" Last Modified By  : abc <123>
"
" 插件配置文件vimrc.vim的内容布局
" 内部配置（vim自带）
" 	界面配置
" 	文件配置
" 	对齐配置
" 	补全配置
" 	单按键配置
" 	组合键配置
" 	未知配置
"
" 外部配置&插件配置（依赖外部插件）
" 	智能补全插件
" 	窗口管理插件
" 	工程管理插件
" 	文件头插件
" 	全局使能配置
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
" 	界面配置
set ttyfast
set completeopt=longest,menu    "让Vim的补全菜单行为与一般IDE一致
set statusline=\ %%F%m%r%h[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ [POS(%P):%l/%L,%c]
"set statusline=\ %{HasPaste()}%F%m%r%h[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ [POS(%P):%l/%L,%c]
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ [POS:%l/%L,%c]
"set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
"set statusline=%h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
"set statusline=%h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)
"set statusline=%h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]
"set statusline=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]
"set statusline=[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]
"set statusline=\ %{HasPaste()}%F%m%r%h[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ [POS(%P):%l/%L,%c]
set laststatus=1    "命令行高度,默认1
set number		    "显示行号&nonumber
set ruler           "显示当前位置坐标
set hlsearch        "搜索高亮&nohlsearch
set ignorecase      "搜索模式里忽略大小写
set smartcase       "如果搜索模式包含大写字符
set incsearch       "开启搜索实时匹配功能&noincsearch
set wrap            "限制（长行显示关闭; nowrap-->打开）
set mousehide	"Hide the mouse cursor while typing
set t_ti= t_te=	"设置退出vim时保留当前画面(防误删)
set mouse=a        "启用鼠标;mouse-=a 关闭鼠标
set scrolloff=0     " 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set showmatch       " 括号配对情况, 跳转并高亮一下匹配的括号
set showcmd         " 在状态栏显示正在输入的命令
set showmode        " 左下角显示当前vim模式
set cursorcolumn	" 突出显示当前列
set cursorline		" 突出显示当前行
"
"
"theme主题
set background=dark
set t_co=256
"设置标记一列的背景颜色和数字一行颜色一致
hi! link signcolumn   linenr
hi! link showmarkshll diffadd
hi! link showmarkshlu diffchange
"for error highlight，防止错误整行标红导致看不清
highlight clear spellbad
highlight spellbad term=standout ctermfg=1 term=underline cterm=underline
highlight clear spellcap
highlight spellcap term=underline cterm=underline
highlight clear spellrare
highlight spellrare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline
"=============================================================
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
" 	文件配置
filetype on                     "检测文件类型
syntax enable		            "syntax switch enable
syntax on		                "syntax switch on
set wildignore=*.o,*~,*.pyc,*.class,*.swp,*.bak     "Ignore compiled files
set nocp	"vi compatible mode 该功能每次修改保存文件时自动插入头文件
set nobackup        "关闭自动备份
set autoread        "文件修改之后自动载入
set noswapfile      "关闭交换文件
set wildmenu        "增强模式中的命令行自动完成操作
set noautochdir     "自动改变当前目录位置autochdir
set encoding=utf-8  " 设置新文件的编码为 UTF-8
" 注：使用utf-8格式后，软件与程序源码、文件路径不能有中文，否则报错
set fileencodings=ucs-bom,utf-8,gbk,cp936,gb18030,big5
set fileencodings+=euc-jp,euc-kr,latin1,latin-1	" 设置支持打开的文件的编码
set termencoding=utf-8	" 下面这句只影响普通模式 (非图形界面) 下的 Vim
set formatoptions+=m	" 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=B	" 合并两行中文时，不在中间加空格
set fileencoding=utf-8	"设置当前文件编码，可以更改
set ffs=unix,dos,mac	" 文件格式，默认 ffs=dos,unix
set fileformat=unix	"设置新文件的<EOL>格式，dos（windows系统常用）
set fileformats=unix,dos,mac	"给出文件的<EOL>格式类型


"set backup
"set backupext=.bak
"set backupdir=/tmp/vimbk/


" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" disbale paste mode when leaving insert mode
au InsertLeave * set nopaste
"
"
"--------启用代码折叠，用空格键来开关折叠
set foldenable		     "打开代码折叠
set foldmethod=syntax        "选择代码折叠类型
set foldlevel=100            "禁止自动折叠
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
" 	对齐配置
filetype plugin indent on       "启动自动对齐
filetype indent on              "针对不同的文件类型采用不同的缩进格式
set autoindent	"自动缩进
set smartindent	"智能缩进
set tabstop=4       " 设置Tab键的宽度        [等同的空格个数]
set shiftwidth=4    " 每一次缩进对应的空格数
set softtabstop=4  " 按退格键时可以一次删掉 4 个空格
set smarttab
"set expandtab       " 将Tab自动转化成空格,需要输入Tab时，使用Ctrl+V + Tab
set shiftround      " 缩进时，取整
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
" 	补全配置
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
" 	单按键配置
"
let g:mapleader = ","
"nnoremap ; :
set backspace=eol,start,indent  "删除键的配置 
"
"搜索模式快速搜索
vnoremap <silent> * :call VisualSelection('f')
vnoremap <silent> # :call VisualSelection('b')
"
"
"插入模式下方向键的使用
imap <c-k> <Up>
imap <c-j> <Down>
imap <c-h> <Left>
imap <c-l> <Right>
"
"
"搜索模式下空格键的绑定
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /<CR>
"
"
"成对符号自动匹配
:inoremap " ""
:inoremap ' ''
:inoremap ` ``
:inoremap [ []
:inoremap < <><ESC>i
"
"
"关闭方向键方向功能:使用hjkl
"map <Left> <Nop>
"map <Right> <Nop>
"map <Up> <Nop>
"map <Down> <Nop>
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
" 	组合键配置
" Windows风格全选组合键<c-a>
nmap <c-a> ggVG$
imap <c-a> <ESC>ggVG$
" Windows风格复制组合键<c-c>
nmap <c-c> yw$
imap <c-c> <ESC>yw$
"
"
" 删除多余空行
:nmap cl :1,$g/^$/d
" 删除行尾空格和tab符号
:nmap cs :1,$s/\s\+$//g
:nmap ct :1,$s/\t\+$//g
" 删除行尾^M符号
:nmap cm :1,$s/\r//g
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
"
" 	未知配置
set magic
set nowb
set expandtab
set smarttab
set hidden          " A buffer becomes hidden when it is abandoned
set wildmode=list:longest
"
"
"=============================================================
"                   object.sh脚本
"=============================================================
"map <F3> :set tags=~/.vim/systags,./tags,./filenametags<cr>
"map <F4> :cscope add ./cscope.out ./<cr>
"
" 	全局使能配置
set showcmd         " 在状态栏显示正在输入的命令
set showmode        " 左下角显示当前vim模式
