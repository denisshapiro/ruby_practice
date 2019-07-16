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
  def initialize(filename = nil)
    @word = Dictionary.choose_word
    @guessed_wrong_letters = []
    @guessed_right_letters = Array.new(@word.length, '_ ')
    @wrong_guesses_taken = 0
    @hangman_display = nil
    @draw = nil
    @file_name = filename
    load_prompt
    @guess = nil
  end

  def save_game
    game_data = {
      draw: @draw,
      guessed_wrong_letters: @guessed_wrong_letters,
      wrong_guesses_taken: @wrong_guesses_taken,
      word: @word,
      guess: @guess,
      guessed_right_letters: @guessed_right_letters
    }

    Dir.mkdir('saves') unless Dir.exist? 'saves'

    puts 'WARNING! If the filename already exist the data on that file will be overwritten!'
    print 'Enter a filename for your save: '
    filename = gets.chomp

    File.open("saves/#{filename}.yaml", 'w') do |file|
      file.puts game_data.to_yaml
    end

    puts 'Your progress has been saved!'
  end

  def load_game
    filename = nil
    loop do
      print 'Please enter an existing filename: '
      filename = gets.chomp
      break if File.exist? "saves/#{filename}.yaml"
    end

    game_data = YAML.load_file("saves/#{filename}.yaml")

    @draw = game_data[:draw]
    @guessed_wrong_letters = game_data[:guessed_wrong_letters]
    @wrong_guesses_taken = game_data[:wrong_guesses_taken]
    @word = game_data[:word]
    @guess = game_data[:guess]
    @guessed_right_letters = game_data[:guessed_right_letters]
    play
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
    puts "your progress, type 'save' without the quotes\n\n"
  end

  def secret_word
    puts "Secret Word: #{@guessed_right_letters.join}"
  end

  def guess_prompt
    loop do
      print "\n\nPlease enter your guess: "
      @guess = gets.chomp.downcase
      save_game if @guess == 'save'
      break if @guess.match(/[a-z]/) && @guess.length == 1 && !(@guessed_wrong_letters.include? @guess)
    end
  end

  def wrong_remaining
    puts "You have #{8 - @wrong_guesses_taken} wrong guesses left"
  end

  def check_guess
    if @word.include? @guess
      @guessed_right_letters.each_with_index do |_pos, index|
        @guessed_right_letters[index] = @guess.green + ' ' if @word[index] == @guess
      end
    else
      @guessed_wrong_letters.push(@guess)
      @wrong_guesses_taken += 1
      @draw = DrawGame.draw_man(@wrong_guesses_taken)
      wrong_remaining
    end
    puts "You tried: #{@guessed_wrong_letters}"
  end

  def endgame?
    !(@guessed_right_letters.include? '_ ') || (@wrong_guesses_taken == 8)
  end

  def end_text
    if @wrong_guesses_taken == 8
      puts "\nGame Over! You have ran out of guesses"
      puts "The secret word was #{@word.blue}"
    else
      puts "\nCongratulations you won!"
    end
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

  def ask_guesses
    loop do
      guess_prompt
      check_guess
      secret_word
      break if endgame?
    end
  end

  def play
    welcome_message
    secret_word
    ask_guesses
    end_text
    play_again?
  end
end

Game.new
