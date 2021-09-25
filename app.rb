# frozen_string_literal: true

require 'pry-byebug'

# Mastermind module
module Mastermind
  # Game class
  class Game
    attr_reader :name, :code, :codebreaker, :codemaker, :guess_attempt

    def initialize
      @name = ask_for_name
      choose_role
      @code = codemaker.create_code
      p code # delete later
      @game_over = false
    end

    # this will have to be refactored depending on the role chosen
    def play_game
      # binding.pry
      while @game_over == false
        puts "\nWhat is your guess, #{codebreaker.name}?"
        codebreaker.guess
        return loser if Player.num_of_guesses == Player.max_num_of_guesses
        return winner if code.eql?(codebreaker.guess_attempt)

        provide_feedback(codebreaker.guess_attempt)
      end
    end

    private

    def ask_for_name
      puts "\nWhat is your name?"
      gets.chomp
    end

    def choose_role
      puts "\nDo you want to be the codebreaker or the codemaker?"
      case gets.chomp.downcase
      when 'codebreaker'
        @codebreaker = HumanPlayer.new('codebreaker', name)
        @codemaker = ComputerPlayer.new('codemaker')
      when 'codemaker'
        @codebreaker = ComputerPlayer.new('codebreaker')
        @codemaker = HumanPlayer.new('codemaker', name)
      end
    end

    def provide_feedback(guess)
      calculate_white_pegs(guess)
      calculate_colored_pegs(guess)
      puts "Colored Key Pegs: #{@num_of_colored_key_pegs}\nWhite Key Pegs: #{@num_of_white_key_pegs}"
    end

    def calculate_colored_pegs(guess)
      @num_of_colored_key_pegs = 0
      guess.each_with_index do |color, index|
        if code[index] == color
          @num_of_colored_key_pegs += 1
          @num_of_white_key_pegs -= 1
        end
      end
    end

    def calculate_white_pegs(guess)
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
      puts "\nCongratulations, #{codebreaker.name}! You cracked the code!"
    end

    def loser
      @game_over = true
      puts "\n#{codebreaker.name}, you did not crack the code within 12 rounds. You lose. The code was #{code}"
    end
  end

  # Player class
  class Player
    attr_reader :name, :role, :guess_attempt

    @@possible_code_values = %w[blue red green pink yellow purple]
    @@num_of_guesses = 0
    @@max_num_of_guesses = 12
    @@guess_attempts = []

    def initialize(role)
      @role = role
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
  class HumanPlayer < Player
    def initialize(role, name)
      super(role)
      @name = name
    end

    def create_code
      puts "\nCreate a code consisting of 4 values using the following values (you can repeat colors): #{@@possible_code_values}"
      gets.chomp.split(' ')
    end

    def guess
      @guess_attempt = gets.chomp.split(' ')
      @@guess_attempts << @guess
      @@num_of_guesses += 1
    end
  end

  # ComputerPlayer class
  class ComputerPlayer < Player
    def initialize(role)
      super(role)
      @name = 'COMPUTER'
    end

    def create_code
      4.times.map { @@possible_code_values.sample }
    end

    def guess
      @guess_attempt = gets.chomp.split(' ')
      @@guess_attempts << @guess
      @@num_of_guesses += 1
    end
  end
end

include Mastermind

Game.new.play_game
