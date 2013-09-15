{Parser} = require "./parser"

builtins = ["+", "*", "/", "-", "define", "lambda", "cons", "list", "map", "apply"]

tree1 = new Parser().parse("(+ (1 2))").sexps[0]
tree2 = new Parser().parse("(+ 1 2)").sexps[0]

print_tree = (tree) ->
  if tree.hasOwnProperty "content"
    tree.content
  else
    "(" + tree.children.map((c) -> return print_tree(c)).join(" ") + ")"

transform_tree = (tree) ->
  if tree.hasOwnProperty "content"
    content1 = tree.content
    switch
      when builtins.indexOf(content1) >= 0 then "[builtin]"
      when not isNaN(parseInt(content1)) then "[integral]"
      else content1
  else
    "(" + tree.children.map((c) -> return transform_tree(c)).join(" ") + ")"

console.log(transform_tree(tree1))
console.log(transform_tree(tree2))