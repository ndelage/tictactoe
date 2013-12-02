require 'spec_helper'

describe Board do
  it { subject.size.should eq 3 } 
  it { subject[2][1].content.should eq " " }

  describe "open indices" do
    it "returns all indices for empty board" do
      subject.open_indices.size.should eq 9
    end

    it "returns only the open indices for non-empty board" do
      board = Board.from_char_ary([["X", "O", " "],
                                   ["O", " ", " "],
                                   [" ", "X", "X"]] )
      board.open_indices.size.should eq 4
      board.open_indices.should include(Indices.new(1,1))
    end

    it 'returns empty array for full board' do
      board = Board.from_char_ary([["X", "O", "X"],
                                   ["O", "X", "O"],
                                   ["O", "X", "X"]] )
      board.open_indices.should eq []
    end
  end

  describe "full?" do
    it 'returns true for a full board' do
      board = Board.from_char_ary([["X", "O", "X"],
                                   ["O", "X", "O"],
                                   ["O", "X", "X"]] )
      board.full?.should be_true
    end

    it 'returns false for non-full board' do
      board = Board.from_char_ary([["X", "O", "X"],
                                   ["O", " ", "O"],
                                   ["O", "X", "X"]] )
      board.full?.should be_false
    end
  end

  # describe 'diagonals' do
  #   it 'returns the diagonals for the board' do
  #     board = Board.from_char_ary([["X", "O", "X"],
  #                                  ["O", " ", "O"],
  #                                  ["O", "X", "X"]] )
  #     board.diagonals.should eq [[Cell.new("X"), Cell.new, Cell.new("X")], [Cell.new("X"), Cell.new(" "), Cell.new("O")]]
  #   end
  # end
end
