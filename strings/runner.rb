require_relative 'basic_string'
require_relative 'quoted_string'

puts '#### BasicString ####'

sentence = BasicString.new('A rose by any other name still smells sweet')
words = ['Rose', 'rose', 'smell', 'Sweet', 'violet', 'any other', 'a', 'A']

puts '#include?'
words.each do |word|
  puts "\t" + [word, sentence.include?(word)].inspect
end

puts '#contains?'
words.each do |word|
  puts "\t" + [word, sentence.contains?(word)].inspect
end

puts '#### QuotedString ####'

placeholder = 5 + 10
sentence = %q{The sum of 5 + 10 is: #{placeholder}}
quoted_string = QuotedString.new(sentence)
puts quoted_string

sentence = %Q{The sum of 5 + 10 is: #{placeholder}}
quoted_string = QuotedString.new(sentence)
puts quoted_string
