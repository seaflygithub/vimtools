echo "start copy"
echo $HOME
rm $HOME/.vimrc -rf
rm $HOME/.vim -rf
cp _vimrc $HOME/.vimrc -rf 
cp _vim  $HOME/.vim  -rf
echo "copy successful"
