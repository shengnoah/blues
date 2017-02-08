local aprn = package.loadlib("libtangguo.so", "prn")
local aadd = package.loadlib("libtangguo.so", "add")
local asub = package.loadlib("libtangguo.so", "sub")
local asplit = package.loadlib("libtangguo.so", "split")
local itable = package.loadlib("libtangguo.so", "itable")
local cjson_new = package.loadlib("libtangguo.so", "cjson_new")
local newID= package.loadlib("libtangguo.so", "newID")
local setID= package.loadlib("libtangguo.so", "setID")
local getID= package.loadlib("libtangguo.so", "getID")

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

local cjson = cjson_new()

for k,v in pairs(cjson) do
    print(k, v, type(v))
end

print(cjson.null)
tmp = cjson.null
print(tmp, type(tmp))


if cjson.null == nil then
    print("OK")
end

if cjson.null == "null" then
    print("OK")
end

if cjson.null == tmp then
    print("OK")
end

hiObj = newID()
setID(hiObj, "testvalue")
ret = getID(hiObj)
print(ret)

