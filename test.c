//用法:execlp():根据全局变量找到可执行文件名的路径并执行该可执行程序
#include <stdio.h>
#include <unistd.h>
int main (int argc, char *argv[])
{
    if (argc != 2)
    {   
        printf ("Usage: %s %s\n", argv[0], "ls");
        _exit (1);
    }   
    execlp (argv[1], "-l", "-h", "-s", NULL);
    return 0;
}
