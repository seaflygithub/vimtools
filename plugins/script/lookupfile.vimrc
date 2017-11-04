" 	工程管理插件
"=============================================================
"               LookupFile文件查找插件
"=============================================================
let g:LookupFile_TagExpr = './filenametags'
let g:LookupFile_MinPatLength = 1               "最少输入1个字符才开始查找
let g:LookupFile_PreserveLastPattern = 0        "不保存上次查找的字符串
let g:LookupFile_PreservePatternHistory = 1     "保存查找历史
let g:LookupFile_AlwaysAcceptFirst = 1          "回车打开第一个匹配项目
let g:LookupFile_AllowNewFiles = 0              "不允许创建不存在的文件
let g:LookupFile_RecentFileListSize = 30
"let g:LookupFile_FileFilter = '\.class$\|\.o$\|\.obj$\|\.exe$\|\.jar$\|\.zip$\|\.war$\|\.ear$'
