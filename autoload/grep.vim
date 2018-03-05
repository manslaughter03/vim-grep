" grep plugin
" Description:  
" Language:     
" Maintainer:   manslaughter <manslaughter03@gmail.com>
" Version:      0.0.1
" Last Change:  2018-02-18

if exists("g:loaded_grep_autoload")
    finish
endif

let g:loaded_grep_autoload = 1

function! grep#version()
    return g:grep_plugin_version
endfunction

function! grep#run_prompt_args()

  let l:pattern = input("Enter pattern: ")
  let l:filename = input("Enter filename: ", expand("%:p"))
  
  call grep#run(l:pattern)

endfunction

function! grep#run_recursive_prompt_args()

  let l:pattern = input("Enter pattern: ")
  let l:directory = input("Enter directory: ", $PWD)
  
  call grep#run_recursive(l:pattern, l:directory)

endfunction

function! grep#run_buffer(pattern)
  
  " Get a list of all the buffer names
  let last_bufno = bufnr("$")

  let i = 1
  let l:filenames = []
  
  while i <= last_bufno
      if bufexists(i) && buflisted(i)
          let fullpath = fnamemodify(bufname(i), ':p')
          if filereadable(fullpath)
              if v:version >= 702
                  let l:filenames = add(l:filenames, fnameescape(fullpath))
              else
                  let l:filenames = add(l:filenames, fullpath)
              endif
          endif
      endif
      let i = i + 1
  endwhile

  " apply js equivalent
  call call('grep#run', [a:pattern] + l:filenames)
endfunction

" Run simple grep with pattern and options as parameters
function! grep#run(...)

  let l:pattern  = a:0 > 0 ? a:1 : expand("<cword>")
  let l:filename = expand("%")
  let l:grep_options = g:grep_default_options
  if a:0 > 1
    let l:grep_options += a:2
  endif

  " Generate commande grep
  let l:cmd      = printf(
        \ "%s %s -e %s %s", 
        \ g:grep_default_bin,
        \ join(l:grep_options, " "),
        \ l:pattern, 
        \ l:filename
        \ )

  call grep#run_async_job(l:pattern, l:cmd)

endfunction

" Run recursive grep with pattern and options as parameters
function! grep#run_recursive( ...)

  " init var options
  let l:recursive = 1
  let l:pattern = a:0 > 0 ? a:1 : expand("<cword>")
  let l:directory = a:0 > 1 ? a:2 : $PWD
  let l:file_pattern = a:0 > 2 ? a:3 : "*"
  let l:exclude_path = a:0 > 3 ? split(a:4, ',') : []
  let l:include_path = a:0 > 4 ? split(a:5, ',') : []

  " Generate command find + grep
  let l:cmd      = printf(
        \ "find %s -type f -name %s%s%s -exec %s -e %s %s {} \\;",
        \ l:directory,
        \ l:file_pattern,
        \ join(map(l:exclude_path, {val -> ' ! -path ' . v:val})), 
        \ join(map(l:include_path, {val -> ' -path "' . v:val . '"'})),
        \ g:grep_default_bin,
        \ join(g:grep_default_options, " "),
        \ l:pattern
        \ )

  call setqflist([])
  call grep#run_async_job(l:pattern, l:cmd)

endfunction


" Run async job from pattern and command
function! grep#run_async_job(pattern, cmd)
  let s:pattern  = a:pattern
  let l:cmd      = a:cmd
  "echo "cmd: " . l:cmd

  exec "silent! cadde \"Search pattern: " . a:pattern . "\""

  " generate buffer name
  let l:job_options = {
        \ "out_cb": "HandleOut",
        \ "exit_cb": "HandleExit",
        \ }

  " Output callback
  func! HandleOut(channel, message)
    exec "cadde a:message"
"    exec "match Search  /" . s:pattern . "/"
    cwindow
  endfunc

  " Exit Callback
  func! HandleExit(job, exit_status)
    echo printf("job: %s, exit_status: %s", a:job, a:exit_status)
  endfunc

  " Exec job
  let g:grep_plugin_current_job = job_start(l:cmd, l:job_options)

endfunction

" Abort current job
function! grep#abort_job()

  if empty(g:grep_plugin_current_job)
    echo "No current job to abort."
  else
    call job_stop(g:grep_plugin_current_job)
  endif

endfunction

" Display info of current job
function! grep#info_job()

  if empty(g:grep_plugin_current_job)
    echo "No current job"
  else
    echo job_info(g:grep_plugin_current_job)
  endif

endfunction
