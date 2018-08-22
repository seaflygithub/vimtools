" File              : plugins/script/winmanager.vimrc
" Author            : seafly <seafly0616@qq.com>
" Date              : 2017.11.11 09时55分37秒
" Last Modified Date: 2017.11.11 09时55分37秒
" Last Modified By  : seafly <seafly0616@qq.com>
" File              : plugins/script/winmanager.vimrc
" Author            : seafly <seafly0616@qq.com>
" Date              : 2017.11.11 09时55分31秒
" Last Modified Date: 2017.11.11 09时55分31秒
" Last Modified By  : seafly <seafly0616@qq.com>
" 设置winmanager
" 设置界面分割
let g:winManagerWindowLayout = "FileExplorer|TagList"
"设置winmanager的宽度，默认为25
let g:winManagerWidth = 30
"定义打开关闭winmanager快捷键为F8
nmap <silent> <F12> :WMToggle<cr>
"在进入vim时自动打开winmanager
let g:AutoOpenWinManager = 1