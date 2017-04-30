"http://www.vim.org/scripts/script.php?script_id=2179
""""""""""""""""""""""""""""""""""""""
"SrcExpl: vimrc setting
""""""""""""""""""""""""""""""""""""""
let g:SrcExpl_winHeight = 8
let g:SrcExpl_refreshTime = 100
let g:SrcExpl_jumpKey = "<ENTER>"
let g:SrcExpl_gobackKey = "<SPACE>"
let g:SrcExpl_searchLocalDef = 1
let g:SrcExpl_prevDefKey = "<F6>"
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
