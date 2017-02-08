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

int split(lua_State* L) {
    const char *s = luaL_checkstring(L, 1);
    const char *sep = luaL_checkstring(L, 2);
    const char *e;
    int i = 1;
 
    lua_newtable(L);  /* result */
 
    /* repeat for each separator */
    while ((e = strchr(s, *sep)) != NULL) {
       lua_pushlstring(L, s, e-s);  /* push substring */
       lua_rawseti(L, -2, i++);
       s = e + 1;  /* skip separator */
    }
 
    /* push last substring */
    lua_pushstring(L, s);
    lua_rawseti(L, -2, i);
 
    return 1;  /* return the table */
}

int itable(lua_State* L) {
    const char *s = luaL_checkstring(L, 1);
    const char *sep = luaL_checkstring(L, 2);
 
    lua_newtable(L);  /* result */
 
    /* push last substring */
    lua_pushstring(L, s);
    lua_rawseti(L, -2, 1);
 
    lua_pushstring(L, sep);
    lua_rawseti(L, -2, 2);
    return 1;  /* return the table */
}


int cjson_new(lua_State* L) {
    lua_newtable(L);
    /* Set cjson.null */
    lua_pushlightuserdata(L, NULL);
    lua_setfield(L, -2, "null");
    return 1;
}

int newID(lua_State* L) {
    size_t iLen = sizeof(struct HiId);
    struct HiId *pHiId;
    pHiId = (struct HiId *)lua_newuserdata(L, iLen);

    luaL_getmetatable(L, "newID");
    lua_setmetatable(L, -2);
    return 1;
}

int setID(lua_State* L) {
    struct HiId *pHiId = (struct HiId*)lua_touserdata(L, 1);
    luaL_argcheck(L, pHiId != NULL, 1, "Wrong Parameter");
    
    const char *pValue = luaL_checkstring(L, 2);
    luaL_argcheck(L, pHiId!= NULL, 2, "Wrong Parameter");
    pHiId->value = pValue; 
    printf("setID:%s\n", pHiId->value);
    return 0;
}

int getID(lua_State* L) {
    struct HiId *pHiId= (struct HiId*)lua_touserdata(L, 1);
    luaL_argcheck(L, pHiId != NULL, 1, "Wrong Parameter");
    printf("getID:%s\n", pHiId->value);
    lua_pushstring(L, pHiId->value);

    return 1;
}
int luaopen_libtangguo(lua_State* L)
{
    luaL_openlibs(L);
    const char *libName = "libtangguo";
    luaL_register(L, libName, libtangguo);
    return 0;
}

