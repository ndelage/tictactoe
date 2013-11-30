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
    return rank_moves(deep_copy(game))
  end

  def average(hash)
    return hash if hash.is_a?(Fixnum)
    ranks = []
    hash.flat_each do |rank|
      ranks << rank
    end
    ranks.inject(:+)/ranks.size.to_f
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
