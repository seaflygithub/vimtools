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

"http://blog.csdn.net/zhaoyw2008/article/details/8012757
"pathogen: https://github.com/tpope/vim-pathogen
"git clone http://github.com/scrooloose/nerdtree.git
"call pathogen#infect()
syntax on  
filetype plugin indent on 


"https://github.com/Yggdroot/indentLine
let g:indentLine_enabled = 1
let g:indentLine_char = '|'
let g:indentLine_color_term = 239


"comments.vim
"Ctrl + c         comments
"Ctrl + x         dis-comments
"

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
" 复制
nmap <c-c> yw$
imap <c-c> <ESC>yw$
" 剪切
nmap <c-x> c$
imap <c-x> <ESC>c$

" 当文件在外部被修改，自动更新该文件
set autoread
" 删除多余空行
nmap cl :g/^$/d<CR>
"nmap cb :g/^\s*$/d<CR>    "强烈模式:更狠
"nmap cb :1,$g/^$/d<CR> "强烈模式
" 删除行尾空格和tab符号
nmap cs :%s/^\s\+<CR> :%s/\s\+$<CR>
" 删除行尾^M符号                
nmap cm :1,$s/\r//g<CR>


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



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"vim: vim's basic configuration for object-management
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=700
syntax enable		"syntax switch enable
syntax on		    "syntax switch on
set nocp		    "vi compatible mode
" Enable filetype plugins
filetype plugin on 	"Allow file type check
filetype plugin indent on 	"Allow indent file type check
filetype indent on
set number		    "Show line number
"set nonumber		"Don't show line number
"set nohlsearch 	"No high light search key word(s)
"colorscheme evening	"Set colorscheme (Default evening)
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
set tabstop=4
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines











"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"vimrc: configure itself
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set mapleader
"let  mapleader = “,”  default was "\" as value of mapleader
let mapleader = ","
let g:mapleader = ","
"fast reloading of the .vimrc
map <silent> <leader>ss :source ~/.vimrc<cr>
"fast editing of .vimrc
map <silent> <leader>ee :e ~/.vimrc<cr>
"when .vimrc is edited, reload it.
autocmd! bufwritepost .vimrc source ~/.vimrc
"Fast edit vimrc




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"vim: vim's basic configuration for object-management
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=700
syntax enable		"syntax switch enable
syntax on		    "syntax switch on
set nocp		    "vi compatible mode
" Enable filetype plugins
filetype plugin on 	"Allow file type check
filetype plugin indent on 	"Allow indent file type check
filetype indent on
set number		    "Show line number
"set nonumber		"Don't show line number
"set nohlsearch 	"No high light search key word(s)
"colorscheme evening	"Set colorscheme (Default evening)
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
set tabstop=4
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines










""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"vim-map: vim's map configuration for object-management
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>
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
" Remember info about open buffers on close
"set viminfo^=%

" Format the status line
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ [POS:%l/%L,%c]
set laststatus=2
set ruler










