require_relative 'word'

test_word = 'Deed'
result = Word.palindrome? test_word
puts (result ? 'The word is a palindrome' : 'The word is not a palindrome')
