# frozen_string_literal: true

require 'pry-byebug'

# Mastermind module
module Mastermind
  # Game class
  class Game
    attr_reader :code, :codebreaker, :guess

    def initialize
      @codebreaker = Player.new
      @code = Code.new.code
      p code # delete later
      @game_over = false
      play_game
    end

    def play_game
      # binding.pry
      while @game_over == false
        @guess = GuessAttempt.new(codebreaker.name).guess
        return loser if GuessAttempt.num_of_guesses == GuessAttempt.max_num_of_guesses
        return winner if code.eql?(guess)

        provide_feedback
      end
    end

    def provide_feedback
      @num_of_black_key_pegs = 0
      @num_of_white_key_pegs = 0
      guess.each_with_index do |color, index|
        if code[index] == color
          @num_of_black_key_pegs += 1
        elsif code.include?(color)
          @num_of_white_key_pegs += 1
        end
      end
      puts "Black Key Pegs: #{@num_of_black_key_pegs}\nWhite Key Pegs: #{@num_of_white_key_pegs}"
    end

    def winner
      @game_over = true
      puts "Congratulations, #{codebreaker.name}! You cracked the code!"
    end

    def loser
      @game_over = true
      puts "#{codebreaker.name}, you did not crack the code within 12 rounds. You lose."
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
end

include Mastermind

Game.new
