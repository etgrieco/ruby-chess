require_relative '../board'
require_relative 'player'

class AIPlayer < Player

  PIECE_VALUES = {
    King: 900,
    Queen: 90,
    Rook: 50,
    Bishop: 30,
    Knight: 30,
    Pawn: 10,
  }.freeze
  
  def play_turn(board)
    best_move = [nil, nil]
    best_move_points = -9999

    all_moves(board).each do |test_move|
      test_board = board.dup
      test_board.move_piece!(*test_move)
      points = evaluate(test_board)
      if points > best_move_points
        best_move = test_move
        best_move_points = points
      elsif points === best_move_points
        best_move = [test_move, best_move].sample
      end
    end

    board.move_piece(*best_move)
  end

  def evaluate(board)
    opponent_color = color == :black ? :white : :black
    points = player_values(board, color).inject(:+)
    points - player_values(board, opponent_color).inject(:+)
  end

  def player_values(board, color)
    board.all_pieces(color).map do |piece|
      key = piece.class.to_s.to_sym
      PIECE_VALUES[key]
    end
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
