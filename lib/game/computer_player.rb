class ComputerPlayer < AbstractPlayer
  def initialize(level, mark)
    @level = level
    super(mark)
  end

  def get_move(game)
    best_score = -Float::INFINITY
    best_index = game.valid_moves.sample
    try_each_valid_move(game) do |game, index|
      score = -negamax(game, -1)
      best_score, best_index = score, index if score > best_score
    end
    return best_index
  end

  def negamax(game, color, depth=@level)
    return color * get_score(game) if game.over? || depth == 0
    best_score = -Float::INFINITY
    try_each_valid_move(game) do |game|
      best_score = [best_score, -negamax(game, -color, depth-1)].max
    end
    return best_score
  end

  def get_score(game)
    return 1 if game.winner == self
    return -1 if game.winner == (game.players - [self]).first
    return 0
  end

  def try_each_valid_move(game)
    game.valid_moves.each do |index|
      game.make_move(index.row, index.column)
      yield(game,index)
      game.undo_move(index.row, index.column)
    end
  end
end
