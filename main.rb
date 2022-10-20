require_relative 'lib/tree'
require_relative 'lib/node'

arbol = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

#arbol.find(67)

arbol.level_order { |node| p node.data }
p arbol.level_order
arbol.pretty_print
