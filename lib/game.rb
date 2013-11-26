require 'player'
require 'computer'
class Game
  attr_reader :board, :turn, :player, :computer, :winner
  
  def initialize(player_first)
    @board = Array.new(9){" "}
    @player = Player.new(player_first ? "X" : "O")
    @computer = Computer.new(player_first ? "O" : "X")
    @turn = player_first ? @player : @computer
    @winner = nil
  end

  def make_move(index)
    @board[index] = @turn.mark
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
    @board.each_slice(3) do |row|
      return @winner = @player if all_same?(row, @player.mark)
      return @winner = @computer if all_same?(row, @computer.mark)
    end
    false
  end

  def vertical_win?
    @board.each_slice(3).to_a.transpose.each do |column|
      return @winner = @player if all_same?(column, @player.mark)
      return @winner = @computer if all_same?(column, @computer.mark)
    end
    false
  end

  def diagonal_win?
    two_dimensional = @board.each_slice(3).to_a

    (0..2).each do |i|
      diagonal_first << two_dimensional[i][i]
      (2..0).each do |n|
        diagonal_second << two_dimensional[i][n]
      end
    end

    return @winner = @player if all_same?(diagonal_first, @player.mark)
    return @winner = @player if all_same?(diagonal_second, @player.mark)
    return @winner = @computer if all_same?(diagonal_first, @computer.mark)
    return @winner = @computer if all_same?(diagonal_second, @computer.mark)
    false
  end

  def draw?
    !@board.find{|el| el == " "}
  end

  def all_same?(ary, mark)
    ary.uniq.size == ary.size && ary.first == mark
  end

end
