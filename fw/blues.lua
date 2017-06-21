local Route = require("proute")
local Request = require("request")

local Application = {}

function Application.new()
        --local base = {}
        --base.id = 1123

        --function base.init(this, req, res)
        --    ngx.say("base.init")
        --end

        local app = {}
        app.baseid = 123456
        app.router = Route:getInstance()
        app.req = Request:getInstance()

        app.get = function(self, url, callback)
                app:router(url, callback, "GET")
        end

        app.post = function(self, url, callback)
                app:router(url, callback, "POST")
        end

        app.run = function()
                fun = Route:run(app.router)
                if fun then
                    local ret = fun(app.req, app.id)
                    local rtype = type(ret)
                    if rtype == "table"  then
                        json = require "cjson"
                        ngx.header['Content-Type'] = 'application/json; charset=utf-8'
                        ngx.say(json.encode(ret))
                    end
                    if rtype == "string"  then
                        ngx.header['Content-Type'] = 'text/plain; charset=UTF-8'
                        ngx.say(ret)
                    end
                end
        end

        --base.__call = base.init
        --setmetatable(app, base)
        return app
end

function Application.run()
        fun = Route:run(app.router)
        local ret = fun(app.req, app.id)
end

return Application
