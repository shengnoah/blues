local Blues = {}

Blues.blues_id = 1

function Blues.new(self, lib)

        local app = {}
        app.app_id = 1

        app.bjson = lib.bjson
        app.request = lib.request
        app.router = lib.router
        app.router.req = lib.nginx:build_request("") 

        app.get = function(self, url, callback)
            app:router(url, callback, "GET")
        end

        app.post = function(self, url, callback)
            app:router(url, callback, "POST")
        end

        app.run = function(self)
            fun = app.router:finder()
            if fun then
                local content = fun(app)
                app:render(content)
            end
        end

        app.render= function(self, content)
            local rtype = type(content)
            if rtype == "table"  then
                 json = require "cjson"
                 ngx.header['Content-Type'] = 'application/json; charset=utf-8'
                 ngx.say(json.encode(content))
            end
            if rtype == "string"  then
                ngx.header['Content-Type'] = 'text/plain; charset=UTF-8'
                ngx.say(content)
            end
        end

        app.json = function(self)
            local jsondata= self.request.params.body
            local t = self.bjson.decode(jsondata)
            return t    
        end

        return app
end


return Blues:new  {
    nginx = require("nginx"),
    bjson = require("utils.bjson"),
    request = require("request"):getInstance(),
    router = require("route"):getInstance()
}
