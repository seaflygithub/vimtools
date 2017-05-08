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
call pathogen#infect()
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



" 当文件在外部被修改，自动更新该文件
set autoread
" 常规模式下输入 cS 清除行尾空格
nmap cS :%s/\s\+$//g<CR>:noh<CR>
" 常规模式下输入 cM 清除行尾 ^M 符号
nmap cM :%s/\r$//g<CR>:noh<CR>



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



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"vimtool:vimrc: vimtool vimrc configuration file
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"2. Set 'omnifunc' option. e.g. >
setlocal omnifunc=javacomplete#Complete
"<   Or, use autocmd: >
    :" Only do this part when compiled with support for autocommands.
if has("autocmd")
  autocmd Filetype java setlocal omnifunc=javacomplete#Complete
endif
"3. Set 'completefunc' option to show parameters information IF YOU LIKE. e.g. >
setlocal completefunc=javacomplete#CompleteParamsInfo
"You can map as follows for better display: >
inoremap <buffer> <C-X><C-U> <C-X><C-U><C-P>
inoremap <buffer> <C-S-Space> <C-X><C-U><C-P>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"tabel: configuration of tabel page
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Platform
function! MySys()
  if has("win32")
    return "windows"
  else
    return "linux"
  endif
endfunction

function! SwitchToBuf(filename)
    "let fullfn = substitute(a:filename, "^\\~/", $HOME . "/", "")
    "find in current tab
    let bufwinnr = bufwinnr(a:filename)
    if bufwinnr != -1
        exec bufwinnr . "wincmd w"
        return
    else
        "Find in each tab
        tabfirst
        let tab = 1
        while tab <= tabpagenr("$")
            let bufwinnr = bufwinnr(a:filename)
            if bufwinnr != -1
                exec "normal " . tab . "gt"
                exec bufwinnr . "wincmd w"
                return
            endif
            tabnext
            let tab = tab + 1
        endwhile
        "Not exist, new tab
        exec "tabnew " . a:filename
    endif
endfunction









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
if MySys() == 'linux'
    "Fast reloading of .vimrc
    map <silent> <leader>ss :source ~/.vimrc<cr>
    "Fast editing of .vimrc
    map <silent> <leader>ee :call SwitchToBuf("~/.vimrc")<cr>
    "When .vimrc is edited, reload it
    autocmd! bufwritepost .vimrc source ~/.vimrc
elseif MySys() == 'windows'
    "Set helplang
    set helplang=cn
    "Fast reloading of the _vimrc
    map <silent> <leader>ss :source ~/_vimrc<cr>
    "Fast editing of _vimrc
    map <silent> <leader>ee :call SwitchToBuf("~/_vimrc")<cr>
    "When _vimrc is edited, reload it
    autocmd! bufwritepost _vimrc source ~/_vimrc
endif
"For windows version
if MySys() == 'windows'
    source $VIMRUNTIME/mswin.vim
    behave mswin
endif 









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
