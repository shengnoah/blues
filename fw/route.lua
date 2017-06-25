local tinsert = table.insert

local Route =  {
    map = {
        get = {},
        post = {}
    }
}

function Route.register(self, app, url, callback, method)
        if method == "GET" then
            tinsert(self.map.get, {url, callback})
        elseif method == "POST" then
            tinsert(self.map.post, {url, callback})
        end
end


function Route.getInstance(self)
        local instance = {}
        instance.__call = self.register
        setmetatable(self, instance)
        return Route
end 


function Route.get(self)
    local url = self.req.cmd_url
    local map = self.map.get
    for k,v in pairs(map) do
        local ret = self:match(url, map[k][1])
        if ret then
            return map[k][2]
        end
    end
end


function Route.post(self)
    for k,v in pairs(self.map.post) do
        if self.map.post[k][1] == url then
            return self.map.post[k][2]
        end
    end
end

function Route.finder(self)
    local method = self.req.cmd_meth

    local ftbl = {
        GET=self.get, 
        POST=self.post
    }

    local ret = ftbl[method](self)
    return ret
end

function Route.match(self, src, dst)
    local ret = string.find(src, dst)
    return ret
end

return Route
