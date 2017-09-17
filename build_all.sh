#!/bin/bash
# File: build_all.sh
# Author: SeaflyGithub <seafly0616@qq.com>
# Date: 2017.08.06
# Last Modified Date: 2017.08.06
# Last Modified By: SeaflyGithub <seafly0616@qq.com>
HOSTOS=""
CUR=
CUR_DIR=`pwd`
CURRENT_DIR=`pwd`
SCRIPTS_DIR=$CURRENT_DIR/plugin/script

vim_src_package=vim-8.0.tar.bz2
vim_src_git=${CURRENT_DIR}/vim/vim

cscope_src_package=cscope-15.8b.tar.gz
cscope_src_git=cscope-15.8b

ctags_src_package=ctags-5.8.tar.gz
ctags_src_git=ctags-5.8

MAKE=make
MKCLEAN=distclean
MKINSTALL=install
MKARGS=-j4
SUDO=
CONFIG=./configure
CFG_ARGS=--prefix=/usr

network_connected=""
HOSTOS=""



#==============================
#vimtool configuration
#==============================
VIMTOOL_ROOT=`pwd`                  #vimtool顶层目录
VIMTOOL_PLUGIN=$VIMTOOL_ROOT/plugin
VIMTOOL_PLG_SCRIPT=$VIMTOOL_PLUGIN/script
VIMTOOL_PLG_SOURCE=$VIMTOOL_PLUGIN/source
VIMTOOL_VIM=$VIMTOOL_ROOT/vim
VIMTOOL_DOC=$VIMTOOL_ROOT/doc
VIMTOOL_CONFIG=$VIMTOOL_ROOT/config
VIMRC=vimrc.vim                     #config/vimrc
OBJECT_TOOL=object.sh               #config/object.sh
VIM_CFG_DIR=$HOME/.vim
VIM_CFG_DIR_PLUGIN=$VIM_CFG_DIR/plugin
VIM_CFG_DIR_DOC=$VIM_CFG_DIR/doc
VIM_CFG_DIR_AUTOLOAD=$VIM_CFG_DIR/autoload
OBJECT_TOOL_PATH=/usr/bin
TEMP_FILE=$HOME/seafly_vimtools.temp

TAR=tar
UNZIP=unzip
DEL_DIR="rm -rf"

ARG_DOT_TAR=-xvf            #xxx.tar
ARG_DOT_TAR_GZ=-xzvf        #xxx.tar.gz  or xxx.tgz
ARG_DOT_TAR_BZ2=-xjvf       #xxx.tar.bz2


#=================================================
#vim editor
#=================================================
VIM=vim-8.0.tar.bz2             #vim source package name
TAR_VIM=$TAR                    #decompress package tool
TAR_VIM_ARGS=$ARG_DOT_TAR_BZ2   #decompress command arguments
VIM_DIR=vim80                   #vim_dir after decompression




#VIM_CONFIG=(./configure \
    #--prefix=/usr \
    #--with-features=huge \
    #--enable-rubyinterp \
    #--enable-pythoninterp=yes \
    #--enable-python3interp=yes \
    #--enable-luainterp \
    #--enable-perlinterp \
    #--enable-multibyte \
    #--enable-cscope \
    #--with-python-config-dir=/usr/lib/python2.6/config)
#--with-python-config-dir=/usr/lib/${PY_VERSION}/config)

#echo "VIM_CONFIG: ${VIM_CONFIG[*]}"        #print all element of array
#======================================================================
####--with-features=huge \
    ####--with-features=big \
    ####--enable-cscope \
    ####--enable-multibyte \


    BVI=bvi-1.4.0-src-11.31.tar.gz             #vim source package name
TAR_BVI=$TAR                    #decompress package tool
TAR_BVI_ARGS=$ARG_DOT_TAR_GZ   #decompress command arguments
BVI_DIR=bvi-1.4.0                  #vim_dir after decompression
#auto get python directory name
BVI_CONFIG=(./configure \
    --prefix=/usr)


#==================================================
#Following are source packages (need to be compiled) plugins
#You should follow the format of following arguments if you want to modify it or add others
CTAGS=ctags-5.8.tar.gz
TAR_CTAGS=$TAR                #decompressing with tar
TAR_CTAGS_ARGS=$ARG_DOT_TAR_GZ
CTAGS_DIR=ctags-5.8

CSCOPE=cscope-15.8b.tar.gz
TAR_CSCOPE=$TAR
TAR_CSCOPE_ARGS=$ARG_DOT_TAR_GZ
CSCOPE_DIR=cscope-15.8b



