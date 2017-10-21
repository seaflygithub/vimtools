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
" File              : plugins/script/auto_update_cscope_ctags_database.vimrc
" Author            : seafly <seafly0616@qq.com>
" Date              : 2017.10.19
" Last Modified Date: 2017.10.19
" Last Modified By  : seafly <seafly0616@qq.com>

" 插件: auto_update_cscope_ctags_database
" 功能: 自动更新同步工程数据库文件
" 地址: https://github.com/SeaflyGithub/auto_update_cscope_ctags_da
" 用法: vim打开工程顶层源文件并执行:Createtag命令进行同步工程
" 配置: 如下
"#easy create new cscope and ctags databse by command :Createtag
"git@github.com:haolongzhangm/auto_update_cscope_ctags_database.git
"    https://github.com/haolongzhangm/auto_update_cscope_ctags_database
let g:check_update_when_first_load_vim = 1
let g:auto_run_function_when_cscope_connect = 1
let g:auto_update_cscope_ctags_database=1
let g:Auto_update_cscope_ctags_timer_filter=60
let g:Auto_update_cscope_ctags_debug_log=0
let g:Auto_update_cscope_ctags_lock_floor_max=1800
let g:auto_update_cscope_ctags_backup_run_py_dir_cache='~/.vim/plugin/auto_update_cscope_ctags_backup_run.py'
" File              : plugins/script/vim-markdown.vimrc
" Author            : seafly <seafly0616@qq.com>
" Date              :51 PM
" Last Modified Date: 2017.10.18 11:18:21 PM
" Last Modified By  : seafly <seafly0616@qq.com>

" 插件: vim-markdown
" 功能: markdown语法支持
" 地址: 
" 用法: ***
" 配置: *** ***
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
" File              : plugins/script/indentLine.vimrc
" Author            : seafly <seafly0616@qq.com>
" Date              :33 PM
" Last Modified Date: 2017.10.18 11:02:16 PM
" Last Modified By  : seafly <seafly0616@qq.com>
" 插件: indentLine
" 功能: 可视化语法缩进对齐线
" 地址: https://github.com/Yggdroot/indentLine
" 用法: ***
" 配置: *** ***
"https://github.com/Yggdroot/indentLine
let g:indentLine_enabled = 1
let g:indentLine_char = '|'
let g:indentLine_color_term = 239
" File              : plugins/script/minibufexpl.vimrc
" Author            : seafly <seafly0616@qq.com>
" Date              :05 PM
" Last Modified Date: 2017.10.18 10:59:13 PM
" Last Modified By  : seafly <seafly0616@qq.com>

