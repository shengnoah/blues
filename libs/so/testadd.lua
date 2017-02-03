local aadd = package.loadlib("libtangguo.so", "add")
local asub = package.loadlib("libtangguo.so", "sub")
local ret = aadd(1,5)
print(ret)

local ret = asub(6,3)
print(ret)
