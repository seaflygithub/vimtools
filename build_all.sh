#!/bin/bash
# File              : build_all.sh
# Author            : Your Name <your@mail>
# Date              : 2017.10.18
# Last Modified Date: 2017.10.19
# Last Modified By  : seafly <seafly0616>

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



#函数: config_vim_header
#功能: 完善文件头的配置，否则保存文件时会不断插入文件头
#参数: 无
function config_vim_header()
{
    echo "config_vim_header(): 正在配置用户信息..."
    echo "config_vim_header(): 下面的用户名和邮箱均用在源文件首部..."
    echo -e "请输入源文件作者名: \c"
    read user_name
    echo -e "请输入作者邮箱: \c"
    read user_email
    echo "let g:header_field_author = '${user_name}'" >> ~/.vimrc
    echo "let g:header_field_author_email = '${user_email}'" >> ~/.vimrc
    return 0
}


#函数: init_vim_configure_dir
#功能: 将原配置文件目录重命名（添加.backup后缀）并新建配置目录
#参数: 无
function init_vim_configure_dir()
{
    if [ -d ${DIR_HOME_VIM_BUNDLE}/YouCompleteMe ] ;
    then
        mv ${DIR_HOME_VIM_BUNDLE}/YouCompleteMe ${HOME}
        mv ${HOME}/.vim ${HOME}/.vim.bak 2>/dev/null 1>/dev/null
        mv ${HOME}/.vimrc ${HOME}/.vimrc.bak 2>/dev/null 1>/dev/null
        mkdir -p ${HOME}/.vim/bundle
        mkdir -p ${HOME}/.vim/plugin
        mkdir -p ${HOME}/.vim/autoload
        mkdir -p ${HOME}/.vim/doc
        mv ${HOME}/YouCompleteMe ${DIR_HOME_VIM_BUNDLE}
        ${SUDO} cp ${DIR_SCRIPT_PATH}/ycmadd.py /usr/bin/
        ${SUDO} chmod 777 /usr/bin/ycmadd.py
        USE_YCM=1
    else
        mv ${HOME}/.vim ${HOME}/.vim.bak 2>/dev/null 1>/dev/null
        mv ${HOME}/.vimrc ${HOME}/.vimrc.bak 2>/dev/null 1>/dev/null
        mkdir -p ${HOME}/.vim/bundle
        mkdir -p ${HOME}/.vim/plugin
        mkdir -p ${HOME}/.vim/autoload
        mkdir -p ${HOME}/.vim/doc
    fi
    return 0
}


