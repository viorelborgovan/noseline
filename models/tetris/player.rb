module Tetris
  class Player
    attr_accessor :score
    attr_reader :name

    def initialize(name)
      @name = name
      @score = 0
    end

    # Other player-related methods
  end
end
