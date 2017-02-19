" File: autoload/add_git_managed_file_to_buffer.vim
" Author: ToruIwashita <toru.iwashita@gmail.com>
" License: MIT License

let s:cpo_save = &cpo
set cpo&vim

fun! s:git_exec(cmd, args) abort
  let results = split(system('\git '.a:cmd.' '.a:args.' 2>/dev/null; echo $?'), "\n")
  let exit_status = remove(results, -1)

  if exit_status
    throw 'failed to '.a:cmd.' command.'
  endif

  return results
endf

fun! s:add_any_files_to_buffer(extract_file_funcref) abort
  try
    for maneged_file in a:extract_file_funcref()
      exec 'silent badd '.maneged_file
    endfor
  catch /failed to diff/
    redraw!
    echo 'file extraction failed.'
  endtry
endf

fun! s:add_any_files_to_tab(extract_file_funcref) abort
  try
    call s:delete_all_buffers()

    for maneged_file in a:extract_file_funcref()
      exec 'silent badd '.maneged_file
    endfor

    call s:assign_buffers_to_tabs()
  catch /failed to diff/
    redraw!
    echo 'file extraction failed.'
  endtry
endf

fun! s:delete_all_buffers() abort
  for buf_num in filter(range(1, bufnr('$')), 'buflisted(v:val)')
    exec 'silent bdelete' buf_num
  endfor
endf

fun! s:assign_buffers_to_tabs() abort
  call s:tab_all()
  tabfirst
  tabc
endf

fun! s:tab_all() abort
  let s:current_tpm = &tabpagemax
  set tabpagemax=100
  exec 'tab ball'
  let &tabpagemax = s:current_tpm
endf

fun! s:changed_files() abort
  return s:git_exec('diff', '--name-only origin/HEAD...HEAD')
endf

fun! s:modified_files() abort
  return map(filter(s:git_exec('status', '--short'), 'v:val =~ "^ M"'), 'matchstr(v:val, "^ M \\zs\\(.*\\)\\ze", 0)')
endf

fun! s:untracked_files() abort
  return map(filter(s:git_exec('status', '--short'), 'v:val =~ "^??"'), 'matchstr(v:val, "^?? \\zs\\(.*\\)\\ze", 0)')
endf

fun! add_git_managed_file_to_buffer#add_changed_files_to_buffer() abort
  call s:add_any_files_to_buffer(funcref('s:changed_files'))
endf

fun! add_git_managed_file_to_buffer#add_modified_files_to_buffer() abort
  call s:add_any_files_to_buffer(funcref('s:modified_files'))
endf

fun! add_git_managed_file_to_buffer#add_untracked_files_to_buffer() abort
  call s:add_any_files_to_buffer(funcref('s:untracked_files'))
endf

fun! add_git_managed_file_to_buffer#add_changed_files_to_tab() abort
  call s:add_any_files_to_tab(funcref('s:changed_files'))
endf

fun! add_git_managed_file_to_buffer#add_modified_files_to_tab() abort
  call s:add_any_files_to_tab(funcref('s:modified_files'))
endf

fun! add_git_managed_file_to_buffer#add_untracked_files_to_tab() abort
  call s:add_any_files_to_tab(funcref('s:untracked_files'))
endf

fun! add_git_managed_file_to_buffer#open_all_buffers_in_tab()
  call s:tab_all()
endf

let &cpo = s:cpo_save
unlet s:cpo_save
