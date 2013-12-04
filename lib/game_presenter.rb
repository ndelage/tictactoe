require_relative 'console_player'
require_relative 'game/game_interactor'
require 'colored'

PRINT_BOARD = <<-STRING.chomp


                             * | * | * 
                            ---|---|---
                             * | * | * 
                            ---|---|---
                             * | * | * 


                             
STRING
class GamePresenter
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def print_board
    system('clear')
    print_board = PRINT_BOARD.dup
    game.board.flatten.each do |cell|
      print_board.sub!("*", cell.content)
    end
    puts print_board
  end


  def mainloop
    until game.over?
      print_board
      move = game.turn.get_move(game)
      game.make_move(move.row, move.column)
    end
    p game.winner
  end
end

player = ConsolePlayer.new("X".blue.bold)
computer = ComputerPlayer.new(6, "O".red.bold)
game = GamePresenter.new(GameInteractor.new(player1: player,
                                            player2: computer))
game.mainloop
