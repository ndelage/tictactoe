class Computer < Player

  def move(game)
    get_best_move(game.dup)
  end

  def get_best_move(game)
    ranked_moves = rank_possible_moves(game)
    move = ranked_moves.max_by {|cell, score| score}
    move.first
  end

  private

  def rank_possible_moves(game)
    possible_moves = open_cells(game)
    possible_moves.each_key do |indices|
      possible_moves[indices] = get_move_score(game, indices)
    end
  end

  def get_move_score(game,indices)
    game.make_move(indices[:row], indices[:column])
    best_score = apply_minimax(game, depth=0)
    game.undo(indices[:row], indices[:column])
    best_score
  end

  def apply_minimax(game, depth)
    return get_score(game) if game.game_over?
    game.turn.is_a?(Player) ? minimax(game, depth).min : minimax(game, depth).max
  end

  def minimax(game, depth, best_score=[])
    open_cells(game).each_key do |indices|
      game.make_move(indices[:row], indices[:column])
      score = (apply_minimax(game, depth += 1) / depth.to_f)
      game.undo(indices[:row], indices[:column])
      best_score.push(score)
    end
    best_score
  end

  def get_score(game)
    return 1 if game.winner.is_a?(Computer)
    return -1 if game.winner.is_a?(Player)
    0
  end

  def open_cells(game)
    open_cells = {}
    game.board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        open_cells[{row: row_index, column:column_index}] = nil if cell == " "
      end
    end
    open_cells
  end

end
