module Tetris
  class Game
    attr_reader :board, :current_tetromino, :next_tetromino, :score, :game_over
    attr_accessor :score, :next_tetromino

    def initialize(board)
      @board = board
      @score = 0
      @game_over = false  # Initialize @game_over here
      @current_tetromino = Tetromino.new_random
      @next_tetromino = Tetromino.new_random
      # Any other initial setup as needed
    end

    def setup_game
      # This method sets up the game, potentially resetting the board and score if restarting.
      reset_board
      reset_score
    end

    def reset_board
      @board.clear
    end

    def reset_score
      @score = 0
    end

    def tick
      # Try to move the current tetromino down
      moved = move_tetromino_down(@current_tetromino)

      unless moved
        # The tetromino couldn't move down, meaning it has landed
        place_tetromino(@current_tetromino)
        cleared_rows = @board.clear_lines
        update_score(cleared_rows)
        @current_tetromino = @next_tetromino
        @next_tetromino = Tetromino.new_random
        @over = @board.game_over?(@current_tetromino)
      end
    end

    # Additional methods for game logic like updating the game state, handling tetromino placement, etc.

    def update_game_state
      # Assuming there's logic here to handle the movement and placement of the current tetromino

      # After placing a tetromino, check if the next tetromino can be placed
      if @board.game_over?(@next_tetromino)
        @game_over = true
      else
        # Proceed with the game
        @current_tetromino = @next_tetromino
        @next_tetromino = Tetromino.new_random
      end
    end

    def over?
      @game_over
    end

    def move_tetromino_left
      new_position = { x: @current_tetromino.position[:x] - 1, y: @current_tetromino.position[:y] }
      move_tetromino(new_position)
    end

    def move_tetromino_right
      new_position = { x: @current_tetromino.position[:x] + 1, y: @current_tetromino.position[:y] }
      move_tetromino(new_position)
    end

    def rotate_tetromino
      rotated_tetromino = @current_tetromino.rotate
      if @board.can_place?(rotated_tetromino, @current_tetromino.position)
        @current_tetromino = rotated_tetromino
      end
    end

    def drop_tetromino
      loop do
        moved = move_tetromino_down(@current_tetromino)
        break unless moved
      end
    end

    private

    def move_tetromino_down(tetromino)
      new_position = { x: tetromino.position[:x], y: tetromino.position[:y] + 1 }
      if @board.can_place?(tetromino, new_position)
        tetromino.position = new_position
        true
      else
        false
      end
    end

    def move_tetromino(new_position)
      if @board.can_place?(@current_tetromino, new_position)
        @current_tetromino.position = new_position
        true
      else
        false
      end
    end

    def place_tetromino(tetromino)
      @board.place_tetromino(tetromino)
    end

    def update_score(cleared_rows)
      # Increase score based on the number of cleared rows
      @score += 100 * cleared_rows
    end
  end
end
