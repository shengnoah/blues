local json = require "cjson"
local util = require "cjson.util"
local bjson = {}

function bjson.loadf(filename, env)
    return util.file_load(filename, env)
end


function bjson.decode(json_text)
    local ret = json.decode(json_text)
    return ret 
end


function bjson.encode(table_data)
    local ret = json.encode(table_data)
    return ret 
end


function bjson.pprint(info)
    return util.serialise_value(info)
end


return bjson
