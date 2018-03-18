#!/bin/bash
# File              : plugins/script/cscope_ctags.sh
# Author            : SeaflyGithub <seafly0616@qq.com>
# Date              : 2017.10.24 11时08分27秒
# Last Modified Date: 2017.11.05 06:12:37
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
# 安装cscope_ctags工具

 echo "install_ctags_cscope(): 选择安装最新..."
 echo "install_ctags_cscope(): 正在检查网络连接..."
 host ${NETADDR_PING} 1>/dev/null 2>/dev/null
 if [ $? -eq 0 ] ; then
     if [ $HOSTOS != "ubuntu" ] ;
     then
         echo "错误: 该系统不是Ubuntu或Debian发行版!"
         echo "install_ctags_cscope(): 即将退出安装..."
         exit 1
     fi
     echo "install_ctags_cscope(): 正在在线安装最新最新插件..."
     $SUDO apt-get install -y ctags     --force-yes
     $SUDO apt-get install -y cscope    --force-yes
     exit 0
 else
     echo "install_ctags_cscope(): 网络无连接,正在本地化安装..."
     cd ${DIR_CUR}/plugins/source ; \
         tar -xzvf $PKG_CSCOPE_SRC ; \
         cd $DIR_CSCOPE_SRC ; \
         ./configure --prefix=/usr ; \
         make && $SUDO make install ; \
         cd .. ; rm -rf ${DIR_CUR}/plugins/source/$DIR_CSCOPE_SRC

     cd ${DIR_CUR}/plugins/source ; \
         tar -xzvf $PKG_CSCOPE_SRC ; \
         tar -xzvf $PKG_CTAGS_SRC ; \
         cd $DIR_CTAGS_SRC ; \
         ./configure --prefix=/usr ; \
         make && $SUDO make install ; \
         cd .. ; rm -rf ${DIR_CUR}/plugins/source/$DIR_CTAGS_SRC
 fi

