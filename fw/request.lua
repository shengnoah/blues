local params = require "nginx"
local Request = {}

function Request:getInstance()

        local name = "request"
        local instance = {
                            getName = function() end
                        }

        instance.params = params
        setmetatable(instance, { __index = self,
                                 __call = function()
                                        end
                                 })
        return instance
end

return Request
