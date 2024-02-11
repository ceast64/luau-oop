--!strict
--!native
--!optimize 2

local types = require("types")
local wrapper = require("wrapper")
local hooks = require("hooks")
local helper = require("helper")
local object = require("object")

local OOP = {}

export type ClassWrapper = types.ClassWrapper
export type Class = types.Class
export type ClassHelper = types.ClassHelper
export type ClassRoot = types.ClassRoot

local classes = {} :: { [string]: types.ClassRoot }

local function deepClone(tab: any): any
  local new = {}

  for key, val in pairs(tab) do
    new[key] = if typeof(val) == "table" then deepClone(val) else val
  end

  return new :: any
end

function OOP.register(class: types.Class, defOverride: string?): types.ClassRoot
  assert(classes[class.name] == nil, `Class {class.name} already registered!`)

  local fileDef = defOverride or debug.info(2, "s")

  local root = {
    class = class,
  }

  function root.new(...: any): any
    local stateCopy = table.clone(class.state)

    local instance = wrapper.new(stateCopy, class)
    local root = getmetatable(instance) :: types.ClassWrapper

    root.fileDef = fileDef

    for _, addHooks in ipairs(hooks) do
      addHooks(root)
    end

    class.constructor(instance, ...)
    return instance
  end

  function root.extend(name: string): types.Class
    assert(not class.sealed, `Class {class.name} is sealed!`)

    local newClass = deepClone(class) :: types.Class
    newClass.base = class
    newClass.name = name

    return newClass
  end

  for key, val in pairs(class.static) do
    assert(root[key] == nil, `Key {key} already exists in root!`)
    root[key] = val
  end

  classes[class.name] = root
  table.freeze(root)
  return root
end

function OOP.getWrapper(obj: any): ClassRoot?
  if obj.__wrapper then
    return getmetatable(obj)
  end

  return
end

function OOP.helper(class: Class): ClassHelper
  return helper.new(class)
end

OOP.Object = OOP.register(object.class, object.fileDef)

table.freeze(OOP)
return OOP
