class BasicString
  def initialize(string)
    @string = string
  end

  def include?(substr)
    @string.include?(substr)
  end

  def contains?(substr)
    @string.downcase.include?(substr.downcase)
  end
end
