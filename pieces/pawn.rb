require_relative 'piece'

class Pawn < Piece

  def inspect
    '♟'
  end

  def moves
    possible_moves = []
    forward_move = forward_dir.map { |dir, idx| dir + self.position[idx] }

    if @board[forward_move].is_a?(NullPiece) && Board.in_bounds?(forward_move)
      possible_moves << forward_move
      if at_start_row?
        vertical_move = @position[0] + (forward_steps * forward_dir[0])
        start_move = vertical_move, @position[1]
        possible_moves << start_move if @board[start_move].is_a?(NullPiece)
      end
    end

    possible_moves + attacks
  end

  private

  def forward_dir
    case @color
    when :black
      [1, 0]
    when :white
      [-1, 0]
    end
  end

  def at_start_row?
    if @color == :white
      @position[0] == 6
    else
      @position[0] == 1
    end
  end

  def forward_steps
    at_start_row? ? 2 : 1
  end

  def side_attacks
    case @color
    when :black
      [[1, -1], [1, 1]]
    when :white
      [[-1, -1], [-1, 1]]
    end
  end

  def attacks
    possible_attacks = []
    side_attacks.each do |diff|
      side_attack = [diff[0] + @position[0], diff[1] + @position[1]]
      next if !Board.in_bounds?(side_attack) ||
        @board[side_attack].is_a?(NullPiece) ||
        @board[side_attack].color == self.color
      possible_attacks << side_attack
    end

    possible_attacks
  end

end
