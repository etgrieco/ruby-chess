require_relative 'player'

class HumanPlayer < Player

  def initialize(name, color)
    super
    @messages = Hash.new
  end

  def get_start_pos(board)
    begin
      start_pos = Display.new(board, [4, 4], nil, messages).get_input
      @messages[:errors] = nil
      if board[start_pos].is_a?(NullPiece)
        raise MoveError.new("You can't select an empty space.")
      elsif board[start_pos].color != @color
        raise MoveError.new("You can't choose the other player's pieces!")
      elsif board[start_pos].valid_moves.empty?
        raise MoveError.new("That piece can't move anywhere")
      end
    rescue MoveError => error
      messages[:errors] = error.message
      retry
    end
    start_pos
  end

  def get_end_pos(start_pos, board)
    begin
      end_pos = Display.new(board, start_pos, start_pos, messages).get_input
      @messages[:errors] = nil
      board.move_piece(start_pos, end_pos)
    rescue MoveError => error
      messages[:errors] = error.message
      retry
    end
  end

  def play_turn(board)
    messages[:start] = "Your turn, #{name} (#{color})!"
    start_pos = get_start_pos(board)
    get_end_pos(start_pos, board)
  end

  private

  attr_accessor :messages

end

class MoveError < StandardError; end
