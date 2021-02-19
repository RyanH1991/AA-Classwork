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

    ttt_node.children.each do |child|
      unless child.losing_node?(mark)
        return child.prev_move_pos
      end
    end

    # opponent_mark = :x
    # if mark == :x
    #   opponent_mark = :o
    # end
    # ttt_node.children.each do |child|
    #   unless child.winning_node?(opponent_mark)
    #     return child.prev_move_pos
    #   end
    # end

    raise error
    return nil
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end

# If none of the children of the node we created are winning_node?s, that's ok. We can just pick one that isn't a losing_node? and return its prev_move_pos. That will prevent the opponent from ever winning, and that's almost as good. To make that even more clear: if a winner isn't found, pick one of the children of our node that returns false to losing_node?.

# Finally, raise an error if there are no non-losing nodes. In TTT, if we play perfectly, we should always be able to force a draw.

# Run your TTT game with the SuperComputerPlayer and weep tears of shame because you can't beat a robot at tic tac toe.