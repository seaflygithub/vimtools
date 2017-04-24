#!/bin/bash
# build_all.sh
# Copyright (c) 2017 SeaflyDennis <seafly0616@qq.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#---------------------------------------
#(configuration item)
#---------------------------------------------
CUR=
MAKE=make
MKCLEAN=distclean
MKINSTALL=install
MKARGS=-j4
SUDO=
CONFIG=./configure
CFG_ARGS=--prefix=/usr
HOSTOS=`uname -v | \
        awk -F ' ' '{print $1}' | \
        awk -F '-' '{print $2}' | \
        tr '[:upper:]' '[:lower:]'`


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
VIMRC=vimrc                         #config/vimrc
OBJECT_TOOL=object.sh               #config/object.sh
VIM_CFG_DIR=$HOME/.vim
HOME_VIMRC=$HOME/.vimrc
VIM_CFG_DIR_PLUGIN=$VIM_CFG_DIR/plugin
VIM_CFG_DIR_DOC=$VIM_CFG_DIR/doc
VIM_CFG_DIR_AUTOLOAD=$VIM_CFG_DIR/autoload
OBJECT_TOOL_PATH=/usr/bin
TEMP_FILE=$HOME/seafly_temp
VIMRCS=$VIMTOOL_CONFIG/vimrcs
VIMRCLIST=`ls ${VIMRCS}`
VIM_HEADER=""
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
#auto get python directory name
list=`ls /usr/lib | grep "python"`
ls /usr/lib | grep "python" > ${TEMP_FILE}
python_version=`awk -F . '{print $1}' ${TEMP_FILE}`	#python2
value=
ret=
for value in $list
do
    ret=$value
    echo "$value" > ${TEMP_FILE}
    value=`awk -F . '{print $1}' ${TEMP_FILE}`
    if [ "$value" == "${python_version}" ] ;	#main support python2.x  !!!!!!
    then
	break
    fi
done
PY_VERSION=$ret
VIM_CONFIG=(./configure \
    --prefix=/usr \
    --with-features=huge \
    --enable-rubyinterp \
    --enable-pythoninterp=yes \
    --enable-python3interp=yes \
    --enable-luainterp \
    --enable-perlinterp \
    --enable-multibyte \
    --enable-cscope \
    --with-python-config-dir=/usr/lib/python2.6/config)
#    --with-python-config-dir=/usr/lib/${PY_VERSION}/config)
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


#------------------------------------------------
#functions' implement
#------------------------------------------------
function debug_vimtool()
{

    echo "function debug_vimtool()>>>complete installation total list"
    read temporary
    echo "function install_vimtool()>>>installation main function"
    echo "function install_vimtool()>>>complete installation"
    echo "function install_vim()>>>install vim"
    echo "function only_vim()>>>only install vim"
    echo "function install_plugin()>>>install plugins"
    echo "function source_plugin()>>>source code plugins"
    echo "function source_tar_plugin()>>>*.tar format source plugin packages"
    echo "function source_zip_plugin()>>>*.zip format source plugin packages"
    echo "function source_tar_gz_plugin()>>>*.tar.gz format source plugin packages"
    echo "function source_tar_bz2_plugin()>>>*.tar.bz2 format source plugin packages"
    echo "function script_plugin()>>> script plugins"
    echo "function script_vim_plugin()>>>*.vim format plugins"
    echo "function script_tar_plugin()>>>*.tar format plugins"
    echo "function script_zip_plugin()>>>*.zip format plugins"
    echo "function script_tar_gz_plugin():*.tar.gz format plugins"
    echo "function script_tar_bz2_plugin()>>>*.tar.bz2 format plugins"
    echo "function install_config()>>>install configuration files"
    echo "function config_object()>>>install object configuration file(s)"
    echo "function config_vimrc()>>>install vimrc configuration file(s)"
    echo " "
    echo " "
    echo debugingdebugingdebugingdebugingdebuging ;read debuging
    echo debugingdebugingdebugingdebugingdebuging ;read debuging
    echo debugingdebugingdebugingdebugingdebuging ;read debuging
    echo debugingdebugingdebugingdebugingdebuging ;read debuging
    echo debugingdebugingdebugingdebugingdebuging ;read debuging
    echo debugingdebugingdebugingdebugingdebuging ;read debuging
    echo debugingdebugingdebugingdebugingdebuging ;read debuging
    echo debugingdebugingdebugingdebugingdebuging ;read debuging
    echo debugingdebugingdebugingdebugingdebuging ;read debuging
    echo debugingdebugingdebugingdebugingdebuging ;read debuging
    echo debugingdebugingdebugingdebugingdebuging ;read debuging
    echo debugingdebugingdebugingdebugingdebuging ;read debuging
    exit 0
    return 0
}

