local tinsert = table.insert
local req = require "nginx"
local utils = require "utils.utils"
local Route =  {}

function Route:Init()
end

function Route:getInstance()
        local instance = {}
        instance.map = {
            get = {},   --get
            post = {}   --post
        }

        instance.idea = 1

        local base = {}
        function base.register(self, app, url, callback, method)
                if method == "GET" then
                    tinsert(self.map.get, {url, callback})
                elseif method == "POST" then
                    tinsert(self.map.post, {url, callback})
                end

        end

        base.__call = base.register
        setmetatable(instance, base)
        return instance
end

function Route:run(router)

        local url = req.cmd_url
        local method = req.cmd_meth

        if method == "POST" then
                for k,v in pairs(router.map.post) do
                        lp(router.map.post[k][1])
                        lp(router.map.post[k][2])
                        if router.map.post[k][1] == url then
                                return router.map.post[k][2]
                        end
                end
        end

        if method == "GET" then
                for k,v in pairs(router.map.get) do
                        lp(router.map.get[k][1])
                        lp(router.map.get[k][2])
                        local match = string.find(url, router.map.get[k][1])
                        --if router.map.get[k][1] == url then
                        if match then
                                return router.map.get[k][2]
                        end
                end
        end

end


return Route
