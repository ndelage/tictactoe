require_relative 'board'
require_relative 'player'
require_relative 'computer'
class Game
  attr_reader :turn, :player, :computer, :winner
  attr_accessor :board
  
  def initialize(player)
    @board = Board.new
    @player = player
    @computer = Computer.new (["X", "O"] - [@player.mark]).join
    @winner = nil
  end

  def print_board
    system('clear')
    @board.each do |row|
      p row
    end
  end

  def make_move(row, column, mark)
    @board[row][column].mark(mark)
  end

  def game_over?
    horizontal_win? || vertical_win? || diagonal_win? 
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


  def all_same?(ary, mark)
    ary.uniq.size == ary.size && ary.first == mark
  end

end

game = Game.new(Player.new("X"))
turn = game.player

until winner = game.game_over?
  game.print_board
  if turn == game.player
    print "SHOOT:"
    input = gets.chomp
    game.make_move(input[0].to_i, input[1].to_i, game.player.mark)
    turn = game.computer
  else
    move = game.computer.best_move(game)
    game.make_move(move.row, move.column, game.computer.mark)
    turn = game.player
    sleep(1)
  end
end
 puts winner







