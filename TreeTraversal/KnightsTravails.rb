

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
        build_move_tree
    end

    def build_move_tree
        move_tree = []
        queue_array = [@considered_positions[0]]
        until queue_array.empty?
            queue_array += new_move_positions(queue_array[0])
            move_tree += queue_array.shift
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
end

tree = KnightPathFinder.new([0,0])
p tree.considered_positions.length