require "set"
require_relative "../TreeTraversal/PolyTreeNode/lib/00_tree_node"
require "byebug"

file = File.open("dictionary")
dictionary = file.readlines.map(&:chomp).to_set


class Game
    
    attr_reader :player1, :player2, :fragment
    
    def initialize(player1, player2, fragment, dictionary)
        @player1 = player1
        @player2 = player2
        @fragment = fragment
        @dictionary = dictionary
        @root_node = PolyTreeNode.new(nil)
        @current_node = @root_node
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
                puts current_node.value
            end
        end
    end

    def play_round

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
        
        play = nil
        char = "";
        
        until play

        
        end
        @fragment += char
        @dictionary.include?(@fragment)

        #I have @fragment.length
        #I can look at words that are fraglength or greater
        #if I looped through the whole set, I could see if the fragment is a piece of a word.
        #I can organize the dictionay in ABC order so that I only look at relevant words
    end

    def valid_play?(char)
        return false unless 'abcdefghijklmnopqrstuvwxyz'.include?(char)
        frag_test = @fragment.dup
        frag_test += char
        current_node = @current_node
        frag_test.each_char do |chr|
            
        end
    end
end

#play_round
# The core game logic lives here. I wrote a number of helper methods to keep things clean:

#current_player
#previous_player
#next_player!: updates the current_player and previous_player
#take_turn(player): gets a string from the player until a valid play is made; then updates the fragment and checks against the dictionary. You may also want to alert the player if they attempt to make an invalid move (or, if you're feeling mean, you might cause them to lose outright).
#valid_play?(char): Checks that string is a letter of the alphabet and that there are words we can spell after adding it to the fragment