# frozen_string_literal: true

# Mastermind module
module Mastermind
  # Game class
  class Game
    attr_reader :code, :codebreaker, :guess

    def initialize
      @codebreaker = Player.new
      @code = Code.new.code
      puts code
      @game_over = false
      play_game
    end

    def play_game
      while @game_over == false && GuessAttempt.num_of_guesses != GuessAttempt.max_num_of_guesses
        @guess = GuessAttempt.new(codebreaker.name).guess
        compare_guess(code, guess)
      end
    end

    def compare_guess(code, guess)
      check_for_correct_guess(code, guess)
    end

    def check_for_correct_guess(code, guess)
      return nil unless guess == code

      @game_over = true
      puts "Congratulations, #{codebreaker.name}! You cracked the code!"
    end
  end

  # Player class
  class Player
    attr_reader :name

    def initialize
      puts 'What is your name, codebreaker?'
      @name = gets.chomp
    end
  end

  # Code class
  class Code
    attr_reader :code

    @@possible_code_values = %w[blue red green pink yellow purple]

    def initialize(code = randomize_code)
      @code = code
    end

    def randomize_code
      4.times.map { @@possible_code_values.sample }
    end
  end

  # Guess Attempt class
  class GuessAttempt
    attr_reader :guess

    @@num_of_guesses = 0
    @@max_num_of_guesses = 12
    @@guess_attempts = []

    def initialize(name)
      puts "What is your guess, #{name}?"
      @guess = gets.chomp.split(' ')
      @@guess_attempts << @guess
      @@num_of_guesses += 1
    end

    def self.guess_attempts
      @@guess_attempts
    end

    def self.num_of_guesses
      @@num_of_guesses
    end

    def self.max_num_of_guesses
      @@max_num_of_guesses
    end
  end

  # # HumanPlayer(aka codebreaker) class
  # class HumanPlayer < Player
  # end

  # # ComputerPlayer(aka codemaker) class
  # class ComputerPlayer < Player
  # end

  # # DecodingBoard class
  # class DecodingBoard
  # end

  # # CodePegs class
  # class CodePegs
  # end

  # # CodePegs subclass for each of the six different colors?

  # # KeyPegs class
  # class KeyPegs
  # end

  # # BlackKeyPegs class
  # class BlackKeyPegs
  # end

  # # WhiteKeyPegs class
  # class WhiteKeyPegs
  # end
end

include Mastermind

Game.new
