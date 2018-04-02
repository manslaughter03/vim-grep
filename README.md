# Vim-grep

Vim plugin allow to search for pattern with grep command from vim in async job (available only on version 8+ of vim). Result is display in the quickfix window.
This plugin need grep and find utilities.

## Install :

Install with [pathogen](https://github.com/tpope/vim-pathogen).

```shell
git clone https://github.com/manslaughter03/vim-grep ~/.vim/bundle/vim-grep
```

Install with packs vim 8 [help](http://vimhelp.appspot.com/repeat.txt.html#packages).

```shell
git clone https://github.com/manslaughter03/vim-grep  ~/.vim/pack/plugins/start/vim-grep
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

- :Grep           [x]
- :Egrep          [x]
- :Fgrep          [x]
- :Pgrep          [x]
- :Rgrep          [x]
- :Regrep         [x]
- :Rfgrep         [x]
- :Rpgrep         [x]
- :GrepAdd        [x]
- :EgrepAdd       [x]
- :FgrepAdd       [x]
- :PgrepAdd       [x]
- :RgrepAdd       [x]
- :RegrepAdd      [x]
- :RfgrepAdd      [x]
- :RpgrepAdd      [x]
- :GrepBuffer     [x]
- :GrepBufferAdd  [x]
- :Bgrep          [x]
- :BgrepAdd       [x]
- :GrepPrompt     [x]
- :RgrepPrompt    [x]
- :GrepAbort      [x]
- :GrepInfo       [x]
- :GrepArgs       [ ]
- :GrepArgsAdd    [ ]

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
