" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @Website:     https://github.com/tomtom
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Last Change: 2017-02-10
" @Revision:    567


if !exists('g:loaded_tlib') || g:loaded_tlib < 122
    runtime plugin/tlib.vim
    if !exists('g:loaded_tlib') || g:loaded_tlib < 122
        echoerr 'tlib >= 1.22 is required'
        finish
    endif
endif

if exists(':Tlibtrace') != 2
    command! -nargs=+ -bang Tlibtrace :
endif


if !exists('g:workbook#map_evalblock')
    " Evaluate the current paragraph
    let g:workbook#map_evalblock = '<c-cr>'   "{{{2
endif

if !exists('g:workbook#map_evalblockinv')
    " Evaluate the current paragraph with |g:workbook#insert_results_in_buffer| temporarily inversed.
    let g:workbook#map_evalblockinv = '<c-s-cr>'   "{{{2
endif

if !exists('g:workbook#map_op')
    " Operator map
    let g:workbook#map_op = '<localleader>e'   "{{{2
endif

if !exists('g:workbook#map_leader')
    " Map leader
    let g:workbook#map_leader = '<localleader>w'   "{{{2
endif

if !exists('g:workbook#transcript')
    " If true, maintain a transcript
    let g:workbook#transcript = 1   "{{{2
endif

if !exists('g:workbook#insert_results_in_buffer')
    " If true, insert the results of an evaluation below the evaluated 
    " code.
    "
    " This parameter will be overridden by the value of 
    " b:workbook_insert_results_in_buffer_once or 
    " b:workbook_insert_results_in_buffer if existant.
    let g:workbook#insert_results_in_buffer = 1   "{{{2
endif


if !exists('g:workbook#handlers')
    let g:workbook#handlers = [{'key': 5, 'agent': 'workbook#EditItem', 'key_name': '<c-e>', 'help': 'Edit item'}]   "{{{2
endif


augroup Workbook
    autocmd!
    autocmd VimLeave * call workbook#StopAll()
augroup END


let s:repls = {}
let s:buffers = {}


function! s:GetBufRepl(bufnr) abort "{{{3
    Tlibtrace 'workbook', a:bufnr
    let rid = s:buffers[a:bufnr]
    Tlibtrace 'workbook', rid
    return s:repls[rid]
endf


function! workbook#GetRepl(...) abort "{{{3
    Tlibtrace 'workbook', a:0
    if a:0 >= 1
        if type(a:1) == 4
            let args = a:1
        else
            let args = tlib#arg#GetOpts(a:1)
        endif
    else
        let args = {}
    endif
    let reset = a:0 >= 2 ? a:2 : 0
    let bufnr = bufnr('%')
    Tlibtrace 'workbook', reset, bufnr, keys(args)
    if reset && has_key(s:buffers, bufnr)
        call workbook#Stop(args, s:GetBufRepl(bufnr))
    endif
    if !has_key(s:buffers, bufnr)
        let repl = workbook#InitBuffer(args, bufnr)
    else
        let repl = s:GetBufRepl(bufnr)
    endif
    return repl
endf


function! workbook#GetID(args, bufnr) abort "{{{3
    Tlibtrace 'workbook', a:bufnr, keys(a:args)
    let id = printf('%s/%s_%s', getcwd(), getbufvar(a:bufnr, '&ft', ''), join(get(a:args, '__rest__', []), ','))
    return id
endf


function! workbook#InitBuffer(args, ...) abort "{{{3
    let bufnr = a:0 >= 1 ? a:1 : bufnr('%')
    let id = workbook#GetID(a:args, bufnr)
    Tlibtrace 'workbook', bufnr, id
    if has_key(s:repls, id)
        let repl = s:repls[id]
    else
        let repl = workbook#repl#New(a:args)
        let repl.id = id
        call repl.Start()
        if has_key(repl, 'InitFiletype')
            call repl.InitFiletype()
        endif
        let s:repls[id] = repl
    endif
    let s:buffers[bufnr] = id
    call workbook#SetupBuffer()
    if has_key(repl, 'quicklist')
        exec 'nnoremap <buffer> '. g:workbook#map_leader .'q :call workbook#Quicklist(expand("<cword>"))<cr>'
        exec 'vnoremap <buffer> '. g:workbook#map_leader .'q :call workbook#Quicklist(join(tlib#selection#GetSelection("v"), " "))<cr>'
    endif
    if has_key(repl, 'InitBufferFiletype')
        call repl.InitBufferFiletype()
    endif
    return repl
