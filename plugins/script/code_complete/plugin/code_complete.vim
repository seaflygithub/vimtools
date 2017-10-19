"==================================================
" File:         code_complete.vim
" Brief:        function parameter complete, code snippets, and much more.
" Author:       Mingbai <mbbill AT gmail DOT com>
" Last Change:  2009-06-09 00:09:03
" Version:      2.9
"
" 修改By：      凝霜
" 博客：        http://blog.csdn.net/MDL13412
" 修改内容：    去掉if, for, while等结构()间的空格
"               对ife，switch加入数字参数，指定分支个数：ifeN,switchN，其中N为分支个数
"               加入命名空间选项
"               加入函数模板补全
" 修改By：      jim
" 修改内容：    添加Shell模板
"
" Install:      1. Put code_complete.vim to plugin
"                  directory.
"               2. Use the command below to create tags
"                  file including signature field.
"                  ctags -R --c-kinds=+p --fields=+S .
"
" Usage:
"           hotkey:
"               "<tab>" (default value of g:completekey)
"               Do all the jobs with this key, see
"           example:
"               press <tab> after function name and (
"                 foo ( <tab>
"               becomes:
"                 foo ( `<first param>`,`<second param>` )
"               press <tab> after code template
"                 if <tab>
"               becomes:
"                 if( `<...>` )
"                 {
"                     `<...>`
"                 }
"
"
"           variables:
"
"               g:completekey
"                   the key used to complete function
"                   parameters and key words.
"
"               g:rs, g:re
"                   region start and stop
"               you can change them as you like.
"
"               g:user_defined_snippets
"                   file name of user defined snippets.
"
"           key words:
"               see "templates" section.
"==================================================

if v:version < 700
    finish
endif

" Variable Definitions: {{{1
" options, define them as you like in vimrc:
if !exists("g:completekey")
    let g:completekey = "<tab>"   "hotkey
endif

if !exists("g:rs")
    let g:rs = '`<'    "region start
endif

if !exists("g:re")
    let g:re = '>`'    "region stop
endif

if !exists("g:user_defined_snippets")
    let g:user_defined_snippets = "$VIMRUNTIME/plugin/my_snippets.vim"
endif

" ----------------------------
let s:expanded = 0  "in case of inserting char after expand
let s:signature_list = []
let s:jumppos = -1
let s:doappend = 1

" Autocommands: {{{1
autocmd BufReadPost,BufNewFile * call CodeCompleteStart()

" Menus:
menu <silent>       &Tools.Code\ Complete\ Start          :call CodeCompleteStart()<CR>
menu <silent>       &Tools.Code\ Complete\ Stop           :call CodeCompleteStop()<CR>

" Function Definitions: {{{1

function! CodeCompleteStart()
    exec "silent! iunmap  <buffer> ".g:completekey
    exec "inoremap <buffer> ".g:completekey." <c-r>=CodeComplete()<cr><c-r>=SwitchRegion()<cr>"
endfunction

function! CodeCompleteStop()
    exec "silent! iunmap <buffer> ".g:completekey
endfunction

