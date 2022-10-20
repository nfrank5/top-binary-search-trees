require_relative 'lib/tree'
require_relative 'lib/node'

arbol = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

#arbol = Tree.new([1, 7])

#arbol = Tree.new([7])

arbol.pretty_print

#arbol.insert(122)
#arbol.pretty_print
arbol.delete(1)
arbol.pretty_print

arbol.delete(2)
arbol.pretty_print

arbol.delete(4)

arbol.delete(67)

arbol.delete(8)

#arbol.delete(8)

arbol.pretty_print
