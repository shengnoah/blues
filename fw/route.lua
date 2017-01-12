local tinsert = table.insert
local Route =  {}

function Route:Init()
        ls('route.Init')
        le('route.Init')
end

function Route:getInstance()
        ls('route.getInstance')
        local instance = {}
        instance.map = {
            get = {},   --get
            post = {}   --post
        }

        instance.id = 1

        local base = {}
        function base.register(this, baseA, baseB, url, callback, meta)
                ls('route.base.register')
                ll('meta')
                lp(meta)
                ll('callback')
                lp(callback)
                ll('this type')
                lp(type(this))
                ll('this')
                for k,v  in pairs(this) do
                        lp(k,v)
                end
                ll('baseA type')
                lp(type(baseA))
                ll('baseA')
                for k,v  in pairs(baseA) do
                        lp(k,v)
                end
                ll('baseB type')
                lp(type(baseB))
                ll('baseB')
                for k,v  in pairs(baseB) do
                        lp(k,v)
                end
                ll()
                --get
                if meta == "GET" then
                        tinsert(this.map.get, {url, callback})
                elseif meta == "POST" then
                        tinsert(this.map.post, {url, callback})
                end

                ll('MAP.GET')
                for k, v in pairs(this.map.get) do 
                    for key,var in pairs(v) do
                        lm(key,var)
                    end
                end
                ll('MAP.POST')
                for k, v in pairs(this.map.post) do 
                    for key,var in pairs(v) do
                        lm(key,var)
                    end
                end

                le('route.base.register')
        end

        base.__call = base.register
        setmetatable(instance, base)
        le('route.getInstance')
        return instance
end

function Route:run(router)
        ls('route.run')
        ll('MAP.GET')
        for k, v in pairs(router.map.get) do 
            for key,var in pairs(v) do
                lm(key,var)
            end
        end
        ll('MAP.POST')
        for k, v in pairs(router.map.post) do 
            for key,var in pairs(v) do
                lm(key,var)
            end
         end

        ll('router')
        for k,v in ipairs(router) do
            lp(k,v)
        end

        local url = "/log"
        local method = "POST"

        if method == "POST" then
                for k,v in pairs(router.map.post) do
                        lp(router.map.post[k][1])
                        lp(router.map.post[k][2])
                        if router.map.post[k][1] == url then
                                le('route.run.POST')
                                return router.map.post[k][2]
                        end
                end
        end

        if method == "GET" then
                for k,v in pairs(router.map.get) do
                        lp(router.map.get[k][1])
                        lp(router.map.get[k][2])
                        if router.map.get[k][1] == url then
                                le('route.run.GET')
                                return router.map.get[k][2]
                        end
                end
        end

--[[
        if method == "get" then
                return router.map.get[1][2]
        elseif method == "post" then
                return router.map.post[1][2]
        end
--]]
        --return router.map
        le('route.run')
end

function Route:match()
        return true
end

return Route
