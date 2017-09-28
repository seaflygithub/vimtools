" Open a preview window for a tag, and change the preview window's height
" to show the "entire" tag; i.e., an entire structure, a function's comment
" (if any) and all it's arguments, etc.
"
" NOTE:
"	The preview window is a feature only available in version 6 (and later)
"
" EXAMPLE USAGE:
"
"	command! -nargs=? -complete=tag_listfiles	PreviewTag call PreviewTag(<f-args>)
"
"	" Tag on current word into preview window.
"	map <C-\> :PreviewTag<CR>

function! PreviewTag(...)
     let current_file = expand('%:p')

     " Open the tag in the preview window...
     if a:0 == 0
	  " Use the word under the cursor as the tag
	  wincmd g}	
     else
	  " Use the argument(s) as the tag
	  if a:0 > 1
	       " Tag contains spaces (yes, that's legal); make a single tag
	       " variable.
	       let tag = a:1
	       let i = 2
	       while i <= a:0
		    exe "let tag = tag . ' ' ." . a:{i}
		    let i = i + 1
	       endwhile
	  else
	       let tag = a:1
	  endif
	  exe 'ptjump ' . tag
     endif

     " Jump to the preview window; if unsuccessful, presumably there were
     " multiple tags, and the user did not select one (or there was simply no
     " tag match), so there is no preview window.
     "
     let v:errmsg = ''
     silent! wincmd P
     if v:errmsg != ''
	  return
     endif

     " Turn off wrapping in the preview window.
     setlocal nowrap

     let tag_line      = line('.')
     let context_start = tag_line
     let context_end   = tag_line
     let text          = getline(context_start)

     " Of course this depends upon coding style...it works for us.
     if text =~ '\<\(\i\+\)($'
	  " Looks like a function; locate the last parameter (i.e., the closing
	  " parentheses).
	  "
	  let fn = matchstr(text, '\<\(\i\+\)($')
	  normal! $%
	  let context_end = line('.')

	  if    context_end == context_start + 3
	  \  && getline(context_end   + 1) =~ '^{'
	  \  && getline(context_start + 1) =~ '^const.*\*\<a,'
	  \  && getline(context_start + 2) =~ '^const.*\*\<b'

	       " Looks like a comparison function, show the body (usually just
	       " several CMP_* macros).
	       "
	       normal! j0%
	       let context_end = line('.')
	       exe context_start
	  else
	       if fn =~ '\(^\|_\)\(compare\|cmp\)\(_\|$\)' && getline(context_end + 1) =~ '^{'
		    " Looks like a bag compare routine; show the entire function.
		    normal! j%
		    let context_end = line('.')
		    normal! %k
	       endif

	       " See if there is a standard function-header " comment.
	       let id = strpart(fn, 0, strlen(fn) - 1)
	       if search('FUNCTION:\s*' . id . '$', 'bW')
		    " Found a standard function header, include it in the preview.
		    normal! k
		    let context_start = line('.')
	       else
		    " Nope; get back to the original line.
		    normal! %
	       endif
	  endif

	  " Put our first line at the top of the preview window.
	  let normal = 'zt'

     elseif text =~ '^\s*}\s*\i\+;'
	  " Looks like a typedef, e.g. (Foobar):
	  "
	  "	typedef {
	  "	    ...
	  "	} Foobar;
	  "
	  let context_end = context_start

	  " Go to the start of the typedef.
	  normal! 0%
	  let context_start = line('.')

	  " Get back to the original line.
	  normal! %

	  " Put this line (e.g., Foobar) at the bottom.
	  let normal = 'zb'

     elseif text =~ '^\s*\i\+\s*\(=\s*.*\)\=,\=\s*\(\/\*.*\*\/\|\/\/.*\)\?$'
	  " Looks like an enumeration (i.e., "tag_match", not the enumerated
	  " type, "EnumType"), e.g:
	  "
	  "	typedef enum {
	  "	    ...
	  "	    tag_match = 1,	// This is an enumeration.
	  "	    ...
	  "	} EnumType;
	  "
	  if search('^}', 'W')
	       let context_end = line('.')
	       normal! %
	       if getline('.') =~ '\<enum\>'
		    let context_start = line('.')
	       else
		    let context_start = tag_line
		    let context_end   = tag_line
		    exe tag_line
	       endif
	  endif

	  let normal = 'zt' . tag_line . 'G'

     elseif text =~ '^\s*\(}\s*\|\(\(static\|extern\)\s\+\)\=\(const\s\+\)\=\(\*\s\)*\)\=\i\+\s*\[\s*\d*\s*\]\s*=\(\s*{\s*\)\=$'
	  " Looks like an array initialization, e.g. (foobar):
	  "
	  " foobar[] = {	or	typedef struct {	or	foobar[] =
	  "      { ... },		     int	f1;		     { ... }
	  "      { ... },		     ...
	  "      ...			} foobar[] = {
	  " };				     { ... },
	  "				     ...
	  "				};
	  if text !~ '{\s*$'
	       normal! j
	       if getline(".") =~ '^\s*{'
		    if getline(".") =~ '^{'
			 normal! %
		    else
			 normal! 0f{%
		    endif
		    let context_end = line('.')
	       endif
	  else
	       normal! 0f{%
	       let context_end = line('.')
	  endif

	  if text =~ '^\s*}'
	       " Looks like second form (with typedef).
	       normal! %$F}%
	       let context_start = line('.')
	  else
	       exe tag_line
	  endif
	  let normal = 'zt' . tag_line . 'G'

     elseif text =~ '^#define.*\\$'
	  " Looks like a multi-line macro definition; make sure the entire
	  " macro is shown.
	  "
	  if search('[^\\]$', 'W')
	       let context_end = line('.')
	       exe tag_line
	  endif
	  let normal = 'zt'
     endif

     if context_start == context_end
	  " Not recognized as anything we want to handle specially (no
	  " context-block); set the preview height to the default, and put this
	  " line at the second-from-the-top.
	  "
	  let context_start = 1
	  let context_end   = &previewheight

	  " Set the preview height to the default.  Do this explicitly; because
	  " it's not *always* done below.
	  "
	  exe &previewheight . 'wincmd _'

	  " Put the tag-matching line second-from-the-top.
	  let normal = 'kztj'
     endif

     " Make the preview window big enough to show the function comment and all
     " the function arguments.
     "
     exe ((context_end - context_start) + 1) . 'wincmd _'

     " Don't let a scrolloff setting mess up our positioning.
     let save_scrolloff = &scrolloff
     se scrolloff=0

     exe 'normal! ' . normal

     let &scrolloff = save_scrolloff

     " Return to the original window.
     wincmd p
endfunction
