module Tetris
  class Tetromino
    attr_accessor :position

    SHAPES = {
      O: [
        [[1, 1],
         [1, 1]]
      ],
      I: [
        [[1, 1, 1, 1]],
        [[1],
         [1],
         [1],
         [1]]
      ],
      S: [
        [[0, 1, 1],
         [1, 1, 0]],
        [[1, 0],
         [1, 1],
         [0, 1]]
      ],
      Z: [
        [[1, 1, 0],
         [0, 1, 1]],
        [[0, 1],
         [1, 1],
         [1, 0]]
      ],
      L: [
        [[1, 0],
         [1, 0],
         [1, 1]],
        [[1, 1, 1],
         [1, 0, 0]],
        [[1, 1],
         [0, 1],
         [0, 1]],
        [[0, 0, 1],
         [1, 1, 1]]
      ],
      J: [
        [[0, 1],
         [0, 1],
         [1, 1]],
        [[1, 0, 0],
         [1, 1, 1]],
        [[1, 1],
         [1, 0],
         [1, 0]],
        [[1, 1, 1],
         [0, 0, 1]]
      ],
      T: [
        [[1, 1, 1],
         [0, 1, 0]],
        [[0, 1],
         [1, 1],
         [0, 1]],
        [[0, 1, 0],
         [1, 1, 1]],
        [[1, 0],
         [1, 1],
         [1, 0]]
      ]
    }

    attr_reader :shape, :rotation, :position

    def initialize(shape, position = { x: 0, y: 0 })
      @shape = shape
      @rotation = 0
      @position = position
    end

    def current_shape
      SHAPES[@shape][@rotation]
    end

    def rotate(clockwise: true)
      rotations = SHAPES[@shape].size
      @rotation = clockwise ? (@rotation + 1) % rotations : (@rotation - 1 + rotations) % rotations
    end

    # Factory method to create a tetromino with a random shape
    def self.new_random
      shape = SHAPES.keys.sample
      Tetromino.new(shape)
    end
  end
end
