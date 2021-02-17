require_relative 'tic_tac_toe'
require "byebug"

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?
      return @board.winner != evaluator
    end
    children = self.children
    if @next_mover_mark == evaluator
      if children.all?{|child| child.board.tied?}
        return false
      end
      return children.all?{|child| child.losing_node?(evaluator)}
    else
      return children.any?{|child| child.losing_node?(evaluator)}
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      return @board.winner == evaluator
    end
    children = self.children
    if @next_mover_mark == evaluator
      return children.any?{|child| child.winning_node?(evaluator)}
    else
      return children.all?{|child| child.winning_node?(evaluator)}
    end

  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    arr = []
    mark = :x

    if @next_mover_mark == :x
      mark = :o
    end
    (0..2).each do |i|
      (0..2).each do |j|

        current_board = @board.dup
        if current_board.rows[i][j].nil?

          current_board.rows[i][j] = @next_mover_mark
          new_node = TicTacToeNode.new(current_board, mark, [i,j])
          arr << new_node
        end
      end
    end
    arr
  end
end

ryan = Board.new
p ryan