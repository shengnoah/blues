local Route = require("route")
local Request = require("request")

local Application = {}

function Application:init(this, req, res)
        ls('Application:init')
        le('Application:init')
end

function Application:new()
        ls('Application.new')
        local base = {}
        base.id = 1123

        function base.init(this, req, res)
        ls('Application.base.init')
                lp("base:init")
                lp(base.id)
        le('Application.base.init')
        end

        local app = {}
        app.id = 123
        app.router = Route:getInstance()
        app.req = Request:getInstance()
        app.get = function(this, url, callback)
                ls('Application.app.get')
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
                le('Application.app.get')
        end

        app.post = function(this, url, callback)
                ls('Application.app.post')
                app:router(this, url, callback, "POST")
                le('Application.app.post')
        end

        app.run = function()
                ls('Application.app.run')
                fun = Route:run(app.router)
                fun(app.req, app.id)
                le('Application.app.run')
        end


        base.__call = base.init

        setmetatable(app, base)

        le('Application:new')
        return app
end

function Application:get1(url, callback)
        ls('Application:get1')
        app.router(url, callback)
        le('Application:get1')
end

function Application:doEvent()
        ls('Application:doEvent')
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
        le('Application:doEvent')
end

function Application:run()
        ls('Application:run')
        fun = Route:run(app.router)
        fun(app.req, app.id)
        le('Application:run')
end

function Application:fin()
end

return Application
