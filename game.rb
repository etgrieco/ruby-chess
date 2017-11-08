require_relative 'board'
require_relative 'display'
require_relative 'players/players'
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
    switch_player
    puts "Game over! #{@current_player.name} has checkmate!"
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
  player1 = HumanPlayer.new("Player 1", :white)
  puts "1. Player vs. Player?"
  puts "2. Player vs. AI?"
  
  begin
    case gets.chomp
    when "1"
      player2 = HumanPlayer.new("Player 2", :black)
    when "2"
      player2 = AIPlayer.new("Player 2 (AI)", :black)
    else
      raise StandardError("Please choose a valid option")
    end
  rescue StandardError => error
    puts error.message
    retry
  end
  
  Game.new(player1, player2).play
end
