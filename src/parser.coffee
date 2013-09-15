{Sexp, Atom, Integral, BooleanFalse, BooleanTrue, ExplicitFunctionDef, Lambda} = require './sexp'
PEG = require "pegjs";

# XXX: Separate the grammar.
# //"(define signature:sexp body:sexp ")"
grammar = 'start = sexp+
sexp =
  /* XXX: DOES NOT CONFORM TO STANDARD! */
  "(define" " " signature:sexp " " body:sexp ")" { return get_define_explicit(signature, body) }
  / "(lambda" " " signature:sexp " " body:sexp ")" { return get_lambda(signature, body) }
  / "(" functional:sexp args:(" " sexp)*")" { return get_sexp([functional].concat(args.map(function(arr){return arr[1]}))) }
  / atom1:atom { return atom1 }
atom =
  chars:("-" ? integral_character+) { return get_integral(parseInt(chars.join(""))) }
  / boolean_false { return get_boolean_false() }
  / boolean_true { return get_boolean_true() }
  / chars:(atom_character+) { return get_atomic(chars.join("")) }
integral_character =
  [0-9]
boolean_false =
  "#" "f"
boolean_true =
  "#" "t"
atom_character =
  integral_character / [A-Z] / [a-z] / ["+""-""*""/"]'

exports.Parser =
class Parser
  parse: (content) ->
    GLOBAL.get_atomic = (x) ->
      new Atom x

    GLOBAL.get_sexp = (x) ->
      new Sexp x

    GLOBAL.get_integral = (x) ->
      new Integral x

    GLOBAL.get_boolean_true = ->
      new BooleanTrue

    GLOBAL.get_boolean_false = ->
      new BooleanFalse

    GLOBAL.get_define_explicit = (signature, body) ->
      new ExplicitFunctionDef(signature, body)

    GLOBAL.get_lambda = (signature, body) ->
      new Lambda(signature, body)


    parser = PEG.buildParser grammar
    sexps = parser.parse content

    delete GLOBAL["get_atomic"]
    delete GLOBAL["get_sexp"]
    delete GLOBAL["get_integral"]
    delete GLOBAL["get_boolean_true"]
    delete GLOBAL["get_boolean_false"]

    return new ASTree(sexps)

###* Root AST of the program. Provides access to the top-level S-expressions. ###
class ASTree
  constructor: (@sexps) ->