" @Author:      Tom Link (micathom AT gmail com?subject=[vim])
" @Website:     https://github.com/tomtom
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Last Change: 2017-02-06
" @Revision:    8
" GetLatestVimScripts: 0 0 :AutoInstall: workbook.vim

if &cp || exists("loaded_workbook")
    finish
endif
let loaded_workbook = 1

let s:save_cpo = &cpo
set cpo&vim


if !exists('g:workbook_autosetup_filetypes')
    let g:workbook_autosetup_filetypes = []   "{{{2
endif


command! -nargs=* -bang Workbook call workbook#GetRepl([<f-args>], !empty("<bang>"))


augroup Workbook
    autocmd!
    for s:ft in g:workbook_autosetup_filetypes
        exec 'autocmd Filetype' s:ft 'call workbook#SetupBuffer()'
    endfor
    unlet! s:ft
augroup END


let &cpo = s:save_cpo
unlet s:save_cpo
