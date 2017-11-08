module SpecialMoves

  def special_move?(start_piece, end_piece)
    if start_piece.can_castle?(end_piece)
      perform_castle(start_piece, end_piece)
      return true
    end
  end

  def perform_castle(king, rook)
    self[king.position] = rook
    self[rook.position] = king
    king.change_position!(rook.position)
    rook.change_position!(king.position)
  end

end
