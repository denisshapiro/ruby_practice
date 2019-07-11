# Class to create board
class Board
  attr_accessor :board_arr

  def initialize
    @board_arr = (1..9).to_a
  end

  def access_data(arr, row, col)
    arr[row * 3 + col]
  end

  def draw_board(arr = @board_arr)
    puts "\n"
    arr.each_with_index do |elem, index|
      if [1, 4, 7].include? index
        print "| #{elem} |"
      elsif [2, 5, 8].include? index
        puts " #{elem} \n---+---+---"
      else
        print " #{elem} "
      end
    end
    puts "\n"
  end
end

# Class to enable interactive gameplay
class Game
  X = 'X'.freeze
  O = 'O'.freeze

  def initialize
    @winning_pos = [
      [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 4, 8], [2, 4, 6]
    ]
    @board = Board.new
    @current_player = ''
    start_game
  end

  def same?(el1, el2, el3)
    el1 == el2 && el2 == el3
  end

  def endgame?(arr)
    @winning_pos.each do |indexes|
      return true if same?(arr[indexes[0]], arr[indexes[1]], arr[indexes[2]])
    end
    false
  end

  def greeting
    puts "\n"
    puts '*************************************************'
    puts '******** Welcome To My Tic-Tac-Toe Game! ********'
    puts '*************************************************'
    puts '================================================='
    puts '********************* RULES *********************'
    puts 'Two players will take turns to mark the spaces on'
    puts 'a 3x3 grid. The player who succeeds in placing 3 '
    puts 'of their marks in a horizontal, vertical, or     '
    puts 'diagonal row wins the game. When there are no    '
    puts 'more spaces left to mark, it is consider a draw. '
    puts 'To place a mark on the grid, type the number on  '
    puts 'the space you would like to mark! As shown below.'
    puts "Good luck! \n "
  end

  def set_mark
    @player1 = Player.new('Player 1')
    loop do
      puts 'Please choose a mark Player 1, X or O ?'
      @player1.mark = gets.chomp.upcase
      break if @player1.mark == 'X'|| @player1.mark == 'O'
    end
    @player2 = Player.new('Player 2', @player1.mark == X ? O : X)
    puts "\nPlayer 1's mark is #{@player1.mark}, Player 2's mark is #{@player2.mark}.\n\n"
  end

  def box_selection
    loop do
      puts "Please write number of the box, where you would like to put your mark #{@current_player.name}"
      @selection = gets.chomp.to_i
      break if @board.board_arr.include? @selection
    end
    @board.board_arr[@board.board_arr.find_index(@selection)] = @current_player.mark
    @current_player = @current_player == @player1 ? @player2 : @player1
    @board.draw_board
  end

  def start_game
    greeting
    set_mark
    @board.draw_board
    @current_player = @player1
    box_selection
  end
end

# Player class
class Player
  attr_accessor :won, :mark, :name
  def initialize(player, mark = '')
    @name = player
    @won = false
    @mark = mark
  end
end

b = Game.new

