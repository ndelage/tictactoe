require 'spec_helper'

describe Computer do
  describe 'best_move' do
    context "first_move" do
      let(:player) { Player.new("O") }
      let(:computer) { Computer.new("X") }
      let(:game) { GameInteractor.new(player1: computer, 
                                      player2: player ) }
      it 'plays a corner' do
        game.player1.best_move(game).should eq Indices.new(0,0)
      end
    end

    context "counter to first move" do
      context "countering a center move" do
        let(:player) { Player.new("X") }
        let(:computer) { Computer.new("O") }
        let(:game) { GameInteractor.new(player1: player, 
                                        player2: computer) }
        
        it 'plays a corner' do
          game.make_move(1,1)
          game.player2.best_move(game).should eq Indices.new(0,0)
        end
      end
    end
  end
end
