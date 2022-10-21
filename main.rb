require_relative 'lib/tree'
require_relative 'lib/node'

arbol = Tree.new((Array.new(15) { rand(1..100) }))


p "Balanced: #{arbol.balanced?}"

p arbol.level_order
p arbol.preorder
p arbol.postorder
p arbol.inorder

arbol.insert(111)
arbol.insert(222)
arbol.insert(333)
arbol.insert(444)

p "Balanced: #{arbol.balanced?}"

arbol.rebalance

p "Balanced: #{arbol.balanced?}"

p arbol.level_order
p arbol.preorder
p arbol.postorder
p arbol.inorder