#函数功能:安装git方式获取并拷贝插件到~/.vim/bundle
#函数用法:install_git_plugin $vimrc $dir $git_addr
function install_git_plugin()
{
    #usage: install_git_plugin update plg_dir_name plg_git_addr
    local download=$1   #download[0|1]
    local update=$2	    #update = [0|1]
    local plg_dir_name="$3"
    local plg_git_addr="$4"
    local bundle_dir=`cd ${HOME}/.vim/bundle ; pwd`
    local backup_dir=`cd ${CUR_DIR}/plugins/script/github ; pwd`

    #备份至本地包
    if [ $network_connected -eq 1 ] ;
    then
        cd ${backup_dir}
        if [ -d ${plg_dir_name} ] ;     #有则更新,没有则clone
        then
            file_list=`ls -l ${plg_dir_name} | wc -l`   #检查插件目录是否为空
            if [ ${file_list} -le 1 ] ;then
                rm -rf ${backup_dir}/${plg_dir_name}
                cd ${backup_dir} ; git clone -b master ${plg_git_addr}
            fi

            if [ ${update} -eq 1 ] ;    #检查更新标志:1则更新，否则不更新
            then
                echo "update==1"
                cd ${plg_dir_name} ; git pull -u origin master ; git submodule update --init --recursive
            else
                echo "update==0"
            fi
        else
            if [ ${download} -eq 1 ] ;  #检查下载标志:1则下载，否则不下载
            then
                echo "download==1"
                cd ${backup_dir} ; git clone -b master ${plg_git_addr}
            else
                echo "download==0"
            fi

        fi

        cd ${backup_dir} ; cp -rv * ${bundle_dir}
    else
        cd ${backup_dir} ; cp -rv * ${bundle_dir}
    fi
    return 0
}

function install_git_plugins()
{
    install_git_plugin 1 1 "asyncrun.vim" "https://github.com/skywind3000/asyncrun.vim"
    install_git_plugin 1 1 "auto_update_cscope_ctags_database" "https://github.com/SeaflyGithub/auto_update_cscope_ctags_database"
    install_git_plugin 1 1 "code_complete" "https://github.com/SeaflyGithub/code_complete"
    install_git_plugin 1 1 "minibufexpl.vim" "https://github.com/fholgado/minibufexpl.vim"
    install_git_plugin 1 1 "nerdtree" "https://github.com/scrooloose/nerdtree"
    install_git_plugin 1 1 "SrcExpl" "https://github.com/wesleyche/SrcExpl"
    install_git_plugin 1 1 "Trinity" "https://github.com/wesleyche/Trinity"
    install_git_plugin 1 1 "vim-header" "https://github.com/alpertuna/vim-header"
    install_git_plugin 1 1 "vim-snippets" "https://github.com/honza/vim-snippets"
    install_git_plugin 1 1 "indentLine" "https://github.com/Yggdroot/indentLine"
    install_git_plugin 0 0 "tabular" "https://github.com/godlygeek/tabular"
    install_git_plugin 0 0 "vim-markdown" "https://github.com/plasticboy/vim-markdown"
    install_git_plugin 0 0 "vim-multiple-cursors" "https://github.com/terryma/vim-multiple-cursors"
    install_git_plugin 1 1 "vim-snippets" "https://github.com/honza/vim-snippets"
    install_git_plugin 1 1 "ultisnips" "https://github.com/SirVer/ultisnips"
    install_git_plugin 0 0 "YouCompleteMe" "https://github.com/Valloric/YouCompleteMe#ubuntu-linux-x64"
    install_git_plugin 1 1 "a.vim" "https://github.com/csliu/a.vim"
    install_git_plugin 1 1 "bufexplorer" "https://github.com/jlanzarotta/bufexplorer"
    install_git_plugin 1 1 "comments.vim" "https://github.com/sudar/comments.vim"
    install_git_plugin 1 1 "genutils" "https://github.com/vim-scripts/genutils"
    install_git_plugin 1 1 "mark.vim" "https://github.com/Tuxdude/mark.vim"
    install_git_plugin 1 0 "minibufexplorerpp.vim" "https://github.com/vim-scripts/minibufexplorerpp/blob/master/plugin/minibufexplpp.vim"
    install_git_plugin 0 0 "OmniCppComplete" "https://github.com/vim-scripts/OmniCppComplete"
    install_git_plugin 1 1 "syntastic" "https://github.com/vim-syntastic/syntastic"
    install_git_plugin 1 1 "taglist.vim" "https://github.com/vim-scripts/taglist.vim"
    install_git_plugin 1 1 "vim-autocomplpop" "https://github.com/othree/vim-autocomplpop"
    install_git_plugin 1 1 "winmanager--Fox" "https://github.com/vim-scripts/winmanager--Fox"
    return 0
}


