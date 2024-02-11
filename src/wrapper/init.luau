--!strict
--!native
--!optimize 2

local types = require("../types")
local setupMetatable = require("metatable")

local ClassWrapper = {}

function ClassWrapper.new(target: any, class: types.Class)
  local root = {
    __wrapper = true,
    target = target,
    metamethods = {},
  } :: types.ClassWrapper

  local proxy = newproxy(true)
  local metatable = getmetatable(proxy)

  root.class = class
  root.metatable = metatable
  root.handle = proxy

  setupMetatable(root)

  return proxy
end

table.freeze(ClassWrapper)
return ClassWrapper
