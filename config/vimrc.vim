" File: /home/seafly/github/vimtools/config/vimrc.vim
" Author: SeaflyGithub <seafly0616@qq.com>
" Date: 2017.08.06
" Last Modified Date: 2017.08.06
" Last Modified By: SeaflyGithub <seafly0616@qq.com>
"=============================================================
"                       插件管理
"=============================================================
"set nocompatible              " be iMproved, required
filetype off                  " required
"set rtp+=~/.vim/bundle/Vundle.vim

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


"=============================================================
"                       vim插件生效插件
"=============================================================
"http://blog.csdn.net/zhaoyw2008/article/details/8012757
"pathogen: https://github.com/tpope/vim-pathogen
"git clone http://github.com/scrooloose/nerdtree.git
"call pathogen#infect()
"syntax on
"filetype plugin indent on


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
""""" Don't display binary files
let g:LookupFile_FileFilter = '\.class$\|\.o$\|\.obj$\|\.exe$\|\.jar$\|\.zip$\|\.war$\|\.ear$'


"=============================================================
"               winmanager窗口管理插件
"=============================================================
let winManagerWindowLayout = 'FileExplorer|TagList'
let Tlist_Auto_Highlight_Tag = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Show_Menu = 1
let Tlist_Show_One_File = 1
let g:bufExplorerMaxHeight=30
let g:miniBufExplorerMoreThanOne=0
"Press <F12> open the winmanager diagram framework
"map <F12> :WMToggle<CR>
nmap <F12>   :WMToggle<CR>


"=============================================================
"                     自动化处理模块
"=============================================================
syntax enable		            "syntax switch enable
syntax on		                "syntax switch on
filetype plugin indent on 	    "Allow indent file type check
filetype on                     "检测文件类型
filetype indent on              "针对不同的文件类型采用不同的缩进格式
filetype plugin on              "允许插件
filetype plugin indent on       "启动自动对齐
set completeopt=longest,menu    "让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
set wildignore=*.o,*~,*.pyc,*.class,*.swp,*.bak     "Ignore compiled files
set statusline=\ %{HasPaste()}%F%m%r%h[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ [POS(%P):%l/%L,%c]
set laststatus=1    "命令行高度,默认1
set noautochdir     "自动改变当前目录位置autochdir
set history=2000    "保留历史长度
set nocp		    "vi compatible mode 该功能每次修改保存文件时自动插入头文件
set number		    "显示行号&nonumber
set ruler           "显示当前位置坐标
set hlsearch        "搜索高亮&nohlsearch
set ignorecase      "搜索模式里忽略大小写
set smartcase       "如果搜索模式包含大写字符
set incsearch       "开启搜索实时匹配功能&noincsearch
set nobackup        "关闭自动备份
set autoread        "文件修改之后自动载入
set noswapfile      "关闭交换文件
set wildmenu        "增强模式中的命令行自动完成操作
set shiftwidth=4    "1 tab == 4 spaces
set tabstop=4       "1 tab == 4 spaces
set ai              "Auto indent
set autoindent
set si              "Smart indent
set smartindent
set wrap            " 设置该选项则关闭列限制（长行显示关闭）
"set nowrap          " 设置该选项则打开列显示（长行显示打开）
set t_ti= t_te=     "设置退出vim时保留当前画面(防误删)
set mouse-=a        " 鼠标暂不启用, 键盘党....
"set mouse=a        "启用鼠标
"set mousehide      " Hide the mouse cursor while typing
set viminfo^=%      " Remember info about open buffers on close
set magic           " For regular expressions turn magic on
set backspace=eol,start,indent  " Configure backspace so it acts as it should act
set whichwrap+=<,>,h,l
set ruler           " 显示当前的行号列号
set showcmd         " 在状态栏显示正在输入的命令
set showmode        " 左下角显示当前vim模式
set scrolloff=7     " 在上下移动光标时，光标的上方或下方至少会保留显示的行数
" set winwidth=79
set showmatch       " 括号配对情况, 跳转并高亮一下匹配的括号
set matchtime=2     " How many tenths of a second to blink when matching brackets
set tabstop=4       " 设置Tab键的宽度        [等同的空格个数]
set shiftwidth=4    " 每一次缩进对应的空格数
set softtabstop=4  " 按退格键时可以一次删掉 4 个空格
set smarttab
set expandtab       " 将Tab自动转化成空格[需要输入真正的Tab键时，使用 Ctrl+V + Tab]
set shiftround      " 缩进时，取整 use multiple of shiftwidth when indenting with '<' and '>'
set hidden          " A buffer becomes hidden when it is abandoned
set wildmode=list:longest
set ttyfast
set encoding=utf-8  " 设置新文件的编码为 UTF-8
set fileencodings=ucs-bom,utf-8,gbk,cp936,gb18030,big5,euc-jp,euc-kr,latin1,latin-1     " 设置支持打开的文件的编码
set helplang=cn
"set langmenu=zh_CN.UTF-8
"set enc=2byte-gb18030
set termencoding=utf-8      " 下面这句只影响普通模式 (非图形界面) 下的 Vim
set formatoptions+=m        " 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=B        " 合并两行中文时，不在中间加空格
" 注：使用utf-8格式后，软件与程序源码、文件路径不能有中文，否则报错
set fileencoding=utf-8                                "设置当前文件编码，可以更改，如：gbk（同cp936）
set ffs=unix,dos,mac                                  " 文件格式，默认 ffs=dos,unix
set fileformat=unix                                   "设置新（当前）文件的<EOL>格式，可以更改，如：dos（windows系统常用）
set fileformats=unix,dos,mac                          "给出文件的<EOL>格式类型
set title           " change the terminal's title
set novisualbell
set noerrorbells    " 去掉输入错误的提示声音
set t_vb=
set tm=500
set ruler
set magic
set nowb
set expandtab
set smarttab
"let  mapleader = “,”  default was "\" as value of mapleader
let g:mapleader = ","
"set shortmess=atI   "启动的时候不显示乌干达提示
"set backup
"set backupext=.bak
"set backupdir=/tmp/vimbk/
"set viminfo^=%                 "Remember info about open buffers on close
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ [POS:%l/%L,%c]
"set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
"set statusline=%h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
"set statusline=%h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)
"set statusline=%h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]
"set statusline=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]
"set statusline=[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]
"set statusline=\ %{HasPaste()}%F%m%r%h[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ [POS(%P):%l/%L,%c]

" 打开自动定位到最后编辑的位置, 需要确认 .viminfo 当前用户可写
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
" disbale paste mode when leaving insert mode
au InsertLeave * set nopaste

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')
vnoremap <silent> # :call VisualSelection('b')
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>
" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

"--------引号 && 括号自动匹配()
":inoremap ( ()
":inoremap ) <c-r>=ClosePair(')')
""inoremap { {}<ESC>i
""inoremap } <c-r>=ClosePair('}')<CR>
"插入{则为多行的配对方式，插入}为单行的配对
""imap { {}<ESC>i<CR><ESC>O
"":inoremap } {}<ESC>i
"插入大括号 就是录制一个宏
:inoremap [ []
":inoremap ] <c-r>=ClosePair(']')
":inoremap < <><ESC>i
":inoremap > <c-r>=ClosePair('>')<CR>
:inoremap " ""
:inoremap ' ''
:inoremap ` ``
"=============================================================





"=============================================================
"                     快捷键映射表模块
"=============================================================
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
" 复制
nmap <c-c> yw$
imap <c-c> <ESC>yw$
" 剪切
nmap <c-x> c$
imap <c-x> <ESC>c$

" 删除多余空行
:nmap cl :1,$g/^$/d
" 删除行尾空格和tab符号
:nmap cs :1,$s/\s\+$//g
"nmap cs :1,$s/\s\+$//g<CR>
" 删除行尾^M符号
:nmap cm :1,$s/\r//g
"nmap cb :g/^\s*$/d<CR>    "强烈模式:更狠
"nmap cb :1,$g/^$/d<CR> "强烈模式
" 关闭方向键, 强迫自己用 hjkl
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>
"下面将<c-w>j映射为<c-j>
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
nnoremap ; :
"=============================================================


"=============================================================
"                     源文件管理模块
"=============================================================
"--------启用代码折叠，用空格键来开关折叠
set foldenable		     " 打开代码折叠
set foldmethod=syntax        " 选择代码折叠类型
set foldlevel=100            " 禁止自动折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc':'zo')
" 保存python文件时删除多余空格
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,shell,vimrc,twig,xml,yml,perl autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
"=============================================================


"=============================================================
"                   theme主题显示设置模块
"=============================================================
" 突出显示当前列
"set cursorcolumn
" 突出显示当前行
"set cursorline
" 设置可以高亮的关键字
if has("autocmd")
  " highlight todo, fixme, note, etc.
  if v:version > 701
    autocmd syntax * call matchadd('todo',  '\w\zs\(todo\|fixme\|changed\|done\|xxx\|bug\|hack\)')
    autocmd syntax * call matchadd('debug', '\w\zs\(note\|info\|idea\|notice\)')
  endif
endif
" set extra options when running in gui mode
if has("gui_running")
    set guifont=monaco:h14
    if has("gui_gtk2")   "gtk2
        set guifont=monaco\ 12,monospace\ 12
    endif
    set guioptions-=t
    set guioptions+=e
    set guioptions-=r
    set guioptions-=l
    set guitablabel=%m\ %t
    set showtabline=1
    set linespace=2
    set noimd
    set t_co=256
endif
" theme主题
set background=dark
set t_co=256
" 设置标记一列的背景颜色和数字一行颜色一致
hi! link signcolumn   linenr
hi! link showmarkshll diffadd
hi! link showmarkshlu diffchange
" for error highlight，防止错误整行标红导致看不清
highlight clear spellbad
highlight spellbad term=standout ctermfg=1 term=underline cterm=underline
highlight clear spellcap
highlight spellcap term=underline cterm=underline
highlight clear spellrare
highlight spellrare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline
"=============================================================


"=============================================================
"                   object.sh脚本
"=============================================================
"map <F3> :set tags=~/.vim/systags,./tags,./filenametags<cr>
"map <F4> :cscope add ./cscope.out ./<cr>


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


"=============================================================
"                   缩进对齐线标注插件
"=============================================================
"https://github.com/Yggdroot/indentLine
let g:indentLine_enabled = 1
let g:indentLine_char = '|'
let g:indentLine_color_term = 239

"=============================================================
"                       批量注释插件
"=============================================================
"comments.vim
"Ctrl + c         comments
"Ctrl + x         dis-comments

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



"=============================================================
"                       文件头管理模块
"=============================================================
"新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()"
""定义函数SetTitle，自动插入文件头
function! SetTitle()
	"如果文件类型为.sh文件
	if &filetype == 'sh'
		call setline(1,"\##################################################")
		call append(line("."), "\# Filename: ".expand("%"))
		call append(line(".")+1, "\# Author: ChrisZZ")
		call append(line(".")+2, "\# E-mail: zchrissirhcz@163.com")
		call append(line(".")+3, "\# Created Time: ".strftime("%c"))
		call append(line(".")+4, "\##################################################")
		call append(line(".")+5, "\#!/bin/bash")
		call append(line(".")+6, "")
	endif

	if &filetype == 'c'
		call setline(1, "/*")
		call append(line("."), " * ==================================================")
		call append(line(".")+1, " *")
		call append(line(".")+2, " *       Filename:  ".expand("%"))
		call append(line(".")+3, " *")
		call append(line(".")+4, " *    Description:  ")
		call append(line(".")+5, " *")
		call append(line(".")+6, " *        Version:  0.01")
		call append(line(".")+7, " *        Created:  ".strftime("%c"))
		call append(line(".")+8, " *         Author:  ChrisZZ, zchrissirhcz@163.com")
		call append(line(".")+9," *        Company:  ZJUT")
		call append(line(".")+10, " *")
		call append(line(".")+11, " * ==================================================")
		call append(line(".")+12, " */")
		call append(line(".")+13, "#include <stdio.h>")
		call append(line(".")+14, "")
		call append(line(".")+15, "int main(){")
		call append(line(".")+16, "")
		call append(line(".")+17, "	return 0;")
		call append(line(".")+18, "}")
	endif
	if &filetype == 'cpp'
		call setline(1, "/*")
		call append(line("."), " * ==================================================")
		call append(line(".")+1, " *")
		call append(line(".")+2, " *       Filename:  ".expand("%"))
		call append(line(".")+3, " *")
		call append(line(".")+4, " *    Description:  ")
		call append(line(".")+5, " *")
		call append(line(".")+6, " *        Version:  0.01")
		call append(line(".")+7, " *        Created:  ".strftime("%c"))
		call append(line(".")+8, " *         Author:  ChrisZZ, zchrissirhcz@163.com")
		call append(line(".")+9," *        Company:  ZJUT")
		call append(line(".")+10, " *")
		call append(line(".")+11, " * ==================================================")
		call append(line(".")+12, " */")
		call append(line(".")+13, "#include <iostream>")
		call append(line(".")+14, "using namespace std;")
		call append(line(".")+15, "int main(){")
		call append(line(".")+16, "")
		call append(line(".")+17, "    return 0;")
		call append(line(".")+18, "}")
	endif
	"新建文件后，自动定位到文件末尾
	autocmd BufNewFile * normal G

endfunction
"[alpertuna/vim-header](https://github.com/alpertuna/vim-header).
let g:header_field_filename = 1
let g:header_field_timestamp = 1
let g:header_field_timestamp_format = '%Y.%m.%d'
map <F2> :AddGNULicense<CR>
"let g:header_field_author = 'Your Name'
"let g:header_field_author_email = 'your@mail'
