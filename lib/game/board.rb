Indices = Struct.new(:row, :column)

class Board < Array
  
  def initialize(ary=Array.new(3){Array.new(3){Cell.new}})
    super(ary)
  end

  def open_indices
    self.map.with_index do |row, row_index|
      row.map.with_index do |cell, col_index|
        Indices.new(row_index, col_index) if cell.empty?
      end
    end
    .flatten
    .compact
  end

  def full?
    flatten.all?(&:marked?)
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
    self.transpose
  end

  # For testing purposes
  def self.from_char_ary(ary)
    new(ary.flatten.map{|char| Cell.new(char)}.each_slice(3).to_a)
  end
end
