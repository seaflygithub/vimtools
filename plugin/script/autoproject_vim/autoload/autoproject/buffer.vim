" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @Website:     https://github.com/tomtom
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Last Change: 2017-04-19
" @Revision:    7


if !exists('g:autoproject#buffer#unfocussed_rx')
    " A |regexp| of buffer names that will be ignored on 
    " |:Autoprojectfocus|.
    let g:autoproject#buffer#unfocussed_rx = '[\/]__\S\+__$'   "{{{2
endif


function! autoproject#buffer#Focus(...) abort "{{{3
    let project = a:0 >= 1 ? a:1 : getbufvar('%', 'autoproject_name', '')
    if !empty(project)
        bufdo call s:MaybeDeleteBuffer(project)
    endif
endf


function! s:MaybeDeleteBuffer(project) abort "{{{3
    if &buflisted && !empty(&buftype)
                \ && (empty(g:autoproject#buffer#unfocussed_rx) || bufname('%') !~# g:autoproject#buffer#unfocussed_rx)
                \ && getbufvar('%', 'autoproject_name', '') !=# a:project
        bdelete 
    endif
endf

