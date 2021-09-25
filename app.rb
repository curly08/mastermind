# frozen_string_literal: true

require 'pry-byebug'

# Mastermind module
module Mastermind
  # Game class
  class Game
    attr_reader :code, :codebreaker, :guess

    def initialize
      choose_role
      @code = Code.new.code
      # p code # delete later
      @game_over = false
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

    private

    def choose_role
      puts 'Do you want to be the codebreaker or the codemaker?'
      case gets.chomp.downcase
      when 'codebreaker'
        @codebreaker = HumanPlayer.new('codebreaker')
        @codemaker = ComputerPlayer.new('codemaker')
      when 'codemaker'
        @codebreaker = ComputerPlayer.new('codebreaker')
        @codemaker = HumanPlayer.new('codemaker')
      end
    end

    def provide_feedback
      calculate_white_pegs
      calculate_colored_pegs
      puts "Colored Key Pegs: #{@num_of_colored_key_pegs}\nWhite Key Pegs: #{@num_of_white_key_pegs}"
    end

    def calculate_colored_pegs
      @num_of_colored_key_pegs = 0
      guess.each_with_index do |color, index|
        if code[index] == color
          @num_of_colored_key_pegs += 1
          @num_of_white_key_pegs -= 1
        end
      end
    end

    def calculate_white_pegs
      @num_of_white_key_pegs = 0
      guess.uniq.each do |color|
        if code.any?(color)
          @num_of_white_key_pegs += code.count(color) < guess.count(color) ? code.count(color) : guess.count(color)
        end
      end
      @num_of_white_key_pegs
    end

    def winner
      @game_over = true
      puts "Congratulations, #{codebreaker.name}! You cracked the code!"
    end

    def loser
      @game_over = true
      puts "#{codebreaker.name}, you did not crack the code within 12 rounds. You lose. The code was #{code}"
    end
  end

  # Code class
  class Code
    attr_reader :code

    @@possible_code_values = %w[blue red green pink yellow purple]

    def initialize(code = randomize_code)
      @code = code
    end

    private

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
      puts "\nWhat is your guess, #{name}?"
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

  # HumanPlayer class
  class HumanPlayer
    attr_reader :name

    def initialize(role)
      puts 'What is your name, codebreaker?'
      @name = gets.chomp
      @role = role
    end
  end

  # ComputerPlayer class
  class ComputerPlayer
    attr_reader :name

    def initialize(role)
      @name = 'COMPUTER'
      @role = role
    end
  end
end

include Mastermind

Game.new.play_game