#函数: install_vim
#功能: 源代码方式编译安装主编辑器
#参数: $1=="update"    如果传入该字串则克隆最新源代码安装
#参数: $2=="python2.x" 配置安装支持python2.x
#参数: $2=="python3.x" 配置安装支持python3.x
#参数: $3=="8.0"	vim版本需求
function install_vim()
{
    ARG_PYTHON="$1"
    ARG_UPDATE="$2"
    ARG_VERSION="$3"
    # 0.首先判断vim是否需要重新安装
    # 首先检查vim版本
        # 其次检查vim对Python的支持
    VIM_VERSION=`vim --version | head -n 1 | awk -F ' ' '{print $5}'`
    if [ ${ARG_VERSION} = "" ] ;
    then
	    echo "install_vim(): 未传入vim版本需求，默认为当前版本..."
	    ARG_VERSION=${VIM_VERSION}
    fi


    echo "install_vim(): 正在检查当前vim版本..."
    if [ ${VIM_VERSION} = ${ARG_VERSION} ] ;
    then
        echo "install_vim(): 当前vim版本符合要求..."
        echo "install_vim(): 正在检查当前vim支持的Python..."
        if [ ${ARG_PYTHON} = "python2.x" ] ;
	then
	    echo "install_vim(): 正在检查vim当前支持的Python..."
            vim --version | grep "+python"
	    if [ $? -eq 0 ] ; then
		    echo "install_vim(): 当前vim支持Python2.x..."
		    return 0
	    fi
        elif [ ${ARG_PYTHON} = "python3.x" ] ;
        then
            vim --version | grep "+python3"
	    if [ $? -eq 0 ] ; then
		    echo "install_vim(): 当前vim支持Python3.x..."
		    return 0
	    fi
        fi
    else
	    echo "install_vim(): 当前vim版本不符合要求"
    fi



    # 1.首先判断是否更新,并为后面的配置安装做准备（准备vim源码包）
    if [ ${ARG_UPDATE} = "update" ] ; then
        echo "install_vim(): 正在选择最新源代码安装..."
        echo "install_vim(): 正在检查网络连接..."
        host ${NETADDR_PING} 1>/dev/null 2>/dev/null
        if [ $? -eq 0 ] ; then
            echo "install_vim(): 网络畅通,准备最新安装..."
            cd ${DIR_CUR}/vim ; rm -rf vim ; \
                git clone -b master https://github.com/vim/vim.git vim
        else
            echo "install_vim(): 网络不通,准备本地安装..."
        fi
    else
        echo "install_vim(): 正在选择本地源代码安装..."
    fi

    # 2.此步骤是判断源码包是否存在并删除.git配置目录
    if [ -d ${DIR_CUR}/vim/vim ] ; then echo "install_vim(): 存在vim源码目录"
        if [ -d ${DIR_CUR}/vim/vim/.git ] ; then
            echo "install_vim(): 正在删除.git配置目录..."
            rm -rf ${DIR_CUR}/vim/vim/.git
        fi
    else
        echo "install_vim(): 不存在本地源码包..."
        host ${NETADDR_PING} 1>/dev/null 2>/dev/null
        if [ $? -eq 0 ] ; then
            echo "install_vim(): 网络畅通,准备获取源码包..."
            cd ${DIR_CUR}/vim ; rm -rf vim ; \
                git clone -b master https://github.com/vim/vim.git vim
        else
            echo "install_vim(): 网络不通,退出安装..."
            exit 1
        fi
    fi

    # 3.源码包准备OK，准备分别配置（Python2.x 和 Python3.x）
    if [ ${ARG_PYTHON} = "python2.x" ] ; then
        echo "install_vim(): 编辑器选择支持Python2.x..."
        echo "install_vim(): 正在寻找python2.x配置目录..."
        if [ -d /usr/lib/python2.7/config-x86_64-linux-gnu ] ; then
            ENABLE_PYTHON="--enable-pythoninterp=yes"
            DIR_PYTHON_CONFIG=/usr/lib/python2.7/config-x86_64-linux-gnu
        elif [ -d /usr/lib/python2.7 ] ; then
            ENABLE_PYTHON="--enable-pythoninterp=yes"
            DIR_PYTHON_CONFIG=/usr/lib/python2.7
        else
            echo "install_vim(): 无法找到python2.x配置目录..."
            exit 1
        fi
    elif [ ${ARG_PYTHON} = "python3.x" ] ; then
        echo "install_vim(): 编辑器选择支持Python3.x..."
        echo "install_vim(): 正在寻找python3.x配置目录..."
        if [ -d /usr/lib/python3.4/config-3.4m-x86_64-linux-gnu ] ; then
            ENABLE_PYTHON="--enable-python3interp=yes"
            DIR_PYTHON_CONFIG=/usr/lib/python3.4/config-3.4m-x86_64-linux-gnu
        elif [ -d /usr/lib/python3.4 ] ; then
            ENABLE_PYTHON="--enable-python3interp=yes"
            DIR_PYTHON_CONFIG=/usr/lib/python3.4
        else
            echo "install_vim(): 无法找到python3.x配置目录..."
            exit 1
        fi
    else
        echo "install_vim(): 编辑器默认支持Python2.x..."
        echo "install_vim(): 正在寻找python2.x配置目录..."
        if [ -d /usr/lib/python2.7/config-x86_64-linux-gnu ] ; then
            ENABLE_PYTHON="--enable-pythoninterp=yes"
            DIR_PYTHON_CONFIG=/usr/lib/python2.7/config-x86_64-linux-gnu
        elif [ -d /usr/lib/python2.7 ] ; then
            ENABLE_PYTHON="--enable-pythoninterp=yes"
            DIR_PYTHON_CONFIG=/usr/lib/python2.7
        else
            echo "install_vim(): 无法找到python2.x配置目录..."
            exit 1
        fi
    fi

    cd ${DIR_VIM_SRC} ; \
        make distclean ; \
        ./configure --prefix=/usr --with-features=huge \
        --enable-multibyte \
        --enable-rubyinterp=yes \
        --enable-perlinterp=yes \
        --enable-luainterp=yes \
        --enable-gui=gtk2 --enable-cscope \
        ${ENABLE_PYTHON} \
        --with-python-config-dir=${DIR_PYTHON_CONFIG}

    # 4.开始编译和安装
    cd ${DIR_VIM_SRC} ; make && ${SUDO} make install ; make distclean

    return 0
}

