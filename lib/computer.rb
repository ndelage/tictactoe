class Hash
  def flat_each(&blk)
    each do |k,v|
      if v.is_a?(Hash)
        v.flat_each(&blk)
      else
        yield v
      end
    end
  end
end

class Computer < Player

  def best_move(game)
    moves = rank_moves(game)
    max = moves.values.max
    moves.select{|k,v| v == max}.first.first
  end

  def rank_moves(game)
    moves = {}
    try_each_valid_move(game) do |game, index|
      moves[index] = average(score(game))
    end
    moves
  end

  def average(hash)
    return hash if hash.is_a?(Fixnum)
    ranks = []
    hash.flat_each do |rank|
      ranks << rank
    end
    ranks.inject(:+)/ranks.size.to_f
  end

  def score(game)
    return 1 if game.game_over? == self
    return -1 if game.game_over? == game.player
    return 0 if game.game_over? == :draw
    return rank_moves(deep_copy(game))
  end

  # def best_move(game)
  #   @game = game.dup
  #   return move_to_win if can_win?(self)
  #   return block if can_win?(game.player)
  #   return fork if can_fork?(self)
  #   return force_win_block(self) if can_fork_twice?(game.player)
  #   return block_fork if can_fork?(game.player)
  #   return play_center if center_open?
  #   return play_opposite_corner if has_corner_and_opposite_open?(game.player)
  #   return play_random_corner if open_corner?
  #   play_random
  # end

  # private

  # def force_win_block(player)
  #   puts "Forcing a block"
  #   @block_move = nil
  #   valid_moves.each do |index|
  #     dup_game = deep_copy(@game)
  #     dup_game.make_move(index.row, index.column, player.mark)
  #     win = false
  #     dup_game.board.open_indices.each do |indexx|
  #       dup_game_again = deep_copy(dup_game)
  #       dup_game_again.make_move(indexx.row, indexx.column, player.mark)
  #       win = true if dup_game_again.game_over? == self
  #     end
  #     @block_move = index if win
  #   end
  #   @block_move
  # end

  # def can_fork_twice?(player)
  #   fork_moves(player).size > 1
  # end

  # def can_fork?(player)
  #   fork_moves(player).size > 0
  # end

  # def play_opposite_corner
  #   puts "Playing opposite corner"
  #   @opposite
  # end

  # def play_random
  #   puts "Playing random"
  #   valid_moves.sample
  # end

  # def play_random_corner
  #   puts "Playing random corner"
  #   @game.board.open_corners.sample
  # end 

  # def open_corner?
  #   @game.board.open_corners.any?
  # end

  # def play_center
  #   puts "Playing center"
  #   Indices.new(1,1)
  # end

  # def center_open?
  #   @game.board[1][1].empty?
  # end

  # def fork
  #   puts "Playing fork"
  #   @fork_moves.first
  # end

  # def block_fork
  #   puts "Blocking fork"
  #   @fork_moves.first
  # end


  # def has_corner_and_opposite_open?(player)
  #   @opposite = nil
  #   @game.board.corners.each_with_index do |index, corner_index|
  #     cell = @game.board[index.row][index.column]
  #     indexxxx = @game.board.corners[corner_index - 2]
  #     opposite = @game.board[indexxxx.row][indexxxx.column]
  #     @opposite = indexxxx if cell.marked_with?(player.mark) && opposite.empty?
  #   end
  #   @opposite
  # end

  # def fork_moves(player)
  #   @fork_moves = []
  #   valid_moves.each do |index|
  #     dup_game = deep_copy(@game)
  #     winning_combinations = 0
  #     dup_game.make_move(index.row, index.column, player.mark)
  #     dup_game.board.open_indices.each do |indexx|
  #       dup_game_again = deep_copy(dup_game)
  #       dup_game_again.make_move(indexx.row, indexx.column, player.mark)
  #       winning_combinations += 1 if dup_game_again.game_over?
  #     end
  #     @fork_moves << index if winning_combinations >= 2
  #   end
  #   @fork_moves
  # end


  # def block
  #   puts "Blocking win"
  #   @winning_move
  # end

  # def move_to_win
  #   puts "Playing win"
  #   @winning_move
  # end

  # def can_win?(player)
  #   @winning_move = nil
  #   valid_moves.each do |index|
  #     game = deep_copy(@game)
  #     game.make_move(index.row, index.column, player.mark)
  #     @winning_move = index if game.game_over?
  #   end
  #   @winning_move
  # end

  def try_each_valid_move(game=@game)
    game.valid_moves.each do |index|
      game_copy = deep_copy(game)
      game_copy.make_move(index.row, index.column)
      yield(game_copy, index)
    end
  end


  def deep_copy(game)
    game = game.clone
    game.board = Marshal.load( Marshal.dump(game.board))
    game
  end
end