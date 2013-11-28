require 'spec_helper'
describe Game do
  let(:player) { Player.new("X") }
  subject(:game) { Game.new(player) }
  it { subject.board.size.should eq 3 } 
  it { subject.board[2][1].content.should eq " " }
  its(:player) { should be_a Player }
  its(:computer) { should be_a Computer }


  describe '#make_move' do
    it 'marks the correct cell' do
      game.make_move(1, 1, player.mark)

      game.board[1][1].content.should eq "X"
    end
  end

  describe '#game_over?' do

    context 'horizontal win' do

      before do
        game.make_move(0, 0, player.mark)
        game.make_move(0, 1, player.mark)
        game.make_move(0, 2, player.mark)
      end

      it 'is truthy' do
        game.game_over?.should_not eq nil
      end

      it 'sets the winner' do
        game.game_over?
        game.winner.should be_a Player

      end
    end

    context 'vertical win' do
      
      before do
        game.make_move(0, 0, player.mark)
        game.make_move(1, 0, player.mark)
        game.make_move(2, 0, player.mark)
      end

      it 'is truthy' do
        game.game_over?.should_not eq nil
      end

      it 'sets the winner' do
        game.game_over?
        game.winner.should be_a Player
      end
    end

    context 'diagonal win' do
      
      before do
        game.make_move(0, 0, player.mark)
        game.make_move(1, 1, player.mark)
        game.make_move(2, 2, player.mark)
      end

      it 'is truthy' do
        game.game_over?.should_not eq nil
      end

      it 'sets the winner' do
        game.game_over?
        game.winner.should be_a Player
      end
    end
  end
end
