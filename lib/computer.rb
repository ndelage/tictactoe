class Computer < Player

  def best_move(game)
    @game = game.dup
    move_to_win ||
    block_win ||
    fork ||
    force_block ||
    block_fork ||
    play_center ||
    play_opposite_corner || 
    play_random_corner ||
    play_random
  end

  private

  def move_to_win
    winning_moves(self).first
  end

  def block_win
    winning_moves(@game.player).first
  end

  def force_block
    try_each_square(self) do |game|
      can_win?(self,game)
    end
    .first
  end

  def can_win?(player, game=@game)
    winning_moves(player, game).any?
  end

  def fork
    fork_moves(self).first
  end

  def block_fork
    fork_moves(@game.player).first
  end

  def play_opposite_corner
    @game.corners.select do |corner|
      @game.board[corner.row][corner.column].marked_with?(@game.player.mark) && opposite_for(corner).empty?
    end
    .first
  end

  def play_random_corner
    @game.open_corners.sample
  end
  
  def play_center
    Indices.new(1,1) if @game.board[1][1].empty?
  end
  
  def play_random
    @game.valid_moves.sample
  end 
  
  def winning_moves(player, game=@game)
    try_each_square(player, game) do |game|
      game.game_over? == player
    end
  end
  
  def fork_moves(player, game=@game)
    try_each_square(player) do |game|
      winning_moves(player, game).size >= 2
    end
  end
  
  def try_each_square(player, game=@game)
    game.valid_moves.select do |index|
      dup_game = deep_copy(game)
      dup_game.make_move(index.row, index.column, player.mark)
      yield(dup_game)
    end
  end
  
  def deep_copy(game)
    game = game.clone
    game.board = Marshal.load( Marshal.dump(game.board))
    game
  end

  def opposite_for(corner)
    index = corners[corners.find_index{|el| el == corner} - 2]
    corners[index.row][index.column]
  end

  def corners
    @game.corners
  end
end
