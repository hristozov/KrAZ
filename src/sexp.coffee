exports.Atom =
  class Atom
    constructor: (@content) ->

exports.Sexp =
  class Sexp
    constructor: (@children) ->
    length: ->
      @children.length
    functional: (idx) -> return @children[0]
    argAt: (idx) -> return @children[idx + 1]

exports.FunctionDefinition =
  class FunctionDefinition extends Sexp

exports.ExplicitFunctionDef =
  class ExplicitFunctionDef extends FunctionDefinition
    constructor: (@signature, @body) ->

exports.Lambda =
  class Lambda extends FunctionDefinition
    constructor: (@signature, @body) ->

exports.BooleanAtom =
  class BooleanAtom extends Atom
    constructor: (content) ->
      super(content)

exports.BooleanFalse =
  class BooleanFalse extends BooleanAtom
    constructor: ->
      super(false)

exports.BooleanTrue =
  class BooleanTrue extends BooleanAtom
    constructor: ->
      super(true)

exports.Integral =
  class Integral extends Atom
    constructor: (content) ->
      super(content)
