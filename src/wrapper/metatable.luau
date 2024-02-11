--!strict
--!optimize 2
--!native

local types = require("../types")

return function(proxy: types.ClassWrapper)
  local metatable = proxy.metatable
  local metamethods = proxy.metamethods

  metamethods["__index"] = {}
  function metatable.__index(t, k)
    local handlers = proxy.metamethods["__index"]

    for _, handler in ipairs(handlers) do
      local did, val = handler(t, k)

      if did then
        return val
      end
    end

    return proxy.target[k]
  end

  metamethods["__newindex"] = {}
  function metatable.__newindex(t, k, v)
    local handlers = proxy.metamethods["__newindex"]

    for _, handler in ipairs(handlers) do
      local did = handler(t, k, v)

      if did then
        return
      end
    end

    proxy.target[k] = v
  end

  metamethods["__call"] = {}
  function metatable.__call(t, ...)
    local handlers = proxy.metamethods["__call"]

    for _, handler in ipairs(handlers) do
      local res = table.pack(handler(t, ...))

      if res[1] then
        return if res.n > 1 then table.unpack(res, 2) else nil
      end
    end

    return proxy.target(...)
  end

  metamethods["__concat"] = {}
  function metatable.__concat(t, v)
    local handlers = proxy.metamethods["__concat"]

    for _, handler in ipairs(handlers) do
      local did, val = handler(t, v)

      if did then
        return val
      end
    end

    return proxy.target .. v
  end

  metamethods["__unm"] = {}
  function metatable.__unm(t)
    local handlers = proxy.metamethods["__unm"]

    for _, handler in ipairs(handlers) do
      local did, val = handler(t)

      if did then
        return val
      end
    end

    return -proxy.target
  end

  metamethods["__add"] = {}
  function metatable.__add(t, v)
    local handlers = proxy.metamethods["__add"]

    for _, handler in ipairs(handlers) do
      local did, val = handler(t, v)

      if did then
        return val
      end
    end

    return proxy.target + v
  end

  metamethods["__sub"] = {}
  function metatable.__sub(t, v)
    local handlers = proxy.metamethods["__sub"]

    for _, handler in ipairs(handlers) do
      local did, val = handler(t, v)

      if did then
        return val
      end
    end

    return proxy.target - v
  end

  metamethods["__mul"] = {}
  function metatable.__mul(t, v)
    local handlers = proxy.metamethods["__mul"]

    for _, handler in ipairs(handlers) do
      local did, val = handler(t, v)

      if did then
        return val
      end
    end

    return proxy.target * v
  end

  metamethods["__div"] = {}
  function metatable.__div(t, v)
    local handlers = proxy.metamethods["__div"]

    for _, handler in ipairs(handlers) do
      local did, val = handler(t, v)

      if did then
        return val
      end
    end

    return proxy.target / v
  end

  metamethods["__idiv"] = {}
  function metatable.__idiv(t, v)
    local handlers = proxy.metamethods["__idiv"]

    for _, handler in ipairs(handlers) do
      local did, val = handler(t, v)

      if did then
        return val
      end
    end

    return proxy.target // v
  end

  metamethods["__mod"] = {}
  function metatable.__mod(t, v)
    local handlers = proxy.metamethods["__mod"]

    for _, handler in ipairs(handlers) do
      local did, val = handler(t, v)

      if did then
        return val
      end
    end

    return proxy.target % v
  end

  metamethods["__pow"] = {}
  function metatable.__pow(t, v)
    local handlers = proxy.metamethods["__pow"]

    for _, handler in ipairs(handlers) do
      local did, val = handler(t, v)

      if did then
        return val
      end
    end

    return proxy.target ^ v
  end

  metamethods["__tostring"] = {}
  function metatable.__tostring(t)
    local handlers = proxy.metamethods["__tostring"]

    for _, handler in ipairs(handlers) do
      local did, val = handler()

      if did then
        return val
      end
    end

    return tostring(proxy.target)
  end

  metatable.__metatable = proxy

  metamethods["__eq"] = {}
  function metatable.__eq(t, v)
    local handlers = proxy.metamethods["__eq"]

    for _, handler in ipairs(handlers) do
      local did, val = handler(t, v)

      if did then
        return val
      end
    end

    return proxy.target == v
  end

  metamethods["__lt"] = {}
  function metatable.__lt(t, v)
    local handlers = proxy.metamethods["__lt"]

    for _, handler in ipairs(handlers) do
      local did, val = handler(t, v)

      if did then
        return val
      end
    end

    return proxy.target < v
  end

  metamethods["__le"] = {}
  function metatable.__le(t, v)
    local handlers = proxy.metamethods["__le"]

    for _, handler in ipairs(handlers) do
      local did, val = handler(t, v)

      if did then
        return val
      end
    end

    return proxy.target <= v
  end

  metamethods["__len"] = {}
  function metatable.__len(t)
    local handlers = proxy.metamethods["__len"]

    for _, handler in ipairs(handlers) do
      local did, val = handler(t)

      if did then
        return val
      end
    end

    return #proxy.target
  end

  metamethods["__iter"] = {}
  function metatable.__iter(t)
    local handlers = proxy.metamethods["__iter"]

    for _, handler in ipairs(handlers) do
      local res = table.pack(handler(t))

      if res[1] then
        return if res.n > 1 then table.unpack(res, 2) else nil
      end
    end

    return pairs(t)
  end
end
