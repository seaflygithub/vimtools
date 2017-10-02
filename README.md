[TOC]

- [vimtools简介](#vimtools简介)
- [vimtools获取](#vimtools获取)
- [vimtools安装](#vimtools安装)
- [vimtools快速体验](#vimtools快速体验)
- [vimtools作者信息](#vimtools作者信息)
- [vimtools使用笔记](#vimtools使用笔记)
## vimtools简介

    温馨提示：如果觉得好用就推荐给其他同伴吧，顺带有兴趣的帮忙一起维护这个笑容（滑稽）

    vimtools其实就是一个vim+plugins的集合包，只是帮用户省去了大量自己动手安装配置的过程;
    让用户可以空闲出无聊的时间去做更多无聊的事情;
    同时vimtools也可以说是vim的强化包，它能尽量提高你的工作效率（当然是在你熟练常用操作以及插件操作的情况下）;

## vimtools获取

`https://github.com/SeaflyGithub/vimtools/tree/vimtools-ubuntu`
- Ubuntu版分支：`git clone -b vimtools-ubuntu https://github.com/SeaflyGithub/vimtools`
- sourceinsight版分支：`待定...（上面的Ubuntu分支已经整合了sourceinsight操作特性）`
- YouCompleteMe版分支：`待定...`
- k-vim版分支：`该分支是另一位哥们儿的作品：https://github.com/SeaflyGithub/vimtools/tree/For_k-vim`

**分支说明：**由于`Python2.x`和`Python3.x`不兼容，致YCM(3.x)和SI(2.x)里重要插件不能同时工作；目前Ubuntu版分支最活跃；其次是另一位哥们儿维护的k-vim分支，简单介绍写哥们儿的k-vim分支：`该分支非常强大，集成了YCM(YouCompleteMe)插件的自动安装配置，推荐大家使用`

## vimtools安装

- 终端进入vimtools顶层目录，紧接着直接执行build_all.sh脚本
- 脚本开始工作，全程自动安装配置
- 脚本执行完成，在脚本即将退出末尾需要输入用户名和邮箱，就是工作中源代码文件的作者和邮箱

## vimtools快速体验

    提示：这里我们以Ubuntu版分支为例，下面是普通工程和内核工程分别的使用情况

### 内核工程

- 首先终端下进入内核顶层目录
- 用vim打开顶层目录中的任意一个源文件
- 在vim中执行Createtag命令，也就是敲入`:Createtag` 紧接着回车
- 提示你的内核是针对哪个处理器架构，这里比如我们选arm 回车
- 紧接着一步一步回车（别回车太急）
- 后面提示是否创建软连接，一般选择默认No，直接回车即可
- 回车回车，然后问是否创建tags文件，输入`yes`，紧接着回车
- 然后工程同步插件就开始工作了！！！
- 同步完成后，按任意键退出，回到正常的vim编辑界面
- 之后你做的每一步修改保存之后它都会自动帮你更新同步了(不用重新执行Createtag了)
- 如果你主要浏览代码建议用SourceInsight窗口布局（按F8打开，再按F8关闭）
- 如果你主要编辑代码或其他，那么可以根据你的喜好自行定义窗口布局

### 其他工程

- 首先终端下进入源代码顶层目录
- 用vim打开顶层目录中的任意一个源文件
- 在vim中执行Createtag命令，也就是敲入`:Createtag` 紧接着回车
- 提示是否创建软连接，一般选择默认No，直接回车即可
- 回车回车，然后问是否创建tags文件，输入`yes`，紧接着回车
- 然后工程同步插件就开始工作了！！！
- 同步完成后，按任意键退出，回到正常的vim编辑界面
- 之后你做的每一步修改保存之后它都会自动帮你更新同步了(不用重新执行Createtag了)
- 如果你主要浏览代码建议用SourceInsight窗口布局（按F8打开，再按F8关闭）
- 如果你主要编辑代码或其他，那么可以根据你的喜好自行定义窗口布局

## vimtools作者信息
![./image/contact_seafly.png](./image/contact_seafly.png)

## vimtools使用笔记