function! FunctionComplete(fun)
    let s:signature_list=[]
    let signature_word=[]
    let ftags=taglist("^".a:fun."$")
    if type(ftags)==type(0) || ((type(ftags)==type([])) && ftags==[])
        return ''
    endif
    let tmp=''
    for i in ftags
        if match(i.cmd,'^/\^.*\(\*'.a:fun.'\)\(.*\)\;\$/')>=0
            if match(i.cmd,'(\s*void\s*)')<0 && match(i.cmd,'(\s*)')<0
                    let tmp=substitute(i.cmd,'^/\^','','')
                    let tmp=substitute(tmp,'.*\(\*'.a:fun.'\)','','')
                    let tmp=substitute(tmp,'^[\){1}]','','')
                    let tmp=substitute(tmp,';\$\/;{1}','','')
                    let tmp=substitute(tmp,'\$\/','','')
                    let tmp=substitute(tmp,';','','')
                    let tmp=substitute(tmp,',',g:re.','.g:rs,'g')
                    let tmp=substitute(tmp,'(\(.*\))',g:rs.'\1'.g:re.')','g')
            else
                    let tmp=''
            endif
            if (tmp != '') && (index(signature_word,tmp) == -1)
                let signature_word+=[tmp]
                let item={}
                let item['word']=tmp
                let item['menu']=i.filename
                let s:signature_list+=[item]
            endif
        endif
        if has_key(i,'kind') && has_key(i,'name') && has_key(i,'signature')
            if (i.kind=='p' || i.kind=='f') && i.name==a:fun  " p is declare, f is definition
                if match(i.signature,'(\s*void\s*)')<0 && match(i.signature,'(\s*)')<0
                    let tmp=substitute(i.signature,',',g:re.','.g:rs,'g')
                    let tmp=substitute(tmp,'(\(.*\))',g:rs.'\1'.g:re.')','g')
                else
                    let tmp=''
                endif
                if (tmp != '') && (index(signature_word,tmp) == -1)
                    let signature_word+=[tmp]
                    let item={}
                    let item['word']=tmp
                    let item['menu']=i.filename
                    let s:signature_list+=[item]
                endif
            endif
        endif
    endfor
    if s:signature_list==[]
        return ')'
    endif
    if len(s:signature_list)==1
        return s:signature_list[0]['word']
    else
        call  complete(col('.'),s:signature_list)
        return ''
    endif
endfunction

function! ExpandTemplate(cword)
    "let cword = substitute(getline('.')[:(col('.')-2)],'\zs.*\W\ze\w*$','','g')
    if has_key(g:template,&ft)
        if has_key(g:template[&ft],a:cword)
            let s:jumppos = line('.')
            return "\<c-w>" . g:template[&ft][a:cword]
        endif
    endif
    if has_key(g:template['_'],a:cword)
        let s:jumppos = line('.')
        return "\<c-w>" . g:template['_'][a:cword]
    endif
    return ''
endfunction

function! SwitchRegion()
    if len(s:signature_list)>1
        let s:signature_list=[]
        return ''
    endif
    if s:jumppos != -1
        call cursor(s:jumppos,0)
        let s:jumppos = -1
    endif
    if match(getline('.'),g:rs.'.*'.g:re)!=-1 || search(g:rs.'.\{-}'.g:re)!=0
        normal 0
        call search(g:rs,'c',line('.'))
        normal v
        call search(g:re,'e',line('.'))
        if &selection == "exclusive"
            exec "norm l"
        endif
        return "\<c-\>\<c-n>gvo\<c-g>"
    else
        if s:doappend == 1
            if g:completekey == "<tab>"
                return "\<tab>"
            endif
        endif
        return ''
    endif
endfunction

function! CodeComplete()
    let s:doappend = 1
    let function_name = matchstr(getline('.')[:(col('.')-2)],'\zs\w*\ze\s*(\s*$')
    if function_name != ''
        let funcres = FunctionComplete(function_name)
        if funcres != ''
            let s:doappend = 0
        endif
        return funcres
    else
        let template_name = substitute(getline('.')[:(col('.')-2)],'\zs.*\W\ze\w*$','','g')
        let tempres = ExpandTemplate(template_name)
        if tempres != ''
            let s:doappend = 0
        endif
        return tempres
    endif
endfunction


" [Get converted file name like __THIS_FILE__ ]
function! GetFileName()
    let filename=expand("%:t")
    let filename=toupper(filename)
    let _name=substitute(filename,'\.','_',"g")
    "let _name="__"._name."__"
    return _name
endfunction