#名称: install_python_libs
#功能: 安装必要的库（安装vim之前）
#参数: 无
function install_python_libs()
{
    echo "install_python_libs(): 正在检查系统属性..."
    if [ $HOSTOS != "ubuntu" ] ;
    then
        echo "install_python_libs(): 该系统不是Ubuntu或debian发行版!"
        exit 1
    else
        echo "install_python_libs(): 正在检查网络连接..."
        host ${NETADDR_PING} 1>/dev/null 2>/dev/null
        if [ $? -eq 0 ] ; then
            echo "install_python_libs(): 网络畅通,正在准备安装python库..."
            $SUDO apt-get install -y libgtk2.0-dev libxt-dev libx11-dev
            $SUDO apt-get install -y tcl-dev libperl-dev libncurses5-dev
            $SUDO apt-get install -y python-dev
            $SUDO apt-get install -y vim-python-jedi
            $SUDO apt-get install -y python-pip python-dev build-essential
            $SUDO pip install --upgrade pip
            $SUDO pip install --upgrade virtualenv
            pip install jedi
        else
            echo "install_python_libs(): 请检查网络连接（该Python库安装需要网络）..."
            exit 1
        fi
    fi
}


#名称: install_ctags_cscope
#功能: 安装两款vim基础插件工具
#参数: $1=="update"	表示通过网络在线安装最新工具
#参数: $1==""或其他字串	表示根据实际情况选择默认安装
function install_ctags_cscope()
{
    ARG_UPDATE="$1"
    if [ ${ARG_UPDATE} = "update" ] ; then
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
            $SUDO apt-get install -y ctags
            $SUDO apt-get install -y cscope
            $SUDO apt-get install -y cscope-el
            $SUDO apt-get install -y exuberant-ctags
            return 0
        else
            echo "install_ctags_cscope(): 网络无连接,正在本地化安装..."
            cd ${DIR_CUR}/plugins/source ; \
                tar -xzvf $PKG_CSCOPE_SRC ; \
                cd $DIR_CSCOPE_SRC ; \
                ./configure --prefix=/usr ; \
                make && $SUDO make install ; \
                cd .. ; rm -rf $DIR_CSCOPE_SRC

            cd ${DIR_CUR}/plugins/source ; \
                tar -xzvf $PKG_CSCOPE_SRC ; \
                tar -xzvf $PKG_CTAGS_SRC ; \
                cd $DIR_CTAGS_SRC ; \
                ./configure --prefix=/usr ; \
                make && $SUDO make install ; \
                cd .. ; rm -rf $DIR_CTAGS_SRC
        fi
    fi
    return 0
}

