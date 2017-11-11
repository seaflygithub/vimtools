#!/bin/bash
# File              : build_all.sh
# Author            : SeaflyGithub <seafly0616@qq.com>
# Date              : 2017.10.24 10时42分53秒
# Last Modified Date: 2017.11.11 10时01分35秒
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

#函数: init_vim_configure_dir
#功能: 将原配置文件目录重命名（添加.backup后缀）并新建配置目录
#参数: 无
#函数实现: 初始化~/.vim/，如果里面有YCM插件，则备份一下该插件
function init_vim_configure_dir()
{
    if [ -d ${DIR_HOME_VIM_BUNDLE}/YouCompleteMe ] ;
    then
        mv ${DIR_HOME_VIM_BUNDLE}/YouCompleteMe ${HOME}
        rm -rf ${HOME}/.vim.bak
        rm -rf ${HOME}/.vimrc.bak
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
        rm -rf ${HOME}/.vim.bak
        rm -rf ${HOME}/.vimrc.bak
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
#实现: 检查当前目录vim/vim下源代码并根据传入参数要求安装
function install_vim()
{
    ARG_PYTHON="$1"
    ARG_UPDATE="$2"
    ARG_VERSION="$3"

    ## 0.首先判断vim是否需要重新安装
    ## 首先检查vim版本
    ## 其次检查vim对Python的支持
    #VERSION_VIM_CUR=`vim --version | head -n 1 | awk -F ' ' '{print $5}'`
    #vim --version | grep "+python"
    #vim --version | grep "+python3"

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

    # 3.源码包准备OK，根据用户传入参数配置支持的Python环境（Python2.x 和 Python3.x）
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

    # 开始配置vim源代码
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
		grep -Hn "security\.ubuntu\.com/" /etc/apt/sources.list
		if [ $? -ne 0 ] ;
	then
		${SUDO} sed -i '$adeb http://security.ubuntu.com/ubuntu trusty-security main universe' /etc/apt/sources.list
		${SUDO} apt-get update
		fi
		echo "install_python_libs(): 网络畅通,正在准备安装python库..."

		${SUDO} apt-get install -y libpng12-*
		${SUDO} apt-get install -y libgdk-pixbuf2.0-dev 
		${SUDO} apt-get install -y libpango1.0-dev 
		${SUDO} apt-get install -y libcairo2-dev 
		${SUDO} apt-get install -y libgtk2.0-dev 
		${SUDO} apt-get install -y libxt-dev 
		${SUDO} apt-get install -y libx11-dev
		${SUDO} apt-get install -y tcl-dev 
		${SUDO} apt-get install -y libperl-dev 
		${SUDO} apt-get install -y libncurses5-dev
		${SUDO} apt-get install -y python-dev
		${SUDO} apt-get install -y vim-python-jedi
		${SUDO} apt-get install -y python-pip 
		${SUDO} apt-get install -y python-dev 
		${SUDO} apt-get install -y build-essential
		if [ $? -ne 0 ]; then
			echo "install_python_libs(): apt-get install build-essential"
				exit 1
				fi
				${SUDO} pip install --upgrade pip
				${SUDO} pip install --upgrade virtualenv
				pip install jedi
}

#名称: install_git_plugin
#功能: 插件组织介绍函数
#参数: $1==插件用到的vimrc配置文件&插件使用说明文件
#参数: $2==插件名&插件顶层目录名
#参数: $3==插件git更新的下载地址
#参数: $4==插件是否更新,更新是"update"，否则为不更新
#返回: 0
function install_git_plugin()
{
    VIMRC="$1"
    PLUGIN_NAME="$2"
    DIR_PLUGIN_RUNTIMEPATH="$3"
    UPDATE_ADDR="$4"
    ARG_UPDATE="$5"
    DIR_ABSOLUTE_PATH="${DIR_CUR}/plugins/script/${PLUGIN_NAME}"

    # 1.获取该插件并清除插件目录的.git配置目录
    # 清除.git目录目的: 防止github管理时出现空目录
    if [ ${ARG_UPDATE} = "update" ] ; then
        echo "install_git_plugin(): 选择准备更新该插件..."
        echo "install_git_plugin(): 正在检查网络连接..."
        host ${NETADDR_PING} 1>/dev/null 2>/dev/null
        if [ $? -eq 0 ] ; then
            echo "install_git_plugin(): 网络畅通,正在更新..."
            cd ${DIR_CUR}/plugins/script;rm -rf ${PLUGIN_NAME};\
                git clone -b master ${UPDATE_ADDR} ${PLUGIN_NAME};\
                rm -rf ${PLUGIN_NAME}/.git
        else
            echo "install_git_plugin(): 网络不通,准备安装本地插件..."
            if [ -d ${DIR_ABSOLUTE_PATH} ] ;
            then
                if [ -d ${DIR_ABSOLUTE_PATH}/.git ] ;
                then
                    echo "install_git_plugin(${PLUGIN_NAME}): 正在删除.git配置目录..."
                    rm -rf ${DIR_ABSOLUTE_PATH}/.git
                fi
            else
                echo "install_git_plugin(): 无该插件..."
                return 1
            fi
        fi
    else
        echo "install_git_plugin(): 正在安装本地插件..."
        if [ -d ${DIR_ABSOLUTE_PATH} ] ; 
        then
            echo ""
            if [ -d ${DIR_ABSOLUTE_PATH}/.git ] ;
            then
                echo "install_git_plugin(${PLUGIN_NAME}): 正在删除.git配置目录..."
                rm -rf ${DIR_ABSOLUTE_PATH}/.git
            fi
        else
            echo "install_git_plugin(): 不存在该本地插件..."
            echo "install_git_plugin(): 正在准备从网络获取该插件..."
            echo "install_git_plugin(): 正在检查网络连接..."
            host ${NETADDR_PING} 1>/dev/null 2>/dev/null
            if [ $? -eq 0 ] ; then
                echo "install_git_plugin(): 网络畅通,正在获取该插件..."
                cd ${DIR_CUR}/plugins/script;rm -rf ${PLUGIN_NAME};\
                    git clone -b master ${UPDATE_ADDR} ${PLUGIN_NAME};\
                    rm -rf ${PLUGIN_NAME}/.git
            else
                echo "install_git_plugin(): 网络不通,无法安装该插件..."
                return 1
            fi

        fi
    fi
    echo "install_git_plugin(): 正在检查该插件配置文件..."
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

    # 2. 把插件拷贝到~/.vim/bundle目录下
    cp -rf ${DIR_ABSOLUTE_PATH} ${DIR_HOME_VIM_BUNDLE}

    # 3.把插件配置导入指定文件汇总
    echo "install_git_plugin(): 正在导入该插件配置文件..."
    cat ${DIR_SCRIPT_PATH}/${VIMRC} >> ${GLOBAL_PLUGINS_VIMRC}

    # 4.为该插件配置rtp值
    echo "install_git_plugin(): 正在配置插件运行时目录..."
    echo "install_git_plugin(): 正在检查传入的运行时目录名是否为空..."
    if [ "${DIR_PLUGIN_RUNTIMEPATH}" = "" ]; then
        echo "install_git_plugin(): 为空，默认插件顶层目录为该插件运行时目录..."
        DIR_PLUGIN_RUNTIMEPATH="${PLUGIN_NAME}"
    fi
    if [ ! -d ${DIR_HOME_VIM_BUNDLE}/${DIR_PLUGIN_RUNTIMEPATH} ]; then
        echo "install_git_plugin(): 不存在此目录，默认插件顶层目录为该插件运行时目录..."
        DIR_PLUGIN_RUNTIMEPATH="${PLUGIN_NAME}"
    fi
    echo ${DIR_HOME_VIM_BUNDLE}/${DIR_PLUGIN_RUNTIMEPATH} >> ${GLOBAL_RUNTIME_VIMRC}

    #下面这句是直接把插件全拷贝到~/.vim/bundle目录之后，统一填写rtp值
    #ls ${HOME}/.vim/bundle | xargs -i -d '\n' echo "set rtp+=${HOME}/.vim/bundle/"{} >> ${GLOBAL_RUNTIME_VIMRC}

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
    if [ "${HOSTOS}" != "ubuntu" ]; then
        echo "install_latest_libclang(): 该安装包仅限于64位Ubuntu..."
        exit 1
    else
        echo "get_ycm_package(): 正在检查网络连接..."
        host ${NETADDR_PING} 1>/dev/null 2>/dev/null
        if [ $? -eq 0 ] ; then
            echo "get_ycm_package(): 网络畅通,正在获取该插件..."

            #You should be able to use any of the listed mirrors by adding a line to your /etc/apt/sources.list like this:
            #	deb http://security.ubuntu.com/ubuntu trusty-security main universe
            grep -Hn "security\.ubuntu\.com/" /etc/apt/sources.list
            if [ $? -ne 0 ] ;
            then
                ${SUDO} sed -i '$adeb http://security.ubuntu.com/ubuntu trusty-security main universe' /etc/apt/sources.list
                ${SUDO} apt-get update
                ${SUDO} apt-get install -y llvm-3.9 
                ${SUDO} apt-get install -y llvm-3.9-dev 
                ${SUDO} apt-get install -y clang-3.9 
                ${SUDO} apt-get install -y libclang-3.9-dev 
                ${SUDO} apt-get install -y libboost-filesystem-dev
                ${SUDO} apt-get install -y libboost-iostreams-dev
                ${SUDO} apt-get install -y libboost-log-dev
                ${SUDO} apt-get install -y libboost-python-dev
                ${SUDO} apt-get install -y libboost-regex-dev
                ${SUDO} apt-get install -y libboost-wave-dev
                ${SUDO} apt-get install -y libboost-all-dev
            else
                ${SUDO} apt-get install -y llvm-3.9 
                ${SUDO} apt-get install -y llvm-3.9-dev 
                ${SUDO} apt-get install -y clang-3.9 
                ${SUDO} apt-get install -y libclang-3.9-dev 
                ${SUDO} apt-get install -y libboost-filesystem-dev
                ${SUDO} apt-get install -y libboost-iostreams-dev
                ${SUDO} apt-get install -y libboost-log-dev
                ${SUDO} apt-get install -y libboost-python-dev
                ${SUDO} apt-get install -y libboost-regex-dev
                ${SUDO} apt-get install -y libboost-wave-dev
                ${SUDO} apt-get install -y libboost-all-dev
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
    echo "init_vimtools_configs(): 正在初始化HOME目录vimrc配置文件..."
    touch ${HOME}/.vimrc
    cat /dev/null > ${HOME}/.vimrc
}

#名称: install_git_plugins
#功能: 安装所有能通过git获取的vimscript插件
#参数、返回值: 无


function install_git_plugins()
{

    #插件安装配置目录走向:
    #    插件源目录: vimtools/plugins/script/
    #    插件目标目录: ~/.vim/bundle
    #    插件配置文件: vimtools/plugins/script/xxx.vimrc
    #    插件补丁文件: vimtools/plugins/script/xxx.patch.xxx
    #    插件补丁脚本: vimtools/plugins/script/xxx.patch.sh

    #插件配置文件xxx.vimrc构造格式:
    #    注释头: 插件名_position_start，如vim_header_position_start
    #    插件名: vim-header
    #    插件功能: 自动为源文件添加头部作者信息
    #    获取地址: https://github.com/alpertuna/vim-header
    #    插件配置: *** ***
    #    注释尾: 插件名_position_end，如vim_header_position_end


    # 下面这些注释行是准备添加进来的插件信息:
    #Jump to the last place where [command|function|mapping] was set
    #http://www.vim.org/scripts/script.php?script_id=5387

    #auto generate c++ function definition or declaration 
    #https://github.com/tenfyzhong/vim-gencode-cpp 

    #composer.vim : Initial release 
    #http://www.vim.org/scripts/script.php?script_id=5436

    #Updated SearchCompete plugin with support for motions 
    #https://github.com/jakykong/SearchComplete

    #Sprint : Async file running 
    #http://www.vim.org/scripts/script.php?script_id=5504
    #https://github.com/pedsm/sprint/tree/v1.0

    #Automated Vim session management and file auto-save
    #https://github.com/thaerkh/vim-workspace 

    #coverage.vim : Show code coverage as signs
    #https://github.com/ruanyl/coverage.vim 

    #far.vim : Find And Replace Vim plugin 
    #https://github.com/brooth/far.vim 

    #auto_mkdir2.vim : Automatically create directories 
    #https://arp242.net/code/auto_mkdir2.vim

    #Chained (fallback) completion that works the way you want!
    #https://github.com/lifepillar/vim-mucomplete 

    #dutch_peasants : A dark scheme of earth colours 
    #use the GitHub repo 'kamwitsta/dutch_peasants'

    #Switch from *.c* to *.h* and vice versa 
    #https://github.com/ericcurtin/CurtineIncSw.vim 

    #a vim scheme appears to eclipse 
    #http://www.vim.org/scripts/script.php?script_id=5543

    #A syntax highlighting for general text notes 
    #https://github.com/Neur1n/note.vim 

    #add information about source file at head of file 
    #https://github.com/pandapan0021/vim-fileHeader.git

    #Asynchronous grep plugin for Vim 
    #http://www.vim.org/scripts/script.php?script_id=5536

    #A plugin to manage large files
    #https://github.com/jbarbero/doctabs.vim 

    #Insert UVM & SystemVerilog code snippets, classes, comment, etc 
    #https://github.com/jmcneal/verilog-support 

    #Add files that are changed, modifiled, untracked in git to the buffer
    #https://github.com/ToruIwashita/add-git-managed-file-to-buffer.vim

    #Terminalogy : Show and tell with a shell 
    #https://github.com/idanarye/vim-terminalogy 

    #z.vim : Help jumping to the most used directories in vim
    #https://github.com/lingceng/z.vim

    #Multiplayer : Collaborative Editing 
    #http://www.vim.org/scripts/script.php?script_id=5555

    #vim-game-snake : snake game 
    #https://github.com/johngrib/vim-game-snake

    #quickEditTab : A new command to open files in the same or another tab
    #https://github.com/Bozar/quickEditTab

    #CompleteParameter : complete parameter after select the completion
    #https://github.com/tenfyzhong/CompleteParameter.vim 

    #dirconf.vim : project specific vim config and notes 
    #https://github.com/aklt/dirconf.vim

    #quickmenu : A nice popup menu for vim 
    #https://github.com/skywind3000/quickmenu.vim 

    #Clean file buffer when U work for long periods on a large project 
    #https://github.com/arithran/vim-delete-hidden-buffers 

    #ZFVimTxtHighlight : highlight plain text files, suit most cases
    #https://github.com/ZSaberLv0/ZFVimTxtHighlight

    #ZFVimIndentMove : move cursor quickly accorrding to indent 
    #https://github.com/ZSaberLv0/ZFVimIndentMove 

    #ZFVimFoldBlock : fold code block using regexp 
    #https://github.com/ZSaberLv0/ZFVimFoldBlock 

    #vim-Verdin : An omni-complete function for Vim script 
    #https://github.com/machakann/vim-Verdin

    #subnetquicksearch.vim : Searches for a highlighted subnet
    #http://www.vim.org/scripts/script.php?script_id=5594

    #MarkdownCopy : Copy Markdown to clipboard as HTML
    #https://bitbucket.org/abudden/vim-markdowncopy

    #highlight-groups.vim : Add words in highlight groups on the fly. 
    #https://github.com/antoinemadec/vim-highlight-groups 

    #A tentative proposal for an “official” colorscheme template
    #https://github.com/lifepillar/vim-colortemplate 

    #completes an entire sequence of non-blank characters 
    #https://github.com/inkarkat/vim-WORDComplete


    

    #EasyMotion : Vim motions on speed! 
    #https://github.com/Lokaltog/vim-easymotion



    #Elegant buffer explorer - takes very little screen space 
    #https://github.com/fholgado/minibufexpl.vim
    #http://www.vim.org/scripts/script.php?script_id=2902

    #可以支持多种程序语言的注释代码的快捷键
    #https://github.com/scrooloose/nerdcommenter

    #自动插入和格式化方括号和圆括号
    #https://github.com/jiangmiao/auto-pairs 

    #插件安装配置目录走向:
    #    插件源目录: vimtools/plugins/script/
    #    插件目标目录: ~/.vim/bundle
    #    插件配置文件: vimtools/plugins/script/xxx.vimrc
    #    插件补丁文件: vimtools/plugins/script/xxx.patch.xxx
    #    插件补丁脚本: vimtools/plugins/script/xxx.patch.sh

    #插件配置文件xxx.vimrc构造格式:
    #    注释头: 插件名_position_start，如vim-header_position_start
    #    插件名: vim-header
    #    插件功能: 自动为源文件添加头部作者信息
    #    获取地址: https://github.com/alpertuna/vim-header
    #    插件配置: *** ***
    #    注释尾: 插件名_position_end，如vim-header_position_end

    #install_git_plugin函数使用方法:
    #   install_git_plugin \
    #       "插件配置文件名.vimrc" \（一般为: 插件名.vimrc）
    #       "插件名（插件目录名）" \
    #       "插件获取地址(git)" \
    #       "是否更新"

    #install_git_plugin参数取值:
    #       "xxx.vimrc" 插件配置，一般为: 插件名.vimrc
    #       "xxx"       插件目录，一般为: 插件名（插件目录名）
    #       "xxx"       插件运行时(rtp)目录，通常默认为插件顶层目录，也可指定
    #       "git-addr"  插件地址，一般为: 插件的git获取地址
    #       "update"    插件更新，一般为: 是否更新(识别到update则更新为最新,否则不更新)
    #方便对代码进行注释
    #https://github.com/tpope/vim-commentary

    #Automated tag file generation and syntax highlighting of tags in Vim
    #https://github.com/xolox/vim-easytags

    #收集了一大坨配色
    #http://github.com/biskark/vim-ultimate-colorscheme-utility

    install_git_plugin \
        "winmanager.vimrc" \
        "winmanager" \
        "" \
        "" \
        "no-update"

    #Provides auto-balancing and some expansions for parens, quotes, etc
    #http://github.com/Raimondi/delimitMate
    install_git_plugin \
        "delimitMate.vimrc" \
        "delimitMate" \
        "" \
        "http://github.com/Raimondi/delimitMate" \
        "no-update"

    #比如c++，会自动调用诸如astyle, clang-format来对代码进行美化
    #https://github.com/Chiel92/vim-autoformat
    install_git_plugin \
        "vim-autoformat.vimrc" \
        "vim-autoformat" \
        "" \
        "https://github.com/Chiel92/vim-autoformat" \
        "no-update"

    #shows a git diff in the gutter (sign column) and stages/undoes hunks
    #https://github.com/airblade/vim-gitgutter
    #install_git_plugin \
        #"vim-gitgutter.vimrc" \
        #"vim-gitgutter" \
        #"" \
        #"https://github.com/airblade/vim-gitgutter" \
        #"no-update"

    #通过将不同层次的括号高亮为不同的颜色, 帮助你阅读世界上最复杂的代码
    #https://github.com/luochen1990/rainbow
    install_git_plugin \
        "rainbow.vimrc" \
        "rainbow" \
        "" \
        "https://github.com/luochen1990/rainbow" \
        "no-update"

    #自定义Vim底部弹出菜单
    #https://github.com/luzhlon/popup.vim
    install_git_plugin \
        "popup.vimrc" \
        "popup.vim" \
        "" \
        "https://github.com/luzhlon/popup.vim" \
        "no-update"

    # 自动语法检查
    install_git_plugin \
        "syntax_check.vimrc" \
        "syntax_check" \
        "" \
        "https://github.com/scrooloose/syntastic" \
        "no-update"

    #内嵌man将man手册格式化输出到文件缓冲区
    install_git_plugin \
        "man.vimrc" \
        "man" \
        "" \
        "http://www.vim.org/scripts/script.php?script_id=5615" \
        "no-update"

    #路径补全插件
    #https://github.com/vim-scripts/AutoComplPop
    install_git_plugin \
        "AutoComplPop.vimrc" \
        "AutoComplPop" \
        "" \
        "https://github.com/vim-scripts/AutoComplPop" \
        "no-update"

    #C结构体成员补全
    install_git_plugin \
        "omnicppcomplete.vimrc" \
        "omnicppcomplete" \
        "" \
        "https://github.com/vim-scripts/OmniCppComplete" \
        "no-update"

    #工程源文件快速查找（但是莫名奇妙排斥该git地址带大小写区分的该插件名）
    install_git_plugin \
        "lookupfile.vimrc" \
        "lookupfile" \
        "" \
        "" \
        "no-update"
    install_git_plugin \
        "genutils.vimrc" \
        "genutils" \
        "" \
        "https://github.com/vim-scripts/genutils" \
        "no-update"

    # ctags,cscope数据库自动更新加载插件
    install_git_plugin \
        "auto_update_cscope_ctags_database.vimrc" \
        "auto_update_cscope_ctags_database" \
        "" \
        "https://github.com/haolongzhangm/auto_update_cscope_ctags_database" \
        "no-update" 

    # 提供markdown的语法支持
    install_git_plugin \
        "vim-markdown.vimrc" \
        "vim-markdown" \
        "" \
        "https://github.com/plasticboy/vim-markdown" \
        "no-update"

    # 语法缩进线
    install_git_plugin \
        "indentLine.vimrc" \
        "indentLine" \
        "indentLine/after" \
        "https://github.com/Yggdroot/indentLine" \
        "no-update"

    # 文件名缓冲区
    install_git_plugin \
        "minibufexpl.vimrc" \
        "minibufexpl" \
        "" \
        "https://github.com/fholgado/minibufexpl.vim" \
        "no-update"

    # 文件缓冲区
    install_git_plugin \
        "bufexplorer.vimrc" \
        "bufexplorer" \
        "" \
        "https://github.com/jlanzarotta/bufexplorer" \
        "no-update"

    # 高亮标签插件（支持6种颜色标签高亮）
    install_git_plugin \
        "mark.vim.vimrc" \
        "mark.vim" \
        "" \
        "https://github.com/Tuxdude/mark.vim" \
        "no-update"

    # 代码批量注释快速注释插件
    install_git_plugin \
        "comments.vim.vimrc" \
        "comments.vim" \
        "" \
        "https://github.com/sudar/comments.vim" \
        "no-update"

    # .c文件对应头文件快速跳转插件
    install_git_plugin \
        "a.vim.vimrc" \
        "a.vim" \
        "" \
        "https://github.com/csliu/a.vim" \
        "no-update"

    # 当前文件全局变量等列表插件
    install_git_plugin \
        "taglist.vimrc" \
        "taglist" \
        "" \
        "https://github.com/vim-scripts/taglist.vim" \
        "no-update"

    # 源代码预览插件
    install_git_plugin \
        "SrcExpl.vimrc" \
        "SrcExpl" \
        "" \
        "https://github.com/wesleyche/SrcExpl.git" \
        "no-update"

    # 目录树管理插件
    install_git_plugin \
        "nerdtree.vimrc" \
        "nerdtree" \
        "" \
        "https://github.com/scrooloose/nerdtree" \
        "no-update"

    # 上述两插件的综合管理插件
    install_git_plugin \
        "Trinity.vimrc" \
        "Trinity" \
        "" \
        "https://github.com/wesleyche/Trinity" \
        "no-update"

    # vim内部异步执行外部shell命令插件
    install_git_plugin \
        "asyncrun.vimrc" \
        "asyncrun.vim" \
        "" \
        "https://github.com/skywind3000/asyncrun.vim" \
        "no-update"

    # 代码补全插件，代码高效编辑插件
    install_git_plugin \
        "code_complete.vimrc" \
        "code_complete" \
        "" \
        "https://github.com/SeaflyGithub/code_complete" \
        "no-update"

    # 文件头管理插件
    install_git_plugin \
        "vim-header.vimrc" \
        "vim-header" \
        "" \
        "https://github.com/alpertuna/vim-header" \
        "no-update"

}

#函数名: enable_vimscript_plugins
#函数功能: 使能这些插件,主要是设置插件的runtimepath值
#参数: No
#返回值: No
function enable_vimscript_plugins()
{
    # 实现细节:
    # 把~/.vim/bundle下所有插件目录写入rtp
    # rtp的设置统一写入vimtools/config/runtime_vimrc.vimrc
    cat /dev/null > ${GLOBAL_RUNTIME_VIMRC}
    echo "enable_vimscript_plugins(): 正在使能插件..."
    ls ${HOME}/.vim/bundle | xargs -i -d '\n' echo "set rtp+=${HOME}/.vim/bundle/"{} >> ${GLOBAL_RUNTIME_VIMRC}

}

#函数名: combine_vimrcs
#函数功能: 把vimtools/config/xxx.vimrc一次合并到~/.vimrc里
#参数: No
#返回值: No
function combine_vimrcs()
{
    # 实现细节:
    #   首先初始化（清空）~/.vimrc
    #   依次把vimtools/config/目录下的配置导入到~/.vimrc

    echo "combine_vimrcs(): 正在合并配置..."
    touch ${HOME}/.vimrc
    cat /dev/null > ${HOME}/.vimrc
    cat ${GLOBAL_RUNTIME_VIMRC} >> ${HOME}/.vimrc
    cat ${GLOBAL_DEFAULT_VIMRC} >> ${HOME}/.vimrc
    cat ${GLOBAL_PLUGINS_VIMRC} >> ${HOME}/.vimrc
}


function build_all_help()
{
    echo "获取帮助:	bash ./build_all.sh"
    echo "全新安装:	bash ./build_all.sh --all"
    echo "只安装vim:	bash ./build_all.sh --vim"
    echo "只安装插件:	bash ./build_all.sh --plugins"
    echo "安装本地插件:	bash ./build_all.sh --script"
    return 0
}

#名称: patch_plugin
#功能: 为特殊插件打补丁
#参数: $1==补丁脚本，脚本里为具体补丁内容，补丁脚本默认规定放在plugins/script/目录下
#参数: $2==补丁脚本解释器，如bash,sh,python等.
#说明: 比如补丁脚本为xxx.sh，那么该函数会自动执行该脚本
function patch_plugin()
{
    PATCH_SCRIPT="$1"
    SCRIPT_EXEC="$2"
    DIR_SCRIPT=${DIR_CUR}/plugins/script/${PATCH_SCRIPT}

    ${SCRIPT_EXEC} ${DIR_SCRIPT}
    return 0
}

function patch_plugins()
{
    #该补丁是安装cscope和ctags工具
    patch_plugin "cscope_ctags.sh" "bash"

    #该indentLine补丁是之前rtp值的修复问题:
    #patch_plugin "indentLine.patch.sh" "bash"
    #该auto_update_cscope_ctags_database补丁是对于最新插件的新功能补丁添加:
    #patch_plugin "auto_update_cscope_ctags_database.sh" "bash"
    #该补丁是安装完成后提示用户填写作者名和邮箱信息
    patch_plugin "vim-header.patch.sh" "bash"

    #patch_plugin "vim-gitgutter.patch.sh" "bash"

    return 0
}

function install_vimtools()
{
    INSTALL_ARG="$1"
    case ${INSTALL_ARG} in
        "")
            build_all_help
            exit 1
            ;;
        "all"|"--all")
            echo "提示: 正在进入完整安装..."
            init_vim_configure_dir
            install_python_libs
            install_vim "python2.x" "no-update" "8.0"
            init_vimtools_configs
            #install_youcomleteme
            install_git_plugins
            enable_vimscript_plugins
            combine_vimrcs
            patch_plugins
            ;;
        "vim"|"--vim")
            echo "提示: 正在进行vim安装..."
            install_python_libs
            install_vim "python2.x" "no-update" "8.0"
            ;;
        "plugins"|"--plugins")
            echo "提示: 正在进行插件安装..."
            install_ctags_cscope "no-update"
            init_vim_configure_dir
            init_vimtools_configs
            install_git_plugins
            patch_plugins
            #config_vim_header 作为补丁来操作
            ;;
        "script_plugins"|"script"|"--script"|"--script_plugins")
            echo "提示: 正在进行本地插件安装..."
            init_vim_configure_dir
            init_vimtools_configs
            install_git_plugins
            enable_vimscript_plugins
            combine_vimrcs
            patch_plugins
            ;;
        *)
            ${INSTALL_ARG}
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

#vimtools推荐:https://github.com/SpaceVim/SpaceVim
install_vimtools "$@"
