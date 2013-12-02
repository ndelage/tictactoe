require 'spec_helper'
describe GameInteractor do
  let(:player) { Player.new("X") }
  subject(:game) { GameInteractor.new(player: player) }
  its(:computer) { should be_a Computer }


  describe '#make_move' do
    it 'marks the correct cell' do
      game.make_move(1, 1)

      game.board[1][1].content.should eq "X"
    end

    it 'switches the turn' do
      game.make_move(1, 1)
      game.turn.should be_a Computer
    end
  end

  describe '#over?' do
    context 'not over' do
      it 'returns a falsey falue' do
        game.over?.should be_false
      end
    end

    context 'horizontal win' do
      let(:board) { Board.from_char_ary([["X", "X", "X"],
        [" ", " ", " "],
        [" ", " ", " "]]) }
      before{ game.board = board }


      it 'is truthy' do
        game.over?.should eq true
      end

      it 'sets the winner' do
        game.over?
        game.winner.should be_a Player
      end
    end

    context 'vertical win' do
      let(:board) { Board.from_char_ary([["O", " ", " "],
        ["O", " ", " "],
        ["O", " ", " "]]) }
      before{ game.board = board }

      it 'is truthy' do
        game.over?.should eq true
      end

      it 'sets the winner' do
        game.over?
        game.winner.should be_a Computer
      end
    end

    context 'diagonal win' do
      let(:board) { Board.from_char_ary([["X", " ", " "],
                                    ["O", "X", " "],
                                    ["O", " ", "X"]]) }
      before{ game.board = board }

      it 'is truthy' do
        game.over?.should eq true
      end

      it 'sets the winner' do
        game.over?
        game.winner.should be_a Player
      end
    end

    context 'draw' do
      let(:board) { Board.from_char_ary([["X", "O", "X"],
                                      ["O", "O", "X"],
                                      ["X", "X", "O"]]) }
      before{ game.board = board }

      it 'recognises draw when all cells are marked' do

        game.over?.should be_true
        game.winner.should be_false
      end
    end
  end
end
