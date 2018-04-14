VIMRC=${HOME}/.vimrc
#sed -i '/bundle\/indentLine/d' ${VIMRC}
echo "$0:正在添加有效使能配置..."
sed -i '1iset rtp+=${HOME}/.vim/bundle/vimwiki/autoload/vimwiki' ${VIMRC}
