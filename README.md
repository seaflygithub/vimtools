## 项目名称

- 主分支：vimtools
- 次分支：vimtools-ubuntu-SI

## 原理说明

- vimtools = vim + plugins
- 当前分支：vimtools-ubuntu-SI（sourceinsight）

# 使用条件

- 当前分支只支持Ubuntu 64（作者平台(2017): 物理机Ubuntu14.04 x86 64位）
- 网络通畅并配置好软件源（不确定软件源的建议配置为aliyun的软件源）

## 作者信息
- 扣扣：1052061602
- 微信：seafly0616
![./doc/screenshots/contact_seafly.png](./doc/screenshots/contact_seafly.png)
- vim被世界评为Linux下的编辑器之神！vim的高度可扩展性可以让我们自己编写插件来实现我们需要的功能.

## 下载安装

- 下载：`git clone -b vimtools-ubuntu-SI https://github.com/SeaflyGithub/vimtools vimtools-ubuntu-SI`
- 安装：`cd ./vimtools-ubuntu-SI ; bash ./build_all.sh`

## 使用方法

### 工程代码阅读基本步骤


- 第一步：进入代码或工程顶层目录
- 第二步：用vim打开顶层目录中任意一源文件
- 第三步：vim底行模式下执行命令`:Createtag`
    - 如果提示输入平台选项（Bootloader/内核代码）：输入相应平台，如arm
    - 如果问是否建立软连接（默认否）
    - 如果问是否建立tags文件（输入yes并回车）
    - 经过一定时间，同步完成，回车回到正常vim界面
- 第四步：正常编辑浏览代码

### vim以及插件使用方法

- 使用方法 = vim基础操作 + 插件使用方法
- xxx.md文档存放位置: doc/xxx.md
- xxx.md文档使用说明: 由于其中包含图片等信息，请通过[vimtools-ubuntu-SI官网](https://github.com/SeaflyGithub/vimtools vimtools-ubuntu-SI)查阅。
- 插件说明文档格式: 插件名,作者信息,插件描述,插件安装方法,插件使用方法
- 各个插件所对应的功能需求表（插件名(链接至使用文档)（功能概述））
  - [a.vim](./doc/a.vim.md)（.c和.h之间的快速切换）
  - [asyncrun.md](./doc/asyncrun.md)（vim中的shell异步执行脚本）
  - [auto_update_cscope_ctags_database.md](./doc/auto_update_cscope_ctags_database.md)（自动同步更新工程代码数据文件）
  - [code_complete.md](./doc/code_complete.md)（可以提高你的编辑效率的插件）
  - [comments.vim.md](./doc/comments.vim.md)（代码块快速注释和取消注释）
  - [indentLine.md](./doc/indentLine.md)（显示代码嵌套层次）
  - [mark.vim.md](./doc/mark.vim.md)（代码块高亮标签）
  - [minibufexpl.md](./doc/minibufexpl.md)（文件名缓冲区(vim窗口最上边)）
  - [nerdtree.md](./doc/nerdtree.md)（目录树浏览插件）
  - [SrcExpl.md](./doc/SrcExpl.md)（源代码预览窗口插件）
  - [taglist.md](./doc/taglist.md)（显示当前文件宏名、全局变量名、定义函数名列表）
  - [Trinity.md](./doc/Trinity.md)（在此之上三个插件的窗口布局组织插件）
  - [vim-header.md](./doc/vim-header.md)（文件头的插入和更新管理）
  - [vim-markdown.md](./doc/vim-markdown.md)（对markdown语法高亮的支持）
  - []()
  - []()
  - []()
- 功能需求清单格式:【功能需求关键字】（具体插件使用文档链接）
  - 【.c和对应.h文件之间的快速切换】（[doc/a.vim.md](./doc/a.vim.md)）
  - 【快速插入main函数】（[doc/code_complete.md](./doc/code_complete.md)）
  - 【快速包含自定义头文件】（[doc/code_complete.md](./doc/code_complete.md)）
  - 【快速包含系统头文件】（[doc/code_complete.md](./doc/code_complete.md)）
  - 【快速添加头文件预编译框架】（[doc/code_complete.md](./doc/code_complete.md)）
  - 【】（）
  - 【】（）
  - 【】（）

## 本工具包目前所缺的功能以及缺陷

- 文件头更新时间时会混乱格式（待修复）
- 还未安装配置Omnicpp（结构体补全）
- 暂时不支持路径补全

## 注意事项

- 待续

## 开发&维护计划

- 待续

## 贡献者作品

- 待续

## 版本说明

- 待续

## 遵循的协议

- 待续
