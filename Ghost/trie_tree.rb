require "set"

require_relative "../TreeTraversal/PolyTreeNode/lib/00_tree_node"

class TrieTree

    attr_reader :root_node

    def initialize
        @root_node = PolyTreeNode.new(nil)
        file = File.open("dictionary")
        @dictionary = file.readlines.map(&:chomp).to_set
        build_tree
    end

    #literally built a trie tree
    def build_tree
        current_node = nil
        
        @dictionary.each do |word|
            current_node = @root_node
            (0...word.length).each do |i|
                chr = word[i]
                previous_node = current_node
                if current_node.children.length > 0
                    current_node.children.each do |child|
                        if child.value == chr
                            current_node = child
                            break
                        end
                    end
        
                end
                if current_node == previous_node
                    new_node = PolyTreeNode.new(chr)
                    current_node.children << new_node
                    current_node = new_node
                end
            end
        end
    end
end