require 'spec_helper'
describe Game do
  subject(:game) { Game.new(true) }
  it { subject.board.size.should eq 3 } 
  it { subject.board[2][1].content.should eq " " }
  its(:player) { should be_a Player }
  its(:computer) { should be_a Computer }

  describe 'initialize' do
    context 'when player goes first' do
      it 'assigns player mark correctly' do
        game = Game.new(true)

        game.player.mark.should eq "X"
      end

      it 'assigns computer mark correctly' do
        game = Game.new(true)

        game.computer.mark.should eq "O"
      end
    end

    context 'when player doesnt go first' do
      it 'assigns player mark correctly' do
        game = Game.new(false)

        game.player.mark.should eq "O"
      end

      it 'assigns player mark correctly' do
        game = Game.new(false)

        game.computer.mark.should eq "X"
      end
    end
  end

  describe '#make_move' do
    it 'marks the correct cell' do
      game.make_move(1, 1)

      game.board[1][1].should eq "X"
    end
  end

  describe '#game_over?' do

    context 'horizontal win' do

      before do
        game.make_move(0, 0)
        game.make_move(2, 2)
        game.make_move(0, 1)
        game.make_move(1, 2)
        game.make_move(0, 2)
      end

      it 'returns true' do
        game.game_over?.should eq true
      end

      it 'sets the winner' do
        game.game_over?
        game.winner.should be_a Player

      end
    end

    context 'vertical win' do
      
      before do
        game.make_move(0, 0)
        game.make_move(0, 2)
        game.make_move(1, 0)
        game.make_move(1, 1)
        game.make_move(2, 0)
      end

      it 'returns true' do
        game.game_over?.should eq true
      end

      it 'sets the winner' do
        game.game_over?
        game.winner.should be_a Player
      end
    end

    context 'diagonal win' do
      
      before do
        game.make_move(0, 0)
        game.make_move(2, 1)
        game.make_move(1, 1)
        game.make_move(0, 1)
        game.make_move(2, 2)
      end

      it 'returns true' do
        game.game_over?.should eq true
      end

      it 'sets the winner' do
        game.game_over?
        game.winner.should be_a Player
      end
    end
  end
end
