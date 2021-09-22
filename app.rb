# frozen_string_literal: true

# Mastermind module
module Mastermind
  # Game class
  class Game
    def initialize(codemaker, codebreaker)
      @codemaker = codemaker
      @codebreaker = codebreaker
    end
  end

  # Player class
  class Player
    attr_reader :name

    def initialize(name)
      @name = name
    end
  end

  # Codebreaker class
  class Codebreaker < Player
  end

  # Codemaker class
  class Codemaker < Player
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

  def establish_codemaker
    puts 'Who will be the codemaker?'
    Codemaker.new(gets.chomp)
  end

  def establish_codebreaker
    puts 'Who will be the codebreaker?'
    Codebreaker.new(gets.chomp)
  end
end

include Mastermind

codemaker = establish_codemaker
codebreaker = establish_codebreaker
Game.new(codemaker, codebreaker)
