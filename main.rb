require_relative 'lib/tree'
require_relative 'lib/node'

arbol = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
#arbol = Tree.new((Array.new(45) { rand(1..100) }))
#arbol.find(67)

#p arbol.level_order { |node| p node.data+1 }
#p arbol.level_order

nuevo_nodo = Node.new(5)
p arbol.depth(nuevo_nodo)


arbol.pretty_print
