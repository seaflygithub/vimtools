" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @Website:     https://github.com/tomtom
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Last Change: 2017-02-11
" @Revision:    34



let s:prototype = {}


function! workbook#mode#vim_nl#New(ext) abort "{{{3
    let o = extend(a:ext, s:prototype)
    return o
endf


function! s:prototype.Start() abort dict "{{{3
    let self.working_dir = getcwd()
    let cmd = self.GetReplCmd()
    Tlibtrace 'workbook', 'Start', cmd
    let self.job = job_start(cmd, {'in_mode': 'nl', 'out_mode': 'nl', 'err_mode': 'nl'
                \ , 'exit_cb': {job, status -> self.ExitCb(job, status)}
                \ , 'out_cb': {ch, msg -> self.OutCb(ch, msg)}
                \ , 'err_cb': {ch, msg -> self.ErrCb(ch, msg)}
                \ })
endf


function! s:prototype.ExitCb(job, status) abort dict "{{{3
    echohl WarningMsg
    echom 'Workbook: REPL' self.id 'has exited with status' a:status
    echohl NONE
    let self.teardown = 1
    call workbook#Stop({}, self)
endf


function! s:prototype.PreprocessCallbackNlMessage(msg) abort dict "{{{3
    if has_key(self, 'PreprocessNlMessage')
        return self.PreprocessNlMessage(a:msg)
    else
        return a:msg
    endif
endf


function! s:prototype.OutCb(ch, msg) abort dict "{{{3
    Tlibtrace 'workbook', 'OutCb', a:msg
    if get(self, 'ignore_output', 0) > 2
        return
    endif
    call self.ConsumeOutput('', self.PreprocessCallbackNlMessage(a:msg))
endf


function! s:prototype.ErrCb(ch, msg) abort dict "{{{3
    Tlibtrace 'workbook', 'ErrCb', a:msg
    call self.ConsumeError(self.PreprocessCallbackNlMessage(a:msg))
endf


function! s:prototype.Stop(args) abort dict "{{{3
    if has_key(self, 'ExitFiletype')
        call self.ExitFiletype(a:args)
    endif
    if job_status(self.job) ==# 'run'
        call job_stop(self.job)
    endif
endf


function! s:prototype.IsReady() abort dict "{{{3
    return job_status(self.job) == 'run'
endf


function! s:prototype.SendToRepl(code, ...) abort dict "{{{3
    let nl = a:0 >= 1 ? a:1 : 0
    let placeholder = a:0 >= 2 ? a:2 : ''
    let code = nl ? a:code ."\n" : a:code
    let channel = job_getchannel(self.job)
    if nl && has_key(self, 'ProcessSendLine')
        for line in split(code, '\n')
            if self.IsReady()
                call self.ProcessSendLine({-> ch_sendraw(channel, line ."\n")})
            endif
        endfor
    else
        if self.IsReady()
            call ch_sendraw(channel, code)
        endif
    endif
endf

