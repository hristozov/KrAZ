{Parser} = require "../parser"
{Integral, Atom, BooleanFalse, BooleanTrue, ExplicitFunctionDef, Lambda} = require "../sexp"

beforeEach ->
  this.parser = new Parser()

describe "Parser", ->
  it "Should properly parse integral atoms", ->
    one = this.parser.parse("1").sexps[0]
    expect(one instanceof Integral).toBeTruthy();
    one = this.parser.parse("-1").sexps[0]
    expect(one instanceof Integral).toBeTruthy();
    one = this.parser.parse("0").sexps[0]
    expect(one instanceof Integral).toBeTruthy();
    one = this.parser.parse("1000").sexps[0]
    expect(one instanceof Integral).toBeTruthy();

  it "Should properly parse booleans", ->
    one = this.parser.parse("#t").sexps[0]
    expect(one instanceof BooleanTrue).toBeTruthy();
    one = this.parser.parse("#f").sexps[0]
    expect(one instanceof BooleanFalse).toBeTruthy();

  it "Should properly parse explicit function definitions", ->
    definition = this.parser.parse("(define (square x) (* x x))").sexps[0];
    expect(definition instanceof ExplicitFunctionDef).toBeTruthy();
    signature = definition.signature
    expect(signature.children[0]).toEqual(new Atom("square"))
    expect(signature.children[1]).toEqual(new Atom("x"))
    body = definition.body
    expect(body.children[0]).toEqual(new Atom("*"))
    expect(body.children[1]).toEqual(new Atom("x"))
    expect(body.children[2]).toEqual(new Atom("x"))

  it "Should properly parse lambdas", ->
    definition = this.parser.parse("(lambda (x) (* x x))").sexps[0];
    expect(definition instanceof Lambda).toBeTruthy();
    signature = definition.signature
    expect(signature.children[0]).toEqual(new Atom("x"))
    body = definition.body
    expect(body.children[0]).toEqual(new Atom("*"))
    expect(body.children[1]).toEqual(new Atom("x"))
    expect(body.children[2]).toEqual(new Atom("x"))