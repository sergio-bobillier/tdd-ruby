class Word
  def self.palindrome?(word)
    word = word.downcase
    word == word.reverse
  end
end
