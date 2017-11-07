require_relative 'board'
require_relative 'display'
require_relative 'player'
require 'byebug'

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
  attr_reader :player1, :player2

  def over?
    @board.checkmate?(@current_player.color)
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

end

if __FILE__ == $PROGRAM_NAME
  player1 = HumanPlayer.new("Player Black", :black)
  player2 = HumanPlayer.new("Player White", :white)
  Game.new(player1, player2).play
end
