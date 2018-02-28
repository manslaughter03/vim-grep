" grep
" Description:  
" Language:     
" Maintainer:   manslaughter <manslaughter03@gmail.com>
" Version:      0.0.1
" Last Change:  2018-02-20

if !exists("g:grep_default_options")
    let g:grep_default_options = [
          \ "--with-filename",
          \ "--line-number",
          \ "--binary-files=without-match"
          \ ]
endif

let g:grep_plugin_current_job = {}

if filereadable(expand('<sfile>:p:h:h') . "/VERSION")
  let g:grep_plugin_version = readfile(expand('<sfile>:p:h:h') . "/VERSION")[0]
endif

if !exists("g:grep_default_bin")
    if executable("grep")
        let g:grep_default_bin = "grep"
    else
        echohl ErrorMsg
        echomsg "Need grep command"
        echohl Normal
    endif
endif

command! -nargs=+ -complete=file Grep
      \ call setqflist([]) | call grep#run(<f-args>)

command! -nargs=+ -complete=file Rgrep
      \ call setqflist([]) | call grep#run_recursive(<f-args>)

command! -nargs=+ -complete=file GrepAdd
      \ call grep#run(<f-args>)

command! -nargs=+ -complete=file RgrepAdd
      \ call grep#run_recursive(<f-args>)

command! -nargs=1 GrepBuffer
      \ call setqflist([]) | call grep#run_buffer(<f-args>)

command! -nargs=1 GrepBufferAdd
      \ call grep#run_buffer(<f-args>)

command! -nargs=1 Bgrep
      \ call setqflist([]) | call grep#run_buffer(<f-args>)

command! -nargs=1 BgrepAdd
      \ call grep#run_buffer(<f-args>)

command! -complete=file GrepPrompt
      \ call setqflist([]) | call grep#run_prompt_args()

command! -complete=file RgrepPrompt
      \ call setqflist([]) | call grep#run_recursive_prompt_args()

command! -nargs=0 GrepAbort
      \ call grep#abort_job()

command! -nargs=0 GrepInfo
      \ call grep#info_job()
