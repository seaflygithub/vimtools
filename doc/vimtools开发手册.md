- [vimtools开发框架图](#vimtools开发框架图)
- [vimtools目录管理结构](#vimtools目录管理结构)
- [vimtools二次开发](#vimtools二次开发)

## vimtools开发框架图
[vimtools-development-framework.png](./screenshots/vimtools-development-framework.png)
## vimtools目录管理结构
[vimtools-dirtree-framework.png](./screenshots/vimtools-dirtree-framework.png)
## vimtools脚本build_all.sh

- 主函数: install_vimtools
- 插件安装安装函数（git）: install_git_plugins
- vimtools完整安装配置总流程:
  - 初始化~/.vim目录: init_vim_configure_dir
  - 安装必要的Python支持库: install_python_libs
  - 定制安装vim编辑器: install_vim "python2.x" "no-update" "8.0"
  - 初始化config/目录下的配置文件: init_vimtools_configs
  - 安装各种插件: install_git_plugins
  - 合并config目录下的配置到~/.vimrc: combine_vimrcs
  - 最后的打补丁操作: patch_plugins

## vimtools二次开发

- 内容: 裁剪定制、插件开发、插件列表加入
- 裁剪定制: 不需要的插件直接在build_all.sh中注释掉即可
- 插件开发: vimscript、Python等
- 插件列表加入: 根据build_all.sh结构加入插件列表

