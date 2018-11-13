#ifndef  MAIN_H
#define  MAIN_H

typedef struct _tag_node {
    struct _tag_node *next;
}node_t;
typedef struct _tag_head {
    node_t  linker;
    int     length;
}head_t,list_t;
typedef struct tag_data {
    int name;
    int age;
    int addr;
    node_t linker;
}data_t;

#endif  // MAIN_H