endf


function! workbook#SetupBuffer() abort "{{{3
    if !exists('b:workbook_setup_done')
        let b:workbook_setup_done = 1
        autocmd Workbook Bufwipeout <buffer> call workbook#RemoveBuffer(expand("<abuf>"))
        command -buffer -nargs=1 Workbooksend call workbook#Send(<q-args>)
        command -buffer -nargs=1 Workbookeval echo workbook#Eval(<q-args>)
        command -buffer Workbookrepl call workbook#InteractiveRepl()
        command -buffer Workbookclear call workbook#StripResults(1, line('$'))
        command -buffer Workbookhelp call workbook#Help()
        exec 'nmap <buffer>' g:workbook#map_evalblock g:workbook#map_op.'ip'
        exec 'nmap <buffer>' g:workbook#map_evalblockinv ':let b:workbook_insert_results_in_buffer_once = !g:workbook#insert_results_in_buffer<cr>'. g:workbook#map_op.'ip'
        exec 'nnoremap <buffer>' g:workbook#map_op ':set opfunc=workbook#Op<cr>g@'
        exec 'vnoremap <buffer>' g:workbook#map_op ':<c-u>call workbook#Op(visualmode(), 1)<cr>'
        exec 'nnoremap <buffer>' g:workbook#map_op .'w :call workbook#Print(line("."), line("."))<cr>'
        exec 'nnoremap <buffer>' g:workbook#map_leader .'r :call workbook#InteractiveRepl()<cr>'
        exec 'nnoremap <buffer>' g:workbook#map_leader .'c :call workbook#StripResults(line("."), line("."))<cr>'
        exec 'nnoremap <buffer>' g:workbook#map_leader .'C :call workbook#StripResults(1, line("$"))<cr>'
        exec 'nnoremap <buffer>' g:workbook#map_leader .'<f1> :Workbookhelp<cr>'
        " exec 'syntax match WorkbookResult /'. escape(repl.GetResultLineRx(1), '/') .'/ contains=@'. &ft
        if &omnifunc !=# 'workbook#OmniComplete'
            let b:workbook_orig_omnifunc = &omnifunc
            setl omnifunc=workbook#OmniComplete
        endif
    endif
endf


function! workbook#UndoSetup() abort "{{{3
    let bufnr = bufnr('%')
    if has_key(s:buffers, bufnr)
        let repl = workbook#GetRepl()
        if has_key(repl, 'UndoFiletype')
            call repl.UndoFiletype()
        endif
    endif
    delcommand Workbooksend
    delcommand Workbookeval
    delcommand Workbookrepl
    delcommand Workbookclear
    nunmap <buffer> g:workbook#map_evalblock
    nunmap <buffer> g:workbook#map_evalblockinv
    exec 'nunmap <buffer>' g:workbook#map_op
    exec 'vunmap <buffer>' g:workbook#map_op
    exec 'nunmap <buffer>' g:workbook#map_op .'w'
    exec 'nunmap <buffer>' g:workbook#map_leader .'e'
    exec 'nunmap <buffer>' g:workbook#map_leader .'c'
    exec 'nunmap <buffer>' g:workbook#map_leader .'C'
    let &l:omnifunc = b:workbook_orig_omnifunc
    unlet! b:workbook_orig_omnifunc
    unlet! b:workbook_setup_done
endf


function! workbook#Help() abort "{{{3
    echom 'Commands:'
    " :nodoc:
    command Workbook
    echom ' '
    echom 'Maps:'
    echom 'Use' g:workbook#map_evalblock 'to evaluate the current paragraph.'
    echom 'Use' g:workbook#map_evalblockinv 'to evaluate the current paragraph with g:workbook#insert_results_in_buffer inversed.'
    exec 'map' g:workbook#map_op
    exec 'map' g:workbook#map_leader
endf

" Called from BufDelete
function! workbook#RemoveBuffer(bufnr) abort "{{{3
    if has_key(s:buffers, a:bufnr)
        let id = remove(s:buffers, a:bufnr)
        Tlibtrace 'workbook', a:bufnr, id
        if index(values(s:buffers), id) ==# -1
            let repl = s:repls[id]
            call workbook#Stop({}, repl)
        endif
    endif
