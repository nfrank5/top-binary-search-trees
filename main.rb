require_relative 'lib/tree'
require_relative 'lib/node'

arbol = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

#arbol.find(67)

#p arbol.level_order { |node| p node.data+1 }
#p arbol.level_order

arbol.inorder { |n| p n.data}
p arbol.inorder
arbol.pretty_print

arbol.preorder { |n| p n.data}
p arbol.preorder
arbol.pretty_print

arbol.postorder { |n| p n.data}
p arbol.postorder

arbol.pretty_print
