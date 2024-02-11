--!strict
--!native
--!optimize 2

local types = require("../types")

return function(root: types.ClassWrapper)
  table.insert(root.metamethods["__index"], function(_, k)
    if type(k) ~= "string" then
      return false
    end

    local class = root.class
    local source = debug.info(3, "s")
    local isPrivate = source == root.fileDef

    local methods = class.methods
    local privateMethod = methods.private[k]

    if privateMethod and isPrivate then
      return true, privateMethod
    end

    local publicMethod = methods.public[k]

    if publicMethod then
      return true, publicMethod
    end

    return false
  end)
end :: types.AddHooks
