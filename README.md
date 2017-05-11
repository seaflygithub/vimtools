[TOC]

## 获取vimtools
在本站下载或克隆vimtools如：
``` shell
git clone https://github.com/SeaflyDennis/vimtools.git
```

## 安装vimtools
克隆后或下载解压zip之后会多出一个vimtools目录，
目录中默认是vimtools-2017.03分支。

- 1.获取简易安装帮助信息：`./build_all.sh help`  或  `./build_all.sh -h` 或 `./build_all.sh ?`
- 2.完整安装（初次安装推荐）：`./build_all.sh`
- 3.只安装或更新vim：`./build_all.sh vim` 或 `./build_all.sh.sh only_vim`
- 4.只安装或更新脚本插件：`./build_all.sh scr_plg` 或 `./build_all.sh script_plugin`
- 5.只安装或更新源码插件：`./build_all.sh src_plg` 或 `./build_all.sh source_plugin`
- 6.只安装或更新配置文件：`./build_all.sh config` 或 `./build_all.sh update_config`

## 快速上手vimtools

### 进入工程环境
- 步骤01：进入目标工程顶层目录，`cd test_proj`
- 步骤02：执行`object.sh`命令生成工程依赖文件，`object.sh`
- 步骤03：启动vim，打开任何一个工程源文件。`vim Makefile`
- 步骤04：启动vim后，分别按F3，F4导入工程依赖文件，F3，F4分别类似如下vim命令：
        :set tags=tags,filenametags,~/.vim/systags
        :cscope add cscope.out ./

至此，我们成功进入工程环境，接下来我们就可以使用vim管理该工程了。


### 普通多窗口模式
#### 垂直分割窗口：`Ctrl-w v`
如图：
#### 水平分割窗口：`Ctrl-w s`
如图：
#### 窗口之间跳转切换：`Ctrl-w [h,j,k,l]`
如图：
#### 该窗口打开一个文件：`:edit src2.c`
如图：

### winmanager窗口模式
按F12进入该窗口模式，再按F12退出该窗口模式

### sourceinsight窗口模式
按F8进入该窗口模式，再按F8退出该窗口模式

E-mail:seafly0616@qq.com
