--!strict
--!native
--!optimize 2

local types = require("../types")

-- the order of the requires determines the order hooks are executed in
return {
  require("methods"),
  require("properties"),
  require("indexers"),

  require("tostring"),
  require("operators"),
} :: { types.AddHooks }
