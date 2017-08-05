[TOC]

## Get vimtools
``` shell
git clone -b vimtools-ubuntu https://SeaflyDennis@github.com/SeaflyDennis/vimtools
```

## Install vimtools
- 0.Into directory: `cd vimtools`
- 1.Get simple help: `./build_all.sh --help` or `./build_all.sh -h` or `./build_all.sh ?`
- 2.Install: `./build_all.sh all`

## usage of vimtools

### Build object environment of vim
- step01: into project root directory:`cd test_proj`
- step02: run vim and open a source file, such as `vim Makefile`
- step03: run vim normal command `:Createtag`
- step04: enjoy yourself!    --(F8)

After, we can manage our object with vim.



# vimtools user's manual

## Window Layout Models

- Vertical Split Layout: `Ctrl-w v`
- Horizontal Split Layout: `Ctrl-w s`
- Changing-over of Layouts: `Ctrl-w [h,j,k,l]`
- Open a file in Layout: `:edit src2.c`
- winmanager Layout: Press `F12` to open or close winmanager.    -- (WMToggle)
- sourceinsight Layout: Press `F8` to open or close sourceinsight.    -- (TrinityToggleAll)

### sourceinsight-coding Layout

- Document: [vimtools-coding-manual.md](https://github.com/SeaflyDennis/vimtools/blob/vimtools-ubuntu/doc/vimtools-coding-manual.md)
- Introduction: This window can view and coding source code.
- Layout Adjustment: `<Ctrl-w>>` adjust width, `<Ctrl-w>+` or `:resize +N` adjust high.
- Frequently-used Operations:
    - insert file information head: `<F2>`
    - insert: type `i`
    - append: type `a`
    - append of line: type `A`
    - new line: type `o`
    - new line above: type `O`
    - choose menu: type `<Ctrl-n>` to next, `<Ctrl-p>` to preview.
    - Select block code: `V` or `<Ctrl-v>`
    - normal copy: `yy` or `yw` or `""y`
    - normal paste: `p` or `""p`
    - Copy to clipboard: `"+y`
    - Paste from clipboard: `"+p`
    - save all: `wall` or `wall!` or `wqall`
    - cl    --Press ESC and type `cl` can clean all blank lines.
    - cs    --Press ESC and type `cs` can clean all blank space and tab end of a line.
    - cm    --Press ESC and type `cm` can clean all `^M`(Windows' `\r\n`)
    - Functions parameters complete: `func_name(` + `<tab>`
    - if，while，switch complete: `keyword` + `<tab>`
    - `#include ""` complete: `in` + `<tab>`
    - `#include <>` complete: `is` + `<tab>`
    - main Function complete: `main` + `<tab>`
    - comment /**/ complete: `cc` + `<tab>`
    - head file (.h) complete: `ff` + `<tab>`
    - define xxx complete: `de` + `<tab>`
    - comment code: `<c-c>`
    - uncomment code: `<c-x>`
    - Select all: `<c-a>`

### sourceinsight-nerdtree Layout

- Document: [NERDTree.txt](https://github.com/scrooloose/nerdtree/blob/master/doc/NERDTree.txt)
- Introduction: This window can view the dir-tree and files list.
- Layout Adjustment: `<Ctrl-w>>` adjust width, `<Ctrl-w>+` or `:resize +N` adjust high.
- Frequently-used Operations:
    - Toggle the display of the quick help: `?`
    - open or close dir: type `o`
    - open file: type `<tab>`
    - Close the current nodes parent: `x`
    - Recursively close all children of the current node: `X`
    - Jump to the root node: `P`
    - Jump to current nodes parent: `p`
    - Move the tree root up one directory: `u`
    - Display the NERD tree menu: `m`
    - Recursively refresh the current director: `u`
    - Recursively refresh the current root: `U`
    - Close the NERDTree window: `q`

### sourceinsight-taglist Layout

- Document: [taglist.txt](https://github.com/vim-scripts/taglist.vim/blob/master/doc/taglist.txt)
- Introduction: This window can view the dir-tree and files list.
- Layout Adjustment: `<Ctrl-w>>` adjust width, `<Ctrl-w>+` or `:resize +N` adjust high.
- Frequently-used Operations:
    - Update the tags listed in the taglist window: `u`
    - Jump to the location: `<Enter>`
    - Jump to the location in a new window: `o`
    - Display the prototype of the tag under the cursor: `<Space>`
    - Close all folds: `=`
    - Open all folds: `*`
    - Open a fold: `+`
    - Close a fold: `-`
    - Jump to the beginning of the next file: `]]`
    - Close the taglist window: `q`


### sourceinsight-minibuf Layout

- Document: [minibufexpl.txt](https://github.com/fholgado/minibufexpl.vim/blob/master/doc/minibufexpl.txt)
- Introduction: This window can view the dir-tree and files list.
- Layout Adjustment: `<Ctrl-w>>` adjust width, `<Ctrl-w>+` or `:resize +N` adjust high.
- Frequently-used Operations:
    - Delete bufs: `bd[!] [N1] [N2] ...` or `bdelete[!] [N1] [N2] ...`
    - Previous buf: `bp` or `bprevious`
    - Next buf: `bn` or `bnext`
    - Switch to first buf: `bf` or `bfirst`
    - Switch to last buf: `bl` or `blast`


### sourceinsight-SrcExpl Layout

- Document: [srcexpl.txt](https://github.com/wesleyche/SrcExpl/blob/master/doc/srcexpl.txt)
- Introduction: This window can preview the source code
- Layout Adjustment: `<Ctrl-w>>` adjust width, `<Ctrl-w>+` or `:resize +N` adjust high.
- Frequently-used Operations:
    - Jump into: `<Enter>`
    - Jump back: `<Space>`



- F1~F12 functions:
    - F1    --System default key.
    - F2    --Press `F2` insert head-of-file
    - F3    --null
    - F5    --Press `F5` to run `:LookupFile`
    - F6    --null
    - F7    --null
    - F8    --Press `F8` to run sourceinsight Layout.
    - F9    --null
    - F10   --null
    - F11   --null
    - F12   --null

