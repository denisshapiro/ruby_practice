require 'colorize'
# class to create game board
class Board
  attr_accessor :squares

  def initialize(starting_x, starting_y)
    @squares = Array.new(8) { Array.new(8, ' ') }
    @knight_piece = '♞'.green
    @vertical = [8, 7, 6, 5, 4, 3, 2, 1]
    @horizontal =  '    a   b   c   d   e   f   g   h'
    @row_separator = '    +---+---+---+---+---+---+---+---+'
    puts "sarting x is #{starting_x}"
    puts "sarting y is #{starting_y}"
    starting_y = 7 - ((starting_y + 8) % 8)
    @squares[starting_y][starting_x] = @knight_piece
  end

  def change(x_coord, y_coord, char)
    y_coord = 7 - ((y_coord + 8) % 8)
    @squares[y_coord][x_coord] = char
    display_board
  end

  def print_row(row_arr)
    str = ''
    row_arr.each do |square|
      str += "| #{square} "
    end
    str
  end

  def display_board
    @squares.each_with_index do |row, index|
      puts @row_separator
      puts " #{@vertical[index]}  #{print_row(row)}|"
    end
    puts @row_separator
    puts "  #{@horizontal}"
  end
end

#class for calculating knight moves
class KnightMove
  def initialize
    @starting = nil
    @ending = nil
    @x_moves = [2, 1, -1, -2, -2, -1, 1, 2]
    @y_moves = [1, 2, 2, 1, -1, -2, -2, -1]
    run
  end

  def valid_pos?(pos)
    pos.match(/^[a-h][1-8]$/)
  end

  def convert_letter_to_number(letter)
    (letter.ord - 97) % 8
  end

  def init_board(starting_x, starting_y)
    @board = Board.new(starting_x, starting_y)
    @board.display_board
  end

  def input_positions
    loop do
      puts 'Starting Position? (e.g a1)'
      @starting = gets.chomp.downcase
      break if valid_pos?(@starting)
    end
    loop do
      puts 'Ending Position? (e.g g7)'
      @ending = gets.chomp.downcase
      break if valid_pos?(@ending)
    end
    @starting = [convert_letter_to_number(@starting[0]), @starting[1].to_i - 1]
    @ending = [convert_letter_to_number(@ending[0]), @ending[1].to_i - 1]
  end

  def possible_from_current(current)
    @x_curr = current[0]
    @y_curr = current[1]
    # 8 possible at maximum
    @possible = []

    8.times do |index|
      x_coord = @x_curr + @x_moves[index]
      y_coord = @y_curr + @y_moves[index]
      @possible.push([x_coord, y_coord]) if on_board?(x_coord, y_coord)
    end
    p @possible
    @possible
  end

  def on_board?(x_coord, y_coord)
    x_coord.between?(0, 7) && y_coord.between?(0, 7)
  end

  def run
    input_positions
    init_board(@starting[0], @starting[1])
    possible_from_current(@starting)
  end
end

Node = Struct.new(:pos, :children)

# Class to implement BFS and search for shortest path to destination
class BST
  def initialize; end

  def new_node(pos)
    @temp = Node.new(pos, nil)
    @temp
  end

  def fact(n)
    (1..n).inject(:*) || 1
  end
end

KnightMove.new
