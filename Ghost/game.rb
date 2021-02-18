require "set"
require_relative "../TreeTraversal/PolyTreeNode/lib/00_tree_node"
require "byebug"
require_relative "player"

file = File.open("dictionary")
dictionary = file.readlines.map(&:chomp).to_set

class Game
    
    attr_reader :player1, :player2, :fragment
    
    def initialize(*players)
        @player1 = player1
        @player2 = player2
        @players = players

        @fragment = ""
        @root_node = PolyTreeNode.new(nil)
        @current_node = @root_node

        file = File.open("dictionary")
        @dictionary = file.readlines.map(&:chomp).to_set

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
        until @players.length == 1
            self.play_round
            self.display_scores
            @players.any? { |player| player.losses == 5 }
            @current_node = @root_node
        end
        puts "#{@players[0].name} won the freaking game!"
        puts "Game Over!"
    end
    
    def display_scores
        @players.each do |player|
            puts player.name + " letters:" + player.letters
            puts 
        end
    end
    
    def play_round
        player = @players[0]
        i = 0
        game_status = true
        while game_status
            game_status = take_turn(player)
            unless game_status
                player.add_loss
                puts "#{player.name} has earned a letter"
                puts
            end
            i = (i + 1) % @players.length
            player = @players[i]
        end

        (0...@players.length).each do |i|
            player = @players[i]
            if player.losses == 5
                self.display_scores
                @players = @players[0...i] + @players[i+1..-1]
                break
            end
        end
    end

    def take_turn(player)
        
        char = "";
        valid_move = :not_char
        
        while valid_move == :not_char
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
p3 = Player.new("Rupesh")
p4 = Player.new("Alex")
GhostGame = Game.new(p1, p2, p3, p4)

# Phase Bonus

#     Write an AiPlayer class for your Ghost game. You'll need to figure out the logic for picking a winning letter on each turn. In order to do this, your AiPlayer will need to know both the current fragment and the number of other players (n).
#         If adding a letter to the fragment would spell a word, then the letter is a losing move.
#         If adding a letter to the fragment would leave only words with n or fewer additional letters as possibilities, then the letter is a winning move.
#         Your AI should take any available winning move; if none is available, randomly select a losing move.
#             See if you can improve your AI by computing the entire tree of possible moves from the current position. Choose the move that leaves the fewest losers and the most winners in the tree.