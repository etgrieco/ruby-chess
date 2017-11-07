class HumanPlayer

  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end

  def play_turn(board)
    puts "Your turn, #{name} (#{color})!".colorize(color)
    begin
      start_pos = Display.new(board).get_input
      raise MoveError.new("You cant' select an empty space.") if board[start_pos].is_a?(NullPiece)
      raise MoveError.new("You can't choose the other player's pieces!") if board[start_pos].color != @color
      raise MoveError.new("That piece can't move anywhere") if board[start_pos].valid_moves.empty?
    rescue MoveError => error
      puts error.message
      retry
    end

    begin
      end_pos = Display.new(board, start_pos, start_pos).get_input
      board.move_piece(start_pos, end_pos)
    rescue MoveError => error
      puts error.message
      retry
    end
  end

end
