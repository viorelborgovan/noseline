module Tetris
  class Board
    attr_reader :grid

    def initialize(width = 10, height = 20)
      @width = width
      @height = height
      @grid = Array.new(height) { Array.new(width, 0) }
    end

    def place_tetromino(tetromino)
      shape = tetromino.current_shape
      x_offset = tetromino.position[:x]
      y_offset = tetromino.position[:y]

      shape.each_with_index do |row, dy|
        row.each_with_index do |cell, dx|
          if cell != 0
            @grid[y_offset + dy][x_offset + dx] = 1 if within_bounds?(x_offset + dx, y_offset + dy)
          end
        end
      end
    end

    # Updated can_place? method to accept a tetromino and a new_position
    def can_place?(tetromino, new_position)
      shape = tetromino.current_shape
      x_offset = new_position[:x]
      y_offset = new_position[:y]

      shape.each_with_index do |row, dy|
        row.each_with_index do |cell, dx|
          next if cell == 0
          return false unless within_bounds?(x_offset + dx, y_offset + dy)
          return false if @grid[y_offset + dy][x_offset + dx] != 0
        end
      end
      true
    end

    def within_bounds?(x, y)
      x >= 0 && x < @width && y >= 0 && y < @height
    end

    def clear_lines
      @grid.reject! { |row| row.all? { |cell| cell != 0 } }
      lines_cleared = @height - @grid.size
      @grid.unshift(Array.new(@width, 0) * lines_cleared) unless lines_cleared == 0
      lines_cleared
    end

    def game_over?(tetromino)
      # Assuming the starting position for a new tetromino
      starting_position = { x: (@width / 2) - (tetromino.current_shape[0].length / 2), y: 0 }
      !can_place?(tetromino, starting_position)
    end
  end
end
