" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @Website:     https://github.com/tomtom
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Last Change: 2017-04-03
" @Revision:    116


if !exists('g:loaded_tlib') || g:loaded_tlib < 124
    runtime plugin/tlib.vim
    if !exists('g:loaded_tlib') || g:loaded_tlib < 124
        echoerr 'tlib >= 1.24 is required'
        finish
    endif
endif


if !exists('g:autoproject#list#enter_project_f')
    " A format string (see |printf()|). After selecting a project, 
    " |:execute| this command with the project's root directory filled 
    " in.
    "
    " The filename is inserted after as a result of |string()|. Thus, 
    " when using a command, you might have to do use values like:>
    "   'exec "Sexplore" fnameescape(%s)'
    "   'exec "NERDTree" fnameescape(%s)'
    let g:autoproject#list#enter_project_f = 'exec "Sexplore" fnameescape(%s)'   "{{{2
endif


if !exists('g:autoproject#list#files_reject_rx')
    let g:autoproject#list#files_reject_rx = g:tlib#file#reject_rx   "{{{2
endif


if !exists('g:autoproject#list#maxlen')
    let g:autoproject#list#maxlen = 999   "{{{2
endif


if !exists('g:autoproject#list#accept_markers')
    " A list of project markers (see |g:autoproject#cd#markers|) that 
    " will be registered as project root. All files in 
    " g:autoproject#list#accept_markers should be defined in 
    " |g:autoproject#cd#markers|.
    let g:autoproject#list#accept_markers = filter(keys(g:autoproject#cd#markers), 'v:val !=# ''default''') "{{{2
endif


TLet g:autoproject#list#world = {
            \ 'type': 's',
            \ 'query': 'Select project',
            \ 'scratch': '__autoproject_listing__',
            \ }


function! autoproject#list#GetReg() abort "{{{3
    let reg_cname = tlib#persistent#EncodedFilename('autoproject', '*registry*', 1)
    let reg = tlib#persistent#Get(reg_cname, [])
    return [reg_cname, reg]
endf


function! autoproject#list#RegisterNameDir(basename, dir) abort "{{{3
    if index(g:autoproject#list#accept_markers, a:basename) != -1
        call autoproject#list#RegisterDir(a:dir)
    endif
endf


function! autoproject#list#RegisterDir(dir, ...) abort "{{{3
    let setwd = a:0 >= 1 ? a:1 : 0
    let [reg_cname, reg] = autoproject#list#GetReg()
    let dir = tlib#file#Canonic(fnamemodify(a:dir, ':p'))
    let diri = index(reg, dir)
    if diri != 0
        if diri > 0
            call remove(reg, diri)
        endif
        call insert(reg, dir)
        if len(reg) > g:autoproject#list#maxlen
            let reg = reg[0 : (g:autoproject#list#maxlen - 1)]
        endif
        let reg = map(reg, 'substitute(v:val, ''[\/]\+$'', '''', '''')')
        let reg = tlib#list#Uniq(reg)
        call tlib#persistent#Save(reg_cname, reg)
    endif
    if setwd
        call autoproject#cd#SetCD('RegisterDir', a:dir)
    endif
endf


function! autoproject#list#Select(...) abort "{{{3
    let [reg_cname, reg] = autoproject#list#GetReg()
    " let dir = tlib#input#List('s', 'Select project:', reg)
    let w = tlib#World#New(g:autoproject#list#world)
    call w.Set_display_format('filename')
    let w.base = reg
    let dir = tlib#input#ListW(w)
    if !empty(dir)
        call autoproject#projectrc#LoadGlobalConfig(dir)
        if !g:autoproject_enable_sessions || !autoproject#session#MaybeRestore(dir, a:0 >= 1 ? a:1 : 0)
            let cmd = printf(g:autoproject#list#enter_project_f, string(dir))
            Tlibtrace 'autoproject', cmd
            exec cmd
        endif
    endif
endf


function! autoproject#list#Open(dir) abort "{{{3
    let base = matchstr(a:dir, '\%(^\|[\/]\)\zs[^\/]\+\ze[\/]\?$')
    let name = tlib#file#Join([a:dir, '__FILES@'. base .'__'])
    let scratch = tlib#scratch#UseScratch({'scratch': name})
    setl textwidth=0
    exec 'lcd' fnameescape(a:dir)
    let files = glob('**', 0, 1)
    let files = filter(files, '!isdirectory(v:val)')
    let files = filter(files, 'v:val !~# g:autoproject#list#files_reject_rx')
    let files = sort(files)
    % delete
    call append(0, files)
    1
    echo 'Use gf to open a file!'
endf

