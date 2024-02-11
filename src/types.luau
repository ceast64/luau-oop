--!strict
--!native
--!optimize 2

export type ClassWrapper = {
  __wrapper: boolean,
  fileDef: string,
  class: Class,
  handle: any,
  target: any,
  metatable: { [any]: any },
  metamethods: { [string]: { (...any?) -> (boolean, ...any?) } },
}

export type AddHooks = (root: ClassWrapper) -> ()

export type Constructor = (self: any, ...any) -> ()

export type Method = (self: any, ...any) -> ...any?

export type PropertyGetCallback = (self: any) -> any
export type PropertySetCallback = (self: any, val: any) -> ()

export type IndexerGetCallback = (self: any, idx: any) -> ...any
export type IndexerSetCallback = (self: any, idx: any, val: any) -> ()

export type ToString = string | (self: any) -> string

export type BinaryOperator = (self: any, rhs: any) -> any?
export type UnaryOperator = (self: any) -> any?

export type Class = {
  base: Class?,
  name: string,
  sealed: boolean,
  constructor: Constructor,
  methods: {
    public: { [string]: Method },
    private: { [string]: Method },
  },
  indexers: {
    public: {
      get: { [string]: IndexerGetCallback },
      set: { [string]: IndexerSetCallback },
    },
    private: {
      get: { [string]: IndexerGetCallback },
      set: { [string]: IndexerSetCallback },
    },
  },
  properties: {
    public: {
      get: { [any]: PropertyGetCallback },
      set: { [any]: PropertySetCallback },
    },
    private: {
      get: { [any]: PropertyGetCallback },
      set: { [any]: PropertySetCallback },
    },
  },
  operators: {
    concat: BinaryOperator?,
    add: BinaryOperator?,
    sub: BinaryOperator?,
    mul: BinaryOperator?,
    div: BinaryOperator?,
    idiv: BinaryOperator?,
    mod: BinaryOperator?,
    pow: BinaryOperator?,
    eq: BinaryOperator?,
    lt: BinaryOperator?,
    le: BinaryOperator?,
    unm: UnaryOperator?,
    len: UnaryOperator?,
  },
  state: { [any]: any },
  tostring: ToString,
  static: { [any]: any },
}

export type BinaryOperatorType = "concat" | "add" | "sub" | "mul" | "div" | "idiv" | "mod" | "pow" | "eq" | "lt" | "le"

export type UnaryOperatorType = "unm" | "len"

export type ClassHelper = {
  class: Class,
  state: { [any]: any },
  static: { [any]: any },

  constructor: (self: ClassHelper, constructor: Constructor) -> (),
  publicReadOnly: (self: ClassHelper, k: any) -> (),
  privateReadOnly: (self: ClassHelper, k: any) -> (),
  publicMethod: (self: ClassHelper, name: string, method: Method) -> (),
  privateMethod: (self: ClassHelper, name: string, method: Method) -> (),
  publicGet: (self: ClassHelper, k: string, callback: PropertyGetCallback) -> (),
  privateGet: (self: ClassHelper, k: string, callback: PropertyGetCallback) -> (),
  publicSet: (self: ClassHelper, k: string, callback: PropertySetCallback) -> (),
  privateSet: (self: ClassHelper, k: string, callback: PropertySetCallback) -> (),
  publicIndexerGet: (self: ClassHelper, type: string, callback: IndexerGetCallback) -> (),
  privateIndexerGet: (self: ClassHelper, type: string, callback: IndexerGetCallback) -> (),
  publicIndexerSet: (self: ClassHelper, type: string, callback: IndexerSetCallback) -> (),
  privateIndexerSet: (self: ClassHelper, type: string, callback: IndexerSetCallback) -> (),
  binaryOperator: (self: ClassHelper, type: BinaryOperatorType, handler: BinaryOperator) -> (),
  unaryOperator: (self: ClassHelper, type: BinaryOperatorType, handler: UnaryOperator) -> (),
}

export type ClassRoot = {
  class: Class,
  new: (...any) -> any,
  extend: (name: string) -> Class,

  [any]: any,
}

return {}
