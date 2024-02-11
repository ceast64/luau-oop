--!strict
--!native
--!optimize 2

local types = require("../types")

local overloads = {
  "concat",
  "add",
  "sub",
  "mul",
  "div",
  "idiv",
  "mod",
  "pow",
  "unm",
  "eq",
  "lt",
  "le",
  "len",
}

return function(root: types.ClassWrapper)
  for _, operation in ipairs(overloads) do
    local metamethod = `__{operation}`

    table.insert(root.metamethods[metamethod], function(t, v)
      local class = root.class
      local overload = class.operators[operation]

      if overload == nil then
        return false
      end

      local val = overload(root.handle, v)

      if val == nil then
        return false
      end

      return true, val
    end)
  end
end :: types.AddHooks