#名称: install_script_plugin
#功能: 插件组织介绍函数
#参数: $1==插件用到的vimrc配置文件&插件使用说明文件
#参数: $2==插件名&插件顶层目录名
#参数: $3==插件更新的下载地址
#参数: $4==插件是否更新,更新是"update"，否则为不更新
#返回: 0
function install_script_plugin()
{
    VIMRC="$1"
    PLUGIN_NAME="$2"
    UPDATE_ADDR="$3"
    ARG_UPDATE="$4"
    DIR_ABSOLUTE_PATH=${DIR_CUR}/plugins/script/${PLUGIN_NAME}


    # 1.获取该插件并清除插件目录的.git配置目录
    # 清除.git目录目的: 防止github管理时出现空目录
    if [ ${ARG_UPDATE} = "update" ] ; then
        echo "install_script_plugin(): 选择准备更新该插件..."
        echo "install_script_plugin(): 正在检查网络连接..."
        host ${NETADDR_PING} 1>/dev/null 2>/dev/null
        if [ $? -eq 0 ] ; then
            echo "install_script_plugin(): 网络畅通,正在更新..."
            cd ${DIR_CUR}/plugins/script;rm -rf ${PLUGIN_NAME};\
                git clone -b master ${UPDATE_ADDR} ${PLUGIN_NAME};\
                rm -rf ${PLUGIN_NAME}/.git
        else
            echo "install_script_plugin(): 网络不通,准备安装本地插件..."
            if [ -d ${DIR_ABSOLUTE_PATH} ] ;
            then
                if [ -d ${DIR_ABSOLUTE_PATH}/.git ] ;
                then
                    echo "install_script_plugin(${PLUGIN_NAME}): 正在删除.git配置目录..."
                    rm -rf ${DIR_ABSOLUTE_PATH}/.git
                fi
            else
                echo "install_script_plugin(): 无该插件..."
                return 1
            fi
        fi
    else
        echo "install_script_plugin(): 正在安装本地插件..."
        if [ -d ${DIR_ABSOLUTE_PATH} ] ; 
        then
            echo ""
            if [ -d ${DIR_ABSOLUTE_PATH}/.git ] ;
            then
                echo "install_script_plugin(${PLUGIN_NAME}): 正在删除.git配置目录..."
                rm -rf ${DIR_ABSOLUTE_PATH}/.git
            fi
        else
            echo "install_script_plugin(): 不存在该本地插件..."
            echo "install_script_plugin(): 正在准备从网络获取该插件..."
            echo "install_script_plugin(): 正在检查网络连接..."
            host ${NETADDR_PING} 1>/dev/null 2>/dev/null
            if [ $? -eq 0 ] ; then
                echo "install_script_plugin(): 网络畅通,正在获取该插件..."
                cd ${DIR_CUR}/plugins/script;rm -rf ${PLUGIN_NAME};\
                    git clone -b master ${UPDATE_ADDR} ${PLUGIN_NAME};\
                    rm -rf ${PLUGIN_NAME}/.git
            else
                echo "install_script_plugin(): 网络不通,无法安装该插件..."
                return 1
            fi

        fi
    fi
    echo "install_script_plugin(): 正在检查该插件配置文件..."
    if [ -f ${DIR_SCRIPT_PATH}/${VIMRC} ] ;
    then
        echo ""
    else
        VIMRC=""
    fi
    if [ -d ${DIR_ABSOLUTE_PATH}/.git ] ;
    then
        rm -rf ${DIR_ABSOLUTE_PATH}/.git
    fi

    # 2.已准备好插件目录和配置文件
    echo "install_script_plugin(): 正把该插件拷贝至目标目录..."
    mkdir -p ${DIR_HOME_VIM_BUNDLE} 2>/dev/null 1>/dev/null
    cp -rf ${DIR_ABSOLUTE_PATH} ${DIR_HOME_VIM_BUNDLE}

    # 3.把插件配置导入指定文件汇总
    echo "install_script_plugin(): 正在导入该插件配置文件..."
    cat ${DIR_SCRIPT_PATH}/${VIMRC} >> ${GLOBAL_PLUGINS_VIMRC}

    return 0
}