function vimtool_finish()
{
    #=================================================================
    #installation finished
    #=================================================================
    echo "CUR: ${CUR}"   #/root/home/user1/vimtool
    echo "Finish installation! Please read doc/xxx.pdf for reference"
    echo "Note"
    echo "    Run vim first time, you need goto ~/.vim/doc, likes following commands:"
    echo "    # cd ~/.vim/doc"
    echo "    # vim"
    echo "         "
    echo "    and then run following 'vim-command':"
    echo "    :helptags ./       (It can load help files into vim)"
    echo "    (If you add other plugins help file(s), replay above stage)"
    echo " "
    echo "Press <Enter> look following message...(Press <Ctrl-c> to ignore)"
    read temporary
    clear
    echo "Manual:(Readme!)"
    echo ""
    echo "    step01 cd ~/your_object_dir"
    echo "    step02 run object.sh directly"
    echo "           (execute object.sh if you want to update object_depend_file)"
    echo "    step03 run vim"
    echo "           Press <F3> load tags file"
    echo "           Press <F4> load cscope file"
    echo "    "
    echo "           Press <F12> open the winmanager window(selectable)"
    echo "    "
    echo "    After above operations, we have finished initialazation of object"
    echo "    and then you can see vimtool/doc/xxx.pdf for details"
    echo " "
    echo "    (Installation details: vimtool/build_all)"
    echo "    (Plugin configuration: vimtool/config/vimrc)"
    echo "    (Object configuration: vimtool/config/object.sh)"
    echo "                                    E-mail: seafly0616@qq.com"
    #=================================================================
    
}

function build_all_help()
{
    echo "Simple installation information:"
    echo "    ./build_all               #Complete install vimtool(Recommend first use)"
    echo "    ./build_all only_vim      #Only install vim"
    echo "    ./build_all no_vim        #Only install plugins"
    echo "    ./build_all script_plugin #Only install script plugins"
    echo "    ./build_all source_plugin #Only install source plugins"
    echo "    ./build_all update_config #Only install configuration files"


    echo "Helpful information of first-use"
    echo "    # cd ~/.vim/doc"
    echo "    # vim"
    echo "         "
    echo "    Then run following command to load help files"
    echo "    :helptags ./ "
    echo "    (If you add other new plugins, replay above stage)"
    echo " "
    echo "Press <Enter> to continue...(Press <Ctrl-c> to ignore)"
    read temporary
    clear
    echo "Manual:(Readme!)"
    echo ""
    echo "    step01 cd ~/your_object_dir"
    echo "    step02 run object.sh directly"
    echo "           (execute object.sh if you want to update object_depend_file)"
    echo "    step03 run vim"
    echo "           Press <F3> load tags file"
    echo "           Press <F4> load cscope file"
    echo "    "
    echo "           Press <F12> open the winmanager window(selectable)"
    echo "    "
    echo "    After above operations, we have finished initialazation of object"
    echo "    and then you can see vimtool/doc/xxx.pdf for details"
    echo " "
    echo "    (Installation details: vimtool/build_all)"
    echo "    (Plugin configuration: vimtool/config/vimrc)"
    echo "    (Object configuration: vimtool/config/object.sh)"
    echo "                                    E-mail: seafly0616@qq.com"
    #=================================================================
    
}


