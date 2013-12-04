require_relative 'game/abstract_player'
class ConsolePlayer < AbstractPlayer
  def get_move(*)
  	print "Enter the index you want to play(x,y): "
   input = gets.chomp
   Indices.new(input[0].to_i, input[1].to_i) 
  end
end