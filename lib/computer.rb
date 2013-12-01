require 'pry'
class Computer < Player
  
  Negative_Infinity = -1.0/0.0
  Positive_Infinity = 1.0/0.0

  def best_move(game)
    best_score = Negative_Infinity
    best_index = nil
    game.valid_moves.each do |index|
      game.make_move(index.row, index.column)
      score = minimax(game, false)
      game.undo_move(index.row, index.column)
      if score > best_score
        best_score = score
        best_index = index
      end
    end
    return best_index
  end
 
  def minimax(game, maximizing_player)
    if game.game_over?
      return 1 if game.winner == self
      return -1 if game.winner == game.player
      return 0
    end
    if maximizing_player
      best_score = Negative_Infinity
      game.valid_moves.each do |index|
        game.make_move(index.row, index.column)
        best_score = [best_score, minimax(game, false)].max
        game.undo_move(index.row, index.column)
      end
      return best_score
    else
      best_score = Positive_Infinity
      game.valid_moves.each do |index|
        game.make_move(index.row, index.column)
        best_score = [best_score, minimax(game, true)].min
        game.undo_move(index.row, index.column)
      end
      return best_score
    end
  end

end
