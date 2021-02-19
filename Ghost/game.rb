require "set"
require "byebug"

require_relative "../TreeTraversal/PolyTreeNode/lib/00_tree_node"
require_relative "player"
require_relative "trie_tree"

class Game
    
    attr_reader :players, :fragment
    
    def initialize(*players)

        @players = players
        @fragment = ""
        @trie_tree = TrieTree.new
        @current_node = @trie_tree.root_node

        game
    end

    def game
        until @players.length == 1
            self.play_round
            self.display_scores
            @players.any? { |player| player.losses == 5 }
            @current_node = @trie_tree.root_node
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

# ask for the number of players and their names
p1 = Player.new("Jonathan")
p2 = Player.new("Ryan")
p3 = Player.new("Rupesh")
p4 = Player.new("Alex")
GhostGame = Game.new(p1, p2, p3, p4)