require_relative "PolyTreeNode/lib/00_tree_node"


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
    attr_reader :considered_positions   
    def initialize (pos)
        @considered_positions = [pos]
        p @considered_positions[0]
        #KnightPathFinder.root_node
        p build_move_tree
        p KnightPathFinder.root_node
    end
    
    def self.root_node
        #p @considered_positions
        #root_node = PolyTreeNode.new(@considered_positions[0])
        root_node = PolyTreeNode.new([0,0])
    end
    
    def build_move_tree
        move_tree = []
        queue_array = [@considered_positions[0]]

        #polytree variables
        poly_queue = [KnightPathFinder.root_node]

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
        #move_tree
        
        return KnightPathFinder.root_node
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

    end
end

tree = KnightPathFinder.new([0,0])
p tree