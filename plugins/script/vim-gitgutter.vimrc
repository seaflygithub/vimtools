" File              : plugins/script/vim-gitgutter.vimrc
" Author            : 吴海飞 <seafly0616@qq.com>
" Date              : 2017.10.28 11时35分03秒
" Last Modified Date: 2017.10.28 11时40分26秒
" Last Modified By  : 吴海飞 <seafly0616@qq.com>
let g:gitgutter_enabled = 0
let g:gitgutter_highlight_lines = 1
let g:gitgutter_signs = 1
let g:gitgutter_max_signs = 500  " default value
let g:gitgutter_map_keys = 0    " disable all key mappings
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0
let g:gitgutter_override_sign_column_highlight = 0
if exists('&signcolumn')  " Vim 7.4.2201
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif
let g:gitgutter_sign_added = 'xx'
let g:gitgutter_sign_modified = 'yy'
let g:gitgutter_sign_removed = 'zz'
let g:gitgutter_sign_removed_first_line = '^^'
let g:gitgutter_sign_modified_removed = 'ww'
let g:gitgutter_diff_args = '-w'

" Default:
let g:gitgutter_grep_command = 'grep'
let g:gitgutter_async = 1