#函数功能:获取当前系统类型(ubuntu)
#函数用法:get_hostos    结果会存入HOSTOS变量
function get_hostos()
{
    HOSTOS="`uname -v | \
        awk -F ' ' '{print $1}' | \
        awk -F '-' '{print $2}' | \
        tr '[:upper:]' '[:lower:]'`"
}

#函数功能:检查用户权限是否为root从而决定是否使用sudo
#函数用法:无返回值,改变SUDO变量,非root用户SUDO="sudo"
function check_access()
{
    echo "function install_vimtool()>>>安装主函数"
    if [ $UID -ne 0 ] ;
    then
        SUDO=sudo
    fi
}


#函数功能:通过传入主分支获取当前系统支持的python版本
#函数用法:get_python_version "python2"
#返回结果:无返回,结果存入PY_VERSION
function get_python_version()
{
    # usage: get_python_version python2|python3     --Recommend python2
    key_word="$1"
    if [ "${key_word}" = "" ] ;
    then
        echo "get_python_version():key_word==NULL"
        exit 1;
    fi
    ls -l /usr/lib | grep "drw" | \
        grep "${key_word}" | \
        awk -F ' ' '{print $9}' > ${TEMP_FILE}
    PY_VERSION=`cat ${TEMP_FILE}`
    echo "PY_VERSION:${PY_VERSION}"
    rm -rf ${TEMP_FILE}
}


#函数功能:判断当前是否联网
#函数用法:直接调用
#返回结果:无返回,结果存入network_connected变量
function get_network_status()
{
    host www.baidu.com 1>/dev/null 2>/dev/null
    if [ $? -eq 0 ];
    then
        echo "Success: Network available!"
        network_connected=1
    else
        echo "Warning: Network unavailable!"
        network_connected=0
    fi
}


#函数功能:判断当前是否联网
#函数用法:直接调用
#返回结果:无返回,结果存入network_connected变量
function install_python_libs()
{
    if [ $HOSTOS = "ubuntu" ] ;
    then
        if [ ${network_connected} -eq 1 ] ;
        then
            $SUDO apt-get install -y libgtk2.0-dev libxt-dev libx11-dev
            $SUDO apt-get install -y tcl-dev libperl-dev libncurses5-dev
            $SUDO apt-get install -y python-dev
            $SUDO apt-get install -y vim-python-jedi
            $SUDO apt-get install -y python-pip python-dev build-essential
            $SUDO pip install --upgrade pip
            $SUDO pip install --upgrade virtualenv
            pip install jedi
        else
            echo "install_python_libs():ubuntu:network unavailable!"
        fi
    fi
}