" Templates: {{{1
" to add templates for new file type, see below
"
" "some new file type
" let g:template['newft'] = {}
" let g:template['newft']['keyword'] = "some abbrevation"
" let g:template['newft']['anotherkeyword'] = "another abbrevation"
" ...
"
" ---------------------------------------------
" C templates
let g:template = {}
let g:template['c'] = {}
let g:template['c']['cc'] = "/*  */\<left>\<left>\<left>"
let g:template['c']['cd'] = "/**<  */\<left>\<left>\<left>"
let g:template['c']['de'] = "#define     "
let g:template['c']['in'] = "#include \"\"\<left>"
let g:template['c']['is'] = "#include <>\<left>"
let g:template['c']['ff'] = "#ifndef  \<c-r>=GetFileName()\<cr>\<CR>#define  \<c-r>=GetFileName()\<cr>".
            \repeat("\<cr>",5)."#endif  // \<c-r>=GetFileName()\<cr>".repeat("\<up>",3)
let g:template['c']['for'] = "for (".g:rs."...".g:re."; ".g:rs."...".g:re."; ".g:rs."...".g:re.")\<cr>{\<cr>".
            \g:rs."...".g:re."\<cr>}\<cr>"
let g:template['c']['main'] = "int main(int argc, char \*argv\[\])\<cr>{\<cr>".g:rs."...".g:re."\<cr>}"

"switch模板
let g:template['c']['switch'] = "switch (".g:rs."...".g:re.")\<cr>{\<cr>case ".g:rs."...".g:re.":\<cr>break;\<cr>case ".
            \g:rs."...".g:re.":\<cr>break;\<cr>default:\<cr>break;\<cr>}"
let g:template['c']['switch1'] = "switch (".g:rs."...".g:re.")\<cr>{\<cr>case ".
            \g:rs."...".g:re.":\<cr>break;".
            \"\<cr>default:\<cr>break;\<cr>}"
let g:template['c']['switch2'] = "switch (".g:rs."...".g:re.")\<cr>{\<cr>case ".
            \g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>default:\<cr>break;\<cr>}"
let g:template['c']['switch3'] = "switch (".g:rs."...".g:re.")\<cr>{\<cr>case ".
            \g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>default:\<cr>break;\<cr>}"
let g:template['c']['switch4'] = "switch (".g:rs."...".g:re.")\<cr>{\<cr>case ".
            \g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>default:\<cr>break;\<cr>}"
let g:template['c']['switch5'] = "switch (".g:rs."...".g:re.")\<cr>{\<cr>case ".
            \g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>default:\<cr>break;\<cr>}"
let g:template['c']['switch6'] = "switch (".g:rs."...".g:re.")\<cr>{\<cr>case ".
            \g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>default:\<cr>break;\<cr>}"
let g:template['c']['switch7'] = "switch (".g:rs."...".g:re.")\<cr>{\<cr>case ".
            \g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>default:\<cr>break;\<cr>}"
let g:template['c']['switch8'] = "switch (".g:rs."...".g:re.")\<cr>{\<cr>case ".
            \g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>default:\<cr>break;\<cr>}"
let g:template['c']['switch9'] = "switch (".g:rs."...".g:re.")\<cr>{\<cr>case ".
            \g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>case ".g:rs."...".g:re.":\<cr>break;".
            \"\<cr>default:\<cr>break;\<cr>}"
            
"
let g:template['c']['if'] = "if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>}"
let g:template['c']['while'] = "while(".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>}"

let g:template['c']['ife'] = "if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} else\<cr>{\<cr>".g:rs."...".
            \g:re."\<cr>}"
let g:template['c']['ife0'] = "if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} else\<cr>{\<cr>".g:rs."...".
            \g:re."\<cr>}"
let g:template['c']['ife1'] = "if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else\<cr>{\<cr>".g:rs."...".
            \g:re."\<cr>}"
let g:template['c']['ife2'] = "if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else\<cr>{\<cr>".g:rs."...".
            \g:re."\<cr>}"
let g:template['c']['ife3'] = "if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else\<cr>{\<cr>".g:rs."...".
            \g:re."\<cr>}"
