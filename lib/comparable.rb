module Comparable
  
    def <(other_node)
        self.data < other_node.data
    end

    def >(other_node)
        self.data > other_node.data
    end

    def ==(other_node)
        self.data == other_node.data
    end
    
    def leaf?
        self.left.nil? && self.right.nil?
    end

    def one_child_node?
        self.left.nil? ^ self.right.nil?
    end

    def two_child_node?
        !self.left.nil? && !self.right.nil?
    end
end