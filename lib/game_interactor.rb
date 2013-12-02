require_relative 'board'
require_relative 'player'
require_relative 'computer'

class GameInteractor
  attr_reader :turn, :player, :computer, :winner
  attr_accessor :board
  
  def initialize(player)
    @board = Board.new
    @player = player
    @computer = Computer.new (["X", "O"] - [@player.mark]).join
    @winner = nil
    @turn = @player.mark == "X" ? @player : @computer
  end

  def make_move(row, column)
    @board[row][column].mark(@turn.mark)
    switch_turn
  end

  def undo_move(row,column)
    @board[row][column].empty!
    switch_turn
  end

  def switch_turn
    @turn = @turn == player ? computer : player
  end

  def valid_moves
    @board.open_indices
  end

  def over?
    @winner = win? || draw?
  end

  private

  def win?
    check_win(@board) || check_win(@board.columns) || check_win(@board.diagonals)
  end

  def draw?
    return false if win?
    try_each_valid_move do
      return draw?
    end
    :draw
  end

  def check_win(ary)
    winner = nil
    ary.each do |subary|
      [@player, @computer].each do |player|
        winner = player if subary.all?{|cell| cell.marked_with? player.mark } 
      end
    end
    return winner
  end

  def try_each_valid_move
    valid_moves.each do |index|
      make_move(index.row, index.column)
      yield(self,index)
      undo_move(index.row, index.column)
    end
  end

end
