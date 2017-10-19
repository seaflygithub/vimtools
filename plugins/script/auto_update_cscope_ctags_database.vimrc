" File              : plugins/script/auto_update_cscope_ctags_database.vimrc
" Author            : seafly <seafly0616@qq.com>
" Date              :58 PM
" Last Modified Date: 2017.10.18 11:10:14 PM
" Last Modified By  : seafly <seafly0616@qq.com>

" 插件: auto_update_cscope_ctags_database
" 功能: 自动更新同步工程数据库文件
" 地址: https://github.com/SeaflyGithub/auto_update_cscope_ctags_da
" 用法: vim打开工程顶层源文件并执行:Createtag命令进行同步工程
" 配置: *** ***
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