#名称: install_script_plugins
#功能: 组织管理各个插件的安装配置与更新
#参数: 无
#返回: 0
#说明: 插件&配置文件添加目录: plugins/script
#说明: 插件&配置文件添加方法: 把目录和配置文件放到上面目录即可
function install_script_plugins()
{
    # 函数调用说明：
    # 01.配置文件统一为（插件名.vimrc）并存放在 plugins/script/目录下
    # 02.对插件的修改或打补丁都放在相应install_script_plugin函数块后

    # xxx.vimrc构造格式
    # 插件: vim-header
    # 功能: 自动为源文件添加头部作者信息
    # 地址: https://github.com/alpertuna/vim-header
    # 用法: ***
    # 配置: *** ***

    #install_script_plugin \
        #"auto_update_cscope_ctags_database.vimrc" \
        #"auto_update_cscope_ctags_database" \
        #"https://github.com/SeaflyGithub/auto_update_cscope_ctags_database" \
        #"no-update"

    install_script_plugin \
        "vim-markdown.vimrc" \
        "vim-markdown" \
        "https://github.com/plasticboy/vim-markdown" \
        "no-update"

    install_script_plugin \
        "indentLine.vimrc" \
        "indentLine" \
        "https://github.com/Yggdroot/indentLine" \
        "no-update"

    install_script_plugin \
        "minibufexpl.vimrc" \
        "minibufexpl" \
        "https://github.com/fholgado/minibufexpl.vim" \
        "no-update"

    install_script_plugin \
        "bufexplorer.vimrc" \
        "bufexplorer" \
        "https://github.com/jlanzarotta/bufexplorer" \
        "no-update"

    install_script_plugin \
        "mark.vim.vimrc" \
        "mark.vim" \
        "https://github.com/Tuxdude/mark.vim" \
        "no-update"

    install_script_plugin \
        "comments.vim.vimrc" \
        "comments.vim" \
        "https://github.com/sudar/comments.vim" \
        "no-update"

    install_script_plugin \
        "a.vim.vimrc" \
        "a.vim" \
        "https://github.com/csliu/a.vim" \
        "no-update"

    install_script_plugin \
        "taglist.vimrc" \
        "taglist" \
        "https://github.com/vim-scripts/taglist.vim" \
        "no-update"

    install_script_plugin \
        "SrcExpl.vimrc" \
        "SrcExpl" \
        "https://github.com/wesleyche/SrcExpl.git" \
        "no-update"

    install_script_plugin \
        "nerdtree.vimrc" \
        "nerdtree" \
        "https://github.com/scrooloose/nerdtree" \
        "no-update"

    install_script_plugin \
        "Trinity.vimrc" \
        "Trinity" \
        "https://github.com/wesleyche/Trinity" \
        "no-update"

    install_script_plugin \
        "asyncrun.vimrc" \
        "asyncrun.vim" \
        "https://github.com/skywind3000/asyncrun.vim" \
        "no-update"

    install_script_plugin \
        "code_complete.vimrc" \
        "code_complete" \
        "https://github.com/SeaflyGithub/code_complete" \
        "no-update"

    install_script_plugin \
        "vim-header.vimrc" \
        "vim-header" \
        "https://github.com/alpertuna/vim-header" \
        "no-update"
    #补丁: vim-header添加对时间的支持（精确到秒）
grep -Hn "%Y\.%m\.%d\ %X" ${DIR_PLUGIN_BUNDLE}/vim-header/autoload/header.vim
    if [ $? -ne 0 ] ;
    then
        sed -i '25ilet g:header_field_timestamp_format = "%Y.%m.%d %X"' ${DIR_PLUGIN_BUNDLE}/vim-header/autoload/header.vim
    fi


    # 生成插件使能配置
    echo "install_script_plugins(): 正在使能插件..."
    ls ${HOME}/.vim/bundle | xargs -i -d '\n' echo "set rtp+=${HOME}/.vim/bundle/"{} >> ${GLOBAL_RUNTIME_VIMRC}

    # 插件的汇总配置
    echo "install_script_plugins(): 正在合并配置..."
    touch ${HOME}/.vimrc
    cat /dev/null > ${HOME}/.vimrc
    cat ${GLOBAL_RUNTIME_VIMRC} >> ${HOME}/.vimrc
    cat ${GLOBAL_DEFAULT_VIMRC} >> ${HOME}/.vimrc
    cat ${GLOBAL_PLUGINS_VIMRC} >> ${HOME}/.vimrc

    return 0
}


#名称: build_ycm_conf
#功能: 为YCM创建配置文件
#参数: 无
#返回: 0
#说明: 
function build_ycm_conf()
{
    #配置YCM
    cp ${HOME}/.vim/bundle/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py ${HOME}/.vim/

    #将插件配置导入全局配置文件
    cat ${DIR_CUR}/plugins/script/YouCompleteMe.vimrc >> ${GLOBAL_PLUGINS_VIMRC}
}

#名称: build_ycm_core_lib
#功能: 为YCM构建核心库支持
#参数: 无
#返回: 0
#说明: 
function build_ycm_core_lib()
{
    #编译构建ycm_core库
    mkdir ${HOME}/.ycm_build ; cd ${HOME}/.ycm_build ; \
        cmake -G "Unix Makefiles" -DUSE_SYSTEM_BOOST=ON -DEXTERNAL_LIBCLANG_PATH=/usr/lib/x86_64-linux-gnu/libclang-3.9.so . ${HOME}/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp ; \
        cmake --build . --target ycm_core --config Release
}

