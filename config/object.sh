#LookupFile: dependent file
echo -e "!_TAG_FILE_SORTED\t2\t/2=foldcase">./filenametags
find ./ -type f -printf "%f\t%p\t1\n" | sort -f >>./filenametags

#ctags: dependent file
TAGARGS=$*
ctags \
    -I __THROW \
    -I __attribute_pure__ \
    -I __nonnull \
    -I __attribute__ \
    --file-scope=yes \
    --langmap=c:+.h  \
    --languages=C,C++,Asm,HTML,Java \
    --links=yes \
    --c-kinds=+p \
    --c++-kinds=+p \
    --fields=+iaS \
    --extra=+q -V -f ~/.vim/systags \
    /usr/include/*\
    /usr/include/alsa/*\
    /usr/include/arpa/*\
    /usr/include/asm/*\
    /usr/include/asm-generic/*\
    /usr/include/bits/*\
    /usr/include/linux/*\
    /usr/include/sys/*\
    /usr/include/net/*\
    /usr/include/netinet/*\
    ${TAGARGS}
#build tags object file
#ctags --list-languages     (list languages of ctags supporter)
ctags -RV \
    --file-scope=yes \
    --langmap=c:+.h  \
    --languages=Asm,Awk,C,C++,C#,HTML,Java,JavaScript,Make,PHP,Sh,python \
    --links=yes \
    --c-kinds=+p \
    --c++-kinds=+p \
    --fields=+iaS \
    --extra=+q .
#    --etags-include=~/.vim/systags \
#ctags -R --sort=1 --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -f cpp cpp_src

#cscope: dependent file(s)
#cscope -Rbqv
cscope -Rbqv

