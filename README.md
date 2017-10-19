## 项目名称

- 主分支：vimtools
- 次分支：vimtools-ubuntu

## 原理说明

- vimtools = vim + plugins

## 使用说明

- 使用方法 = vim基础操作 + 插件使用方法

## 使用条件

- 当前分支只支持Ubuntu 64（作者平台: Ubuntu14.04 x86 64位）
- 网络通畅并配置好软件源

## 下载安装

- 下载：`git clone -b vimtools-ubuntu https://github.com/SeaflyGithub/vimtools vimtools-ubuntu`
- 安装：`cd ./vimtools-ubuntu ; ./build_all.sh`

## 使用方法

- 第一步：进入代码或工程顶层目录
- 第二步：用vim打开顶层目录中任意一源文件
- 第三步：vim命令模式下执行命令`:Createtag`
    - 平台选项（内核代码）：输入相应平台，如arm
    - 是否建立软连接（默认否）
    - 是否建立tags文件（输入yes并回车）
    - 同步完成，回车回到正常vim界面

## 注意事项

## 开发&维护计划

## 贡献者作品

## 版本说明

## 遵循的协议

