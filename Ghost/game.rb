require "set"
require_relative "../TreeTraversal/PolyTreeNode/lib/00_tree_node"
require "byebug"
require_relative "player"

file = File.open("dictionary")
dictionary = file.readlines.map(&:chomp).to_set

class Game
    
    attr_reader :player1, :player2, :fragment
    
    def initialize(player1, player2, dictionary)
        @player1 = player1
        @player2 = player2
        @fragment = ""
        @dictionary = dictionary
        @root_node = PolyTreeNode.new(nil)
        @current_node = @root_node
        build_tree
        game
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

    def game
        until @player1.losses == 5 || @player2.losses == 5
            self.play_round
            #put displaying scores in a separate function
            #Also spell out ghost
            puts @player1.name + " losses:"
            puts
            puts @player1.losses
            puts @player2.name + " losses:"
            puts
            puts @player2.losses
            @current_node = @root_node
        end
        puts "Game Over!"
    end
    
    def play_round
        player = @player1
        game_status = true
        while game_status
            game_status = take_turn(player)
            player.add_loss unless game_status 
            if player == @player1
                player = @player2
            else
                player = @player1
            end
        end
        puts "You earned a letter"
        
    end

    def current_player
        @player1
    end

    def previous_player
        @player2
    end

    def next_player!
        @player2
    end

    def take_turn(player)
        
        char = "";
        valid_move = :not_char
        
        while valid_move == :not_char
            # puts "Make your move #{player}!"
            # char = gets.chomp
            valid_move = valid_play?(player.guess)
        end

        @fragment += char

        return valid_move
    end
    
    def valid_play?(char)
        return :not_char unless 'abcdefghijklmnopqrstuvwxyz'.include?(char)
        return false if @current_node.children.length == 0 

        @current_node.children.each do |child|
            if child.value == char
                @current_node = child
                return true
            end
        end
        return false
    end
end

p1 = Player.new("Jonathan")
p2 = Player.new("Ryan")
GhostGame = Game.new(p1,p2,dictionary)

#play_round
# The core game logic lives here. I wrote a number of helper methods to keep things clean:

#current_player
#previous_player
#next_player!: updates the current_player and previous_player
#take_turn(player): gets a char from the player until a valid play is made; then updates the fragment and checks against the dictionary. You may also want to alert the player if they attempt to make an invalid move (or, if you're feeling mean, you might cause them to lose outright).
#valid_play?(char): Checks that string is a letter of the alphabet and that there are words we can spell after adding it to the fragment

# Phase 2: Playing a Full Game

# Now that we have the logic to play a single round of Ghost, we'll have to add another layer.
# Game#losses and Game#record

# In a game of Ghost, a player "earns" a letter each time they lose a round. Thus, if Eric beats Ryan 3 times and loses once, then Eric has a "G" and Ryan has a "GHO". If a player spells the word "GHOST", they are eliminated from play (and in the case of two players, the other player wins).

# I added a losses hash to my Game class. The keys to the hash are Players, and the values are the number of games that player has lost. Update this at the end of #play_round. For flavor, I also wrote a helper method, #record(player), that translates a player's losses into a substring of "GHOST".
# Game#run

# This method should call #play_round until one of the players reaches 5 losses ("GHOST"). I wrote a helper method, #display_standings, to show the scoreboard at the beginning of each round. Remember to reset the fragment at the beginning of each round, as well!
# Phase 3: Multiplayer!

# Refactor your game to work with more than just two players. Instead of ending the game when one of the players reaches five losses, simply exclude that player from further rounds. End the game when only one player is left standing. Hint: You won't be able to use an instance variable for each player anymore. What data structure might we use as an alternative?
# Phase Bonus

#     Write an AiPlayer class for your Ghost game. You'll need to figure out the logic for picking a winning letter on each turn. In order to do this, your AiPlayer will need to know both the current fragment and the number of other players (n).
#         If adding a letter to the fragment would spell a word, then the letter is a losing move.
#         If adding a letter to the fragment would leave only words with n or fewer additional letters as possibilities, then the letter is a winning move.
#         Your AI should take any available winning move; if none is available, randomly select a losing move.
#             See if you can improve your AI by computing the entire tree of possible moves from the current position. Choose the move that leaves the fewest losers and the most winners in the tree.