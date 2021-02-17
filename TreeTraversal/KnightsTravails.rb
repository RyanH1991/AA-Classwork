require_relative "PolyTreeNode/lib/00_tree_node"
require "byebug"

class KnightPathFinder

    MOVES = [
        [-2,+1],
        [-2,-1],
        [-1,+2],
        [-1,-2],
        [+1,+2],
        [+1,-2],
        [+2,+1],
        [+2,-1]
    ]

    def self.valid_moves(pos)
        valid = []
        #naively calculate the eight possible moves. 
        #then check if they are within the bounds of the board.
        MOVES.each do |move|
            new_pos = [pos[0]+move[0],pos[1]+move[1]]
            if new_pos[0] >= 0 && new_pos[0] <= 7 && new_pos[1] >= 0 && new_pos[1] <= 7
                valid << new_pos
            end
        end
        valid
    end

    attr_reader :considered_positions, :root_node, :start_pos

    def initialize (pos)
        @considered_positions = [pos]
        @root_node = PolyTreeNode.new(pos)
        @start_pos = pos
        build_move_tree
    end
    
    def build_move_tree
        move_tree = []
        queue_array = [@considered_positions[0]]

        #polytree variables
        poly_queue = [@root_node]
        until queue_array.empty?
            new_moves = new_move_positions(queue_array[0])
            queue_array += new_moves
            move_tree += queue_array.shift
            #polytree logic
            new_nodes = []
            new_moves.each do |move|
                child = PolyTreeNode.new(move)
                poly_queue[0].add_child(child)
                new_nodes << child
            end
            poly_queue += new_nodes
            poly_queue.shift
        end
        
        move_tree
    end

    def new_move_positions(pos)
        valid = KnightPathFinder.valid_moves(pos)
        final_positions = []


        i = 0
        while i < valid.length
            unless @considered_positions.include?(valid[i])
                final_positions << valid[i]
                @considered_positions << valid[i]
            end
            i += 1
        end
        final_positions
    end

    def find_path(end_pos)
        path = trace_path_back(@root_node.bfs(end_pos))
    end

    def trace_path_back(node)
        path = []
        until node.parent.nil?
            path.unshift(node.value)
            node = node.parent
        end
        path.unshift(node.value)
        path
    end
end

tree = KnightPathFinder.new([0,0])
p tree.find_path([7,6])
p tree.find_path([6,2])