"  snake.vim: Snake game in vim
"  Last Change: Tue Jan 19 16:07:52 CST 2016
"  Maintainer:  Jacob Gelbman <gelbman@gmail.com>
"  Version:     2.0.0, for Vim 7.0+
"  URL:		http://github.com/zorgnax/vim-snake
"
" Installation:
"
" place this script into .vim/plugin/
"
" Directions:
"
" start the game by typing :Snake in command line. use hjkl to move
" your snake around and eat apples. don't bump into yourself or
" you'll die. use s to start over, or q to quit.
"
" References:
"
" RNG https://groups.google.com/forum/#!topic/vim_use/jfGVB2Rbc54
" Timer http://vim.wikia.com/wiki/Timer_to_execute_commands_periodically
" Another snake game https://github.com/zyedidia/vim-snake

command! Snake call s:init ()
map <Leader>s :call <SID>init()<CR>

function! s:init ()
    tabe
    set showtabline=0
    set updatetime=200
    set viminfo+=!
    setlocal buftype=nofile
    let g:SNAKESCORE = exists("g:SNAKESCORE") ? g:SNAKESCORE : 0
    exe "setlocal statusline=" . repeat("\\ ", winwidth(0) / 2 - 12) . "---=======\\ Snake\\ ========(*)-<"

    map <buffer> <silent> s :call <SID>start()<CR>
    map <buffer> <silent> q :call <SID>quit()<CR>
    map <buffer> <silent> p :let b:pause = !b:pause<CR>
    map <buffer> <silent> h :call <SID>setdirection(0, -1)<CR>
    map <buffer> <silent> j :call <SID>setdirection(1, 0)<CR>
    map <buffer> <silent> k :call <SID>setdirection(-1, 0)<CR>
    map <buffer> <silent> l :call <SID>setdirection(0, 1)<CR>

    augroup snake
        au!
        au CursorHold * call s:updateframe()
        au BufLeave * call s:quit()
    augroup END

    syn match snake "\*"
    syn match apple "o"
    syn match text "(.*)"
    hi snake ctermfg=green
    hi apple ctermfg=red
    hi text ctermfg=white

    call s:start()
endfunction

function! s:setdirection (y, x)
    if a:y != -b:oy || a:x != -b:ox
        let b:y = a:y
        let b:x = a:x
    endif
endfunction

function! s:start ()
    let b:i = 0
    let b:y = 0
    let b:x = 1
    let b:oy = 0
    let b:ox = 1
    let b:score = 0
    let b:gameover = 0
    let b:pause = 0
    let b:apples = []
    let y = winheight(0) / 2
    let x = 0
    let b:snake = []
    for i in range(40)
        call add(b:snake, [y, x + i])
    endfor

    for i in range(1, winheight(0))
        call setline(i, repeat(" ", winwidth(0)))
    endfor
endfunction

function! s:quit ()
    bwipeout!
    set showtabline=1
    au! snake
endfunction

function! s:updateframe ()
    call feedkeys("f\e")
    let b:i = b:i + 1
    if b:gameover
        let y = winheight(0) / 5 * 2
        let x = winwidth(0) / 2
        call cursor(y, x - 5)
        normal! RGame Over!
        call cursor(y + 1, x - 17)
        normal! R(Press q to quit, s to start again)
        call s:showscore()
        return
    endif
    if b:pause
        return
    endif
    call s:showscore()
    let b:oy = b:y
    let b:ox = b:x
    let head = s:addhead(b:snake[-1][0] + b:y, b:snake[-1][1] + b:x)
    if getline(head[0])[head[1] - 1] == "*" && head != b:snake[0]
        let b:gameover = 1
        return
    endif
    if s:eatapple(head)
        let b:score = b:score + 1
        if b:score > g:SNAKESCORE
            let g:SNAKESCORE = b:score
        endif
        call s:placeapples()
    else
        let tail = remove(b:snake, 0)
        call cursor(tail[0], tail[1])
        exe "normal r "
    endif
    for [y, x] in b:snake
        call cursor(y, x)
        normal r*
    endfor
    if b:i == 1
        call s:placeapples()
    endif
endfunction

function! s:showscore ()
    echo "score: " . b:score . ", high score: " . g:SNAKESCORE
endfunction

function! s:eatapple (head)
    for i in range(len(b:apples))
        let apple = b:apples[i]
        if a:head == apple
            call remove(b:apples, i)
            return 1
        endif
    endfor
    return 0
endfunction

function! s:placeapples ()
    if len(b:apples) > 20
        return
    endif

    let n = 1 + s:rand() % 15
    let i = 0
    while 1
        let y = s:rand() % winheight(0) + 1
        let x = s:rand() % winwidth(0) + 1
        if getline(y)[x - 1] == " "
            call cursor(y, x)
            normal ro
            call add(b:apples, [y, x])
            let i = i + 1
            if i == n
                break
            endif
        endif
    endwhile
endfunction

function! s:addhead (y, x)
    let y = a:y
    if y <= 0
        let y = winheight(0) - 1
    endif
    if y > winheight(0)
        let y = y % winheight(0)
    endif
    let x = a:x
    if x <= 0
        let x = winwidth(0) - 1
    endif
    if x > winwidth(0)
        let x = x % winwidth(0)
    endif
    let head = [y, x]
    call add(b:snake, head)
    return head
endfunction

function! s:rand ()
    let b:rand = exists("b:rand") ? b:rand : 0
    let b:rand = abs((((b:rand + localtime()) * 31421) + 6927)) % 65536
    return b:rand
endfunction

