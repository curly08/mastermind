# frozen_string_literal: true

# Mastermind module
module Mastermind
  # Game class
  class Game
    def initialize(codebreaker)
      @codebreaker = codebreaker
    end

    # create random code
  end

  # Player class
  class Player
    attr_reader :name

    def initialize(name)
      @name = name
    end

    # attempt to guess code
  end

  # HumanPlayer(aka codebreaker) class
  class HumanPlayer < Player
  end

  # ComputerPlayer(aka codemaker) class
  class ComputerPlayer < Player
  end

  # DecodingBoard class
  class DecodingBoard
  end

  # CodePegs class
  class CodePegs
  end

  # CodePegs subclass for each of the six different colors?

  # KeyPegs class
  class KeyPegs
  end

  # BlackKeyPegs class
  class BlackKeyPegs
  end

  # WhiteKeyPegs class
  class WhiteKeyPegs
  end
end

include Mastermind
