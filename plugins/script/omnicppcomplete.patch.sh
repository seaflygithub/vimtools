#!/bin/bash
DIR_ROOT=`pwd`  #root dir is vimtools
DIR_CUR=${DIR_ROOT}/plugins/script

cat ${DIR_CUR}/omnicppcomplete.patch.vimrc > /tmp/vimrc
cat ${HOME}/.vimrc >> /tmp/vimrc
cat /tmp/vimrc > ${HOME}/.vimrc
