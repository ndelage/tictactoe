PRINT_BOARD = <<-STRING.chomp

                             * | * | * 
                            ---|---|---
                             * | * | * 
                            ---|---|---
                             * | * | * 


                             
STRING

class GamePresenter
  attr_accessor :game

  # I see two responsibilities here. (1) rendering the board and (2) printing it
  def print_board
    system('clear')
    print_board = PRINT_BOARD.dup
    game.board.flatten.each do |cell|
      print_board.sub!("*", cell.content)
    end
    puts "\n\n"
    puts "                              #{game.turn.mark} turn"
    puts print_board
  end

  # this prints both winners and ties. how about different name?
  # maybe 'print_results' or somthing like that
  def present_winner
    puts "#{game.winner.mark} has Won!" if game.winner
    puts "It is a tie" if !game.winner
  end

  # the nesting makes my head hurt
  def get_player(mark)
    input = gets.chomp.to_i
    if input == 1
      player = ConsolePlayer.new(mark)
    elsif input == 2
      print "Select difficulty(1-easy, 2-impossible): "
      # ack! multiple things calls "input"
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

  def prompt_play_again
    print "Do you want to play again?(y, n): "
    input = gets.chomp
    start if input == "y"
    exit if input == "n"
  end

  def get_options
    # UX advice. Ask me the question that matches what I'm thinking...
    # "Two player or one player against the computer?"
    print "Choose the first player(1-human, 2-computer): "
    player1 = get_player("X".blue)
    print "Choose the second player(1-human, 2-computer): "
    player2 = get_player("O".red)
    @game = GameInteractor.new(player1: player1,
                               player2: player2)
  end

  # I prefer to see this method at the top of this file
  def start
    system 'clear'
    get_options
    until game.over?
      print_board
      move = game.turn.get_move(game)
      game.make_move(move.row, move.column)
    end
    present_winner
    prompt_play_again
  end
end
