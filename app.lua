require "log"
local Application = require "orc"
app = Application.new()

for k,v in pairs(app) do
        logp(k,v)
end

app:get("/testcase", function(request,id)
        logp("testcase")
end)


app:get("/def", function(request,id)
        logp("test def")
end)

app:post("/post", function(request,id)
        logp("test post")
end)

app:post("/post1", function(request,id)
        logp("test post1")
end)

--[[
Application:get1("/testcaseA", function(request,id)
        logp("A")
        logp(request["url"])
end)
--]]


--Application:run() 
return app.run()
