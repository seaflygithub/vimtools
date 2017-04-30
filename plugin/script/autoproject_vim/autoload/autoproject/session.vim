" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @Website:     https://github.com/tomtom
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Last Change: 2017-03-03
" @Revision:    52


if !exists('g:autoproject#session#dir')
    " Where to keep session files. If empty, use the first entry in 
    " 'runtimepath'.
    let g:autoproject#session#dir = ''   "{{{2
endif


let s:current_session = ''


function! s:GetSessionFilename(...) abort "{{{3
    let dir = a:0 >= 1 && !empty(a:1) ? fnamemodify(a:1, ':p:h') : getcwd()
    Tlibtrace 'autoproject', dir
    let cdir = tlib#file#Canonic(dir)
    Tlibtrace 'autoproject', cdir
    let sid = sha256(cdir)
    if empty(g:autoproject#session#dir)
        let sdir = tlib#file#Canonic(split(&rtp, ',')[0])
        if sdir !~# '/$'
            let sdir .= '/'
        endif
        let sdir .= 'autoproject/'
        if !isdirectory(sdir)
            call mkdir(sdir, 'p')
        endif
    else
        let sdir = g:autoproject#session#dir
    endif
    let sname = sdir . sid
    Tlibtrace 'autoproject', sname
    return sname
endf


function! autoproject#session#MaybeRestore(...) abort "{{{3
    if !empty(s:current_session)
        let leave = a:0 >= 2 ? a:2 : 0
        if leave
            call autoproject#session#Leave()
        else
            let s:current_session = '*'
            echohl WarningMsg
            echom 'Autoproject: Multiple sessions; no session will be saved when leaving'
            echohl NONE
        endif
    endif
    let fname = s:GetSessionFilename(get(a:000, 0, ''))
    if filereadable(fname)
        exec 'source' fnameescape(fname)
        let s:current_session = fname
        return 1
    endif
    return 0
endf


function! autoproject#session#Leave(...) abort "{{{3
    if !empty(s:current_session)
        let bdel = a:0 >= 1 ? a:1 : 1
        if s:current_session !=# '*'
            exec 'mksession!' fnameescape(s:current_session)
        endif
        if bdel
            bufdo bdelete
        endif
        let s:current_session = ''
    endif
endf


function! autoproject#session#Make(...) abort "{{{3
    let fname = call(function('s:GetSessionFilename'), a:000)
    exec 'mksession!' fnameescape(fname)
    let s:current_session = fname
endf

