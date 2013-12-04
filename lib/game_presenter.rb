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

  def print_board
    system('clear')
    print_board = PRINT_BOARD.dup
    game.board.flatten.each do |cell|
      print_board.sub!("*", cell.content)
    end
    puts print_board
  end

  def present_winner
    puts "#{game.winner.mark} has Won!" if game.winner
    puts "It is a tie" if !game.winner
  end

  def get_player(mark)
    input = gets.chomp.to_i
    if input == 1
      player = ConsolePlayer.new(mark)
    elsif input == 2
      print "Select difficulty(1-easy, 2-impossible): "
      input = gets.chomp.to_i
      if input == 1
        player = ComputerPlayer.new(4, mark)
      elsif input == 2
        player = ComputerPlayer.new(12, mark)
      else
        print "Invalid input, try again: "
        get_player(mark)
      end
    else
      print "Invalid input, try again: "
      get_player(mark)
    end
    player
  end

  def get_options
    print "Choose the first player(1-human, 2-computer): "
    player1 = get_player("X".blue)
    print "Choose the second player(1-human, 2-computer): "
    player2 = get_player("O".red)
    @game = GameInteractor.new(player1: player1,
                               player2: player2)
  end

  def start
    get_options
    until game.over?
      print_board
      puts "#{game.turn.mark} turn"
      move = game.turn.get_move(game)
      game.make_move(move.row, move.column)
    end
    present_winner
  end
end
GamePresenter.new.start
