--!strict
--!native
--!optimize 2

local types = require("../types")

return function(root: types.ClassWrapper)
  table.insert(root.metamethods["__index"], function(_, k)
    local class = root.class
    local source = debug.info(3, "s")
    local isPrivate = source == root.fileDef

    local properties = class.properties
    local private = properties.private
    local privateHandler = private.get[k]

    if privateHandler and isPrivate then
      return true, privateHandler(root.handle)
    end

    local public = properties.public
    local publicHandler = public.get[k]

    if publicHandler then
      return true, publicHandler(root.handle)
    end

    return false
  end)

  table.insert(root.metamethods["__newindex"], function(_, k, v)
    local class = root.class
    local source = debug.info(3, "s")
    local isPrivate = source == root.fileDef

    local properties = class.properties
    local private = properties.private
    local privateHandler = private.set[k]

    if privateHandler and isPrivate then
      return true, privateHandler(root.handle, v)
    end

    local public = properties.public
    local publicHandler = public.set[k]

    if publicHandler then
      return true, publicHandler(root.handle)
    end

    return false
  end)
end :: types.AddHooks
