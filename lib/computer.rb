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
    p moves
    min = moves.values.map{|n| n.abs}.min
    moves.select{|k,v| v.abs == min}.first.first
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
    scores = []
    try_each_valid_move(game) do |game, index|
      scores << score(game)
    end
    return scores
  end

  def average(scores)
    scores.flatten.inject(:+)/scores.flatten.size.to_f
  end


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
