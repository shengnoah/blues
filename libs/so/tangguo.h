#ifndef __tangguo_h__
#define __tangguo_h__
#include <stdio.h>
#include <string.h>
#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"


static struct HiId
{
    char *key;
    char *value;
};


extern int add(lua_State* L);
extern int sub(lua_State* L);
extern int prn(lua_State* L);
extern int split(lua_State* L);
extern int itable(lua_State* L);
extern int cjson_new(lua_State* L);
extern int newID(lua_State* L);
extern int setID(lua_State* L);
extern int getID(lua_State* L);

static luaL_Reg libtangguo[] = {
    {"add", add},
    {"sub", sub},
    {"prn", prn},
    {"split", split},
    {"itable", itable},
    {"cjson_new", cjson_new},
    {"newID", newID},
    {"setID", setID},
    {"getID", getID},
    {NULL, NULL}
};

#endif
