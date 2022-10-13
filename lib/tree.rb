require_relative './node'

class Tree

  def initialize(arr)
    @root = build_tree(arr)
  end

  def build_tree(arr)
    return nil if arr.empty?

    arr = arr.uniq.sort
    middle = arr.length / 2

    node = Node.new(arr[middle])

    node.left = build_tree(arr[0, middle])

    node.right = build_tree(arr[middle+1, arr.length])

    node
  end


  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end



