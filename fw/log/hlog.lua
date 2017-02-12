local utils = require"utils"
local t_log = {
    router = {
	prn = function(...)
            param = arg[1]
            do 
                 local ds = {
      	             'uri',
                     'method'
                 }
                 for k,v in pairs(ds) do
                     if (param[v]) then
                         print(param[v])
                     end
                 end
            end
        end
    }
}


function prouter(foo)
    t_log.router['prn'](foo)
end

local tst = {a=1,b=2,c=3}


local param = {uri="/hilua", method="post",testcase=tst}
print(type(utils))
for k,v in pairs(utils) do
print(k,v)
end


print(utils:pprint(param))
--prouter(param)
