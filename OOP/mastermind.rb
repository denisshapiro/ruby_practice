# gem install colorize
# gem install win32console  # if on Windows
require 'colorize'

# Set up game class
class Game
  def initialize
    start_game
    @role = ''
  end

  def display_welcome
    puts "\n"
    puts '*************************************************'
    puts '******** Welcome To The Mastermind Game! ********'
    puts '*************************************************'
    puts '================================================='
  end

  def choose_role
    loop do
      puts "\nWhich role would you like to play as?"
      puts 'Code Maker (1) || Code Breaker (2)'
      @role = gets.chomp.to_i
      break if [1, 2].include? @role
    end
  end

  def display_instructions
    puts "\n"
    puts '*************************************************'
    puts '****************  Instructions  *****************'
    puts '*************************************************'
    puts '================================================='

    @role == 1 ? code_maker_instructions : code_breaker_instructions

    puts '3. Each time you enter your guesses, the computer'
    puts '   will give you some hints on whether your guess'
    puts '   had correct digit, incorrect digits or correct'
    puts "   digits that are in the incorrect position.\n  "
    puts '*************************************************'
    puts '*************   GUIDES TO HINTS   ***************'
    puts '*************************************************'
    puts '================================================='
    puts '1. If you get a digit correct and it is in the   '
    puts '   correct position, the digit will be colored   '
    puts "   #{'green'.green}."
    puts '2. If you get a digit correct but in the wrong   '
    puts '   position, the digit will be colored white.     '
    puts '3. If you get the digit incorrect, the digit will'
    puts "   be colored #{'red'.red}.\n "
    puts 'For example:'
    puts 'If the secret code is:'
    puts '1523'
    puts 'and your guess was:'
    puts '1562'
    puts 'You will see the following result:'
    puts "#{'15'.green}#{'6'.red}2"
  end

  def code_maker_instructions
    puts '1. You will create a 4 digits secret code. The   '
    puts '   code must be between 1 to 6.'
    puts '2. The AI/Computer will have 5 guesses to try and'
    puts '   crack your secret code. You win if your secret'
    puts '   code is not cracked'
  end

  def code_breaker_instructions
    puts '1. You have to break the secret code in order to '
    puts '   win the game'
    puts '2. You are given 5 guesses to break the code. The'
    puts '   code ranges between 1 to 6. A number can be   '
    puts '   repeated more than once!'
  end

  def init_role
    @role == 1 ? Codemaker.new : Codebreaker.new
  end

  def play_again?
    loop do
      puts 'Play Again? (Y/N)'
      @answer = gets.chomp.upcase
      break if @answer == 'Y' || @answer == 'N'
    end

    Game.new if @answer == 'Y'
    puts 'Thanks for Playing!' if @answer == 'N'
  end

  def start_game
    display_welcome
    choose_role
    display_instructions
    init_role
    play_again?
  end
end

# Breaking code made by computer
class Codebreaker
  attr_reader :code, :guess

  def initialize
    @guesses_left = 5
    play
  end

  def create_code
    @code = []
    4.times do
      @code.push(rand(1..6))
    end
  end

  def display_code
    puts @code.join('')
  end

  def valid_guess?
    @guess.length == 4 &&
      @guess.scan(/\D/).empty? &&
      @guess.each_char { |e| return false unless (1..6).member?(e.to_i) }
  end

  def code_guess
    loop do
      puts 'Enter 4 numbers within the range of 1 to 6 to guess the secret code!'
      @guess = gets.chomp
      break if valid_guess?
    end
  end

  def guesses_remaining
    puts @guesses_left == 1 ? "\nYou have #{@guesses_left} guess remaining." : "\nYou have #{@guesses_left} guesses remaining."
    @guesses_left -= 1
  end

  def display_guess
    @colored = []
    @count = 0
    @guess.each_char do |char|
      if char.to_i == @code[@count]
        @colored.push(char.green)
      elsif !@code.include? char.to_i
        @colored.push(char.red)
      else
        @colored.push(char)
      end
      @count += 1
    end
    @colored.join('')
  end

  def ask_guess
    loop do
      guesses_remaining
      code_guess
      puts display_guess
      break if @guess.to_i == @code.join('').to_i || @guesses_left == 0
    end
  end

  def conclude
    if @guess.to_i == @code.join('').to_i
      puts "\nThe code breaker has cracked the secret code! The code breaker wins!"
    else
      puts "\nThe secret code was #{@code.join('')}. The code maker wins!"
    end
  end

  def play
    create_code
    ask_guess
    conclude
  end
end

# Create code to be broken by computer
class Codemaker
  def initialize
    @guesses_left = 5
    @guess = %w[1 1 2 2]
    @discarded_nums = []
    @reuse_nums = Hash.new { |h, k| h[k] = [] }
    play
  end

  def valid_code?
    @code.length == 4 &&
      @code.scan(/\D/).empty? &&
      @code.each_char { |e| return false unless (1..6).member?(e.to_i) }
  end

  def input_code
    loop do
      puts "\nEnter 4 numbers within the range of 1 to 6 to make the secret code!"
      @code = gets.chomp
      break if valid_code?
    end
  end

  def keep_pos?(index)
    @guess[index] == @code[index]
  end

  def proper_random(index)
    num = 0
    loop do
      num = rand(1..6)
      break unless @discarded_nums.include?(num) || @reuse_nums[index].include?(num)
    end
    num.to_s
  end

  def code_guess
    puts 'Computer enters 4 numbers within the range of 1 to 6 to guess the secret code!'
    @guess.each_with_index do |_num, index|
      @guess[index] = proper_random(index) unless keep_pos?(index)
    end
  end

  def guesses_remaining
    puts @guesses_left == 1 ? "\nComputer has #{@guesses_left} guess remaining." : "\nComputer has #{@guesses_left} guesses remaining."
    @guesses_left -= 1
  end

  def display_guess
    @colored = []
    @count = 0
    @guess.each do |char|
      if char == @code[@count]
        @colored.push(char.green)
      elsif !@code.include? char
        @colored.push(char.red)
        @discarded_nums.push(char.to_i)
      else
        @colored.push(char)
        @reuse_nums[@count].push(char.to_i)
      end
      @count += 1
    end
    @colored.join('')
  end

  def ask_guess
    loop do
      guesses_remaining
      code_guess if @guesses_left < 4
      puts display_guess
      break if @guess.join('') == @code || @guesses_left == 0
    end
  end

  def conclude
    if @guess.join('') == @code
      puts "\nThe code breaker has cracked the secret code! The code breaker wins!"
    else
      puts "\nThe secret code was #{@code}. The code maker wins!"
    end
  end

  def play
    input_code
    ask_guess
    conclude
  end
end

Game.new
