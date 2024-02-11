--!strict
--!native
--!optimize 2

local types = require("../types")

return function(root: types.ClassWrapper)
  table.insert(root.metamethods["__index"], function(_, k)
    local class = root.class
    local source = debug.info(3, "s")
    local isPrivate = source == root.fileDef

    local keyType = typeof(k)

    local indexers = class.indexers
    local private = indexers.private
    local privateHandler = private.get[keyType]

    if privateHandler and isPrivate then
      return true, privateHandler(root.handle)
    end

    local public = indexers.public
    local publicHandler = public.get[keyType]

    if publicHandler then
      return true, publicHandler(root.handle)
    end

    return false
  end)

  table.insert(root.metamethods["__newindex"], function(_, k, v)
    local class = root.class
    local source = debug.info(3, "s")
    local isPrivate = source == root.fileDef

    local keyType = typeof(k)

    local indexers = class.indexers
    local private = indexers.private
    local privateHandler = private.set[keyType]

    if privateHandler and isPrivate then
      return true, privateHandler(root.handle, v)
    end

    local public = indexers.public
    local publicHandler = public.set[keyType]

    if publicHandler then
      return true, publicHandler(root.handle)
    end

    return false
  end)
end :: types.AddHooks
