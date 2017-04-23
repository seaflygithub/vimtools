"README.md: https://github.com/lifepillar/vim-mucomplete

"Mandatory Vim settings:
set completeopt+=menuone

"For automatic completion, you also need to put these in your vimrc:
"inoremap <expr> <c-e> mucomplete#popup_exit("\<c-e>")
"inoremap <expr> <c-y> mucomplete#popup_exit("\<c-y>")
"inoremap <expr>  <cr> mucomplete#popup_exit("\<cr>")

"Other recommended settings:

"No other configuration is needed. Just start pressing <tab> or <s-tab> to complete a word. If you want to enable automatic completion at startup, put:
let g:mucomplete#enable_auto_at_startup = 1

"The first example shows µcomplete automatically offering suggestions from jedi-vim, which provides semantic completion for Python. Used settings:
set completeopt-=preview
let g:jedi#popup_on_dot = 0  " It may be 1 as well
let g:mucomplete#enable_auto_at_startup = 1

"The second example shows how different completion methods (omni completion, keyword completion, file completion) are automatically selected in different contexts. Used settings:
let g:mucomplete#user_mappings = { 'sqla' : "\<c-c>a" }
let g:mucomplete#chains = { 'sql' : ['file', 'sqla', 'keyn'] }
let g:mucomplete#enable_auto_at_startup = 1

set noinfercase
set completeopt-=preview
" The following line assumes `brew install llvm` in macOS
let g:clang_library_path = '/usr/local/opt/llvm/lib/libclang.dylib'
let g:clang_user_options = '-std=c++14'
let g:clang_complete_auto = 1
let g:mucomplete#enable_auto_at_startup = 1
