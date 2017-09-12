module SteppingPiece
  def moves
    possible_moves = []
    move_diffs.each do |diff|
      possible_moves << [diff[0] + @position[0], diff[1] + @position[1]]
    end

    possible_moves.select do |move|
      Board.in_bounds?(move) && @board[move].color != self.color
    end

  end

end
