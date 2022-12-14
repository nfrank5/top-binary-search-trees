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
    return nil if node.nil?

    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value)
    new_node = Node.new(value)
    last_node = find(value, @root)
    new_node > last_node ? last_node.right = new_node : last_node.left = new_node
  end

  def find(value, node = @root)
    value_node = Node.new(value)
    if !node.left.nil? && value_node < node 
      find value, node.left
    elsif !node.right.nil? && value_node > node
      find value, node.right
    else
      node
    end
  end

  def next_minimum_value(node = @root, first_recursion = true)
    if first_recursion
      next_minimum_value(node.right, false) 
    else
      return node if node.left.nil?
      next_minimum_value(node.left, false)
    end
  end

  def find_parent(node, tree)
    return nil if node == tree

    if !tree.left.nil? && node == tree.left
      tree
    elsif !tree.right.nil? && node == tree.right
      tree
    else
      if !tree.right.nil? && node > tree 
        find_parent(node, tree.right)
      else
        find_parent(node, tree.left)
      end
    end
  end

  def delete(value, node = @root)
    return nill if node.nil?

    node_to_delete = find(value, node)
    parent = find_parent(node_to_delete, node)
    case true
      #delete roor
      when parent.nil? && node_to_delete.leaf?
        @root = nil
      when parent.nil? && node_to_delete.one_child_node?
        @root = !node_to_delete.left.nil? ? node_to_delete.left : node_to_delete.right
      when parent.nil? && node_to_delete.two_child_node?
        nmv = next_minimum_value(node_to_delete)
        nmv_parent = find_parent(nmv, node)
        if nmv_parent == node_to_delete
          nmv.left = node_to_delete.left
          @root = nmv
        else
          nmv_parent.left = nmv.right
          nmv.left = node_to_delete.left
          nmv.right = node_to_delete.right
          @root = nmv
        end
      #delete others
      when node_to_delete.leaf?
        node_to_delete > parent ? parent.right = nil : parent.left = nil
      when node_to_delete.one_child_node?
        if node_to_delete > parent 
          parent.right = !node_to_delete.left.nil? ? node_to_delete.left : node_to_delete.right
        else 
          parent.left = !node_to_delete.left.nil? ? node_to_delete.left : node_to_delete.right
        end
      when node_to_delete.two_child_node?
        nmv = next_minimum_value(node_to_delete)
        nmv_parent = find_parent(nmv, node)
        nmv_parent.left = nmv.right
        nmv.left = node_to_delete.left
        nmv.right = node_to_delete.right
        node_to_delete > parent ? parent.right = nmv : parent.left = nmv
      else
        nil
    end
  end

  def level_order(node = @root)
    return if node.nil?
    queue = [node]
    values_array = []
    loop do
      break if queue.empty?
      current_node = queue.pop

      if block_given?
        yield current_node
      else
        values_array.push(current_node.data)
      end
      queue.unshift(current_node.left) unless current_node.left.nil?
      queue.unshift(current_node.right) unless current_node.right.nil?
    end
    return values_array unless block_given?
  end



  def level_order_recursive(queue = [@root], values_array = [], &block)
    return if queue.nil?
    return values_array if !block_given? && queue.empty?

    return if queue.empty?

    current_node = queue.pop
    if block_given?
      yield current_node
    else
      values_array.push(current_node.data)
    end
    queue.unshift(current_node.left) unless current_node.left.nil?
    queue.unshift(current_node.right) unless current_node.right.nil?
    level_order_recursive(queue, values_array, &block) 
  end
  
  def inorder(node = @root, values_array = [], &block)
    return values_array if !block_given? && node.nil?
    return if node.nil?
    
    inorder(node.left, values_array, &block)
    if block_given?
      yield node
    else
      values_array.push(node.data)
    end
    inorder(node.right, values_array, &block)
  end

  def preorder(node = @root, values_array = [], &block)
    return values_array if !block_given? && node.nil?
    return if node.nil?


    if block_given?
      yield node
    else
      values_array.push(node.data)
    end
    preorder(node.left, values_array, &block)
    preorder(node.right, values_array, &block)
  end


  def postorder(node = @root, values_array = [], &block)
    return values_array if !block_given? && node.nil?
    return if node.nil?

    
    postorder(node.left, values_array, &block)
    postorder(node.right, values_array, &block)
    if block_given?
      yield node
    else
      values_array.push(node.data)
    end
  end

  def height(node = @root, count = 0, h = 0)
    return if node.nil?
    if node.leaf? && (count) > h
      h = (count)
    end
    count += 1
    h = height(node.left, count, h) unless node.left.nil?
    h = height(node.right, count, h) unless node.right.nil?
    count -=1 
    h 
  end

  def depth(target, node = @root, count = 0, d = 0)
    return if node.nil?
    if target == node
      d = count
    end
    count += 1
    if target < node
      d = depth(target, node.left, count, d) unless node.left.nil?
    else
      d = depth(target, node.right, count, d) unless node.right.nil?
    end
    count -=1 
    d 
  end

  def balanced?
    if @root.left.nil? 
      left_tree = 0 
    else
      left_tree = height(@root.left)
    end

    if @root.right.nil?
      right_tree = 0
    else
      right_tree = height(@root.right)
    end
    (left_tree - right_tree).abs <= 1
  end



  def rebalance
    tree_array = inorder
    @root = build_tree(tree_array)
  end
end

