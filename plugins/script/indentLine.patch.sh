VIMRC=${HOME}/.vimrc
echo "$0:正在删除原有使能配置..."
sed -i '/bundle\/indentLine/d' ${VIMRC}
echo "$0:正在添加有效使能配置..."
sed -i '1iset rtp+=/home/seafly/.vim/bundle/indentLine/after' ${VIMRC}