endf


function! workbook#Op(type, ...) abort "{{{3
    call assert_true(type(a:type) == v:t_string)
    let sel_save = &selection
    let &selection = "inclusive"
    try
        let l1 = line("'[")
        let l2 = line("']")
        Tlibtrace 'workbook', l1, l2, a:type
        if a:type ==# 'line'
            " if exists('s:by_paragraph')
                call workbook#Print(l1, l2)
            " else
            "     let repl = workbook#GetRepl()
            "     let result_rx = repl.GetResultLineRx()
            "     let s:by_paragraph = 1
            "     let m = line("'m")
            "     exec l2 'mark m'
            "     try
            "         let lbeg = 1
            "         while lbeg <= line("'m")
            "             let lend = lbeg
            "             let lline = getline(lend + 1)
            "             while lend < line('$') && !empty(lline) && lline !~# result_rx
            "                 let lend += 1
            "                 let lline = getline(lend + 1)
            "             endwh
            "             echom "DBG" lbeg lend string(getline(lbeg, lend))
            "             call workbook#Print(lbeg, lend)
            "             let lbeg = lend + 1
            "             let lline = getline(lbeg)
            "             while lbeg <= line("'m") && (empty(lbeg) || lbeg =~ result_rx)
            "                 let lbeg += 1
            "                 let lline = getline(lbeg)
            "             endwh
            "         endwh
            "         norm! 'm
            "     finally
            "         delmark m
            "         if m > 0
            "             exec m 'mark m'
            "         endif
            "         unlet! s:by_paragraph
            "     endtry
            " endif
        else
            if a:type ==# 'block'
                silent exe "normal! `[\<C-V>`]yy"
            elseif a:type ==# 'char'
                silent exe "normal! `[v`]yy"
            else
                silent exe "normal! `[v`]yy"
            endif
            let lines = split(@", "\n")
            Tlibtrace 'workbook', a:type, lines
            call workbook#Print(l1, l2, lines)
        endif
        " norm! `<
    finally
        let &selection = sel_save
    endtry
endf


function! workbook#Stop(...) abort "{{{3
    if a:0 >= 1
        if type(a:1) == 4
            let args = a:1
        else
            let args = tlib#arg#GetOpts(a:1)
        endif
    else
        let args = {}
    endif
    call assert_true(type(args) == v:t_dict)
    if a:0 >= 2
        let repl = a:2
    else
        if has_key(s:buffers, bufnr('%'))
            let repl = workbook#GetRepl(args)
        else
            return
        endif
    endif
    call assert_true(type(repl) == v:t_dict)
    let id = repl.id
    Tlibtrace 'workbook', id
    if has_key(s:repls, id)
        let s:buffers = filter(s:buffers, {key, val -> val != id})
        call repl.Stop(args)
        unlet! s:repls[id]
    endif
    call assert_true(index(values(s:buffers), id) == -1)
    call assert_true(index(keys(s:repls), id) == -1)
endf


function! workbook#StopAll(...) abort "{{{3
    let args = a:0 >= 1 ? a:1 : {}
    for repl in values(s:repls)
        call repl.Stop(args)
    endfor
    let s:repls = {}
    let s:buffers = {}
endf


function! workbook#Print(line1, line2, ...) abort "{{{3
    Tlibtrace 'workbook', a:line1, a:line2
    let repl = workbook#GetRepl()
    let [line1, line2] = workbook#StripResults(a:line1, a:line2, repl)
    Tlibtrace 'workbook', line1, line2
    " TODO allow for in line selection
    let lines = a:0 >= 1 ? a:1 : getline(line1, line2)
    Tlibtrace 'workbook', lines
    let code = join(lines, "\n")
    let indent = matchstr('^\s\+', code)
    let placeholder = repl.GetPlaceholder(code)
    Tlibtrace 'workbook', placeholder
    if repl.DoInsertResultsInBuffer()
        let pline = indent . repl.GetResultLine('p', placeholder)
        call append(line2, [pline])
    else
        let pline = ''
    endif
    let rid = repl.id
    Tlibtrace 'workbook', rid
    call repl.SetPlaceholder(bufnr('%'), placeholder, pline)
    " async
    if repl.DoTranscribe()
        call repl.Transcribe('c', lines)
    endif
    call repl.Send(code, placeholder)
endf


function! workbook#StripResults(line1, line2, ...) abort "{{{3
    Tlibtrace 'workbook', a:line1, a:line2
    let repl = a:0 >= 1 ? a:1 : workbook#GetRepl()
    let result_rx = repl.GetResultLineRx()
    let line1 = a:line1
    let line2 = a:line2
    let line3 = a:line2 + 1
    let line = getline(line3)
    while line3 <= line('$') && line =~ result_rx
        exec line3 'delete'
        let line = getline(line3)
    endwh
    for lnum in range(line2, line1, -1)
        if getline(lnum) =~ result_rx
            exec lnum 'delete'
            let line2 -= 1
        endif
    endfor
    return sort([line1, line2], {i1, i2 -> i1 == i2 ? 0 : i1 > i2 ? 1 : -1})
endf


function! workbook#Send(code) abort "{{{3
    Tlibtrace 'workbook', a:code
    let repl = workbook#GetRepl()
    let p = repl.GetPlaceholder(a:code)
    call repl.SetPlaceholder(0, p, '')
    call repl.Send(a:code, p)
endf


function! workbook#Eval(code) abort "{{{3
    Tlibtrace 'workbook', a:code
    let repl = workbook#GetRepl()
    " sync
    return repl.Eval(a:code)
endf


function! workbook#OmniComplete(findstart, base) abort "{{{3
    Tlibtrace 'workbook', a:findstart, a:base
    let repl = workbook#GetRepl()
    if !has_key(repl, 'Complete')
        if exists('b:workbook_orig_omnifunc')
            let &l:omnifunc = b:workbook_orig_omnifunc
            unlet! b:workbook_orig_omnifunc
            return empty(&l:omnifunc) ? [] : call(&l:omnifunc, [a:findstart, a:base])
        endif
    else
        if a:findstart
            let line = getline('.')
            let start = col('.') - 1
            let rx = has_key(repl, 'GetKeywordRx') ? repl.GetKeywordRx() : '\k'
            while start > 0 && line[start - 1] =~ rx
                let start -= 1
            endwhile
            return start
        else
            let values = repl.Complete(a:base)
            if empty(values) && exists('b:workbook_orig_omnifunc') && !empty(b:workbook_orig_omnifunc)
                let values = call(b:workbook_orig_omnifunc, [a:findstart, a:base])
            endif
            return values
        endif
    endif
endf


function! workbook#InteractiveRepl() abort "{{{3
    let repl = workbook#GetRepl()
    if !repl.DoTranscribe()
        let transcribe = repl.DoTranscribe()
        call repl.SetTranscribe(1)
    endif
    try
        let ignore_output = get(repl, 'ignore_output', 0)
        if ignore_output == 0
            let repl.ignore_output = 1
        endif
        call inputsave()
        while 1
            let code = input('> ')
            if empty(code)
                break
            else
                call repl.Transcribe('i', [code], 1)
                call repl.Input(code, 1)
            endif
        endwh
        call inputrestore()
    finally
        if ignore_output == 0
            let repl.ignore_output = 0
        endif
        if exists('transcribe')
            call repl.SetTranscribe(transcribe)
        endif
    endtry
endf


function! workbook#NextCmd() abort "{{{3
    let repl = workbook#GetRepl()
    if !empty(repl.next_cmd)
        let cmd = remove(repl.next_cmd, 0)
        exec cmd
    endif
endf


function! workbook#Quicklist(word) "{{{3
    " TLogVAR a:word
    let repl = workbook#GetRepl()
    if has_key(repl, 'quicklist')
        let ql = map(copy(repl.quicklist), 'tlib#string#Printf1(v:val, a:word)')
        let code = tlib#input#List('s', 'Select function:', ql, g:workbook#handlers)
        if !empty(code)
            call workbook#Send(code)
        endif
    endif
endf


function! workbook#EditItem(world, items) "{{{3
    " TLogVAR a:items
    let item = get(a:items, 0, '')
    call inputsave()
    let item = input('Edit> ', item)
    call inputrestore()
    " TLogVAR item
    if item != ''
        let a:world.rv = item
        let a:world.state = 'picked'
        return a:world
    endif
    let a:world.state = 'redisplay'
    return a:world
endf


