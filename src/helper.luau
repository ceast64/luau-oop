--!strict
--!optimize 2
--!native

local types = require("types")

local helper = {}
local helperPrototype = {}
helperPrototype.__index = helperPrototype

function helperPrototype.constructor(self: types.ClassHelper, constructor: types.Constructor)
  self.class.constructor = constructor
end

function helperPrototype.publicReadOnly(self: types.ClassHelper, k: any)
  self.class.properties.public.set[k] = function()
    error(`{k} is read-only`)
  end
end

function helperPrototype.privateReadOnly(self: types.ClassHelper, k: any)
  self.class.properties.private.set[k] = function()
    error(`{k} is read-only`)
  end
end

function helperPrototype.publicMethod(self: types.ClassHelper, name: string, method: types.Method)
  self.class.methods.public[name] = method
end

function helperPrototype.privateMethod(self: types.ClassHelper, name: string, method: types.Method)
  self.class.methods.private[name] = method
end

function helperPrototype.publicGet(self: types.ClassHelper, k: string, callback: types.PropertyGetCallback)
  self.class.properties.public.get[k] = callback
end

function helperPrototype.privateGet(self: types.ClassHelper, k: string, callback: types.PropertyGetCallback)
  self.class.properties.private.get[k] = callback
end

function helperPrototype.publicSet(self: types.ClassHelper, k: string, callback: types.PropertySetCallback)
  self.class.properties.public.set[k] = callback
end

function helperPrototype.privateSet(self: types.ClassHelper, k: string, callback: types.PropertySetCallback)
  self.class.properties.private.set[k] = callback
end

function helperPrototype.publicIndexerGet(self: types.ClassHelper, type: string, callback: types.IndexerGetCallback)
  self.class.indexers.public.get[type] = callback
end

function helperPrototype.privateIndexerGet(self: types.ClassHelper, type: string, callback: types.IndexerGetCallback)
  self.class.indexers.private.get[type] = callback
end

function helperPrototype.publicIndexerSet(self: types.ClassHelper, type: string, callback: types.IndexerSetCallback)
  self.class.indexers.public.set[type] = callback
end

function helperPrototype.privateIndexerSet(self: types.ClassHelper, type: string, callback: types.IndexerSetCallback)
  self.class.indexers.private.set[type] = callback
end

function helperPrototype.binaryOperator(self: types.ClassHelper, type: types.BinaryOperatorType, handler: types.BinaryOperator)
  self.class.operators[type] = handler
end

function helperPrototype.unaryOperator(self: types.ClassHelper, type: types.BinaryOperatorType, handler: types.UnaryOperator)
  self.class.operators[type] = handler
end

function helper.new(class: types.Class): types.ClassHelper
  local self = {
    class = class,
    state = class.state,
    static = class.static
  }

  return setmetatable(self :: any, helperPrototype)
end

table.freeze(helper)
return helper
