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

  def switch_turn
    @turn = @turn == player ? computer : player
  end


  def make_move(row, column)
    @board[row][column].mark(@turn.mark)
    switch_turn
  end

  def valid_moves
    @board.open_indices
  end

  def game_over?
    horizontal_win? || vertical_win? || diagonal_win? || draw?
  end

  private

  def horizontal_win?
    check_win(@board)
  end

  def vertical_win?
    check_win(@board.columns)
  end

  def diagonal_win?
    check_win(@board.diagonals)
  end

  def check_win(ary)
    ary.each do |subary|
      [@player, @computer].each do |player|
        @winner = player if subary.all?{|cell| cell.marked_with? player.mark } 
      end
    end
    return @winner
  end

  def draw?
    @winner = :draw if @board.flatten.all?{|cell| cell.marked?}
  end

end
