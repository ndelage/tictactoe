class Computer < Player

  def best_move(game)
    moves = rank_moves(game)
    min = moves.values.min
    moves.select{|k,v| v == min}.first.first
  end

  def rank_moves(game)
    moves = {}
    try_each_valid_move(game) do |game, index|
      moves[index] = average(score(game))
    end
    moves
  end

  def score(game)
    return -1 if game.game_over? == self
    return 1 if game.game_over? == game.player
    return 0 if game.game_over? == :draw
    try_each_valid_move(game) do |game, index|
      score(game)
    end
  end

  def average(scores)
    return scores if scores.is_a?(Fixnum)
    scores = scores.flatten
    scores.inject(:+)/scores.size.to_f
  end


  def try_each_valid_move(game=@game)
    game.valid_moves.map do |index|
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
