require "log"
local Application = require "orc"
app = Application.new()

for k,v in pairs(app) do
        lp(k,v)
end

--[[
app:get("/testcase", function(request,id)
        lp("testcase")
end)
--]]
app:get("/def", function(request,id)
        ls("app.app:get")
        --print(debug.getinfo(1)['name'])
        lp("test def")
        le("app.app:get")
end)

--[[
app:post("/post", function(request,id)
        lp("test post")
end)

app:post("/post1", function(request,id)
        lp("test post1")
end)

--]]

--[[
Application:get1("/testcaseA", function(request,id)
        lp("A")
        lp(request["url"])
end)
--]]


--Application:run() 
return app.run()
