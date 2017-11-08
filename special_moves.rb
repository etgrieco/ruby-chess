module SpecialMoves
  
  def special_move?
    castling?(start_pos, end_pos)
  end
  
  def castling?(start_pos, end_pos)
    start_piece = board[start_pos]
    end_piece = board[end_piece]
    if start_piece.class.to_s == "King"
      unless start_piece.has_moved
        return end_piece.class.to_s != "Rook"
              # &&... include conditions of empty spaces in-between
      end
      start_piece.make_move
    end
    false
  end
  
end