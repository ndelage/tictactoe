require_relative 'game_interactor'

PRINT_BOARD = <<-STRING.chomp                                    
                                                   TIC TAC TOE

                                                    * | * | * 
                                                   ---|---|---
                                                    * | * | * 
                                                   ---|---|---
                                                    * | * | * 
STRING

class GamePresenter

  def initialize(game)
    @game = game
  end

  def print_board
    system('clear')
    play_board = PRINT_BOARD.dup
    @game.board.flatten.each do |cell|
      play_board.sub!('*', cell.content)
    end
    puts play_board
  end


  def mainloop
    turn = @game.player.mark == "X" ? @game.player : @game.computer

    until winner = @game.game_over?
      print_board
      if turn == @game.player
        print "SHOOT:"
        input = clean_input(gets.chomp)
        @game.make_move(input.row, input.column, @game.player.mark)
        turn = @game.computer
      else
        move = @game.computer.best_move(@game)
        @game.make_move(move.row, move.column, @game.computer.mark)
        turn = @game.player
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

game = GamePresenter.new(GameInteractor.new(Player.new("O")))
game.mainloop