function flush_vim_conf()
{
    rm -rf ${HOME}/.vim/*
    rm -rf ${HOME}/.vimrc
    mkdir -p ${HOME}/.vim/bundle 2>/dev/null 1>&2
    mkdir -p ${HOME}/.vim/plugin 2>/dev/null 1>&2
    mkdir -p ${HOME}/.vim/autoload 2>/dev/null 1>&2
    mkdir -p ${HOME}/.vim/doc 2>/dev/null 1>&2
}


#函数功能:配置并编译安装vim编辑器
function config_compile_install_vim()
{
    cd ${vim_src_git} ; \
        make distclean ; \
        ./configure --prefix=/usr --with-features=huge \
        --enable-multibyte \
        --enable-rubyinterp=yes \
        --enable-perlinterp=yes \
        --enable-luainterp=yes \
        --enable-gui=gtk2 --enable-cscope \
        --enable-pythoninterp=yes \
        --with-python-config-dir=/usr/lib/${PY_VERSION}/config-x86_64-linux-gnu/ ; \
        make && ${SUDO} make install ; \ make distclean
}

#函数功能:通过git获取vim源码包
function install_vim_source_package()
{
    if [ ${network_connected} -eq 1 ] ;
    then
        [ -d ${CUR_DIR}/vim/vim ]
        if [ $? -eq 0 ];
        then
            #cd ${vim_src_git} ; git pull -u origin master
            config_compile_install_vim
        else
            cd ${CUR_DIR}/vim ; \
                git clone -b master https://github.com/vim/vim.git
            config_compile_install_vim
        fi

        if [ ${HOSTOS} = "ubuntu" ] ; then
            echo ""
            #${SUDO} apt-get install -y vim-youcompleteme
            #${SUDO} apt-get install -y vim-syntax-go
            #${SUDO} apt-get install -y vim-syntax-gtk
            #${SUDO} apt-get install -y vim-scripts
            #${SUDO} apt-get install -y vim-python-jedi
            #${SUDO} apt-get install -y vim-gtk
            #${SUDO} apt-get install -y vim-gocomplete
            #${SUDO} apt-get install -y vim-gnome
        fi
    else
        config_compile_install_vim
    fi
}

function config_compile_install_src_plg()
{
    cd $CURRENT_DIR/plugin/source && \
        tar -xzvf $cscope_src_package && \
        cd $cscope_src_git && \
        ./configure --prefix=/usr && \
        make && $SUDO make install && \
        cd .. && rm -rf $cscope_src_git

    cd $CURRENT_DIR/plugin/source && \
        tar -xzvf $ctags_src_package && \
        cd $ctags_src_git && \
        ./configure --prefix=/usr && \
        make && $SUDO make install && \
        cd .. && rm -rf $ctags_src_git
    return 0
}

#函数功能:安装ctags,cscope等
function install_source_plugins()
{
    echo "function install_source_plugins()>>>  script plugins"
    if [ $HOSTOS = "ubuntu" ] ;
    then
        if [ $network_connected -ne 1 ] ;
        then
            echo "Error: Network unavailable!"
            echo "       Install with local source package!"
            config_compile_install_src_plg
            return 0
        fi
        $SUDO apt-get install -y ctags
        $SUDO apt-get install -y cscope
        $SUDO apt-get install -y cscope-el
        $SUDO apt-get install -y exuberant-ctags
        return 0
    fi

    #Redhat CentOS
    if [ $network_connected -ne 1 ] ;
    then
        config_compile_install_src_plg
        return 0
    fi
    $SUDO yum install -y ctags
    if [ $? -ne 0 ] ;
    then
        config_compile_install_src_plg
        return 0
    fi
    $SUDO yum install -y ctags
    $SUDO yum install -y ctags-etags
    $SUDO yum install -y cscope
    $SUDO yum install -y cscope-el
    $SUDO yum install -y exuberant-ctags

    return 0
}


function build_all_help()
{
    echo "Simple installation information:"
    echo "    ./build_all               #Complete install vimtool(Recommend first use)"
    echo "    ./build_all function_name #execute specifical function"
    exit 1
}

#函数功能:安装特定插件,来自vim home
#函数用法:$1=plg_dir_name
function install_vimhome_plugin()
{
    local src_dir="${CUR_DIR}/plugins/script/vimhome"
    local dst_dir="${HOME}/.vim/bundle"
    local plg_dir_name="$1"

    cp -rv ${src_dir}/${plg_dir_name} ${dst_dir}
    #ls $src_dir/*.zip | xargs -i -d "\n" unzip -uf {} -d $dst_dir
}

function install_vimhome_plugins()
{
    #install_vimhome_plugin "vim-autocomplpop"
    return 0;
}

function enable_plugins()
{
    local vimrc="${HOME}/.vimrc"
    ls ${HOME}/.vim/bundle | xargs -i -d '\n' echo "set rtp+=${HOME}/.vim/bundle/"{} >> ${vimrc}
}

function config_vimrc()
{
    cat $CURRENT_DIR/config/$VIMRC >> $HOME/.vimrc
    echo -e "Please input your name: \c"
    read user_name
    echo -e "Please input your email: \c"
    read user_email
    echo "let g:header_field_author = '${user_name}'" >> ${HOME}/.vimrc
    echo "let g:header_field_author_email = '${user_email}'" >> ${HOME}/.vimrc
    #sed -i '/colorscheme/d' ~/.vimrc
    return 0
}

function vimtool_finish()
{
    #=================================================================
    #installation finished
    #=================================================================
    echo "CUR: ${CUR}"   #/root/home/user1/vimtool
    echo "Finish installation!"
    echo "                                    E-mail: seafly0616@qq.com"
    #=================================================================
    return 0;
}

function install_youcomleteme()
{
    ${SUDO} apt-get install -y build-essential cmake
    ${SUDO} apt-get install -y python-dev python3-dev
    cd ${HOME}/.vim/bundle/YouCompleteMe ; \
	git submodule update --init --recursive; \
	./install.py --all
}

#函数功能:vimtools主函数
function install_vimtools()
{

    get_hostos
    check_access
    get_python_version "python2"    # be wrote to PY_VERSION
    get_network_status

    INSTALL_ARG=$1

    case $INSTALL_ARG in
        "" | "all")
            echo "Complete installation"
            install_python_libs
            flush_vim_conf
            install_vim_source_package
            install_source_plugins
            install_git_plugins
            install_vimhome_plugins
            enable_plugins
            #install_youcomleteme
            config_vimrc
            vimtool_finish
            ;;
		"help" | "--help" | "?" | "-H" | "-h" | "/?")
			echo "Display installation information:"
            build_all_help
			;;
        *)
            $*
            if [ $? -ne 0 ] ;
            then
                build_all_help
            fi
            ;;
    esac

    return 0
}

install_vimtools $@
