class Cell
  attr_reader :content
  
  def initialize
    @content = " "
  end

  def marked_with?(char)
    @content == char
  end

  def mark(char)
    @content = char
  end

  def marked?
    @content != " "
  end

  def empty?
    @content == " "
  end

  def empty!
    @content = " "
  end

  def to_s
    @content
  end
end
