local tinsert = table.insert
local req = require "nginx"
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
                --local log = {type = 1, this=this, baseA=baseA, baseB=baseB, url=url, callback=callback, meta=meta}

                --get
                if meta == "GET" then
                        tinsert(this.map.get, {url, callback})
                elseif meta == "POST" then
                        tinsert(this.map.post, {url, callback})
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
        --local req_url = ngx.unescape_uri(request_uri)
        local url = req.cmd_url()
        local method = req.cmd_meth()

	ngx.say(req.cmd_url())
	ngx.say(req.cmd_meth())

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

        --return router.map
        le('route.run')
end

function Route:match()
        return true
end

return Route
