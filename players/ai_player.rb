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
    # best_move = get_best_simple_move(board)
    best_move = get_best_minimax_move(2, board)
    board.move_piece(*best_move)
  end

  def create_test_board(test_move, board)
    new_board = board.dup
    new_board.move_piece!(*test_move)
    new_board
  end

  def get_best_simple_move(board)
    best_move = { move: nil, points: -9999 }

    all_moves(board).each do |test_move|
      test_board = create_test_board(test_move, board)
      points = evaluate(test_board)
      if points > best_move[:points]
        best_move = { move: test_move, points: points }
      end
    end

    best_move[:move]
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


  def get_best_minimax_move(depth, board)
    best_move = { move: nil, points: -9999 }

    all_moves(board).each do |test_move|
      test_board = create_test_board(test_move, board)
      points = minimax(depth, test_board, self.color)
      if points > best_move[:points]
        best_move = { move: test_move, points: points }
      end
    end

    best_move[:move]
  end

  def minimax(depth, board, maximizing_color)
    opponent_color = maximizing_color == :black ? :white : :black

    if depth == 0
      return evaluate(board)
    end

    all_moves = all_moves(board)
    if maximizing_color == color
      best_move = -9999
      all_moves.each do |move|
        test_board = create_test_board(move, board)
        best_move = [best_move, minimax(depth - 1, test_board, opponent_color)].max
      end
    else
      best_move = 9999
      all_moves.each do |move|
        test_board = create_test_board(move, board)
        best_move = [best_move, minimax(depth - 1, test_board, opponent_color)].min
      end
    end

    best_move
  end

end
