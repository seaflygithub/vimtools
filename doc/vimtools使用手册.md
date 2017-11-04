- [vimtools用户使用手册简介](#vimtools用户使用手册简介)
- [vimtools浏览工程代码](#vimtools浏览工程代码)

# vimtools用户使用手册简介

- vimtools使用 = vim操作 + 插件操作
- 提示: 下面这些都是工程中常用的操作，熟能生巧即可

# vimtools同步工程

- 说明: 既然是工程代码，我们都知道其代码里的庞大
- 前提: 用vim浏览工程代码就必须要生成vim所依赖的工程数据库文件
- 开始:
  1. 进入工程顶层目录，如`cd /home/seafly/linux-2.6.9/`
  2. 通过vim打开顶层目录中任意一个源文件，如`vim Makefile`
  3. 紧接着执行底行命令`:Createtag`
    1. 如果提示选择体系结构，则选择你的目标体系，如`arm`回车
    2. 如果提示目录确认提示，一般我们顶层目录就直接回车
    3. 如果提示是否创建软连接，默认否即可，直接回车
    4. 如果提示是否创建tags文件，输入`yes`并回车，因为我们需要数据库文件
  4. 经过一段时间(看工程大小)我们的工程数据库文件就同步完成
  5. 紧接着我们就可以浏览代码了（手动同步一次以后就自动同步该工程了）
  - 操作示意图: [vimtools-Createtag.gif](./screenshots/vimtools-Createtag.gif)

# vimtools使用工程

- vimtools启动SI(SourceInsight)模式
  - 同步工程: 进入工程顶层目录，根据情况同步工程(同步过一次的可跳过)
    - 同步过后会产生cscope.xxx和tags文件
  - 启动SI模式: 其次启动SI模式,按F8即可启动,再按F8即可关闭
    - 打开顶层目录中任意一个源文件
    - 紧接着按F8打开SI模式(再按F8关闭SI模式)
    - 调整窗口布局（鼠标、键盘任选）
  - 操作示意图: [vimtools-F8-open-SI.gif](./screenshots/vimtools-F8-open-SI.gif)

- SI(SourceInsight)模式下工程源文件的打开
  - 同步工程: 进入工程顶层目录，根据情况同步工程(同步过一次的可跳过)
    - 同步过后会产生cscope.xxx和tags文件
  - 启动SI模式: 其次启动SI模式,按F8即可启动,再按F8即可关闭
    - 打开顶层目录中任意一个源文件
    - 紧接着按F8打开SI模式(再按F8关闭SI模式)
    - 调整窗口布局（鼠标、键盘任选）
    - 从右边目录树打开某目录下的文件
      - 先找到你要打开的文件
      - 确认一遍你的光标在编辑区内
      - 再鼠标点中右边文件名，紧接着双击即可打开该文件（键盘就是光标定位到文件名上按字母o）
    - 然后你的编辑区就是该文件内容了
    - 窗口最上面的文件名缓冲区就多了一个你的文件名标签了
  - 操作示意图: ![vimtools-SI-nerdtree-open-file.gif](./screenshots/vimtools-SI-nerdtree-open-file.gif)

- SI(SourceInsight)模式下跟踪到定义处（函数、变量、宏...）
  - 同步工程: 进入工程顶层目录，根据情况同步工程(同步过一次的可跳过)
    - 同步过后会产生cscope.xxx和tags文件
  - 启动SI模式: 其次启动SI模式,按F8即可启动,再按F8即可关闭
    - 打开顶层目录中任意一个源文件
    - 紧接着按F8打开SI模式(再按F8关闭SI模式)
    - 调整窗口布局（鼠标、键盘任选）
    - 打开你的目标源文件
    - 鼠标点中你要跟踪的函数
    - 紧接着在最下面的SrcExpl窗口中显示定义或列表（因为这里有不同体系架构的CPU）
      - 定义:(直接显示定义，说明工程中只有这一个)
        - 跟踪: 鼠标点中SrcExpl中的高亮标识，然后双击它(或回车)，即可在编辑区打开
        - 回退: 鼠标点中编辑区，然后按空格键，按一次回退一步
      - 列表:(因为体系结构的不同或其他有同名标识)
        - 跟踪: 在列表中选中你需要的，鼠标点中它，然后双击它(或回车)，即可在编辑区打开
        - 回退: 鼠标点中编辑区，然后按空格键，按一次回退一步
  - 操作示意图: [vimtools-goto-define-and-back.gif](./screenshots/vimtools-goto-define-and-back.gif)

- vimtools通过LookupFile模糊查找某个文件
  - 同步工程: 进入工程顶层目录，根据情况同步工程(同步过一次的可跳过)
    - 同步过后会产生cscope.xxx和tags文件
    - 打开顶层目录中任意一个源文件
    - 这里比如我要查找miscdevice.h，但我记不清,我通过关键字device来查找
    - 首先底行模式下输入`:LookupFile`后回车
      - 输入文件名关键字，(之后删除一个字符启动全局检索)
      - 按<Ctrl-n>向下选择(next)，按<Ctrl-p>向上选择(previous)，（<Ctrl-j><Ctrl-k>也可以）
      - 选中之后按回车,就打开了此文件(注意文件名缓冲区)
      - 退出lookupfile: 按ESC进入normal模式,然后按组合件<Ctrl-w>q即可退出lookupfile
  - 操作示意图: [vimtools-lookupfile-findfile.gif](./screenshots/vimtools-lookupfile-findfile.gif)

- vimtools代码快速编辑
  - code_complete优化版:快速插入头文件预编译选项: 插入模式下输入ff然后紧接着按Tab键
  - code_complete优化版:快速插入main函数: 插入模式下输入main然后紧接着按Tab键
  - code_complete优化版:快速定义一个新函数: 插入模式下输入f3然后紧接着按Tab键(其中的3代表该函数有3个参数,可根据自己情况更改)
  - code_complete优化版:函数参数提示: 例如插入模式下输入printf(然后紧接着按Tab键(被宏定义过的函数无法使用此功能)
  - code_complete优化版:快速包含系统标准库头文件: 插入模式下输入is然后紧接着按Tab键
  - code_complete优化版:快速包含自定义头文件: 插入模式下输入in然后紧接着按Tab键
  - code_complete优化版:快速打桩if条件语句: 插入模式下输入if然后紧接着按Tab键
  - code_complete优化版:快速打桩if-else条件语句: 插入模式下输入ife然后紧接着按Tab键
  - code_complete优化版:快速打桩if-else多分支条件语句: 例如插入模式下输入ife5然后紧接着按Tab键，产生5个else-if分支
  - code_complete优化版:快速打桩switch条件语句: 插入模式下输入switch然后紧接着按Tab键
  - code_complete优化版:快速打桩switch多分支条件语句: 例如插入模式下输入switch5然后紧接着按Tab键，产生5个case分支
  - code_complete优化版:快速打桩for循环语句: 插入模式下输入for然后紧接着按Tab键
  - code_complete优化版:快速打桩while循环语句: 插入模式下输入while然后紧接着按Tab键
