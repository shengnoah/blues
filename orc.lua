local Route = require("route")
local Request = require("request")

local Application = {}

function Application:init(this, req, res)
end

function Application:new()
        local base = {}
        base.id = 1123

        function base.init(this, req, res)
                logp("init")
                logp(base.id)
        end

        local app = {}
        app.id = 123
        app.router = Route:getInstance()
        app.req = Request:getInstance()
        app.get = function(this, url, callback)
                logp("########## app:get (start)############")
                logp(type(this))
                logp("-----------------")
                for k,v in pairs(this) do
                        logp(k,v)
                end
                logp("-----------------")
                logp(type(url))
                logp(url)
                logp("-----------------")
                logp(type(callback))
                --callback()
                logp("-----------------")
                app:router(this, url, callback, "GET")
                logp("########## app:get ( end )###########")
        end

        app.post = function(this, url, callback)
                logp("############[ app.post ]###############")
                app:router(this, url, callback, "POST")
        end

        app.run = function()
                fun = Route:run(app.router)
                logp("@@@@@app.run( start )@@@@@@@")
                fun(app.req, app.id)
                logp("@@@@@app.run(  end   )@@@@@@@")
        end


        base.__call = base.init

        setmetatable(app, base)

        return app
end

function Application:get1(url, callback)
        app.router(url, callback)
end

function Application:doEvent()
        logp("doEvent")
        app.router("one", function()
                logp("test1")
        end)
        app.router("two", function()
                logp("test2")
        end)
        app.router("three", function()
                logp("test3")
        end)
        Route:run(app.router)
end

function Application:run()
        fun = Route:run(app.router)
        logp("@@@@@ Application:run(start)@@@@@@@")
        fun(app.req, app.id)
        logp("@@@@@ Applicaiton:run( end )@@@@@@@")
end

function Application:fin()
end

return Application
