require_relative 'game_interactor'
class GamePresenter
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def print_board
    system('clear')
    @game.board.each do |row|
      p row
    end
  end


  def mainloop
    until winner = @game.game_over?
      print_board
      if game.turn == @game.player
        print "SHOOT:"
        input = clean_input(gets.chomp)
        @game.make_move(input.row, input.column)
      else
        move = @game.computer.best_move(@game)
        @game.make_move(move.row, move.column)
        sleep(1)
      end
    end
    puts winner
  end

  private

  def clean_input(input)
    Indices.new(input[0].to_i, input[1].to_i)
  end

end

game = GamePresenter.new(GameInteractor.new(Player.new("X")))
game.mainloop
