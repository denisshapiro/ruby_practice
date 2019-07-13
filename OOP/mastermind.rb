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

  def start_game
    display_welcome
    choose_role
    display_instructions
    init_role
  end
end

# Breaking code made by computer
class Codebreaker
  def initialize
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

  def play
    create_code
    display_code
  end
end

# Create code to be broken by computer
class Codemaker
  def initialize; end
end


Game.new