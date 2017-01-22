require "log"
local Application = require "orc"
app = Application.new()

app:get("/testcase", function(request,id)
        lp("testcase")
end)

return app.run()
