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


function Route.finder(self)
        local url = self.req.cmd_url
        local method = self.req.cmd_meth

        if method == "POST" then
                for k,v in pairs(self.map.post) do
                        if self.map.post[k][1] == url then
                                return self.map.post[k][2]
                        end
                end
        end

        if method == "GET" then
                for k,v in pairs(self.map.get) do
                        local match = string.find(url, self.map.get[k][1])
                        if match then
                                return self.map.get[k][2]
                        end
                end
        end
end


return Route
