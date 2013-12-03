require_relative 'console_player'
require_relative 'game/game_interactor'
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
    until @game.over?
      print_board
      move = @game.turn.get_move(@game)
      @game.make_move(move.row, move.column)
    end
    p @game.winner
  end

  private

  def clean_input(input)
    Indices.new(input[0].to_i, input[1].to_i)
  end

end

player = ConsolePlayer.new("O")
computer = ComputerPlayer.new(7, "X")
game = GamePresenter.new(GameInteractor.new(player1: player,
                                            player2: computer))
game.mainloop
