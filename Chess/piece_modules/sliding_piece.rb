module SlidingPiece

  def moves
    possible_moves = []
    move_dirs.each do |diff|
      new_position = @position[0] + diff[0], @position[1] + diff[1]
      until !Board.in_bounds?(new_position) || @board[new_position].color == self.color
        possible_moves << new_position
        new_position = new_position[0] + diff[0], new_position[1] + diff[1]
      end
    end
    possible_moves
  end

end
