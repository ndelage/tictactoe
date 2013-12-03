require_relative 'game/abstract_player'
class ConsolePlayer < AbstractPlayer
  def get_move(*)
   input = gets.chomp
   Indices.new(input[0].to_i, input[1].to_i) 
  end
end