let g:template['c']['ife4'] = "if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else\<cr>{\<cr>".g:rs."...".
            \g:re."\<cr>}"
let g:template['c']['ife5'] = "if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else\<cr>{\<cr>".g:rs."...".
            \g:re."\<cr>}"
let g:template['c']['ife6'] = "if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else\<cr>{\<cr>".g:rs."...".
            \g:re."\<cr>}"
let g:template['c']['ife7'] = "if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else\<cr>{\<cr>".g:rs."...".
            \g:re."\<cr>}"
let g:template['c']['ife8'] = "if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else\<cr>{\<cr>".g:rs."...".
            \g:re."\<cr>}"
let g:template['c']['ife9'] = "if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else if (".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>} ".
            \"else\<cr>{\<cr>".g:rs."...".
            \g:re."\<cr>}"
            
"作用域           
let g:template['c']['nm']="namespace ".g:rs."...".g:re."\<cr>{\<cr>".g:rs."...".g:re."\<cr>}"
let g:template['c']['ns']="namespace NsLib\<cr>{\<cr>".g:rs."...".g:re."\<cr>}"

"函数模板
let g:template['c']['f0']=g:rs."...".g:re."()\<cr>{\<cr>".g:rs."...".g:re."\<cr>}"
let g:template['c']['f1']=g:rs."...".g:re."(".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>}"
let g:template['c']['f2']=g:rs."...".g:re."(".g:rs."...".g:re.", ".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>}"
let g:template['c']['f3']=g:rs."...".g:re."(".g:rs."...".g:re.", ".g:rs."...".g:re.", ".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>}"
let g:template['c']['f4']=g:rs."...".g:re."(".g:rs."...".g:re.", ".g:rs."...".g:re.", ".g:rs."...".g:re.", ".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>}"
let g:template['c']['f5']=g:rs."...".g:re."(".g:rs."...".g:re.", ".g:rs."...".g:re.", ".g:rs."...".g:re.", ".g:rs."...".g:re.", ".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>}"
let g:template['c']['f6']=g:rs."...".g:re."(".g:rs."...".g:re.", ".g:rs."...".g:re.", ".g:rs."...".g:re.", ".g:rs."...".g:re.", ".g:rs."...".g:re.", ".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>}"
let g:template['c']['f7']=g:rs."...".g:re."(".g:rs."...".g:re.", ".g:rs."...".g:re.", ".g:rs."...".g:re.", ".g:rs."...".g:re.", ".g:rs."...".g:re.", ".g:rs."...".g:re.", ".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>}"
let g:template['c']['f8']=g:rs."...".g:re."(".g:rs."...".g:re.", ".g:rs."...".g:re.", ".g:rs."...".g:re.", ".g:rs."...".g:re.", ".g:rs."...".g:re.", ".g:rs."...".g:re.", ".g:rs."...".g:re.", ".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>}"
let g:template['c']['f9']=g:rs."...".g:re."(".g:rs."...".g:re.", ".g:rs."...".g:re.", ".g:rs."...".g:re.", ".g:rs."...".g:re.", ".g:rs."...".g:re.", ".g:rs."...".g:re.", ".g:rs."...".g:re.", ".g:rs."...".g:re.", ".g:rs."...".g:re.")\<cr>{\<cr>".g:rs."...".g:re."\<cr>}"

let g:template['c']['class']="class ".g:rs."...".g:re."\<cr>{\<cr>public:\<cr>".g:rs."...".g:re."\<cr>\<cr>};"
let g:template['c']['const']="const ".g:rs."...".g:re." = ".g:rs."...".g:re.";"

" ---------------------------------------------
" C++ templates
let g:template['cpp'] = g:template['c']

