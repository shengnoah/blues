local params = require "nginx"
local Request = {}

function Request:init()
end

function Request:getInstance()

        local name = "request"
        local instance = {
                        url="/request",
                        getName = function()
                                lp("CRequest!")
                        end
                        }

        instance.uri = "candy lab"
        instance.params = params
        setmetatable(instance, { __index = self,
                                 __call = function()
                                                lp("Initial Instance")
                                        end
                                 })
        return instance
end

function Request:run()
end

return Request
