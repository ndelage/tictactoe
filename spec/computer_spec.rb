# require 'spec_helper'

# describe Computer do
#   describe 'best_move' do
#     context "first_move" do
#       let(:game) { GameInteractor.new(player: Player.new("O")) }
#       it 'plays a corner' do
#         game.computer.best_move(game).should eq Indices.new(0,0)
#       end
#     end

#     context "counter to first move" do
#       context "countering a center move" do
#         let(:game) { GameInteractor.new(player: Player.new("X")) }
#           it 'plays a corner' do
#             game.make_move(1,1)
#             game.computer.best_move(game).should eq Indices.new(0,0)
#           end
#       end
#     end
#   end
# end
