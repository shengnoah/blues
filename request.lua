local Request = {}

function Request:init()
end

function Request:getInstance()

        local name = "request"
        local instance = {
                        url="/request",
                        getName = function()
                                logp("CRequest!")
                        end
                        }

        instance.uri = "candy lab"
        setmetatable(instance, { __index = self,
                                 __call = function()
                                                logp("Initial Instance")
                                        end
                                 })
        return instance
end

function Request:run()
end

return Request