#名称: install_latest_libclang
#功能: 为YCM安装最新的clang
#参数: 无
#返回: 0
#说明: 
function install_latest_libclang()
{
    #下载安装最新版的libclang（C家族语义化补全）
    # 1. 确定是ubuntu系统
    if [ ${HOSTOS} != "ubuntu" ]; then
        echo "install_latest_libclang(): 该安装包仅限于64位Ubuntu..."
        exit 1
    else
        echo "get_ycm_package(): 正在检查网络连接..."
        host ${NETADDR_PING} 1>/dev/null 2>/dev/null
        if [ $? -eq 0 ] ; then
            echo "get_ycm_package(): 网络畅通,正在获取该插件..."

            #You should be able to use any of the listed mirrors by adding a line to your /etc/apt/sources.list like this:
            #	deb http://security.ubuntu.com/ubuntu trusty-security main universe
            ${SUDO} apt-get install -y llvm-3.9 llvm-3.9-dev clang-3.9 libclang-3.9-dev libboost-all-dev
            if [ $? -ne 0 ] ;
            then
                ${SUDO} sed -i '$adeb http://security.ubuntu.com/ubuntu trusty-security main universe' /etc/apt/sources.list
                ${SUDO} apt-get update
                ${SUDO} apt-get install -y llvm-3.9 llvm-3.9-dev clang-3.9 libclang-3.9-dev libboost-all-dev
            fi

            #${SUDO} apt-get install -y llvm-3.9 clang-3.9 libclang-3.9-dev libboost-all-dev
            ${SUDO} apt-get install -y cmake python3-dev
            echo "get_ycm_package(): 该插件获取并更新成功..."
        else
            echo "get_ycm_package(): 网络不通,无法安装该插件..."
            return 1
        fi
    fi
}

#名称: get_ycm_package
#功能: 获取最新YCM源码包
#参数: 无
#返回: 0
#说明: 
function get_ycm_package()
{
    #通过github方式获取YouCompleteMe
    echo "get_ycm_package(): 正在检查网络连接..."
    host ${NETADDR_PING} 1>/dev/null 2>/dev/null
    if [ $? -eq 0 ] ; then
        echo "get_ycm_package(): 网络畅通,正在获取该插件..."
        cd ${HOME}/.vim/bundle ; \
            git clone -b master https://github.com/Valloric/YouCompleteMe YouCompleteMe ; \
            cd ${HOME}/.vim/bundle/YouCompleteMe ; \
            git submodule update --init --recursive
        echo "get_ycm_package(): 该插件获取并更新成功..."
    else
        echo "get_ycm_package(): 网络不通,无法安装该插件..."
        return 1
    fi
}

#名称: install_youcomleteme
#功能: 安装YouCompleteMe(YCM)插件
#参数: 无
#返回: 0
#说明: 
function install_youcomleteme()
{
    echo "install_youcomleteme(): 正在准备重新编译安装vim编辑器..."
    install_vim "python3.x" "no-update" "8.0"

    echo "install_youcomleteme(): 正在准备获取最新YCM源码包..."
    get_ycm_package

    echo "install_youcomleteme(): 正在准备安装最新的clang库支持..."
    install_latest_libclang


    echo "install_youcomleteme(): 正在准备构建YCM核心支持库..."
    build_ycm_core_lib

    echo "install_youcomleteme(): 正在准备创建YCM配置文件..."
    build_ycm_conf
}

function init_vimtools_configs()
{
    echo "init_vimtools_configs(): 正在初始化vimtools默认配置文件..."
    echo "init_vimtools_configs(): 正在初始化vimtools插件配置文件..."
    touch ${GLOBAL_PLUGINS_VIMRC}
    cat /dev/null > ${GLOBAL_PLUGINS_VIMRC}
    echo "init_vimtools_configs(): 正在初始化插件使能文件..."
    touch ${GLOBAL_RUNTIME_VIMRC}
    cat /dev/null > ${GLOBAL_RUNTIME_VIMRC}
}

function install_vimtools()
{
    INSTALL_ARG=$1
    case ${INSTALL_ARG} in 
        "")
            echo "提示: 正在进入完整安装..."
            init_vim_configure_dir
            install_python_libs
            install_vim "python2.x" "no-update" "8.0"
            install_ctags_cscope "no-update"
            init_vimtools_configs
            install_youcomleteme
            install_script_plugins
            config_vim_header
            ;;
        *)
            $INSTALL_ARG
            if [ $? -ne 0 ] ; then
                echo "错误: 该脚本传入参数无法识别..."
                build_all_help
                exit 1
            fi
            ;;
    esac
    if [ ${USE_YCM} -ne 0 ] ; then
        echo "YCM使用说明: 进入工程目录，执行ycmadd.py后即可"
    else
        echo ""
    fi
}

install_vimtools $@
