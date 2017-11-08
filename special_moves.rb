module SpecialMoves

  def special_move?(start_piece, end_piece)
    castling?(start_piece, end_piece)
  end

  def castling?(start_piece, end_piece)
    row = start_piece.position[0]

    if initial_castling_conditions_met?(start_piece, end_piece)
      king = start_piece.position[1] === 4 ? start_piece : end_piece
      rook = king == start_piece ? end_piece : start_piece

      position_difference = king.position[1] - rook.position[1]
      check_range = position_difference == 4 ? (1..3) : (5..6)

      positions = check_range.to_a.map { |col| [row, col] }

      if all_null?(positions) && none_in_check?(king, positions)
        perform_castle(king, rook)
        return true
      end
    end
    false
  end

  def perform_castle(king, rook)
    self[king.position] = rook
    self[rook.position] = king
    king.change_position!(rook.position)
    rook.change_position!(king.position)
  end

  def initial_castling_conditions_met?(start_piece, end_piece)
    debugger
    (start_piece.class.to_s == "King" && end_piece.class.to_s == "Rook"    ||
      start_piece.class.to_s == "Rook" && end_piece.class.to_s == "King")  &&
      !start_piece.has_moved? && !end_piece.has_moved?
  end

  def all_null?(positions)
    positions.all? { |pos| self[pos].class.to_s == "NullPiece" }
  end

  def none_in_check?(piece, positions)
    positions.none? { |pos| piece.move_into_check?(pos) }
  end

end
