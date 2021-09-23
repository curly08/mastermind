# frozen_string_literal: true

# Mastermind module
module Mastermind
  # Game class
  class Game
    attr_reader :code

    def initialize(codebreaker)
      @codebreaker = codebreaker
      @code = Code.new.code
    end
  end

  # Player class
  class Player
    attr_reader :name

    def initialize(name)
      @name = name
    end

    # attempt to guess code
  end

  # Code class
  class Code
    @@possible_code_values = %w[blue red green pink yellow purple]

    attr_reader :code

    def initialize
      @code = randomize_code
    end

    def randomize_code
      4.times.map { @@possible_code_values.sample }
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

new_game = Game.new('matt')
