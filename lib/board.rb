require_relative 'cell'

Indices = Struct.new(:row, :column)

class Board < Array
  CORNERS = [Indices.new(0,0), Indices.new(0,2), Indices.new(2,0), Indices.new(2,2)]
  def initialize
    super(Array.new(3){Array.new(3){Cell.new}})
  end

  def open_indices
    indices = []
    self.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        indices.push(Indices.new(row_index, col_index)) if cell.empty?
      end
    end
    indices
  end

  def open_corners
    CORNERS.select do |index|
      self[index.row][index.column].empty?
    end
  end


  def diagonals
    diagonals = []
    diagonals << (0..2).map do |i|
      self[i][i]
    end

    nums = (0..2).to_a
    diagonals << self.map do |row|
      row[nums.pop]
    end
    diagonals
  end

  def columns
    transpose
  end
end