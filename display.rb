require 'colorize'
require_relative 'board'
require_relative 'cursor'

class Display

  def initialize(board, current_pos, selected_pos, messages = Hash.new)
    @board = board
    @current_pos, @selected_pos = current_pos, selected_pos
    @messages = messages
    get_moves_positions
  end

  def get_input
    cursor = Cursor.new(current_pos, board)
    until cursor.selected?
      render
      self.current_pos = cursor.get_input
      system 'clear'
    end
    current_pos
  end

  def get_moves_positions
    if @selected_pos
      @moves_positions = board[@selected_pos].moves
    else
      @moves_positions = []
    end
  end

  def pos_highlight(pos)
    case pos
    when current_pos
      return :light_red
    when selected_pos
      return :light_blue
    end

    if moves_positions.include?(pos)
      return :cyan
    end

    if pos[0].even?
      pos[1].odd? ? :yellow : :white
    else
      pos[1].even? ? :yellow : :white
    end
  end

  def print_board
    board.grid.each.with_index do |row, row_idx|
      row.each.with_index do |piece, col_idx|
        highlight_color = pos_highlight([row_idx, col_idx])

        print " #{piece} ".colorize(background: highlight_color)
      end
      puts ""
    end
  end

  def render
    puts messages[:start]
    print_board
    puts messages[:errors]
  end

  private

  attr_accessor :current_pos
  attr_reader :board, :selected_pos, :moves_positions, :messages
end
