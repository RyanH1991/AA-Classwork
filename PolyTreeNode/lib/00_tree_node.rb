class PolyTreeNode
    attr_reader :parent, :children, :value

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(node)
        if self.parent != nil
            self.parent.children.delete(self)
        end

        @parent = node

        return if node == nil

        unless node.children.include?(self)
            node.children << self
        end
        
    end

    def add_child(child)
        unless self.children.include?(child)
            self.children << child
            child.parent=(self)
        end
    end

    def remove_child(child)
        if self.children.include?(child)
            child.parent=(nil)
        else
            raise "this node is not a child"
        end
        
    end

    def dfs(target_value)
        if self.value == target_value
            return self
        else
            self.children.each do |child|
                childCheck = child.dfs(target_value)
                if childCheck != nil
                    return childCheck
                end
            end
        end
        nil
    end
    
    def bfs(target_value)
        queueArray = [self]
        while queueArray != []
            if queueArray[0].value == target_value
                return queueArray[0]
            else
                queueArray += queueArray[0].children
                queueArray.shift
            end
        end
        return nil
    end
end

a = PolyTreeNode.new("a")
b = PolyTreeNode.new("b")
c = PolyTreeNode.new("c")
d = PolyTreeNode.new("d")
e = PolyTreeNode.new("e")
f = PolyTreeNode.new("f")
a.add_child(b)
a.add_child(c)
d.add_child(e)
d.add_child(f)
