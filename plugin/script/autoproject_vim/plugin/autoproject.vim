" @Author:      Tom Link (micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Last Change: 2017-04-22
" @Revision:    55
" GetLatestVimScripts: 5550 0 :AutoInstall: autoproject.vim

if &cp || exists('loaded_autoproject')
    finish
endif
let loaded_autoproject = 1

let s:save_cpo = &cpo
set cpo&vim


if !exists('g:autoproject_enable_cd')
    " If true, try to detect a file's project directory.
    let g:autoproject_enable_cd = !(&autochdir)   "{{{2
endif

if !exists('g:autoproject_enable_sessions')
    " If true, enable session handling.
    let g:autoproject_enable_sessions = 1   "{{{2
endif

if !exists('g:autoproject_map_edit')
    " Map to invoke |:edit| with a `%:p:h/` argument.
    let g:autoproject_map_edit = '<Leader><Leader>e'   "{{{2
endif

if !exists('g:autoproject_map_saveas')
    " Map to invoke |:saveas| with a `%:p:h/` argument.
    let g:autoproject_map_saveas = '<Leader><Leader>s'   "{{{2
endif


if !empty(g:autoproject_map_edit)
    exec 'nmap <expr>' g:autoproject_map_edit '":e ". expand("%:p:h") ."/"'
endif


if !empty(g:autoproject_map_saveas)
    exec 'nmap <expr>' g:autoproject_map_saveas '":saveas ". expand("%:p:h") ."/"'
endif


" :display: :Autoprojectselect[!]
" Switch to a project previously detected by autoproject that has an 
" acceptable project marker (see |g:file autoproject#list#accept_markers|).
" If |g:autoproject_enable_sessions| is true, restore a previous 
" session.
"
" With the optional bang "!", leave the previous session.
command! -bar -bang Autoprojectselect call autoproject#list#Select(!empty("<bang>"))


" :display: :Autoprojectregister[!] [DIR]
" Register DIR or the current buffer's directory and set the buffer's 
" working directory.
"
" With the optional bang "!", also set the buffer's directory.
command! -bang -nargs=? -bar -complete=dir Autoprojectregister call autoproject#list#RegisterDir(empty(<q-args>) ? expand('%:p:h') : <q-args>, !empty("<bang>"))


" :display: :Autoprojectfocus [PROJECT]
" Focus on PROJECT (or the current buffer's project), i.e. delete all 
" other buffers.
command! -bar Autoprojectfocus call autoproject#buffer#Focus(<f-args>)


if g:autoproject_enable_sessions

    " :display: :Autoprojectmksession [DIR]
    " Create a session for a working directory.
    " If no argument, a directory, is given, the current working 
    " directory (|getcwd()|) is used.
    command! -bar -nargs=? -complete=dir Autoprojectmksession call autoproject#session#Make(<q-args>)

    " Leave a session. Update the session file. Close all buffers.
    command! -bar Autoprojectleavesession call autoproject#session#Leave()

endif


augroup Autoproject
    autocmd!
    autocmd BufNewFile,BufRead * if !empty(bufname('%')) && empty(&buftype) && &buflisted && g:autoproject_enable_cd | call autoproject#cd#Buffer(expand("<afile>:p")) | else | call autoproject#projectrc#SearchAndLoad(expand('%:p:h')) | endif
    " autocmd VimLeave * if g:autoproject_enable_sessions | call autoproject#session#Leave(0) | endif
augroup END

if has('vim_starting')
    autocmd Autoproject VimEnter * doautoall Autoproject BufRead %
else
    doautoall Autoproject BufRead %
endif


let &cpo = s:save_cpo
unlet s:save_cpo
