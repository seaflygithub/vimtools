" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @Website:     https://github.com/tomtom
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Last Change: 2017-02-10
" @Revision:    17


let s:prototype = {}


function! workbook#mode#vim_eval#New(ext) abort "{{{3
    let o = extend(a:ext, s:prototype)
    return o
endf


function! s:prototype.Start(...) abort dict "{{{3
endf


function! s:prototype.Stop(args) abort dict "{{{3
endf


function! s:prototype.IsReady() abort dict "{{{3
    return 1
endf


function! s:prototype.SendToRepl(code, ...) abort dict "{{{3
    let nl = a:0 >= 1 ? a:1 : 0
    let placeholder = a:0 >= 2 ? a:2 : ''
    let t = @t
    let @t = a:code
    try
        redir => out
        silent @t
        redir END
        Tlibtrace 'workbook', 'SendToRepl', out
        call self.ConsumeOutput('', out, placeholder)
        " call self.ProcessOutput(placeholder)
    finally
        let @t = t
    endtry
endf


