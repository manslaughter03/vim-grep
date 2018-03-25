# Vim-grep

Vim plugin allow to run grep command from vim. Result is display in the quickfix window.

## Install :

Install with pathogen.

```shell
git clone git_url/banks/vim-grep ~/.vim/bundle/vim-grep
```

Install with packs vim 8 [help](http://vimhelp.appspot.com/repeat.txt.html#packages).

```shell
git clone git_url/banks/vim-grep ~/.vim/pack/plugins/start/vim-grep
```

## Example of usage :

- Grep on current buffer :

```
:Grep bool
```

- Use vim-grep api from vimscript :

```
call grep#run("test")
```

Call recursive grep function :

```
call grep#run_recursive("python", "/usr/share")
```

## Features :

* Run grep command on current buffer/or specify filename

* Grep recursive on a target directory (default current dir), can filter on filename, exclude pattern (ex: ./dist/\*.js)

* Grep on each open buffer (:GrepBuffer)

* Simple and recursive grep with prompt config

* GrepAdd allow to add result in current quickfix list. Also available for Rgrep, GrepBuffer.

## Todos :

Features api :

- :Grep          [X]
- :GrepAdd       [X]
- :Rgrep         [X]
- :RgrepAdd      [X]
- :GrepBuffer    [X]
- :GrepBufferAdd [X]
- :Bgrep         [X]
- :BgrepAdd      [X]
- :GrepArgs      [ ]
- :GrepArgsAdd   [ ]
- :Fgrep         [X]
- :FgrepAdd      [X]
- :Rfgrep        [X]
- :RfgrepAdd     [X]
- :Egrep         [X]
- :EgrepAdd      [X]
- :Regrep        [X]
- :RegrepAdd     [X]
- :Agrep         [ ]
- :AgrepAdd      [ ]
- :Ragrep        [ ]
- :RagrepAdd     [ ]

## Idea

- global var shell escape quote ?

- Replace GrepPrompt and RgrepPrompt command by the default case when Grep and Rgrep without args ? Pattern default value from expand("<cword>") ?

- case sensitive/insensitive

- :ResultListFilter ?

- :ResultListDo ?

- :Replace ? :ReplaceUndo ?

## Sources

- [Quickfix list](http://vimdoc.sourceforge.net/htmldoc/quickfix.html)

- [Vim-grep](https://github.com/vim-scripts/grep.vim)
