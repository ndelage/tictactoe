require_relative 'player'
require_relative 'computer'
class Game
  attr_reader :board, :turn, :player, :computer, :winner
  
  def initialize(player_first)
    @board = Array.new(3){Array.new(3){" "}}
    @player = Player.new(player_first ? "X" : "O")
    @computer = Computer.new(player_first ? "O" : "X")
    @turn = player_first ? @player : @computer
    @winner = nil
  end

  def make_move(row, column)
    @board[row][column] = @turn.mark
    switch_turn
  end

  def undo(row, column)
    @board[row][column] = " "
    switch_turn
  end

  def game_over?
    return true if horizontal_win? || vertical_win? || diagonal_win? || draw?
    false
  end

  private

  def switch_turn
    @turn = @turn == @computer ? @player : @computer
  end

  def horizontal_win?
    @board.each do |row|
      return @winner = @player if row.all?{|cell| cell == @player.mark}
      return @winner = @computer if row.all?{|cell| cell == @computer.mark}
    end
    false
  end

  def vertical_win?
    columns.each do |column|
      return @winner = @player if column.all?{|cell| cell == @player.mark}
      return @winner = @computer if column.all?{|cell| cell == @computer.mark}
    end
    false
  end

  def diagonal_win?
    diagonals.each do |diagonal|
      return @winner = @player if diagonal.all?{|cell| cell == @player.mark } 
      return @winner = @computer if diagonal.all?{|cell| cell == @computer.mark } 
    end
    false
  end

  def diagonals
    diagonals = []
    diagonals << (0..2).map do |i|
      @board[i][i]
    end

    nums = (0..2).to_a
    diagonals << @board.map do |row|
      row[nums.pop]
    end
    diagonals
  end

  def columns
    @board.transpose
  end

  def draw?
    !@board.flatten.any?{|el| el == " "}
  end


  def all_same?(ary, mark)
    ary.uniq.size == ary.size && ary.first == mark
  end

end

game = Game.new(true)

until game.game_over?
  if game.turn.is_a?(Computer)
    move = game.computer.move(game)
    game.make_move(move[:row], move[:column])
  else
    print "Your turn:"
    move = gets.chomp
    game.make_move(move[0].to_i, move[1].to_i)
  end
  system("clear")
  game.board.each { |row| p row}
end

p game.winner ? game.winner : "Draw"

