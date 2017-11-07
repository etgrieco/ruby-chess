require_relative '../board'
require_relative 'player'

class AIPlayer < Player

  def play_turn(board)
    random_move = all_moves(board).sample
    board.move_piece(*random_move)
  end

  def all_moves(board)
    moves = []
    board.all_pieces(color).each do |piece|
      position = piece.position
      p_moves = piece.moves.map { |move| [position, move] }
      moves.push(*p_moves)
    end
    moves
  end

end
