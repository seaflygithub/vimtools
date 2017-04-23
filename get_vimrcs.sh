#!/bin/bash
cat /dev/null > ./vimrc
vimrclist=`ls config/vimrcs`
for vimrc in $vimrclist
do
    if [ $vimrc == "vim-header.vimrc" ] ;
    then
        echo "jump:$vimrc"
        vimrc=""
        continue
    fi
    echo "get:$vimrc" >> ./vimrc
#   cat "config/vimrcs/$vimrc" >> ./vimrc
done
