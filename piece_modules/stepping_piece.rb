require 'set'
module SteppingPiece

  def moves
    moves = Set.new(diffs)
    moves.keep_if { valid_pos?(move) }
  end

end
