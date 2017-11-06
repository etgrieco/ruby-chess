module SlidingPiece

  def moves
    possible_moves = []
    move_dirs.each do |diff|
      new_position = @position[0] + diff[0], @position[1] + diff[1]
      until !Board.in_bounds?(new_position) || @board[new_position].color == self.color
        possible_moves << new_position
        break unless @board[new_position].is_a?(NullPiece)
        new_position = new_position[0] + diff[0], new_position[1] + diff[1]
      end
    end
    possible_moves
  end

  def diagnal_dirs
    [[-1, -1], [1, 1], [-1, 1], [1, -1]]
  end

  def lateral_dirs
    [[-1, 0], [1, 0], [0, 1], [0, -1]]
  end

end
