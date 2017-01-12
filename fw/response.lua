local Template = require("template")

local Response = {}

function Response:render(style, file, param)
    Template:render("/index.html", "list")
end

Response:render("html", "index.html", "string")

return Response
