#!/bin/bash
# File              : auto_update_cscope_ctags_database.sh
# Author            : SeaflyGithub <seafly0616@qq.com>
# Date              :11 PM
# Last Modified Date: 2017.10.20 09:49:23 PM
# Last Modified By  : SeaflyGithub <seafly0616@qq.com>

DIR_CUR="`pwd`"
DIR_HOME_BUNDLE=${HOME}/.vim/bundle
DIR_SCRIPT=${DIR_CUR}/plugins/script
FILE_HEAD=${DIR_CUR}/plugins/script/auto_update_cscope_ctags_database.1.py
FILE_TAIL=${DIR_CUR}/plugins/script/auto_update_cscope_ctags_database.3.py
FILE_PATCH=${DIR_CUR}/plugins/script/auto_update_cscope_ctags_database.patch.lookupfile.py
FILE_PATCHED=${DIR_HOME_BUNDLE}/auto_update_cscope_ctags_database/plugin/auto_update_cscope_ctags_backup_run.py
auto_update_cscope_ctags_database.patch.lookupfile.py
#01.首先判断是否已经具备该插件了
grep -Hn "auto_update_cscope_ctags_database_patch_lookupfile_py" ${FILE_PATCHED}
if [ $? -ne 0 ]; then
    echo "$0:正在为auto_update_cscope_ctags_database打上该补丁..."
    echo "$0:正在获取补丁插入位置..."		#从补丁文件最后一行注释行中获取补丁信息
    PATCH_LINE_HEAD=`tail -n 1 ${FILE_PATCH} | awk -F ':' '{print $1}'`
    PATCH_LINE_TAIL=`tail -n 1 ${FILE_PATCH} | awk -F ':' '{print $2}'`
    echo "$0:读取被补丁文件上半部..."
    head -n ${PATCH_LINE_HEAD} ${FILE_PATCH} > ${FILE_HEAD}
    echo "$0:读取被补丁文件下半部..."
    tail -n ${PATCH_LINE_TAIL} ${FILE_PATCH} > ${FILE_TAIL}
    echo "$0:正在重组插件文件..."
    cat ${FILE_HEAD}    >   ${FILE_PATCHED}
    cat ${FILE_PATCH}   >>  ${FILE_PATCHED}
    cat ${FILE_TAIL}    >   ${FILE_PATCHED}
    rm -rf ${FILE_HEAD}
    rm -rf ${FILE_TAIL}
    echo "$0:该插件成功打上补丁..."
else
    echo "$0:已经为auto_update_cscope_ctags_database打了该补丁..."
    exit 0
fi
