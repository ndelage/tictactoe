class Computer < Player
  def move(game)
    @game = game.dup
    # move_to_win if can_win?(self)
    # block if can_win?(game.player)
    # fork if can_fork?(self)
    # block_fork if can_fork?(game.player)
    # play_center if center_open?
    # play_opposite_corner if opponent_has_corner_and_opposite_open?
    # play_random_corner if open_corner?
    play_random
  end

  private

  def play_random
    valid_moves.sample
  end

  def play_random_corner
    @game.board.open_corners.sample
  end 

  def open_corner?
    @game.board.open_corners.any?
  end

  def play_center
    Indices.new(1,1)
  end

  def center_open?
    @game.board[1][1].empty?
  end

  def fork
    @fork_move
  end

  def block_fork
    @fork_move
  end

  def can_fork?(player)
    dup_game = @game.dup
    valid_moves.each do |index|
      winning_combinations = 0
      dup_game.make_move(index.row, index.column, player.mark).board.open_indices.each do |indexx|
        winning_combinations += 1 if dup_game.make_move(indexx.row, indexx.column, player.mark).game_over?
      end
      @fork_move = index if winning_combinations >= 2
    end
    @fork_move
  end


  def block
    @winning_move
  end

  def move_to_win
    @winning_move
  end

  def can_win?(player)
    valid_moves.each do |index|
      game = @game.dup
      game.make_move(index.row, index.column, player.mark)
      @winning_move = index if game.game_over?
    end
    @winning_move
  end

  def valid_moves
    @game.board.open_indices
  end
end