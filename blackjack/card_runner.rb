require_relative 'card'

card = Card.new('Clubs', '9')

puts "Card suit: #{card.suit}"
puts "Card rank: #{card.rank}"
puts "Card: #{card}"

card.show = false
puts "Card: #{card}"
