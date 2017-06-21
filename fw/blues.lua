local Route = require("proute")
local Request = require("request")

local Blues = {}

Blues.blues_id = 1

function Blues.new(self, lib)

        local app = {}
        app.app_id = 1
        app.router = Route:getInstance()
        app.req = Request:getInstance()

        app.get = function(self, url, callback)
                app:router(url, callback, "GET")
        end

        app.post = function(self, url, callback)
                app:router(url, callback, "POST")
        end

        app.run = function(self)
                fun = Route:run(app.router)
                if fun then
                    --local ret = fun(this, app.req)
                    local ret = fun(app)
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

        return app
end

return Blues:new {
    pipeline='Pipeline System.'
}
