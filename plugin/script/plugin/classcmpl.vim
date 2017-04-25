"=============================================================================
" File: classcmpl.vim
" Author: Yasuhiro Matsumoto <mattn_jp@hotmail.com>
" Last Change: Fri, 13 Jun 2003
" Version: 0.9a
" Usage:
"   --- test.cpp ---
"   class Test
"   {
"   public:
"     int getValue() { return 0 };
"   };
"   int main( void )
"   {
"     Test *test;
"     test->_
"   }
"   ----------------
"           A
"           +-- cursor at here.
"
"   type <c-space>
"
"   this script work for cpp, java, 
"=============================================================================
autocmd! BufNewFile,BufRead *.cpp,*.java call <SID>CmplInstall()

function! s:CmplInstall()
  let fnc1 = '<C-O>:silent call <SID>CmplMemberFromTags(<SID>GetTypeUnderCursor(0))<Cr><C-x><C-t>'
  let fnc2 = ':echo "class:".<SID>GetTypeUnderCursor(1)<cr>'
  if exists('g:ClassComplete_Key')
    let ckey = g:ClassComplete_Key
  else
    let ckey = '<C-Space>'
  endif
  exec 'silent inoremap <buffer> <silent> '.ckey.' '.fnc1
  exec 'silent nnoremap <buffer> <silent> '.ckey.' '.fnc2
endfunction

function! s:CmplMemberFromTags(class)
  if exists('s:tmpl')
    if s:tmpl != ''
      call delete(s:tmpl)
	  let s:tmpl = ''
    endif
  endif
  let ret = ''
  let cnt = 0
  let nam = expand('%:p')
  let g:hoge = nam
  silent! 1sp ____tags
  if filereadable('tags')
    read tags
  else
	exec 'r! ctags -f - "'.nam.'"'
  endif
  let eol = line('$')
  let lin = 1
  while lin <= eol
    let str = getline(lin)
    if str =~ 'class:'.a:class
      let pat = '^\([^\t]\+\)\t.*$'
      let cmp = substitute(str, pat, '\1', '')
      if cmp != str
        let cnt = cnt + 1
        let ret = ret . cnt . ':' . cmp . "\n"
      endif
    endif
    let lin = lin + 1
  endwhile
  silent! bw!
  let tmp = tempname()
  exec "redir! > ".tmp
  if a:class != ''
    silent echo ret
  endif
  redir end
  exec 'set thesaurus='.tmp
  let s:tmpl = tmp
endfunction

function! s:GetTypeUnderCursor(typ)
  1sp
  if a:typ == 0
    let sep = expand('<cword>')
    if sep !~ '\.' && sep !~ '->'
      close!
	  return ''
    endif
    exec 'silent! normal! '.(strlen(sep)+1).'h'
  endif
  let orig = expand('<cword>')
  while 1
    let orgxy = line('.').'.'.col('.')
    silent! normal! gd
	call search('[^\s]\s', 'b')
    let word = expand('<cword>')
    if orig != word || orgxy != line('.').'.'.col('.')
      break
    endif
  endwhile
  close!
  return word
endfunction

