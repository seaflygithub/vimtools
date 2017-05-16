CURRENT_DIR=`pwd`

function install_YouCompleteMe()
{
    echo "*****************************************"
    SUDO=sudo

    $SUDO apt-get install -y vim
    $SUDO apt-get install -y vim-nox
    $SUDO apt-get install -y vim-gnome-py2
    $SUDO apt-get install -y git git-core

    #1. clone 到本地
    #k-vim  https://github.com/wklken/k-vim
    git clone https://github.com/wklken/k-vim.git
    #wklken/vim-for-server  https://github.com/wklken/vim-for-server

    #把我们修改好的INSTALL,vimrc,vimrc.bundles文件覆盖进去
    cat $CURRENT_DIR/INSTALL > $CURRENT_DIR/k-vim/install.sh
    cat $CURRENT_DIR/vimrc > $CURRENT_DIR/k-vim/vimrc
    cat $CURRENT_DIR/vimrc.bundles > $CURRENT_DIR/k-vim/vimrc.bundles
    cp -rvf $CURRENT_DIR/scripts $CURRENT_DIR/k-vim/

    #2. 安装依赖包 ## ubuntu
    $SUDO apt-get install -y ctags
    $SUDO apt-get install -y build-essential cmake python-dev  #编译YCM自动补全插件依赖
    $SUDO apt-get install -y silversearcher-ag

    #2.2 使用Python
    $SUDO pip install pyflakes
    $SUDO pip install pylint
    $SUDO pip install pep8

    #3. 安装
    cd k-vim/ && sh -x install.sh

    #移除安装
    #cd ~ && rm -rf .vim .vimrc .vimrc.bundles && cd -
    echo "*****************************************"
    exit 0
}

install_YouCompleteMe