" ---------------------------------------------
" Shell templates
let g:template['sh'] = {}
let g:template['sh']['sh'] = "#!/bin/sh\<cr>".g:rs."...".g:re."\<cr>exit 0"
let g:template['sh']['sx'] = "#!/bin/sh -x\<cr>".g:rs."...".g:re."\<cr>exit 0"
let g:template['sh']['ba'] = "#!/bin/bash\<cr>".g:rs."...".g:re."\<cr>exit 0"
let g:template['sh']['bx'] = "#!/bin/bash -x\<cr>".g:rs."...".g:re."\<cr>exit 0"
let g:template['sh']['cc'] = "#  \<left>"
let g:template['sh']['ff'] = "function ".g:rs."...".g:re." ()\<cr>{\<cr>".g:rs."...".g:re."\<cr>}"
let g:template['sh']['if'] = "if [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>fi"
let g:template['sh']['ife'] = "if [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>else\<cr>".g:rs."...".g:re."\<cr>fi"
let g:template['sh']['ife1'] = "if [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"fi"
let g:template['sh']['ife2'] = "if [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"fi"
let g:template['sh']['ife3'] = "if [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"fi"
let g:template['sh']['ife4'] = "if [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"fi"
let g:template['sh']['ife5'] = "if [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"fi"
let g:template['sh']['ife6'] = "if [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"fi"
let g:template['sh']['ife7'] = "if [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"fi"
let g:template['sh']['ife8'] = "if [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"fi"
let g:template['sh']['ife9'] = "if [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"elif [ ".g:rs."...".g:re." ]; then\<cr>".g:rs."...".g:re."\<cr>".
            \"fi"
let g:template['sh']['case'] = "case i in ".g:rs."...".g:re."\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \"*)\<cr>".g:rs."...".g:re."\<cr>;;\<cr>esac"
let g:template['sh']['case2'] = "case i in ".g:rs."...".g:re."\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \"*)\<cr>".g:rs."...".g:re."\<cr>;;\<cr>esac"
let g:template['sh']['case3'] = "case i in ".g:rs."...".g:re."\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \"*)\<cr>".g:rs."...".g:re."\<cr>;;\<cr>esac"
let g:template['sh']['case4'] = "case i in ".g:rs."...".g:re."\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \"*)\<cr>".g:rs."...".g:re."\<cr>;;\<cr>esac"
let g:template['sh']['case5'] = "case i in ".g:rs."...".g:re."\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \"*)\<cr>".g:rs."...".g:re."\<cr>;;\<cr>esac"
let g:template['sh']['case6'] = "case i in ".g:rs."...".g:re."\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \"*)\<cr>".g:rs."...".g:re."\<cr>;;\<cr>esac"
let g:template['sh']['case7'] = "case i in ".g:rs."...".g:re."\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \"*)\<cr>".g:rs."...".g:re."\<cr>;;\<cr>esac"
let g:template['sh']['case8'] = "case i in ".g:rs."...".g:re."\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \"*)\<cr>".g:rs."...".g:re."\<cr>;;\<cr>esac"
let g:template['sh']['case9'] = "case i in ".g:rs."...".g:re."\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \"*)\<cr>".g:rs."...".g:re."\<cr>;;\<cr>esac"
let g:template['sh']['while'] = "while [ ".g:rs."...".g:re." ]\<cr>do\<cr>".g:rs."...".g:re."\<cr>done\<cr>"
let g:template['sh']['select'] = "select i in ".g:rs."...".g:re."\<cr>do\<cr>case ${i} in ".g:rs."...".g:re."\<cr>".
            \g:rs."...".g:re.")\<cr>".g:rs."...".g:re."\<cr>;;\<cr>".
            \"*)\<cr>".g:rs."...".g:re."\<cr>;;\<cr>esac\<cr>done"
" ---------------------------------------------
" common templates
let g:template['_'] = {}
let g:template['_']['xt'] = "\<c-r>=strftime(\"%Y-%m-%d %H:%M:%S\")\<cr>"

" ---------------------------------------------
" load user defined snippets
exec "silent! runtime ".g:user_defined_snippets


" vim: set fdm=marker et :
