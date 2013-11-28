class Computer < Player
  def best_move(game)
    @game = game.dup
    return move_to_win if can_win?(self)
    return block if can_win?(game.player)
    return fork if can_fork?(self)
    return block_fork if can_fork?(game.player)
    return play_center if center_open?
    return play_opposite_corner if has_corner_and_opposite_open?(game.player)
    return play_random_corner if open_corner?
    play_random
  end

  private

  def play_opposite_corner
    @opposite
  end

  def has_corner_and_opposite_open?(player)
    @opposite = nil
    Board::CORNERS.each_with_index do |index, corner_index|
      cell = game.board[index.row][index.column].marked_with?(player.mark)
      indexxxx = Board::CORNERS[corner_index - 2]
      opposite = game.board[indexxxx.row][indexxxx.column]
      @opposite = indexxxx if cell.marked_with?(player.mark) && opposite.empty?
    end
    @opposite
  end

  def play_random
    puts "Playing random"
    valid_moves.sample
  end

  def play_random_corner
    puts "Playing random corner"
    @game.board.open_corners.sample
  end 

  def open_corner?
    @game.board.open_corners.any?
  end

  def play_center
    puts "Playing center"
    Indices.new(1,1)
  end

  def center_open?
    @game.board[1][1].empty?
  end

  def fork
    puts "Playing fork"
    @fork_move
  end

  def block_fork
    puts "Blocking fork"
    @fork_move
  end

  def can_fork?(player)
    @fork_move = nil
    valid_moves.each do |index|
      dup_game = deep_copy(@game)
      winning_combinations = 0
      dup_game.make_move(index.row, index.column, player.mark)
      dup_game.board.open_indices.each do |indexx|
        dup_game_again = deep_copy(dup_game)
        dup_game_again.make_move(indexx.row, indexx.column, player.mark)
        winning_combinations += 1 if dup_game_again.game_over?
      end
      @fork_move = index if winning_combinations >= 2
    end
    @fork_move
  end


  def block
    puts "Blocking win"
    @winning_move
  end

  def move_to_win
    puts "Playing win"
    puts @winning_move
    @winning_move
  end

  def can_win?(player)
    @winning_move = nil
    valid_moves.each do |index|
      game = deep_copy(@game)
      game.make_move(index.row, index.column, player.mark)
      @winning_move = index if game.game_over?
    end
    @winning_move
  end


  def valid_moves
    @game.board.open_indices
  end

  def deep_copy(game)
    game = game.clone
    game.board = Marshal.load( Marshal.dump(game.board))
    game
  end
end