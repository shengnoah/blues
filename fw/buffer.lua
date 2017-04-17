local json = require "cjson"
local util = require "cjson.util"

local buffer = {}


function buffer.set(_key,_value)
  if _key then
    local g_waf = ngx.shared.g_waf
    g_waf:set(_key, _value)
  end
end


function buffer.get(_key)
  if _key then
    local g_waf = ngx.shared.g_waf
    local value = g_waf:get(_key)
    return value
  end
end

function buffer.sett(_key,_value)
  if type(_value) != "table" then return end
  if _key then
    local g_waf = ngx.shared.g_waf    
    local json_value = json.encode(_value)
    g_waf:set(_key, json_value)    
  end 
end


function buffer.gett(_key) 
  if _key then
    local g_waf = ngx.shared.g_waf
    local value = g_waf:get(_key)
    if value then
      local table_value = json.decode(value)    
      return table_value
    end 
  end 
end

return buffer