function only_vim()
{
    if [ $HOSTOS == "ubuntu" ] ;
    then
	echo "HOSTOS:$HOSTOS"
        host www.baidu.com 1>/dev/null 2>/dev/null
        if [ $? -ne 0 ] ;
        then
            echo "Error: Network unavailable!"
            exit 1
        fi

    $SUDO apt-get install vim
    $SUDO apt-get install vim-nox
    $SUDO apt-get install vim-athena
    $SUDO apt-get install vim-gnome
	$SUDO apt-get install vim-gocomplete
	$SUDO apt-get install vim-gtk
	$SUDO apt-get install vim-python-jedi
	$SUDO apt-get install vim-scripts
	$SUDO apt-get install vim-syntax-go
	$SUDO apt-get install vim-syntax-docker
	$SUDO apt-get install vim-syntax-gtk
	$SUDO apt-get install vim-tiny
	$SUDO apt-get install vim-vimerl
	$SUDO apt-get install vim-vimerl-syntax
	$SUDO apt-get install vim-youcompleteme
        return 0
    fi

    echo "function only_vim()>>>only install vim"
    CUR=$VIMTOOL_VIM
    cd $CUR                     #vimtool/vim
    echo "CUR: $CUR"            #CUR: vimtool
    $TAR_VIM $TAR_VIM_ARGS $VIM
    cd $VIMTOOL_VIM/$VIM_DIR    #vimtool/vim/vim80
    $MAKE $MKCLEAN
    #$VIM_CONFIG     #configuration for python
    ./configure  \
        --prefix=/usr  \
        --with-features=huge  \
        --enable-rubyinterp  \
        --enable-pythoninterp=yes  \
        --enable-python3interp=yes  \
        --enable-luainterp  \
        --enable-perlinterp  \
        --enable-multibyte   \ --enable-cscope \
        --with-python-config-dir=/usr/lib/python2.6/config

    $MAKE $MKARGS
    $SUDO $MAKE $MKINSTALL
    cd $VIMTOOL_VIM
    $DEL_DIR $VIM_DIR


    CUR=$VIMTOOL_VIM
    cd $CUR                     #vimtool/vim
    echo "CUR: $CUR"            #CUR: vimtool
    $TAR_BVI $TAR_BVI_ARGS $BVI
    cd $VIMTOOL_VIM/$BVI_DIR    #vimtool/vim/vim80
    $MAKE $MKCLEAN
    $BVI_CONFIG
    $MAKE $MKARGS
    $SUDO $MAKE $MKINSTALL
    cd $VIMTOOL_VIM
    $DEL_DIR $BVI_DIR

    echo "only_vim():successfully!"
    return 0
}

