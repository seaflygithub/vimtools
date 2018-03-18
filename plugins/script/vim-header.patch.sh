#!/bin/bash
# File              : plugins/script/vim-header.patch.sh
# Author            : SeaflyGithub <seafly0616@qq.com>
# Date              : 2017.10.24 10时56分35秒
# Last Modified Date: 2017.11.05 06:22:37
# Last Modified By  : seafly <seafly0616@qq.com>

DIR_CUR="`pwd`"
SUDO=""
USE_YCM=0
NETADDR_PING="www.baidu.com"
if [ ${UID} -ne 0 ] ; then 
    SUDO="sudo" 
else 
    SUDO="" 
fi
HOSTOS="`uname -v | \
    awk -F ' ' '{print $1}' | \
    awk -F '-' '{print $2}' | \
    tr '[:upper:]' '[:lower:]'`"

DIR_VIM_SRC=${DIR_CUR}/vim/vim
PKG_CSCOPE_SRC=cscope-15.8b.tar.gz
DIR_CSCOPE_SRC=cscope-15.8b
PKG_CTAGS_SRC=ctags-5.8.tar.gz
DIR_CTAGS_SRC=ctags-5.8

DIR_SCRIPT_PATH=${DIR_CUR}/plugins/script
DIR_HOME_VIM_BUNDLE=${HOME}/.vim/bundle
GLOBAL_PLUGINS_VIMRC=${DIR_CUR}/config/plugins_vimrc.vimrc
GLOBAL_RUNTIME_VIMRC=${DIR_CUR}/config/runtime_vimrc.vimrc
GLOBAL_DEFAULT_VIMRC=${DIR_CUR}/config/default_vimrc.vimrc

#补丁: vim-header添加对时间的支持（精确到秒）
if [ -f ${DIR_HOME_VIM_BUNDLE}/vim-header/autoload/header.vim ] ; then
    grep -Hn "%Y\.%m\.%d\ %X" ${DIR_HOME_VIM_BUNDLE}/vim-header/autoload/header.vim
    if [ $? -ne 0 ] ;
    then
        sed -i '25ilet g:header_field_timestamp_format = "%Y.%m.%d %X"' ${DIR_HOME_VIM_BUNDLE}/vim-header/autoload/header.vim
    fi
fi

# vim-header配置头信息 >> 并追加到配置文件尾部（由此之该插件最后一个配置）
echo "config_vim_header(): 正在配置用户信息..."
echo "config_vim_header(): 下面的用户名和邮箱均用在源文件首部..."
tail -n 5 ${HOME}/.vimrc
echo "config_vim_header(): 请手动修改~/.vimrc最后几行的用户名和邮箱"
#echo "let g:header_field_author = '${user_name}'" >> ~/.vimrc
#echo "let g:header_field_author_email = '${user_email}'" >> ~/.vimrc
