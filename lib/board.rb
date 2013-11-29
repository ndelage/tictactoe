require_relative 'cell'

Indices = Struct.new(:row, :column)

class Board < Array
  
  def initialize(ary=Array.new(3){Array.new(3){Cell.new}})
    super(ary)
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
    corners.select do |index|
      self[index.row][index.column].empty?
    end
  end

  def corners
    [Indices.new(0,0), Indices.new(0,2), Indices.new(2,0), Indices.new(2,2)]
  end


  def diagonals
    diagonals = []
    diagonals << (0..2).map do |i|
      self[i][i]
    end

    diagonals << (0..2).map do |i|
      self.transpose[i][i]
    end
    diagonals
  end

  def columns
    transpose
  end
end
