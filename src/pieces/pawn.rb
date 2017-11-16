require 'set'
require_relative 'piece'

class Pawn < Piece

  def inspect
    '♟'
  end

  def moves
    moves = Set.new
    move = increment_pos(position, diff)

    if valid_pos?(move) && board.is_empty?(move)
      moves << move
      if at_start_row?
        move = increment_pos(move, diff)
        moves << move if board.is_empty?(move)
      end
    end
    moves + attacks
  end

  private

  def diff
    case color
    when :black
      [1, 0]
    when :white
      [-1, 0]
    end
  end

  def at_start_row?
    @color == :white ? @position[0] == 6 : @position[0] == 1
  end

  def attack_diffs
    case @color
    when :black
      [[1, -1], [1, 1]]
    when :white
      [[-1, -1], [-1, 1]]
    end
  end

  def attacks
    attacks = Set.new
    attack_diffs.each do |diff|
      attack = increment_pos(position, diff)
      if valid_pos?(attack) && board.is_occupied?(attack)
        attacks << attack
      end
    end
    attacks
  end

end
