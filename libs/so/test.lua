local aprn = package.loadlib("libtangguo.so", "prn")
local aadd = package.loadlib("libtangguo.so", "add")
local asub = package.loadlib("libtangguo.so", "sub")
local asplit = package.loadlib("libtangguo.so", "split")
local itable = package.loadlib("libtangguo.so", "itable")

local ret = itable("elementA","elementB")
for k,v in pairs(ret) do
    print(k, v)
end

local ret = aprn(1,6)
local ret = asplit("hi,,there",",")

for k,v in pairs(ret) do
    print(k, v)
end

local ret = aadd(1,5)
print(ret)

local ret = asub(6,3)
print(ret)