" 插件: minibufexpl
" 功能: 文件名缓冲区窗口插件
" 地址: https://github.com/fholgado/minibufexpl.vim
" 用法: 如下
" b 3   跳转到3号标签文件
" bd 3  删除3号标签文件名缓冲区
" bd 1 2 3  删除1,2,3号标签文件名缓冲区
" bfirst    跳转到第一个文件名缓冲区
" blast     跳转到最后一个文件名缓冲区
" bprevious 跳转到上一个文件名缓冲区
" bnext     跳转到下一个文件名缓冲区
" 配置: *** ***
" 插件: bufexplorer
" 功能: 
" 地址: https://github.com/jlanzarotta/bufexplorer
" 用法: ***
" 配置: *** ***
" 插件: mark.vim
" 功能: 代码高亮标签标注
" 地址: https://github.com/Tuxdude/mark.vim
" 用法: 命令模式下输入 ,m即可标注，再输入,m即可取消标注
" 配置: *** ***
" 插件: comments.vim
" 功能: 代码批量注释插件
" 地址: https://github.com/sudar/comments.vim
" 用法: <Ctrl-c>注释, <Ctrl-x>取消注释
" 配置: *** ***
" 插件: a.vim
" 功能: 快速在相应.c和.h之间跳转
" 地址: https://github.com/csliu/a.vim
" 用法: 底行模式下输入 :A 即可相互切换，没有则自动创建
" 配置: *** ***
" 插件: vim-header
" 功能: 自动为源文件添加头部作者信息
" 地址: https://github.com/alpertuna/vim-header
" 用法: 
" 配置: 
" File              : SrcExpl.vimrc
" Author            : Your Name <your@mail>
" Date              : 2017.10.18
" Last Modified Date: 2017.10.18
" Last Modified By  : Your Name <your@mail>
" 插件: SrcExpl
" 功能: 预览源代码
" 用法: 如下
" 进入代码: 回车键  或  双击
" 回退浏览: 空格键
" 配置: 如下
let g:SrcExpl_winHeight = 15
let g:SrcExpl_refreshTime = 500
let g:SrcExpl_jumpKey = "<ENTER>"
let g:SrcExpl_gobackKey = "<SPACE>"
let g:SrcExpl_searchLocalDef = 1
"let g:SrcExpl_prevDefKey = "<F6>"
"let g:SrcExpl_nextDefKey = "<F7>"
" File              : nerdtree.vimrc
" Author            : Your Name <your@mail>
" Date              : 2017.10.18
" Last Modified Date: 2017.10.18
" Last Modified By  : Your Name <your@mail>
" 插件: nerdtree
" 功能: 在vim中管理目录文件树
" 用法: 见下
" 打开目录: o   或  鼠标双击该目录
" 关闭目录: o   或  鼠标双击该目录
" 打开文件: o   或  鼠标双击该目录
" 关闭目录树: x
" 插件: Trinity
" 功能: 强大的vim窗口管理插件
" 地址: https://github.com/wesleyche/Trinity
" 用法: 如下
" 启动vim窗口的sourceinsight模式: 按快捷键F8，关闭也按F8
" 配置: 
nmap <F8>   :TrinityToggleAll<CR>
"nmap <F9>   :TrinityToggleSourceExplorer<CR>
"nmap <F10>  :TrinityToggleTagList<CR>
"nmap <F11>  :TrinityToggleNERDTree<CR>
" File              : asyncrun.vimrc
" Author            : Your Name <your@mail>
" Date              : 2017.10.18
" Last Modified Date: 2017.10.18
" Last Modified By  : Your Name <your@mail>
" 插件: asyncrun
" 功能: 在vim中异步执行外部shell命令
" 用法: 底行模式输入 :AsyncRun command 回车即可运行该command
" 插件: code_complete
" 功能: 快速编辑代码
" 用法: 快速建立main函数: 输入main后紧接着按<tab>键
" 用法: 头文件插入预编译: 输入ff后紧接着按<tab>键
" 用法: 快速插入系统头文件: is<tab>
" 用法: 快速插入自定义头文件: in<tab>
" 用法: 快速插入if条件: ife3<tab>
" 用法: 快速插入switch条件: switch3<tab>
" 用法: 快速插入while循环: while<tab>
" 用法: 快速插入for循环: for<tab>
" 用法: 函数参数补齐提示: 如输入函数名fun(紧接着按<tab>键
" 用法: 函数快速定义: 如输入fun3<tab>表示定义一个三个参数函数
" 用法: 快速切换目标: 插入模式下按<tab>键快速切换
" File              : plugins/script/vim-header.vimrc
" Author            : seafly <seafly0616@qq.com>
" Date              :52 PM
" Last Modified Date: 2017.10.18 11:12:01 PM
" Last Modified By  : seafly <seafly0616@qq.com>
" 插件: vim-header
" 功能: 自动为源文件添加头部作者信息
" 用法: 底行模式输入":AddHeader"
" 用法: 编辑一个未创建的源文件
" 地址: https://github.com/alpertuna/vim-header
set showcmd         " 在状态栏显示正在输入的命令
set showmode        " 左下角显示当前vim模式
let g:header_field_filename = 1
let g:header_field_timestamp = 1
let g:header_field_timestamp_format = '%Y.%m.%d'
map <F2> :AddGNULicense<CR>
"let g:header_field_author = 'Your Name'
"let g:header_field_author_email = 'your@mail'
