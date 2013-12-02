require_relative 'board'
require_relative 'player'
require_relative 'computer'

class GameInteractor
  attr_reader :turn, :player, :computer, :winner
  attr_accessor :board
  DEFAULTS = {board: Board.new}
  
  def initialize(opts)
    opts = DEFAULTS.merge(opts)
    @board = opts.fetch(:board)
    @player = opts.fetch(:player)
    @computer = opts.fetch(:computer, Computer.new((["X", "O"] - [@player.mark]).join))
    @turn = opts.fetch(:turn, @player.mark == "X" ? @player : @computer)
    @winner = nil
  end

  def make_move(row, column)
    @board[row][column].mark(@turn.mark)
    switch_turn
  end

  def undo_move(row,column)
    @board[row][column].empty!
    switch_turn
  end

  def valid_moves
    @board.open_indices
  end

  def over?
    true if win? || draw?
  end

  private

  def draw?
    @board.full? && !winner
  end
  
  def win?
    @winner = check_winner(@board) || check_winner(@board.columns) || check_winner(@board.diagonals)
  end
  
  def check_winner(ary)
    winner = nil
    ary.each do |subary|
      [@player, @computer].each do |player|
        winner = player if subary.all?{|cell| cell.marked_with? player.mark } 
      end
    end
    return winner
  end
  
  def switch_turn
    @turn = @turn == player ? computer : player
  end
  
end
