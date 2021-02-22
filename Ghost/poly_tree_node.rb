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

    #fantasia fails, must fix
    def dfs_search(player_count, fragment)
        if self.value
            fragment += self.value
        end
        # we take the incrementation of fragment.length
        # to account for the addition of the current char
        if self.children.empty? && fragment.length % player_count != 1
            #fail safe for the challenge feature
            if fragment.length == 1
                return nil
            end
            #we return position 1 becuase pos 0 is the letter that previous
            #player concatinated
            return fragment[1]
        end
        
        self.children.each do |child|
            node_check = child.dfs_search(player_count, fragment)
            if node_check
                return node_check 
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