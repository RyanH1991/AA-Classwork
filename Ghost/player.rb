class Player
    attr_reader :name, :losses
    def initialize(name)
        @name = name
        @losses = 0
    end

    def guess(fragment, player_count)
        puts "Make your move #{@name}!"
        char = gets.chomp
        return char
    end

    def add_loss
        @losses += 1
    end

    def letters
        return "" if @losses == 0
        return "GHOST"[0...@losses]
    end
end