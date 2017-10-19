" File: /home/seafly/github/vimtools/config/vimrc.vim
" Author: SeaflyGithub <seafly0616@qq.com>
" Date: 2017.08.06
" Last Modified Date: 2017.08.06
" Last Modified By: SeaflyGithub <seafly0616@qq.com>
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
set statusline=\ %{HasPaste()}%F%m%r%h[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ [POS(%P):%l/%L,%c]
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
filetype plugin on              "允许插件
" 	智能补全插件
"=============================================================
"               代码补全插件code_complete
"=============================================================
"https://github.com/mbbill/code_complete
"code_complete使用说明:
"1.输入函数名后在输入(，然后按tab键就可以显示函数行参
"2.常用语句
"if，while，switch等，输入后，按tab键就行
"3.其他
"1.输入in后按tab，就是#include " "
"2.输入is后按tab，就是#include < >
"3.输入main后按tab，就是上图所示的那样，main函数就好了
"4.输入cc后按tab，就是上图中的注释
"5.输入ff后按tab，就是上图中的头文件，预处理宏
"6.输入de后按tab，就是宏定义
"code_complete配置:
let g:user_defined_snippets = "snippets/custom_snippets.vim"
"YouCompleteMe:YCM"
let g:ycm_server_python_interpreter='/usr/bin/python'
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
"
"
"=============================================================
"                       批量注释插件
"=============================================================
"comments.vim
"Ctrl + c         comments
"Ctrl + x         dis-comments
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
" 	窗口管理插件
" Close all the buffers(minibuf)
map <leader>ba :1,1000 bd!<cr>
"
"
"=============================================================
"               winmanager窗口管理插件
"=============================================================
let winManagerWindowLayout = 'FileExplorer|TagList'
let Tlist_Auto_Highlight_Tag = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Show_Menu = 1
let Tlist_Show_One_File = 1
let g:bufExplorerMaxHeight=50
let g:miniBufExplorerMoreThanOne=0
"Press <F12> open the winmanager diagram framework
"map <F12> :WMToggle<CR>
nmap <F12>   :WMToggle<CR>
"
"
"=============================================================
"                    多处光标同时编辑插件
"=============================================================
"https://github.com/terryma/vim-multiple-cursors
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_next_key='<s-n>'
let g:multi_cursor_prev_key='<s-p>'
let g:multi_cursor_skip_key='<s-x>'
let g:multi_cursor_quit_key='<Esc>'
" Map start key separately from next key
let g:multi_cursor_start_key='<F6>'
let g:multi_cursor_start_key='<C-n>'
let g:multi_cursor_start_word_key='g<C-n>'
"
"
"=============================================================
"                   缩进对齐线标注插件
"=============================================================
"https://github.com/Yggdroot/indentLine
let g:indentLine_enabled = 1
let g:indentLine_char = '|'
let g:indentLine_color_term = 239
"
"
"=============================================================
"                   SourceInsight插件
"=============================================================
let g:SrcExpl_winHeight = 15
let g:SrcExpl_refreshTime = 500
let g:SrcExpl_jumpKey = "<ENTER>"
let g:SrcExpl_gobackKey = "<SPACE>"
let g:SrcExpl_searchLocalDef = 1
"let g:SrcExpl_prevDefKey = "<F6>"
"let g:SrcExpl_nextDefKey = "<F7>"
nmap <F8>   :TrinityToggleAll<CR>
"nmap <F9>   :TrinityToggleSourceExplorer<CR>
"nmap <F10>  :TrinityToggleTagList<CR>
"nmap <F11>  :TrinityToggleNERDTree<CR>
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
" 	工程管理插件
"=============================================================
"               LookupFile文件查找插件
"=============================================================
let g:LookupFile_TagExpr = './filenametags'
let g:LookupFile_MinPatLength = 1               "最少输入1个字符才开始查找
let g:LookupFile_PreserveLastPattern = 0        "不保存上次查找的字符串
let g:LookupFile_PreservePatternHistory = 1     "保存查找历史
let g:LookupFile_AlwaysAcceptFirst = 1          "回车打开第一个匹配项目
let g:LookupFile_AllowNewFiles = 0              "不允许创建不存在的文件
let g:LookupFile_RecentFileListSize = 30
"let g:LookupFile_FileFilter = '\.class$\|\.o$\|\.obj$\|\.exe$\|\.jar$\|\.zip$\|\.war$\|\.ear$'
"
"
"=============================================================
"                   object.sh脚本
"=============================================================
"map <F3> :set tags=~/.vim/systags,./tags,./filenametags<cr>
"map <F4> :cscope add ./cscope.out ./<cr>
"
"
"=============================================================
"                   markdown语法支持插件
"=============================================================
"https://github.com/plasticboy/vim-markdown
let g:vim_markdown_folding_disabled = 0
set foldenable          "set nofoldenable
let g:vim_markdown_folding_style_pythonic = 1   "To fold in a style like python-mode
let g:vim_markdown_override_foldtext = 0
let g:vim_markdown_folding_level = 6
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_emphasis_multiline = 0
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_no_extensions_in_markdown = 1
let g:vim_markdown_autowrite = 1
"
"
"=============================================================
"           auto_update_cscope_ctags_database插件
"=============================================================
"#easy create new cscope and ctags databse by command :Createtag
"git@github.com:haolongzhangm/auto_update_cscope_ctags_database.git
let g:check_update_when_first_load_vim = 1      "(default)vim check database update when firstly load vim
let g:auto_run_function_when_cscope_connect = 1 "auto update database during edit you file
let g:auto_update_cscope_ctags_database=1
let g:Auto_update_cscope_ctags_timer_filter=60    "default 60s
let g:Auto_update_cscope_ctags_debug_log=0      "default
let g:Auto_update_cscope_ctags_lock_floor_max=1800  "default
let g:auto_update_cscope_ctags_backup_run_py_dir_cache='~/.vim/plugin/auto_update_cscope_ctags_backup_run.py'
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
" 	全局使能配置
set showcmd         " 在状态栏显示正在输入的命令
set showmode        " 左下角显示当前vim模式
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
" 	文件头插件
"=============================================================
"                       文件头管理模块
"=============================================================
"[alpertuna/vim-header](https://github.com/alpertuna/vim-header).
let g:header_field_filename = 1
let g:header_field_timestamp = 1
let g:header_field_timestamp_format = '%Y.%m.%d'
map <F2> :AddGNULicense<CR>
"let g:header_field_author = 'Your Name'
"let g:header_field_author_email = 'your@mail'

