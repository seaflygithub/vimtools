" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Last Change: 2017-03-02
" @Revision:    35


if !exists('g:autoproject#projectrc#buffer_config')
    " A list of files for project-related buffer-local settings.
    " Only the first matching file will be loaded.
    let g:autoproject#projectrc#buffer_config = ['project.vim', '_projectvim/buffer.vim', '.projectvim/buffer.vim']   "{{{2
endif
if exists('g:autoproject#projectrc#buffer_config_user')
    let g:autoproject#projectrc#buffer_config += g:autoproject#projectrc#buffer_config_user
endif


if !exists('g:autoproject#projectrc#global_config')
    " A list of files for project-related settings. This file will be 
    " loaded when switching to a project via |:Autoprojectselect|.
    " Only the first matching file will be loaded.
    let g:autoproject#projectrc#global_config = ['_projectvim/global.vim', '.projectvim/global.vim']   "{{{2
endif
if exists('g:autoproject#projectrc#global_config_user')
    let g:autoproject#projectrc#global_config += g:autoproject#projectrc#global_config_user
endif


if !exists('g:autoproject#projectrc#sandbox')
    " If true, evaluate a file from |g:autoproject#projectrc#buffer_config| 
    " in a |sandbox|.
    let g:autoproject#projectrc#sandbox = 1   "{{{2
endif

let s:sandbox_cmd = g:autoproject#projectrc#sandbox ? 'sandbox' : ''


function! autoproject#projectrc#LoadConfig(rootdir, type) abort "{{{3
    Tlibtrace 'autoproject', a:rootdir, a:type
    call assert_true(exists('g:autoproject#projectrc#'. a:type .'_config'))
    for basename in g:autoproject#projectrc#{a:type}_config
        let filename = a:rootdir .'/'. basename
        Tlibtrace 'autoproject', filename, filereadable(filename)
        if filereadable(filename)
            exec s:sandbox_cmd 'source' fnameescape(filename)
            break
        endif
    endfor
endf


" let s:global_done = {}

function! autoproject#projectrc#LoadGlobalConfig(rootdir) abort "{{{3
    " let cdir = tlib#file#Canonic(fnamemodify(a:rootdir, ':p'))
    " if !has_key(s:global_done, cdir)
    call autoproject#projectrc#LoadConfig(a:rootdir, 'global')
    "     let s:global_done[cdir] = 1
    " endif
endf


function! autoproject#projectrc#LoadBufferConfig(rootdir) abort "{{{3
    if !exists('b:autoproject_pvim')
        let b:autoproject_pvim = 1
        call autoproject#projectrc#LoadConfig(a:rootdir, 'buffer')
    endif
endf


function! autoproject#projectrc#SearchAndLoad(rootdir) abort "{{{3
    " TODO
    return autoproject#projectrc#LoadBufferConfig(a:rootdir)
endf

