class TetrisView
  def render(game)
    system "clear" or system "cls" # Clear the console for a fresh display
    puts "Score: #{game.score}"
    puts "Next Tetromino:"
    render_tetromino(game.next_tetromino)
    puts "Game Board:"
    render_board(game.board, game.current_tetromino)
    display_game_over(game) if game.over?
  end

  def display_game_over(game)
    puts "Game Over!"
    puts "Final Score: #{game.score}"
    # Optionally, provide instructions for restarting or exiting
    puts "Press 'r' to restart or 'q' to quit."
  end

  private

  def render_tetromino(tetromino)
    tetromino.current_shape.each do |row|
      puts row.map { |cell| cell == 0 ? ' ' : '#' }.join
    end
  end

  def render_board(board, current_tetromino)
    current_shape = current_tetromino.current_shape
    position = current_tetromino.position

    # Create a copy of the board grid to render the falling tetromino
    rendered_board = board.grid.map(&:dup)

    # Merge the falling tetromino with the board grid
    current_shape.each_with_index do |row, dy|
      row.each_with_index do |cell, dx|
        x = position[:x] + dx
        y = position[:y] + dy
        rendered_board[y][x] = cell unless cell == 0
      end
    end

    # Render the merged board
    rendered_board.each do |row|
      puts row.map { |cell| cell == 0 ? '.' : '#' }.join(' ')
    end
  end
end
