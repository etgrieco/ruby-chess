require 'set'
module SteppingPiece

  def moves
    moves = diffs.map { |diff| increment_pos(position, diff) }
    moves = Set.new(moves)
    moves.keep_if { |move| valid_pos?(move) }
  end

end
