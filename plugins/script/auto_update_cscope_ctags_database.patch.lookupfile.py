#!/usr/bin/env python
# -*- coding: utf-8 -*-
# File              : auto_update_cscope_ctags_database.patch.lookupfile.py
# Author            : SeaflyGithub <seafly0616@qq.com>
# Date              :46 PM
# Last Modified Date: 2017.10.20 09:44:02 PM
# Last Modified By  : SeaflyGithub <seafly0616@qq.com>
# https://github.com/haolongzhangm/auto_update_cscope_ctags_database



        #ctags_cmd = "ctags -R --fields=+lafikmnsztS --extra=+fq -L tags.files"
        ctags_cmd = "ctags -RV --file-scope=yes --langmap=c:+.h --links=yes --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q ."
        ctags_cmd = ctags_cmd + " ; mv tags tags.1"
        #kernel mode
        if 'not_kernel' != arch_type_str:
        	ctags_cmd = ctags_cmd + " ; ctags -RV --file-scope=yes --links=yes --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q "
            ctags_cmd = ctags_cmd + " -I EXPORT_SYMBOL+,EXPORT_SYMBOL_GPL+,__acquires+,__releases+,module_init+,module_exit"
            ctags_cmd = ctags_cmd + " -I fs_initcall+,subsys_initcall+,device_initcall+,core_initcall+,arch_initcall"
            ctags_cmd = ctags_cmd + " -I late_initcall+,postcore_initcall+,console_initcall+,early_initcall"
            ctags_cmd = ctags_cmd + " -I __initcall+,core_initcall_sync+,subsys_initcall_sync+,fs_initcall_sync"
            ctags_cmd = ctags_cmd + " -I late_initcall_sync+,arch_initcall_sync+,rootfs_initcall+,pure_initcall+,__exitcall"
            ctags_cmd = ctags_cmd + " -I DEFINE_SRCU+,security_initcall+,postcore_initcall_sync+,device_initcall_sync"
            ctags_cmd = ctags_cmd + " --langmap=c:+.h"
            ctags_cmd = ctags_cmd + " ; mv tags tags.2"
            ctags_cmd = ctags_cmd + " ; sed -i '1,6d' tags.2"
        #slient mode
        else:
        	ctags_cmd = ctags_cmd + " ; ctags --file-scope=yes --langmap=c:+.h --links=yes--extra=+q -V"
        	ctags_cmd = ctags_cmd + " --c-kinds=+p --c++-kinds=+p --fields=+iaS"
        	ctags_cmd = ctags_cmd + " -I __THROW -I __attribute_pure__ -I __nonnull -I __attribute__"
        	ctags_cmd = ctags_cmd + " /usr/include/*"
        	ctags_cmd = ctags_cmd + " /usr/include/alsa/*"
        	ctags_cmd = ctags_cmd + " /usr/include/arpa/*"
        	ctags_cmd = ctags_cmd + " /usr/include/asm/*"
        	ctags_cmd = ctags_cmd + " /usr/include/asm-generic/*"
        	ctags_cmd = ctags_cmd + " /usr/include/bits/*"
        	ctags_cmd = ctags_cmd + " /usr/include/linux/*"
        	ctags_cmd = ctags_cmd + " /usr/include/sys/*"
        	ctags_cmd = ctags_cmd + " /usr/include/net/*"
        	ctags_cmd = ctags_cmd + " /usr/include/netinet/*"
        	ctags_cmd = ctags_cmd + " -f tags.2"
        	ctags_cmd = ctags_cmd + " ; sed -i '1,6d' tags.2"
        
        ctags_cmd = ctags_cmd + " ; cat tags.2 >> tags.1 ; mv tags.1 tags"
		#LookupFile: dependent file
		ctags_cmd = ctags_cmd + ' ; echo -e "!_TAG_FILE_SORTED\t2\t/2=foldcase">./filenametags'
		ctags_cmd = ctags_cmd + ' ; find ./ -type f -printf "%f\t%p\t1\n" | sort -f >>./filenametags'



#:补丁插入位置开始:补丁插入位置结尾:补丁文件匹配字串:(用来判断该插件是否已经打了该补丁)
#:400:438:auto_update_cscope_ctags_database_patch_lookupfile_py
