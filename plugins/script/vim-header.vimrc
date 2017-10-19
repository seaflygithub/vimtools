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
