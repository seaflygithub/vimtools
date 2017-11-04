
# 窗口布局介绍

- 垂直分割窗口: ESC: `Ctrl-w v`
- 水平分割窗口: ESC: `Ctrl-w s`
- 子窗口之间的跳转定位: ESC: `Ctrl-w [h,j,k,l]`
- 多窗口模式下打开一个新文件: ESC: `:edit src2.c`
- 调整窗口布局: ESC: `:help resize`
- winmanager窗口布局模式: ESC: Press `F12` to open or close winmanager.    -- (WMToggle)
- sourceinsight窗口布局模式: ESC: Press `F8` to open or close sourceinsight.    -- (TrinityToggleAll)

# sourceinsight-coding Layout

- Mode: ESC
- Document: Note: `<Ctrl-w>` equal to `<c-w>`
- Introduction: This window can view and coding source code.
- Layout Adjustment: `<c-w>>` adjust width, `<c-w>+` or `:resize +N` adjust high.
- Frequently-used Operations:
    - insert file information head: `<F2>`
    - insert: type `i`
    - append: type `a`
    - append of line: type `A`
    - new line: type `o`
    - new line above: type `O`
    - choose menu: NOT_ESC: type `<c-n>` to next, `<c-p>` to preview; and press `<ESC>` to select.
    - Jump to define of symbol: `<c-]>`
    - Jump back frome symbol: `<c-t>` or `<c-o>`
    - Select block code: `V` or `<c-v>`
    - normal copy: `yy` or `yw` or `""y`
    - normal paste: `p` or `""p`
    - Copy to clipboard: `"+y`
    - Paste from clipboard: `"+p`
    - save all and quit: `qall` or `wall` or `qall!` or `wall!` or `wqall` or `wqall!`
    - Press ESC and type `cl` clean all blank lines(cautious).
    - Press ESC and type `cs` clean all `<space>` and `<tab>` end of a line.
    - Press ESC and type `cm` clean all `^M`(Windows' `\r\n`)
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
    - Select and mark: select + `,m`
    - Select all: `<c-a>`
    - Cscope help: ESC: `:cs help` or `:cs ?`
    - Show cscope database file: ESC: `:cs show`
    - Reinit all cscope database: ESC: `:cs reset`
    - Kill a connection of cscope: ESC: `:cs kill`
    - Find functions calling this function: ESC: `:cs find c funcname`
    - Find functions called by this function: ESC: `:cs find d funcname`
    - Find text with egrep mode: ESC: `:cs find e text1`
    - Find this file: ESC: `:cs find f filename`
    - Find this definition: ESC: `:cs find g symbol`
    - Find files #including this file: ESC: `:cs find i filename`
    - Find text contain symbol1: ESC: `:cs find t text1`


# sourceinsight-nerdtree Layout

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

# sourceinsight-taglist Layout

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


# sourceinsight-minibuf Layout

- Document: [minibufexpl.txt](https://github.com/fholgado/minibufexpl.vim/blob/master/doc/minibufexpl.txt)
- Introduction: This window can view the dir-tree and files list.
- Layout Adjustment: `<Ctrl-w>>` adjust width, `<Ctrl-w>+` or `:resize +N` adjust high.
- Frequently-used Operations:
    - Delete bufs: `bd[!] [N1] [N2] ...` or `bdelete[!] [N1] [N2] ...`
    - Previous buf: `bp` or `bprevious`
    - Next buf: `bn` or `bnext`
    - Switch to first buf: `bf` or `bfirst`
    - Switch to last buf: `bl` or `blast`


# sourceinsight-SrcExpl Layout

- Document: [srcexpl.txt](https://github.com/wesleyche/SrcExpl/blob/master/doc/srcexpl.txt)
- Introduction: This window can preview the source code
- Layout Adjustment: `<Ctrl-w>>` adjust width, `<Ctrl-w>+` or `:resize +N` adjust high.
- Frequently-used Operations:
    - Jump into: `<Enter>`
    - Jump back: `<Space>`

# Functions of F1-F12

- F1-F12 functions:
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

# 其他常用shell命令

- Redirect system manual: `man 2 write | col -b > write.man`
- search history command: <c-r> <c-r><c-r> <c-i>
- Move to the beginning or end of the line: <c-a>......<c-e>
- use `!$` to use the argument of last command: `ls /usr/include ; cd !$`
- run last command: `!!`
- free memory cache: `sudo sh -c "/usr/bin/echo 3 > /proc/sys/vm/drop_caches"`
