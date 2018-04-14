- [项目名称](#项目名称)
- [项目简介](#项目简介)
- [作者信息](#作者信息)
- [使用环境](#使用环境)
- [下载安装](#下载安装)
- [使用方法](#使用方法)
- [注意事项](#注意事项)
- [vimtools-issue](#vimtools-issue)
- [项目结构](#项目结构)
- [开发&维护计划](#开发&维护计划)
- [贡献者作品](#贡献者作品)
- [版本说明](#版本说明)
- [功能列表](#功能列表)
- [遵循的协议](#遵循的协议)


## 项目名称

- 主分支：vimtools
- 次分支：vimtools-ubuntu-SI
- 当前分支：vimtools-ubuntu-SI（sourceinsight）

## 项目简介

- 项目名: vimtools
- 项目结构: vim + 插件 + 配置 + 补丁
- 项目核心: build_all.sh脚本
- 项目特点: 充分使用vim，方便，可裁剪，可定制，可二次开发

## 作者信息

- 扣扣：1052061602
- 微信：seafly0616
![./doc/screenshots/contact_seafly.png](./doc/screenshots/contact_seafly.png)
## 使用环境

- 当前分支只支持Ubuntu 64（作者平台(2017): 物理机Ubuntu14.04 x86 64位）
- 网络通畅并配置好软件源,不确定的建议[配置为aliyun的软件源](./doc/sources-config-aliyun.gif)

- vim被世界评为Linux下的编辑器之神！vim的高度可扩展性可以让我们自己编写插件来实现我们需要的功能.

## 下载安装

- 下载：`git clone -b vimtools-ubuntu-SI https://gitee.com/SeaflyGitee/vimtools vimtools-ubuntu-SI`
- 获取帮助信息：`cd ./vimtools-ubuntu-SI ; bash ./build_all.sh`
- 全新安装vimtools：`cd ./vimtools-ubuntu-SI ; bash ./build_all.sh --all`

## 使用方法

- 请参考doc目录下的文档
  - 顶层目录: vimtools相关手册
  - vim目录: vim常用操作.md
  - plugins目录: 各种插件的使用方法文档说明

## 注意事项

- 保存文件: 保存文件时注意跳转到顶层源文件再执行保存操作
- NERDTree异常关闭问题: 快速重启F8（即按F8关闭，再按F8启动）

## vimtools-issue

- Q：修改工程代码保存自动同步更新后tags不见了。。。
- A：保存修改请到顶层源文件下执行保存操作即可避免
- Q：打开F8之后，最右边的Nerdtree突然异常停止了。。。
- A：如果发现该情况，马上按两次F8重启SI窗口布局

## 项目结构

- vimtools = vim + 插件 + 补丁

## 开发&维护计划

- 请参考doc目录下的开发文档
- [vimtools开发手册.md](./doc/vimtools开发手册.md)

## 贡献者作品

- 待续

## 版本说明

- 待续

## 功能列表

+ vimwiki离线版维基插件
+ 添加了GTK编程的独立环境配置包(config相关目录:vim_configure_GTK:内有独立安装脚本)
+ 优化工程自动同步插件（auto_update_cscope_ctags_database）
+ 添加源文件语法检查（syntax_check）
+ 添加路径补齐（AutoComplPop）
+ 添加结构体成员补齐（omnicppcomplete）
+ 添加工程代码文件快速查找（LookupFile、genutils）
+ 添加工程数据库自动检测更新同步（auto_update_cscope_ctags_database）
+ 添加对man在vim中的内嵌（man.vim）
+ 添加文件头自动插入更新插件（vim-header）
+ 添加代码快速编辑插件（code_complete）
+ 添加vim内置异步执行命令（asyncrun.vim）
+ 添加sourceinsight窗口布局插件（Trinity）
+ 添加目录树管理（NerdTree）
+ 添加源代码预览窗口（SrcExpl）
+ 添加文件内容列表（taglist）
+ 添加源文件对应头文件快速切换（a.vim）
+ 添加快速注释支持（comments.vim）
+ 添加多标签高亮支持（mark.vim）
+ 添加文件目录管理插件（bufexplorer）
+ 添加多文件名编辑缓冲区（minibufexpl）
+ 添加缩进对齐线显示（indenjLine）
+ 添加markdown语法支持（vim-markdown）

## 其他优秀网友作品

https://github.com/liuchengxu/space-vim
https://github.com/hominlinx/vim
vim-python: https://github.com/SeaflyGithub/vim
https://github.com/wklken/vim-for-server

## 遵循的协议

- 待续
