require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    # debugger
    ttt_node = TicTacToeNode.new(game.board, mark)
    ttt_node.children.each do |child|
      if child.winning_node?(mark)
        return child.prev_move_pos
      end
    end
    # debugger
    ttt_node.children.each do |child|
      if child.losing_node?(mark)
        return child.prev_move_pos
      end
    end

    return nil
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end


# Phase II: SuperComputerPlayer
# Write a subclass of ComputerPlayer; we'll override the #move method to use our TicTacToeNode.

# In the #move method, build a TicTacToeNode from the board stored in the game passed in as an argument. 

# Next, iterate through the children of the node we just created. 

#If any of the children is a winning_node? for the mark passed in to the #move method, return that node's prev_move_pos because that is the position that causes a certain victory! I told you we would use that later!

# If none of the children of the node we created are winning_node?s, that's ok. We can just pick one that isn't a losing_node? and return its prev_move_pos. That will prevent the opponent from ever winning, and that's almost as good. To make that even more clear: if a winner isn't found, pick one of the children of our node that returns false to losing_node?.

# Finally, raise an error if there are no non-losing nodes. In TTT, if we play perfectly, we should always be able to force a draw.

# Run your TTT game with the SuperComputerPlayer and weep tears of shame because you can't beat a robot at tic tac toe.