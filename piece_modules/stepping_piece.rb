require 'set'
module SteppingPiece

  def moves
    moves = Set.new( diffs.map { |diff| increment_pos(position, diff) } )
    moves.keep_if { |move| valid_pos?(move) }
  end

end
