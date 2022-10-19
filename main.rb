require_relative 'lib/tree'
require_relative 'lib/node'

arbol = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

arbol.pretty_print

p arbol.insert(65)


arbol.pretty_print
