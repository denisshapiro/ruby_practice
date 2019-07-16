require 'yaml'
require 'colorize'

# Dictionary class to select word
class Dictionary
  @file = '5desk.txt'
  @dictionary = File.readlines(@file)
  @min_length = 5
  @max_length = 12

  def initialize; end

  def self.choose_word
    loop do
      @word = @dictionary[rand(@dictionary.length)].gsub("\r\n", "").downcase
      break if @word.length.between?(@min_length, @max_length)
    end
    @word
  end
end

class DrawGame
  @@gallow = "───────────" 
  @@noose = " \\|      | " 
  @@head = "  |      O " 
  @@body = "  |      | " 
  @@left_arm = "  |     /| "
  @@both_arms = "  |     /|\\"
  @@left_leg = "  |     /  " 
  @@both_legs = "  |     / \\" 

  @@parts = [@@gallow, @@noose, @@head, [@@body, @@left_arm, @@both_arms], [@@left_leg, @@both_legs]]

  def self.draw_man(guesses_taken)
    index = 0
    while guesses_taken != index
      if (@@parts[index].is_a? Array) && (@@parts[index].length == 3)
        case guesses_taken
        when 4
          puts @@parts[index][0].center(20)
        when 5
          puts @@parts[index][1].center(20)
        when (6..8)
          puts @@parts[index][2].center(20)
        end
      elsif (@@parts[index].is_a? Array) && (@@parts[index].length == 2)
        case guesses_taken
        when 7
          puts @@parts[index][0].center(20)
        when 8
          puts @@parts[index][1].center(20)
        end
      elsif @@parts[index].is_a? String
        puts @@parts[index].center(20)
      end
      index += 1
    end
  end
end

# Game class to setup hangman
class Game
  def initialize
    @word = Dictionary.choose_word
    @guessed_wrong_letters = []
    @guessed_right_letters = Array.new(@word.length, '_ ')
    @guesses_taken = 0
    load_prompt
    @guess = nil
  end

  def load_prompt
    loop do
      puts 'Would you like to start a new game or load a previous save?'
      puts '1. New Game || 2. Load Game'
      print 'Please select 1 or 2: '
      @input = gets.chomp
      break if @input == '1' || @input == '2'
    end
    @input == '1' ? play : load_game
  end

  def welcome_message
    puts '***************************************'
    puts '**** Welcome To The Hangman Game! *****'
    puts '***************************************'
    puts '======================================='
    puts '************ Instructions *************'
    puts '***************************************'
    puts '1. The objective of the game is to guess'
    puts 'letters to a secret word. The secret word'
    puts 'is represented by a series of horizontal'
    puts 'lines indicating its length. '
    puts 'For example:'
    puts 'If the secret word is "chess", then it will '
    puts 'be displayed as:'
    puts '_ _ _ _ _ \n '
    puts '2. You are given 8 chances. For each incorrect'
    puts 'guess, the chances will decrease by 1. For each correct'
    puts 'guess, part of the secret word is revealed'
    puts 'For example: If your guess is "s" then the result'
    puts 'of the guess will be:'
    puts '_ _ _ s s \n '
    puts '3. When you guessed all the correct letters to the secret word'
    puts 'or when you are out of chances, it will be game over.'
    puts '4. Any time during the game, if you would like to save'
    puts 'your progress, type "save--" without the quotes'
  end

  def secret_word
    puts "\nSecret Word: #{@guessed_right_letters.join()}"
  end

  def guess_prompt
    loop do
      print "Please enter your guess: "
      @guess = gets.chomp.downcase
      break if @guess.match(/[a-z]/) && @guess.length == 1
    end
  end

  def play
    welcome_message
    secret_word
    guess_prompt
  end
end

Game.new

