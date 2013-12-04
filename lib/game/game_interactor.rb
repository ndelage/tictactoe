class GameInteractor
  attr_reader :player1, :player2, :winner, :players
  attr_accessor :board
  DEFAULTS = {board: Board.new}
  
  def initialize(opts)
    opts = DEFAULTS.merge(opts)
    @board   = opts.fetch(:board)
    @player1 = opts.fetch(:player1)
    @player2 = opts.fetch(:player2)
    @players = [@player1, @player2]
    @winner  = nil
  end

  def make_move(row, column)
    board[row][column].mark(turn.mark)
    switch_turn
  end

  def undo_move(row,column)
    board[row][column].empty!
    switch_turn
  end

  def valid_moves
    board.open_indices
  end

  def over?
    true if win? || draw?
  end

  def turn
    players.first
  end

  private

  def draw?
    board.full? && !winner
  end
  
  def win?
    @winner = check_winner(board) || check_winner(board.columns) || check_winner(board.diagonals)
  end
  
  def check_winner(ary)
    winner = nil
    ary.each do |subary|
      players.each do |player|
        winner = player if subary.all?{|cell| cell.marked_with? player.mark } 
      end
    end
    return winner
  end
  
  def switch_turn
    players.rotate!
  end
  
end
