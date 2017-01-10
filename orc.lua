local Route = require("route")
local Request = require("request")

local Application = {}

function Application:init(this, req, res)
end

function Application:new()
        local base = {}
        base.id = 1123

        function base.init(this, req, res)
                lp("init")
                lp(base.id)
        end

        local app = {}
        app.id = 123
        app.router = Route:getInstance()
        app.req = Request:getInstance()
        app.get = function(this, url, callback)
                ls('app:get')
                lp(type(this))
                ll()
                for k,v in pairs(this) do
                        lp(k,v)
                end
                lp("-----------------")
                lp(type(url))
                lp(url)
                lp("-----------------")
                lp(type(callback))
                --callback()
                lp("-----------------")
                app:router(this, url, callback, "GET")
                le('app:get')
        end

        app.post = function(this, url, callback)
                ls('app.post')
                app:router(this, url, callback, "POST")
                le('app.post')
        end

        app.run = function()
                fun = Route:run(app.router)
                ls('app.run')
                fun(app.req, app.id)
                le('app.run')
        end


        base.__call = base.init

        setmetatable(app, base)

        return app
end

function Application:get1(url, callback)
        app.router(url, callback)
end

function Application:doEvent()
        lp("doEvent")
        app.router("one", function()
                lp("test1")
        end)
        app.router("two", function()
                lp("test2")
        end)
        app.router("three", function()
                lp("test3")
        end)
        Route:run(app.router)
end

function Application:run()
        fun = Route:run(app.router)
        lp("@@@@@ Application:run(start)@@@@@@@")
        fun(app.req, app.id)
        lp("@@@@@ Applicaiton:run( end )@@@@@@@")
end

function Application:fin()
end

return Application
