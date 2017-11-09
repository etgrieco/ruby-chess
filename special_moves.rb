require_relative 'piece_modules/castling'

include Castling
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
    king_pos, rook_pos = king.position, rook.position
    king.change_position!(rook_pos)
    rook.change_position!(king_pos)
  end

end
