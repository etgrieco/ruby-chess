require_relative 'src/game'
require_relative 'src/players/players'

if __FILE__ == $PROGRAM_NAME
  puts "Player 1 (white): What is your name?"
  name1 = gets.chomp
  name1 = "Player 1" if name1.length == 0
  puts "Player 2 (black): What is your name?"
  name2 = gets.chomp
  name2 = "Player 2" if name2.length == 0

  player1 = HumanPlayer.new(name1, :white)
  player2 = HumanPlayer.new(name2, :black)
  Game.new(player1, player2).play
end
