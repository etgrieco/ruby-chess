require_relative 'piece'

class Pawn < Piece

  def to_s
    'P'.colorize(self.color)
  end

  def moves
    possible_moves = []
    forward_move = forward_dir[0] + @position[0], forward_dir[1] + @position[1]
    if @board[forward_move].is_a?(NullPiece)
      possible_moves << forward_move if Board.in_bounds?(forward_move)

      if at_start_row?
        vertical_move = @position[0] + (forward_steps * forward_dir[0])
        start_move = vertical_move, @position[1]
        possible_moves << start_move
      end
    end

    side_attacks.each do |diff|
      side_attack = [diff[0] + @position[0], diff[1] + @position[1]]
      next if !Board.in_bounds?(side_attack) ||
        @board[side_attack].is_a?(NullPiece) ||
        @board[side_attack].color == self.color
      possible_moves << side_attack
    end

    possible_moves
  end

  def at_start_row?
    if @color == :white && @position[0] == 6
      true
    elsif @color == :black && @position[0] == 1
      true
    else
      false
    end
  end

  def forward_dir
    case @color
    when :black
      [1,0]
    when :white
      [-1,0]
    end
  end

  def forward_steps
    at_start_row? ? 2 : 1
  end

  def side_attacks
    case @color
    when :black
      [[1,-1], [1,1]]
    when :white
      [[-1,-1], [-1,1]]
    end
  end

end
