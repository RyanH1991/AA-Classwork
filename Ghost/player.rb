class Player
    attr_reader :name, :losses
    def initialize(name)
        @name = name
        @losses = 0
    end

    def guess 
        puts "Make your move #{@name}!"
        char = gets.chomp
        return char
    end

    def add_loss
        @losses+=1
    end

end