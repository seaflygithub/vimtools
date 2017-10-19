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
