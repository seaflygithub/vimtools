" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @Website:     https://github.com/tomtom
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Last Change: 2017-02-13
" @Revision:    392

if !exists('g:loaded_tlib') || g:loaded_tlib < 122
    runtime plugin/tlib.vim
    if !exists('g:loaded_tlib') || g:loaded_tlib < 122
        echoerr 'tlib >= 1.22 is required'
        finish
    endif
endif


if !exists('g:workbook#ft#r#cmd')
    let g:workbook#ft#r#cmd = executable('Rterm') ? 'Rterm' : 'R'   "{{{2
endif
if !executable(g:workbook#ft#r#cmd)
    throw 'Workbook: g:workbook#ft#r#cmd is not executable: '. g:workbook#ft#r#cmd
endif


if !exists('g:workbook#ft#r#args')
    " let g:workbook#ft#r#args = '--slave --no-save'   "{{{2
    let g:workbook#ft#r#args = '--silent --no-save '. (g:workbook#ft#r#cmd =~ '\<Rterm\%(\.exe\)\>' ? '--ess' : '--no-readline --interactive')   "{{{2
endif


if !exists('g:workbook#ft#r#init_script')
    let g:workbook#ft#r#init_script = simplify(expand('<sfile>:p:h') .'/workbook_vim.R')  "{{{2
endif


if !exists('g:workbook#ft#r#init_code')
    let g:workbook#ft#r#init_code = ''   "{{{2
endif


" if !exists('g:workbook#ft#r#help_type')
"     " Other help types may not work.
"     let g:workbook#ft#r#help_type = ''   "{{{2
" endif


if !exists('g:workbook#ft#r#comment_rxf')
    let g:workbook#ft#r#comment_rxf = '#%s %s'   "{{{2
endif


if !exists('g:workbook#ft#r#quicklist')
    let g:workbook#ft#r#quicklist = ['??"%s"', 'str(%s)', 'summary(%s)', 'head(%s)', 'edit(%s)', 'fix(%s)', 'debugger()', 'traceback()', 'install.packages("%s")', 'update.packages()', 'example("%s")', 'graphics.off()']   "{{{2
    if exists('g:workbook#ft#r_quicklist_etc')
        let g:workbook#ft#r#quicklist += g:workbook#ft#r_quicklist_etc
    endif
endif


if !exists('g:workbook#ft#r#highlight_debug')
    " Highlight group for debugged functions.
    let g:workbook#ft#r#highlight_debug = 'SpellRare'   "{{{2
endif


if !exists('g:workbook#ft#r#use_rserve')
    " Defined how to talk to R. Possible values are:
    " '' ......... run via |job_start()|
    " 'rserve' ... Use Rserve (doesn't work properly yet)
    let g:workbook#ft#r#mode = ''   "{{{2
endif


if !exists('g:workbook#ft#r#wait_after_send_line')
    let g:workbook#ft#r#wait_after_send_line = '100m'   "{{{2
endif


let s:wrap_code_f = "tryCatch(with(withVisible({%s\n}), if (visible) print(value)), finally = {cat(\"\\n%s\\n\"); flush.console()})"   "{{{2
" let s:wrap_code_f = "{%s\n}; cat(\"\\n%s\\n\"); flush.console()"   "{{{2


let s:prototype = {'debugged': {}
            \ , 'quicklist': g:workbook#ft#r#quicklist
            \ }
            " \ ,'repl_type': 'vim_nl'
            " \ ,'repl_type': 'vim_raw'

function! workbook#ft#r#New(ext) abort "{{{3
    let o = extend(a:ext, s:prototype)
    return o
endf


function! s:prototype.GetFiletypeCmdAndArgs() abort dict "{{{3
    return [g:workbook#ft#r#cmd, g:workbook#ft#r#args]
endf


function! s:prototype.InitFiletype() abort dict "{{{3
    if filereadable(g:workbook#ft#r#init_script)
        call self.Send(printf('source("%s")', substitute(g:workbook#ft#r#init_script, '\\', '/', 'g')))
    endif
    " let p = self.GetPlaceholder('startup message')
    " call self.SetPlaceholder(0, p, '')
    " call self.Send(printf('options(help_type = %s)', empty(g:workbook#ft#r#help_type) ? 'NULL' : string(g:workbook#ft#r#help_type)))
    call self.Send(g:workbook#ft#r#init_code)
    " call workbook#ft#r#Cd()
    call self.Send('flush.console()')
    " call self.Input("\n\n", 0)
endf


function! s:prototype.ExitFiletype(args) abort dict "{{{3
    let qargs = get(a:args, 'save', 0) || get(self, 'save', 0) ? 'save = "yes"' : ''
    let cmd = printf('q(%s)', qargs)
    call self.Send(cmd)
endf


function! s:prototype.InitBufferFiletype() abort dict "{{{3
    if &buftype != 'nofile'
        let filename = substitute(expand('%:p'), '\\', '/', 'g')
        " let wd = substitute(expand('%:p:h'), '\\', '/', 'g')
        " let wd = substitute(getcwd(), '\\', '/', 'g')
        exec 'nnoremap <buffer>' g:workbook#map_leader .'s :call workbook#Send(''source('. string(filename) .')'')<cr>'
    endif
    exec 'nnoremap <buffer>' g:workbook#map_leader .'cd :call workbook#ft#r#Cd()<cr>'
    " if &keywordprg =~# '^\%(:\?help$\|man\>\)'
    "     nnoremap <buffer> K :call workbook#Send('workbookKeyword(<c-r><c-w>, "<c-r><c-w>")')<cr>
    " endif
    exec 'nnoremap <buffer>' g:workbook#map_leader .'k :call workbook#Send(''workbookKeyword(<c-r><c-w>, "<c-r><c-w>")'')<cr>'
    exec 'nnoremap <buffer>' g:workbook#map_leader .'f :echo "<c-r><c-w>" workbook#Eval(''args("<c-r><c-w>")'')<cr>'
    exec 'nnoremap <buffer> '. g:workbook#map_leader .'d :call workbook#ft#r#Debug(expand("<cword>"))<cr>'
    exec 'vnoremap <buffer> '. g:workbook#map_leader .'d ""p:call workbook#ft#r#Debug(@")<cr>'
endf


function! s:prototype.UndoFiletype() abort dict "{{{3
    exec 'nunmap <buffer>' g:workbook#map_leader .'cd'
    exec 'nunmap <buffer>' g:workbook#map_leader .'s'
    exec 'nunmap <buffer>' g:workbook#map_leader .'f'
    exec 'nunmap <buffer>' g:workbook#map_leader .'q'
    exec 'vunmap <buffer>' g:workbook#map_leader .'q'
    exec 'nunmap <buffer>' g:workbook#map_leader .'d'
    exec 'vunmap <buffer>' g:workbook#map_leader .'d'
    " nunmap <buffer> K
    exec 'nunmap <buffer>' g:workbook#map_leader .'k'
endf


" function! s:prototype.PreprocessNlMessage(msg) abort dict "{{{3
"     let parts = split(a:msg, "\<c-h>\\+\<c-m>\\?", 1)
"     return parts[-1]
" endf


" function! s:prototype.PreprocessRawMessage(msg) abort dict "{{{3
"     echom "DBG" string(a:msg)
"     let parts = split(a:msg, '\n', 1)
"     let parts = map(parts, {i,p -> self.PreprocessNlMessage(p)})
"     return join(parts, "\n")
" endf


function! s:prototype.ProcessMessage(msg) abort dict "{{{3
    Tlibtrace 'workbook', 'ProcessMessage', a:msg
    let rx = printf("\\V\\%(\\^\\|\n\\)\\(\\[>+]\\s\\*\\)\\?". escape(s:wrap_code_f, '\') ."\\%(\\$\\|\n\\)", '\_.\{-}', '---- \S\+ ----')
    Tlibtrace 'workbook', 'ProcessMessage', rx
    let msg = substitute(a:msg, rx, '\n', 'g')
    Tlibtrace 'workbook', 'ProcessMessage', msg
    return msg
endf


function! s:prototype.ProcessLine(line) abort dict "{{{3
    "" Doesn't work because it will be called recursively
    if a:line =~# '^Browse\[\d\+\]>'
        echohl WarningMsg
        echom 'Workbook/r:' a:line
        echohl NONE
    "     " call add(self.next_cmd, 'Worbookrepl')
    "     if !has_key(self, 'browser_mode')
    "         call timer_start(500, function('workbook#ft#r#BrowserHandler'))
    "     endif
    endif
    return substitute(a:line, '^\%([>+] \)\+', '', 'g')
endf


if !empty(g:workbook#ft#r#wait_after_send_line)
    function! s:prototype.ProcessSendLine(Sender) abort dict "{{{3
        call a:Sender()
        exec 'sleep' g:workbook#ft#r#wait_after_send_line
    endf
endif


function! s:prototype.GetResultLineRxf() abort dict "{{{3
    return g:workbook#ft#r#comment_rxf
endf


" function! s:prototype.GetKeywordRx() abort dict "{{{3
" endf


function! s:prototype.Complete(text) abort dict "{{{3
    let cmd = printf('workbookComplete(%s)', string(a:text))
    let cs = self.Eval(cmd)
    return split(cs, "\t")
endf


function! s:prototype.WrapCode(placeholder, code) abort dict "{{{3
    if g:workbook#ft#r#mode ==# 'rserve'
        let code = printf('workbookRserveEval(with(withVisible({%s}), if (visible) {print(value); value}))', a:code)
    else
        let code = a:code
    endif
    let wcode = printf(s:wrap_code_f, code, self.GetEndMark(a:placeholder))
    return wcode
endf


" function! s:prototype.FilterOutputLines(lines) abort dict "{{{3
"     " let rx = printf('\V'. escape(s:wrap_code_f, '\'), '\.\{-}', '---- \S\+ ----')
"     " Tlibtrace 'workbook', 'FilterOutputLines', a:lines
"     " Tlibtrace 'workbook', 'FilterOutputLines', rx
"     " return filter(a:lines, {i,v -> v !~# rx})
" endf


function! s:prototype.Debug(fn) abort dict "{{{3
    " TLogVAR fn
    if !empty(a:fn) && !get(self.debugged, a:fn, 0)
        let r = printf('{debug(%s); "ok"}', a:fn)
        let rv = self.Eval(r)
        " TLogVAR rv
        if rv == "ok"
            let self.debugged[a:fn] = 1
            call self.HighlightDebug()
        else
            echohl Error
            echom "Workbook/r: Cannot debug ". a:fn
            echohl NONE
        endif
    else
        call workbook#ft#r#Undebug(a:fn)
    endif
endf


function! s:prototype.Undebug(fn) abort dict "{{{3
    let fn = a:fn
    if empty(fn)
        let fn = tlib#input#List('s', 'Select function:', sort(keys(self.debugged)))
    endif
    if !empty(fn)
        if has_key(self.debugged, fn)
            let self.debugged[fn] = 0
            echom "Workbook/r: Undebug:" a:fn
        else
            echom "Workbook/r: Not a debugged function?" fn
        endif
        let r = printf('undebug(%s)', fn)
        call self.Send(r)
        call self.HighlightDebug()
    endif
endf


function! s:prototype.HighlightDebug() abort dict "{{{3
    let bufnr = bufnr('%')
    try
        for [bnr, rid] in items(s:buffers)
            if rid == self.id
                exec 'hide buffer' bnr
                if b:workbook_r_hl_init
                    syntax clear WorkbookRDebug
                else
                    exec 'hi def link WorkbookRDebug' g:workbook#ft#r#highlight_debug
                    let b:workbook_r_hl_init = 1
                endif
                if !empty(self.debugged)
                    let debugged = map(copy(self.debugged), 'escape(v:val, ''\'')')
                    exec 'syntax match WorkbookRDebug /\V\<\('. join(debugged, '\|') .'\)\>/'
                endif
            endif
        endfor
    finally
        exec 'hide buffer' bufnr
    endtry
endf


function! workbook#ft#r#Cd() abort "{{{3
    let wd = substitute(getcwd(), '\\', '/', 'g')
    exec 'Workbooksend setwd('. string(wd) .')'
endf


" Toggle the debug status of a function.
function! workbook#ft#r#Debug(fn) "{{{3
    let repl = workbook#GetRepl()
    call repl.Debug(a:fn)
endf


" Undebug a debugged function.
function! workbook#ft#r#Undebug(fn) "{{{3
    let repl = workbook#GetRepl()
    call repl.Undebug(a:fn)
endf


function! workbook#ft#r#BrowserHandler(timer) abort "{{{3
    call workbook#InteractiveRepl()
endf

