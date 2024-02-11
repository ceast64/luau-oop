--!strict
--!native
--!optimize 2

local types = require("../types")

return function(root: types.ClassWrapper)
  table.insert(root.metamethods["__tostring"], function(val)
    local class = root.class
    local str = if type(class.tostring) == "string" then class.tostring else class.tostring(root.handle)
    return true, str
  end)
end :: types.AddHooks
