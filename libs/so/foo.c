#include <stdio.h>
#include "lauxlib.h"

void foo(lua_State* L)
{
    puts("Hello, I'm a shared library");
}
