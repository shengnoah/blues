#include "tangguo.h"

int sub(lua_State* L) {
    double op1 = luaL_checknumber(L, 1);
    double op2 = luaL_checknumber(L, 2);
    lua_pushnumber(L, op1 - op2);
    return 1;
}

int add(lua_State* L) {
    double op1 = luaL_checknumber(L, 1);
    double op2 = luaL_checknumber(L, 2);
    lua_pushnumber(L, op1 + op2);
    return 1;
}


int prn(lua_State* L) {
    puts("CandyLab, Hi LUA!");
    return 1;
}
int luaopen_libtangguo(lua_State* L)
{
    luaL_openlibs(L);
    const char *libName = "libtangguo";
    luaL_register(L, libName, libtangguo);
    return 0;
}

