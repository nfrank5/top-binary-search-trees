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
    
end