require "byebug"

require_relative "player"
require_relative "trie_tree"
require_relative "ai_player"

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
            @fragment = ""
        end
        puts "#{@players[0].name} won the freaking game!"
        puts "Game Over!"
    end

    def rotate_players(i)
        #i is the player that the last round ended on
        @players = @players[i..-1] + @players[0...i]
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
                total_losses = player.add_loss
                if total_losses == 5
                    puts "#{player.name} is a GHOST"
                    @players = @players[0...i] + @players[i+1..-1]
                    i = i - 1
                end
                puts "#{player.name} has earned a letter"
                puts
            end
            i = (i + 1) % @players.length
            player = @players[i]
        end
        self.rotate_players(i)
    end

    def take_turn(player)
        
        valid_move = :not_char
        char = ""

        while valid_move == :not_char
            char = player.guess(@fragment)
            valid_move = valid_play?(char)
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
                if @current_node.children == []
                    puts "you finished the word!"
                    return false
                end
                return true
            end
        end
        return false
    end
end

# ask for the number of players and their names
p1 = Player.new("Jonathan")
p2 = Player.new("Ryan")
p3 = Player.new("Eternal")
p4 = Player.new("Telly")
a1 = AIPlayer.new("Chris")
GhostGame = Game.new(p1, p2, p3, p4, a1)