"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"LookupFile:  => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"LookupFile:  => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"LookupFile: lookupfile plugin configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:LookupFile_TagExpr = '"./filenametags"'
"let g:LookupFile_TagExpr = string('./filenametags')
""""let g:myLookupFileTagExpr = './filenanmetags'
""""let g:LookupFile_TagExpr = 'g:myLookupFileTagExpr'
"let g:LookupFile_MinPatLength = 2               "最少输入2个字符才开始查找
let g:LookupFile_MinPatLength = 1               "最少输入1个字符才开始查找
let g:LookupFile_PreserveLastPattern = 0        "不保存上次查找的字符串
let g:LookupFile_PreservePatternHistory = 1     "保存查找历史
let g:LookupFile_AlwaysAcceptFirst = 1          "回车打开第一个匹配项目
let g:LookupFile_AllowNewFiles = 0              "不允许创建不存在的文件
let g:LookupFile_RecentFileListSize = 30
""""" Don't display binary files
let g:LookupFile_FileFilter = '\.class$\|\.o$\|\.obj$\|\.exe$\|\.jar$\|\.zip$\|\.war$\|\.ear$'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"LookupFile: lookup file with ignore case
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! LookupFile_IgnoreCaseFunc(pattern)
    let _tags = &tags
    try
        let &tags = eval(g:LookupFile_TagExpr)
        let newpattern = '\c' . a:pattern
        let tags = taglist(newpattern)
    catch
        echohl ErrorMsg | echo "Exception: " . v:exception | echohl NONE
        return ""
    finally
        let &tags = _tags
    endtry

    "show the matches for what is typed so far.
    let files = map(tags, 'v:val["filename"]')
    return files
endfunction
let g:LookupFile_LookupFunc = 'LookupFile_IgnoreCaseFunc'











""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"winmanager: configuration of taglist, Explorebuf, minibuf etc.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let winManagerWindowLayout = 'FileExplorer|TagList'
let Tlist_Auto_Highlight_Tag = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Show_Menu = 1
let Tlist_Show_One_File = 1
let g:bufExplorerMaxHeight=30
let g:miniBufExplorerMoreThanOne=0
"Press <F12> open the winmanager diagram framework
map <F12> :WMToggle<CR>




" NOTE: 以下配置有详细说明，一些特性不喜欢可以直接注解掉

"==========================================
" General Settings 基础设置
"==========================================


" history存储容量
set history=2000

" 检测文件类型
filetype on
" 针对不同的文件类型采用不同的缩进格式
filetype indent on
" 允许插件
filetype plugin on
" 启动自动补全
filetype plugin indent on

" 文件修改之后自动载入
set autoread
" 启动的时候不显示那个援助乌干达儿童的提示
set shortmess=atI

" 备份,到另一个位置. 防止误删, 目前是取消备份
"set backup
"set backupext=.bak
"set backupdir=/tmp/vimbk/

" 取消备份。 视情况自己改
set nobackup
" 关闭交换文件
set noswapfile


" TODO: remove this, use gundo
" create undo file
" if has('persistent_undo')
  " " How many undos
  " set undolevels=1000
  " " number of lines to save for undo
  " set undoreload=10000
  " " So is persistent undo ...
  " "set undofile
  " set noundofile
  " " set undodir=/tmp/vimundo/
" endif

set wildignore=*.swp,*.bak,*.pyc,*.class,.svn

" 突出显示当前列
set cursorcolumn
" 突出显示当前行
set cursorline


" 设置 退出vim后，内容显示在终端屏幕, 可以用于查看和复制, 不需要可以去掉
" 好处：误删什么的，如果以前屏幕打开，可以找回
set t_ti= t_te=


" 鼠标暂不启用, 键盘党....
set mouse-=a
" 启用鼠标
" set mouse=a
" Hide the mouse cursor while typing
" set mousehide


" 修复ctrl+m 多光标操作选择的bug，但是改变了ctrl+v进行字符选中时将包含光标下的字符
"set selection=inclusive
"set selectmode=mouse,key

" change the terminal's title
set title
" 去掉输入错误的提示声音
set novisualbell
set noerrorbells
set t_vb=
set tm=500

" Remember info about open buffers on close
set viminfo^=%

" For regular expressions turn magic on
set magic

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l


"==========================================
" Display Settings 展示/排版等界面格式设置
"==========================================

" 显示当前的行号列号
set ruler
" 在状态栏显示正在输入的命令
set showcmd
" 左下角显示当前vim模式
set showmode

" 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set scrolloff=7

" set winwidth=79

" 命令行（在状态行下）的高度，默认为1，这里是2
set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
" Always show the status line - use 2 lines for the status bar
set laststatus=2

" 显示行号
set number
" 取消换行  (one line out of screen)
set nowrap

" 括号配对情况, 跳转并高亮一下匹配的括号
set showmatch
" How many tenths of a second to blink when matching brackets
set matchtime=2


" 缩进配置
" Smart indent
set smartindent
" 打开自动缩进
" never add copyindent, case error   " copy the previous indentation on autoindenting
set autoindent


" tab相关变更
" 设置Tab键的宽度        [等同的空格个数]
set tabstop=4
" 每一次缩进对应的空格数
set shiftwidth=4
" 按退格键时可以一次删掉 4 个空格
"set softtabstop=4
" insert tabs on the start of a line according to shiftwidth, not tabstop 按退格键时可以一次删掉 4 个空格
set smarttab
" 将Tab自动转化成空格[需要输入真正的Tab键时，使用 Ctrl+V + Tab]
set expandtab
" 缩进时，取整 use multiple of shiftwidth when indenting with '<' and '>'
set shiftround

" A buffer becomes hidden when it is abandoned
set hidden
set wildmode=list:longest
set ttyfast



"==========================================
" FileEncode Settings 文件编码,格式
"==========================================
" 设置新文件的编码为 UTF-8
set encoding=utf-8
" 自动判断编码时，依次尝试以下编码：
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set helplang=cn
"set langmenu=zh_CN.UTF-8
"set enc=2byte-gb18030
" 下面这句只影响普通模式 (非图形界面) 下的 Vim
set termencoding=utf-8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=m
" 合并两行中文时，不在中间加空格
set formatoptions+=B


" 自动补全配置
" 让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
set completeopt=longest,menu


" 增强模式中的命令行自动完成操作
set wildmenu
" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*.class


" 离开插入模式后自动关闭预览窗口
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" 回车即选中当前项
"inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"


" 打开自动定位到最后编辑的位置, 需要确认 .viminfo 当前用户可写
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


"==========================================
" HotKey Settings  自定义快捷键设置
"==========================================
" 主要按键重定义
" 关闭方向键, 强迫自己用 hjkl
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>


" F1 - F6 设置
" F1 废弃这个键,防止调出系统帮助
" I can type :help on my own, thanks.  Protect your fat fingers from the evils of <F1>
noremap <F1> <Esc>"


" disbale paste mode when leaving insert mode
au InsertLeave * set nopaste


" 分屏窗口移动, Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l



" Map ; to : and save a million keystrokes 用于快速进入命令行
nnoremap ; :



" 复制选中区到系统剪切板中
vnoremap <leader>y "+y



" 保存python文件时删除多余空格
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,shell,vimrc,twig,xml,yml,perl autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()



" 设置可以高亮的关键字
if has("autocmd")
  " Highlight TODO, FIXME, NOTE, etc.
  if v:version > 701
    autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\)')
    autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\)')
  endif
endif




"==========================================
" Theme Settings  主题设置
"==========================================

" Set extra options when running in GUI mode
if has("gui_running")
    set guifont=Monaco:h14
    if has("gui_gtk2")   "GTK2
        set guifont=Monaco\ 12,Monospace\ 12
    endif
    set guioptions-=T
    set guioptions+=e
    set guioptions-=r
    set guioptions-=L
    set guitablabel=%M\ %t
    set showtabline=1
    set linespace=2
    set noimd
    set t_Co=256
endif



" theme主题
set background=dark
set t_Co=256

colorscheme solarized
" colorscheme molokai
" colorscheme desert


" 设置标记一列的背景颜色和数字一行颜色一致
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" for error highlight，防止错误整行标红导致看不清
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline
















""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"vim-header: You can add these lines into your `.vimrc`
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Easily Adds Brief Author Info and License Headers
"Usage
"=====
"This is a general usage example.
"You can add these lines into your `.vimrc`

"    let g:header_field_author = 'Your Name'
"    let g:header_field_author_email = 'your@mail'
"    map <F4> :AddHeader<CR>

"Pressing `F4` in normal mode will add a brief author information at the top of your buffer.

"Examples
"========
"For example, when you open a file named `start.sh` and press `F4` after above settings, plugin will add these lines at the top of your buffer

"    #!/bin/bash
"    # start.sh
"    # Author: Your Name <your@mail>
"    # Date: 13.03.2016

"or for a file named `index.php`

"    <?php
"    /*
"     * index.php
"     * Author: Your Name <your@mail>
"     * Date: 13.03.2016
"     */

"Commands
"========
"Adding Brief Headers

"- `:AddHeader` Adds brief author information
"- `:AddMinHeader` Adds minified version of author information

"Adding Lincenses

"- `:AddMITLicense` Adds MIT License with author info
"- `:AddApacheLicense` Adds Apache License with author info
"- `:AddGNULicense` Adds GNU License with author info

"Settings
"========
"These settings are for your `.vimrc`

"    let g:header_field_filename = 0
"It disables to add filename line in header. Default is 1.

"    let g:header_field_author = 'Your Name'
"It adds your name as author. Default is ''. Empty string means to disable adding it.

"    let g:header_field_author_email = 'your@mail'
"It adds your email after author name with surrounding chars. If you don't define your author name, defined email also won't be shown. Default is ''. Empty string means to disable adding it.

"    let g:header_field_timestamp = 0
"It disables to add timestamp line of generating header date in header. Default is 1.

"    let g:header_field_timestamp_format = '%d.%m.%Y'
"It sets timestamp format for your locale. Default is '%d.%m.%Y'.

"Support
"=======
"Supported filetypes are;

"- c
"- cpp
"- css
"- java
"- javascript
"- php
"- perl
"- python
"- sh
"- vim

"And licenses are;

"- MIT
"- Apache
"- GNU

"If you want more filetypes or licenses, 
"you can open issues or provide any improvements by pull requests on 
"[alpertuna/vim-header](https://github.com/alpertuna/vim-header). 
"Also you can correct my English on README file or at comments in source code.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"vim-header: configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""





""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"project.sh: configuration for vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F3> :set tags=~/.vim/systags,./tags,./filenametags<cr>
map <F4> :cscope add ./cscope.out ./<cr>

""""""""""""""""""""""""""""""""""""""
"SrcExpl: vimrc setting
""""""""""""""""""""""""""""""""""""""
" // The switch of the Source Explorer                                         " 
" nmap <F8> :SrcExplToggle<CR> 
"                                                                              " 
" // Set the height of Source Explorer window                                  " 
let g:SrcExpl_winHeight = 8
"                                                                              " 
" // Set 100 ms for refreshing the Source Explorer                             " 
let g:SrcExpl_refreshTime = 100
"                                                                              " 
" // Set "Enter" key to jump into the exact definition context                 " 
let g:SrcExpl_jumpKey = "<ENTER>"
"                                                                              " 
" // Set "Space" key for back from the definition context                      " 
let g:SrcExpl_gobackKey = "<SPACE>"
"                                                                              " 
" // In order to avoid conflicts, the Source Explorer should know what plugins " 
" // except itself are using buffers. And you need add their buffer names into " 
" // below listaccording to the command ":buffers!"                            " 
"let g:SrcExpl_pluginList = [ 
"        \ "__Tag_List__", 
"        \ "_NERD_tree_" 
"    \ ] 
"                                                                              " 
" // Enable/Disable the local definition searching, and note that this is not  " 
" // guaranteed to work, the Source Explorer doesn't check the syntax for now. " 
" // It only searches for a match with the keyword according to command 'gd'   " 
let g:SrcExpl_searchLocalDef = 1
"

" // Set "<F6>" key for displaying the previous definition in the jump list    " 
let g:SrcExpl_prevDefKey = "<F6>"
"                                                                              " 
" // Set "<F7>" key for displaying the next definition in the jump list        " 
let g:SrcExpl_nextDefKey = "<F7>"

"<F5>       "run LookupFile
" Open and close all the three plugins on the same time 
nmap <F8>   :TrinityToggleAll<CR>
" Open and close the srcexpl.vim separately 
nmap <F9>   :TrinityToggleSourceExplorer<CR>
" Open and close the taglist.vim separately 
nmap <F10>  :TrinityToggleTagList<CR>
" Open and close the NERD_tree.vim separately 
nmap <F11>  :TrinityToggleNERDTree<CR>



"Adding Brief Headers(You can modify it)
"map <F2> :AddHeader<CR>        #Adds brief author information
"map <F2> :AddMinHeader<CR>     #Adds minified version of author information
"Adding Lincenses
"map <F2> :AddMITLicense<CR>    # Adds MIT License with author info
"map <F2> :AddApacheLicense<CR> # Adds Apache License with author info
"map <F2> :AddGNULicense<CR>    # Adds GNU License with author info

let g:header_field_filename = 1
let g:header_field_timestamp = 1
let g:header_field_timestamp_format = '%Y.%m.%d'
map <F2> :AddGNULicense<CR>
"let g:header_field_author = 'Your Name'
"let g:header_field_author_email = 'your@mail'
