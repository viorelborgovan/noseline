require_relative '../models/tetris/game'
require_relative '../views/tetris_view'

class TetrisController
  def initialize
    @game = Tetris::Game.new
    @view = TetrisView.new
  end

  def start_game
    # Main game loop
    loop do
      @view.render(@game)
      # Handle user input and update game state
      break if @game.over?
    end
    @view.display_game_over(@game)
  end
end
