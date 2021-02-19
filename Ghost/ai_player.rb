require_relative "player"

class AiPlayer < Player
    def initialize(name)
        super(name)
        @name = name
    end

    def guess

        puts "Machine #{@name} selects the letter: "
    end

end

# Phase Bonus

# Write an AiPlayer class for your Ghost game. You'll need to figure out the logic for picking a winning letter on each turn. In order to do this, your AiPlayer will need to know both the current fragment and the number of other players (n).
# If adding a letter to the fragment would spell a word, then the letter is a losing move.
# If adding a letter to the fragment would leave only words with n or fewer additional letters as possibilities, then the letter is a winning move.
# Your AI should take any available winning move; if none is available, randomly select a losing move.
# See if you can improve your AI by computing the entire tree of possible moves from the current position. Choose the move that leaves the fewest losers and the most winners in the tree.