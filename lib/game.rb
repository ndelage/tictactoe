require_relative 'board'
require_relative 'player'
require_relative 'computer'
class Game
  attr_reader :board, :turn, :player, :computer, :winner
  
  def initialize(player_first)
    @board = Board.new
    @player = Player.new(player_first ? "X" : "O")
    @computer = Computer.new(player_first ? "O" : "X")
    @turn = player_first ? @player : @computer
    @winner = nil
  end

  def print_board
    system('clear')
    @board.each do |row|
      p row
    end
  end

  def play
    until game_over?
      print_board
      print "where to?:"
      input = gets.chomp
      make_move(input[0].to_i,input[1].to_i)
      sleep(0.5)
      computer_move = @computer.move(self)
      make_move(computer_move.row, computer_move.column)
      sleep(0.5)
    end
    puts @winner
  end

  def make_move(row, column, mark=@turn.mark)
    @board[row][column].mark(mark)
    switch_turn
  end

  def game_over?
    return true if horizontal_win? || vertical_win? || diagonal_win? 
    false
  end

  private

  def switch_turn
    @turn = @turn == @computer ? @player : @computer
  end

  def horizontal_win?
    @board.each do |row|
      return @winner = @player if row.all?{|cell| cell.marked_with?(@player.mark)}
      return @winner = @computer if row.all?{|cell| cell.marked_with?(@computer.mark)}
    end
    false
  end

  def vertical_win?
    @board.columns.each do |column|
      return @winner = @player if column.all?{|cell| cell.marked_with?(@player.mark)}
      return @winner = @computer if column.all?{|cell| cell.marked_with?(@computer.mark)}
    end
    false
  end

  def diagonal_win?
    @board.diagonals.each do |diagonal|
      return @winner = @player if diagonal.all?{|cell| cell == @player.mark } 
      return @winner = @computer if diagonal.all?{|cell| cell == @computer.mark } 
    end
    false
  end

  def draw?
    return @winner = :draw if @board.flatten.all?{|cell| cell.marked?}
  end


  def all_same?(ary, mark)
    ary.uniq.size == ary.size && ary.first == mark
  end

end

Game.new(true).play