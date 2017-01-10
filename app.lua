local Application = require "orc"
app = Application.new()

for k,v in pairs(app) do
        print(k,v)
end

app:get("/testcase", function(request,id)
        print("testcase")
end)


app:get("/def", function(request,id)
        print("test def")
end)

app:post("/post", function(request,id)
        print("test post")
end)

app:post("/post1", function(request,id)
        print("test post1")
end)

--[[
Application:get1("/testcaseA", function(request,id)
        print("A")
        print(request["url"])
end)
--]]


--Application:run() 
return app.run()
