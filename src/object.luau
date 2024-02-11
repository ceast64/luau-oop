--!strict
--!native
--!optimize 2

local types = require("types")

local Object = {
  name = "Object",
  constructor = function() end,
  methods = {
    public = {},
    private = {},
  },
  indexers = {
    public = {
      get = {},
      set = {},
    },
    private = {
      get = {},
      set = {},
    },
  },
  properties = {
    public = {
      get = {},
      set = {},
    },
    private = {
      get = {},
      set = {},
    },
  },
  operators = {},
  state = {},
} :: types.Class

function Object.tostring(self: any): string
  local root = getmetatable(self) :: types.ClassWrapper
  return root.class.name
end

table.freeze(Object)
return {
  class = Object,
  fileDef = debug.info(1, "s"),
}
