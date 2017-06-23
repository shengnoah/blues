local Route = require("route")
local Request = require("request")

local Application = {}

function Application:init(this, req, res)
end

function Application:new()
        local base = {}
        base.id = 1123

        function base.init(this, req, res)
        end

        local app = {}
        app.id = 123
        app.router = Route:getInstance()
        app.req = Request:getInstance()
        app.get = function(this, url, callback)
                app:router(this, url, callback, "GET")
        end

        app.post = function(this, url, callback)
                app:router(this, url, callback, "POST")
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


        base.__call = base.init

        setmetatable(app, base)
        return app
end

function Application:get1(url, callback)
        app.router(url, callback)
end


function Application:run()
        fun = Route:run(app.router)
        local ret = fun(app.req, app.id)
end


return Application
