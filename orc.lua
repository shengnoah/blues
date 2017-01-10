local Route = require("route")
local Request = require("request")

local Application = {}

function Application:init(this, req, res)
end

function Application:new()
        local base = {}
        base.id = 1123

        function base.init(this, req, res)
                print("init")
                print(base.id)
        end

        local app = {}
        app.id = 123
        app.router = Route:getInstance()
        app.req = Request:getInstance()
        app.get = function(this, url, callback)
                print("########## app:get (start)############")
                print(type(this))
                print("-----------------")
                for k,v in pairs(this) do
                        print(k,v)
                end
                print("-----------------")
                print(type(url))
                print(url)
                print("-----------------")
                print(type(callback))
                --callback()
                print("-----------------")
                app:router(this, url, callback, "GET")
                print("########## app:get ( end )###########")
        end

        app.post = function(this, url, callback)
                print("############[ app.post ]###############")
                app:router(this, url, callback, "POST")
        end

        app.run = function()
                fun = Route:run(app.router)
                print("@@@@@app.run( start )@@@@@@@")
                fun(app.req, app.id)
                print("@@@@@app.run(  end   )@@@@@@@")
        end


        base.__call = base.init

        setmetatable(app, base)

        return app
end

function Application:get1(url, callback)
        app.router(url, callback)
end

function Application:doEvent()
        print("doEvent")
        app.router("one", function()
                print("test1")
        end)
        app.router("two", function()
                print("test2")
        end)
        app.router("three", function()
                print("test3")
        end)
        Route:run(app.router)
end

function Application:run()
        fun = Route:run(app.router)
        print("@@@@@ Application:run(start)@@@@@@@")
        fun(app.req, app.id)
        print("@@@@@ Applicaiton:run( end )@@@@@@@")
end

function Application:fin()
end

return Application
