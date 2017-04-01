local ngx_request = {
  headers = function()
    return ngx.req.get_headers()
  end,
  cmd_meth = function()
    return ngx.var.request_method
  end,
  cmd_url = function()
    return ngx.var.request_uri
  end,
}

local lazy_tbl
lazy_tbl = function(tbl, index)
  return setmetatable(tbl, {
    __index = function(self, key)
      local fn = index[key]
      if fn then
        do  
          local res = fn(self)
          self[key] = res 
          return res 
        end 
      end 
    end 
  })  
end



local build_request
build_request = function(unlazy)
        ret = lazy_tbl({}, ngx_request)
        for k in pairs(ngx_request) do
             local _ = ret[k]
        end
        return ret
end

return build_request("") 
