" grep
" Description:  
" Language:     
" Maintainer:   manslaughter <manslaughter03@gmail.com>
" Version:      0.0.1
" Last Change:  2018-02-20

" check if the script is already load
if exists("g:loaded_grep_plugin")
    finish
endif

if v:version < 800
  echoerr "vim-grep: this plugin requires vim >= 800. GO GET IT"
endif

let g:loaded_grep_plugin = 1

if !exists("g:grep_default_options")
    let g:grep_default_options = [
          \ "--with-filename",
          \ "--line-number",
          \ "--binary-files=without-match"
          \ ]
endif

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

command! -nargs=* -complete=file Grep
      \ call setqflist([]) | call grep#run([], <f-args>)

command! -nargs=* -complete=file Egrep
      \ call setqflist([]) | call grep#run(["--extended-regexp"], <f-args>)

command! -nargs=* -complete=file Fgrep
      \ call setqflist([]) | call grep#run(["--fixed-strings"], <f-args>)

command! -nargs=* -complete=file Pgrep
      \ call setqflist([]) | call grep#run(["--perl-regexp"], <f-args>)

command! -nargs=* -complete=file Rgrep
      \ call setqflist([]) | call grep#run_recursive([], <f-args>)

command! -nargs=* -complete=file Regrep
      \ call setqflist([]) | call grep#run_recursive(["--extended-regexp"], <f-args>)

command! -nargs=* -complete=file Rfgrep
      \ call setqflist([]) | call grep#run_recrusive(["--fixed-strings"], <f-args>)

command! -nargs=* -complete=file Rpgrep
      \ call setqflist([]) | call grep#run_recrusive(["--perl-regexp"], <f-args>)

command! -nargs=* -complete=file GrepAdd
      \ call grep#run(<f-args>)

command! -nargs=* -complete=file EgrepAdd
      \ call grep#run(<f-args>, ["--extended-regexp"])

command! -nargs=* -complete=file FgrepAdd
      \ call grep#run(<f-args>, ["--fixed-strings"])

command! -nargs=* -complete=file PgrepAdd
      \ call grep#run(<f-args>, ["--perl-regexp"])

command! -nargs=* -complete=file RgrepAdd
      \ call grep#run_recursive(<f-args>)

command! -nargs=* -complete=file RegrepAdd
      \ call grep#run_recursive(["--extended-regexp"], <f-args>)

command! -nargs=* -complete=file RfgrepAdd
      \ call grep#run_recursive(["--fixed-strings"], <f-args>)

command! -nargs=* -complete=file RpgrepAdd
      \ call grep#run_recursive(["--perl-regexp"], <f-args>)

command! -nargs=* GrepBuffer
      \ call setqflist([]) | call grep#run_buffer(<f-args>)

command! -nargs=* GrepBufferAdd
      \ call grep#run_buffer(<f-args>)

command! -nargs=* Bgrep
      \ call setqflist([]) | call grep#run_buffer(<f-args>)

command! -nargs=* BgrepAdd
      \ call grep#run_buffer(<f-args>)

command! -complete=file GrepPrompt
      \ call setqflist([]) | call grep#run_prompt_args()

command! -complete=file RgrepPrompt
      \ call setqflist([]) | call grep#run_recursive_prompt_args()

command! -nargs=0 GrepAbort
      \ call grep#abort_job()

command! -nargs=0 GrepInfo
      \ call grep#info_job()
