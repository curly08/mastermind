# frozen_string_literal: true

# Mastermind module
module Mastermind
  # Game class
  class Game
    attr_reader :code, :codebreaker

    def initialize
      @codebreaker = Player.new.name
      @code = Code.new.code
    end
  end

  # Player class
  class Player
    attr_reader :name

    def initialize
      puts 'What is your name, codebreaker?'
      @name = gets.chomp
    end

    # attempt to guess code
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
    @@guess_attempts = []

    def initialize
      puts 'What is your guess?'
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

# new_game = Game.new
# puts new_game.code
# puts new_game.codebreaker
