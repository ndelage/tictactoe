class Computer < Player
  
  Negative_Infinity = -1.0/0.0
 
  def best_move(game)
   best_score = Negative_Infinity
   game.valid_moves.each do |index|
    game.make_move(index.row, index.column)
    score = -negamax_score(game)
    game.undo_move(index.row, index.column)
    if score > best_score
      best_score = score
      best_index = index
    end
  end
  return best_index
end

def negamax_score(game)
  score = Negative_Infinity

  return 1 if game.game_over? == self
  return -1 if game.game_over? == game.player
  return 0 if game.game_over? == :draw

  game.valid_moves.each do |index|
    game.make_move(index.row, index.column)
    score = [score, -negamax_score(game)].max
    game.undo_move(index.row, index.column)
  end                                                                                                                                                                                                     
  return score
end

# def best_move(game)
#   moves = rank_moves(game)
#   min = moves.values.min
#   moves.select{|k,v| v == min}.first.first
# end

# def rank_moves(game)
#   moves = {}
#   try_each_valid_move(game) do |game, index|
#     moves[index] = average(score(game))
#   end
#   moves
# end

# def score(game)
#   return -1 if game.game_over? == self
#   return 1 if game.game_over? == game.player
#   return 0 if game.game_over? == :draw
#   scores = []
#   try_each_valid_move(game) do |game, index|
#     scores << score(game)
#   end
#   return scores
# end

# def average(scores)
#   return scores if scores.is_a?(Fixnum)
#   scores = scores.flatten
#   scores.inject(:+)/scores.size.to_f
# end


# def try_each_valid_move(game=@game)
#   game.valid_moves.each do |index|
#     game.make_move(index.row, index.column)
#     yield(game, index)
#     game.undo_move(index.row, index.column)
#   end
# end


# def deep_copy(game)
#   game = game.clone
#   game.board = Marshal.load( Marshal.dump(game.board))
#   game
# end
end