function source_tar_gz_plugin()
{
    echo "function source_tar_gz_plugin()>>>*.tar.gz  script plugins"
    [ -d $VIM_CFG_DIR ]
    if [ $? -ne 0 ] ;
    then
        mkdir -p $VIM_CFG_DIR
    fi

    cp -v $VIMTOOL_PLG_SOURCE/*.tar.gz $VIM_CFG_DIR
    cd $VIM_CFG_DIR

    local value=
    local value_dir=
    local list=`ls *.tar.gz`
    echo "list: $list"
    for value in $list
    do
        if [ -z $value ] ;
        then
            break
        fi

        #检查value是否为普通 script plugins
        if [ $value == "netrw-93.tar.gz" ] ;
        then
            echo "$value isn't a source package"
        elif [ $value == "vimcdoc-1.5.0.tar.gz" ] ;
        then
            echo "$value isn't a source package"
        else
            echo ""
        fi

        #解压压缩包
        $TAR $ARG_DOT_TAR_GZ $value

        #获取压缩包解压之后的目录:这里直接根据命名规则获取
        #还有其它获取方式等用到再说
        echo "$value" > $TEMP_FILE
        echo "value: $value"
        value_dir=`awk -F . '{print $1}' $TEMP_FILE`
        value_dir=${value_dir}.
        value_dir=${value_dir}`awk -F . '{print $2}' $TEMP_FILE`
        echo "value_dir: $value_dir"

        #测试解压之后的目录的有效性#失败，则通过另一种方式(*)获取
        cd $VIM_CFG_DIR/$value_dir
        if [ $? -ne 0 ] ;
        then
            echo "$value" > $TEMP_FILE
            value_dir=`awk -F - '{print $1}' $TEMP_FILE`
            value_dir=${value_dir}*
            cd ${value_dir}
            if [ $? -ne 0 ] ;
            then
                #手动指定解压之后的目录名:不用写绝对路径:vim80
                echo    "无法获取解压之后的目录名,"
                echo    "当前压缩包解压名: $value"
                echo    "请手动输入当前压缩包解压之后的目录名,"
                echo -e "(请直接填目录名(相对路径)): \c"
                read value_dir

            fi

        fi

        #进入解压之后的目录开始配置编译安装
        cd $VIM_CFG_DIR/$value_dir
        $CONFIG $CFG_ARGS $CFG_OTHER_ARGS
        $MAKE $MKARGS
        $MAKE $MKINSTALL

        #安装完成一个就清除目录和临时文件并为下一个安装做准备
        cd $VIM_CFG_DIR
        $DEL_DIR $TEMP_FILE
        $DEL_DIR $VIM_CFG_DIR/$value_dir
    done

    $DEL_DIR $VIM_CFG_DIR/*.tar.gz
    return 0
}

function source_tar_bz2_plugin()
{
    echo "function source_tar_bz2_plugin()>>>*.tar.bz2  script plugins"
    return 0
}

function source_tar_plugin()
{
    echo "function source_tar_plugin()>>>*.tar  script plugins"

    return 0
}
function source_zip_plugin()
{
    echo "function source_zip_plugin()>>>*.zip  script plugins"
    return 0
}

#安装  script plugins
function source_plugin()
{
    echo "function source_plugin()>>>  script plugins"
    if [ $HOSTOS == "ubuntu" ] ;
    then
	echo "HOSTOS:$HOSTOS"
        host www.baidu.com 1>/dev/null 2>/dev/null
        if [ $? -ne 0 ] ;
        then
            echo "Error: Network unavailable!"
            exit 1
        fi
        $SUDO apt-get install ctags
        $SUDO apt-get install cscope
        return 0
    fi
    source_tar_plugin
    source_zip_plugin
    source_tar_gz_plugin
    source_tar_bz2_plugin
    return 0
}

function script_vim_plugin()
{
    echo "function script_vim_plugin()>>>*.vim script plugins"
    [ -d $VIM_CFG_DIR_PLUGIN ] ;
    if [ $? -ne 0 ] ;
    then
        mkdir -p $VIM_CFG_DIR_PLUGIN
    fi
    cp -v $VIMTOOL_PLG_SCRIPT/*.vim $VIM_CFG_DIR_PLUGIN
    if [ $? -ne 0 ] ;
    then
        return 2;
    fi
    return 0
}

function script_zip_plugin()
{
    echo "function script_zip_plugin()>>>*.zip script plugins"
    [ -d $VIM_CFG_DIR ] ;
    if [ $? -ne 0 ] ;
    then
        mkdir -p $VIM_CFG_DIR
    fi
    cp -v $VIMTOOL_PLG_SCRIPT/*.zip $VIM_CFG_DIR 1>/dev/null 2>/dev/null
    if [ $? -ne 0 ] ;
    then
        return 2;
    fi
    cd $VIM_CFG_DIR

    #unzip one by one
    local value=
    local list=`ls *.zip`
    for value in $list
    do
        if [ -z $value ] ;
        then
            break
        fi
        $UNZIP $value
    done

    $DEL_DIR $VIM_CFG_DIR/*.zip

    return 0
}
function script_tar_plugin()
{
    echo "function script_tar_plugin()>>>*.tar script plugins"
    [ -d $VIM_CFG_DIR ] ;
    if [ $? -ne 0 ] ;
    then
        mkdir -p $VIM_CFG_DIR
    fi
    cp -v $VIMTOOL_PLG_SCRIPT/*.tar $VIM_CFG_DIR 1>/dev/null 2>/dev/null
    if [ $? -ne 0 ] ;
    then
        return 2;
    fi
    cd $VIM_CFG_DIR

    #decompress *.tar one by one
    local value=
    local list=`ls *.tar`
    for value in $list
    do
        if [ -z $value ] ;
        then
            break
        fi
        $TAR $ARG_DOT_TAR $value
    done

    $DEL_DIR $VIM_CFG_DIR/*.tar


    #Following special vim-header plugins
    cp -rv $VIMTOOL_PLG_SCRIPT/vim-header* $VIM_CFG_DIR
    cd $VIM_CFG_DIR
    $TAR $ARG_DOT_TAR vim-header*.tar
    cp -rv $VIM_CFG_DIR/vim-header/autoload/* $VIM_CFG_DIR_AUTOLOAD/
    cp -rv $VIM_CFG_DIR/vim-header/plugin/*   $VIM_CFG_DIR_PLUGIN/
    cp -rv $VIM_CFG_DIR/vim-header/licensefiles $VIM_CFG_DIR


    return 0
}
function script_tar_gz_plugin()
{
    echo "function script_tar_gz_plugin():*.tar.gz script plugins"
    [ -d $VIM_CFG_DIR ] ;
    if [ $? -ne 0 ] ;
    then
        mkdir -p $VIM_CFG_DIR
    fi
    tar -xzvf $VIMTOOL_PLG_SCRIPT/*.tar.gz -C $VIM_CFG_DIR 1>/dev/null 2>/dev/null
#   cp -v $VIMTOOL_PLG_SCRIPT/*.tar.gz $VIM_CFG_DIR 1>/dev/null 2>/dev/null
    if [ $? -ne 0 ] ;
    then
        return 2;
    fi
    cd $VIM_CFG_DIR

    #decompress *.tar.gz one by one
    local value=
    local list=`ls *.tar.gz` 1>/dev/null 2>/dev/null
    if [ $? -ne 0 ] ;
    then
        return 2;
    fi
    for value in $list
    do
        if [ -z $value ] ;
        then
            break
        fi
        $TAR $ARG_DOT_TAR_GZ $value
    done

    $DEL_DIR $VIM_CFG_DIR/*.tar.gz
    return 0
}
function script_tar_bz2_plugin()
{
    echo "function script_tar_bz2_plugin()>>>*.tar.bz2 script plugins"
    [ -d $VIM_CFG_DIR ] ;
    if [ $? -ne 0 ] ;
    then
        mkdir -p $VIM_CFG_DIR
    fi
    cp -v $VIMTOOL_PLG_SCRIPT/*.tar.bz2 $VIM_CFG_DIR 1>/dev/null 2>/dev/null
    if [ $? -ne 0 ] ;
    then
        return 2;
    fi
    cd $VIM_CFG_DIR

    #decompress *.tar.bz2 one by one
    local value=
    local list=`ls *.tar.bz2` 1>/dev/null 2>/dev/null
    for value in $list
    do
        if [ -z $value ] ;
        then
            break
        fi
        $TAR $ARG_DOT_TAR_BZ2 $value
    done

    $DEL_DIR $VIM_CFG_DIR/*.tar.bz2
    return 0
}

function script_plugin()
{
    echo "function script_plugin()>>> script plugins"
    [ -d ~/.vim ] 
    if [ $? -ne 0 ] ;
    then
        mkdir -p ~/.vim
    fi

    rm -rf $VIM_CFG_DIR/*
    #vimtool-plugins.tar.gz
    echo "cp -rf $VIMTOOL_PLG_SCRIPT/* $VIM_CFG_DIR"
    cp -rf $VIMTOOL_PLG_SCRIPT/* $VIM_CFG_DIR
    return 0
}

#Install plugins(both source and script)"
function install_plugin()
{
    echo "function install_plugin()>>>Install plugins(both source and script)"
    script_plugin
    source_plugin
    return 0
}

#Install vimtool/config/object.sh configuration files"
function config_object()
{
    echo "function config_object()"
    $SUDO cp -v $VIMTOOL_CONFIG/$OBJECT_TOOL $OBJECT_TOOL_PATH
    return 0
}

function init_vimrc()
{
    cat /dev/null > $HOME_VIMRC
    return 0
}

function combine_vimrcs()
{
    init_vimrc
    for vimrc in $VIMRCLIST
    do
        if [ $vimrc == "vim-header.vimrc" ] ;
        then
            echo "jump:$vimrc"
            VIM_HEADER=$vimrc
            vimrc=""
            continue
        fi
        cat $VIMRCS/$vimrc >> $HOME_VIMRC
        echo "cat $VIMRCS/$vimrc >> $HOME_VIMRC"
    done
    cat $VIMRCS/$VIM_HEADER >> $HOME_VIMRC
    echo "cat $VIMRCS/$VIM_HEADER >> $HOME_VIMRC"

    if  [ $HOSTOS  ==  "ubuntu"  ] ;
    then
	echo "HOSTOS:$HOSTOS"
        sed -i  '/colorscheme/d' ~/.vimrc
    fi
    return 0
}

#Install 'vimtool/config/vimrc' configuration file"
function config_vimrc()
{
    echo "function config_vimrc()>>>Install vimrc configuration file"

    combine_vimrcs

    cat $VIMTOOL_CONFIG/$VIMRC > $HOME/.vimrc

    echo -e "Please input your name: \c"
    read user_name
    echo -e "Please input your email: \c"
    read user_email

    echo "let g:header_field_author = '${user_name}'" >> ~/.vimrc
    echo "let g:header_field_author_email = '${user_email}'" >> ~/.vimrc

    if  [ $HOSTOS  ==  "ubuntu"  ] ;
    then
	echo "HOSTOS:$HOSTOS"
        sed -i  '/colorscheme/d' ~/.vimrc
    fi

    return 0
}

#Install configuration files"
function install_config()
{
    echo "function install_config()>>>Install configuration files"
    config_object
    config_vimrc
}

#Don't install vim"
function no_vim()
{
    echo "function no_vim()>>>Dont install vim"
    CUR=`pwd`
    echo "CUR: $CUR"
    install_plugin
    return 0
}

#Install vim"
function install_vim()
{
    echo "function install_vim()>>>Install vim"
    only_vim
    return 0
}

#Complete installation function
function complete_install()
{
    echo "function complete_install()>>>Complete installation function"
    install_vim             #step01 install vim editor
    install_plugin          #step02 install plugin
    install_config          #step03 install configuration file
}

function build_vimconf_dir()
{
    mkdir -p $VIM_CFG_DIR 1>/dev/null 2>/dev/null
    mkdir -p $VIM_CFG_DIR_PLUGIN 1>/dev/null 2>/dev/null
    mkdir -p $VIM_CFG_DIR_AUTOLOAD 1>/dev/null 2>/dev/null
    mkdir -p $VIM_CFG_DIR_DOC 1>/dev/null 2>/dev/null
    return 0
}

#The main function(entry)
function install_vimtool()
{
    echo "function install_vimtool()>>>安装主函数"
    if [ $UID -ne 0 ] ;
    then
        echo "You had better to run build_all as a root user"
        SUDO=sudo
    fi

    INSTALL_ARG=$1

    if [ $# -eq 0 ] ;
    then
        echo "Complete installation"
        $DEL_DIR $VIM_CFG_DIR
        build_vimconf_dir
        complete_install
        vimtool_finish
    else
        echo "Incomplete installation"
        if [ $INSTALL_ARG == "only_vim" ] ;
        then
            echo "Only install vim editor"
            only_vim
            vimtool_finish
        elif [ $INSTALL_ARG == "no_vim" ] ;
        then
            echo "Only install plugins (both script and source)"
            $DEL_DIR $VIM_CFG_DIR
            build_vimconf_dir
            no_vim
            vimtool_finish
        elif [ $INSTALL_ARG == "script_plugin" ] ;
        then
            echo "Only install  script plugins"
            script_plugin
            vimtool_finish
        elif [ $INSTALL_ARG == "source_plugin" ] ;
        then
            echo "Only install source code plugins"
            source_plugin
            vimtool_finish
        elif [ $INSTALL_ARG == "update_config" ] ;
        then
            echo "Only update configuration files"
            install_config
            vimtool_finish
        elif [ $INSTALL_ARG == "help" ] ;
        then
            echo "Display installation information:"
            build_all_help
        else
            echo "ERROR: $INSTALL_ARG unknown argument!!!"
            echo "Press <Enter> to continue ..."
            read temporary
            build_all_help
            exit 1
        fi
    fi

    return 0
}

#---------------------------------------
#开发调试部分
#-----------------------------------------
#echo "VIM_CONFIG: ${VIM_CONFIG[*]}"
#echo "configlen: ${#VIM_CONFIG[*]}"
#debug_vimtool           #类似断点:只能执行这个之上代码
script_plugin
config_vimrc
#-----------------------------------------------

#--------------------------------------------------
#函数执行部分
#------------------------------------------------
#install_vimtool $1
#----------------------------------------------
