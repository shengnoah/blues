local lazytable= {

    ngx_request = {
      headers = function()
        return ngx.req.get_headers()
      end,
      cmd_meth = function()
        return ngx.var.request_method
      end,
      rip = function()
        return (ngx.req.get_headers()['X-Real-IP'])
      end,
      cip = function()
        return ngx.var.remote_addr  
      end,
      ip = function()
        return ngx.var.remote_addr  
      end,
      cmd_url = function()
        return ngx.var.request_uri
      end,
      body = function()
        ngx.req.read_body()
        local data = ngx.req.get_body_data()    
        return data 
      end,
      content_type = function()
        local content_type = ngx.header['content-type'] 
        return content_type
      end
    }

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

function lazytable.build_request(self, unlazy) 
        ret = lazy_tbl({}, self.ngx_request)
        for k in pairs(self.ngx_request) do
             local _ = ret[k]
        end
        return ret
end


return lazytable 
