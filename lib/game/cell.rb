class Cell
  attr_reader :content
  EMPTY_VALUE = " "
  
  def initialize(content=EMPTY_VALUE)
    @content = content
  end

  def marked_with?(char)
    @content == char
  end

  def mark(char)
    @content = char
  end

  def marked?
    !empty?
  end

  def empty?
    @content == EMPTY_VALUE
  end

  def empty!
    @content = EMPTY_VALUE
  end

  def to_s
    @content
  end
end
