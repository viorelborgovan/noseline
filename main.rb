require 'io/console'
require 'timeout'
require_relative 'models/tetris/board'
require_relative 'models/tetris/tetromino'
require_relative 'models/tetris/game'
require_relative 'views/tetris_view'

module Tetris
  class Main
    def initialize
      @board = Board.new
      @game = Game.new(@board)
      @view = TetrisView.new
    end

    def setup_game
      @game.score = 100
      @game.next_tetromino = Tetromino.new_random
      @board.place_tetromino(Tetromino.new(:I, { x: 4, y: 0 })) # Example placement
    end

    def run
      setup_game

      loop do
        system "clear" or system "cls"
        @view.render(@game)

        break if @game.over?

        handle_input # Handle user input

        @game.tick # Advance the game state by one tick

        sleep 0.1 # Adjust the sleep time to control the game speed
      end

      @view.display_game_over(@game)
    end

    def handle_input
      # Non-blocking input read with timeout
      input = nil
      begin
        Timeout.timeout(0.1) do
          input = $stdin.getch
        end
      rescue Timeout::Error
        # No input within timeout, continue with the game loop
      end

      # Process the input if available
      case input
      when 'a', "\e[D" # Left arrow key
        @game.move_tetromino_left
      when 'd', "\e[C" # Right arrow key
        @game.move_tetromino_right
      when 'w', "\e[A" # Up arrow key
        @game.rotate_tetromino
      when 's', "\e[B" # Down arrow key
        @game.drop_tetromino
      when "\u0003" # Ctrl + C
        exit(0) # Exit the program
      end
    end
  end
end

tetris_game = Tetris::Main.new
tetris_game.run
