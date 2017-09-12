require_relative 'board'
require_relative 'display'

class Game

  def initialize(player1, player2)
    @board = Board.new
    @player1 = player1
    @player2 = player2
  end

  def play
    @current_player = @player1
    until over?
      @current_player.play_turn(@board)
      switch_player
    end
  end

  private

  def over?
    @board.checkmate?(@current_player.color)
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

end

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

if __FILE__ == $PROGRAM_NAME
  player1 = HumanPlayer.new("george", :black)
  player2 = HumanPlayer.new("ned", :white)
  Game.new(player1, player2).play
end
