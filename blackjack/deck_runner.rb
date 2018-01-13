require_relative 'deck'

deck = Deck.new
new_deck = []

puts '# Dealing some cards from an ordered deck:'

10.times do
  card = deck.deal
  puts "  dealt: #{card}"
  new_deck << card
end

puts "\n  Cards left on deck: #{deck.count}"
puts

puts '# Shuffling the deck and dealing some cards from it:'

deck.shuffle

10.times do
  card = deck.deal
  puts "  dealt: #{card}"
  new_deck << card
end

puts "\n  Cards left on deck: #{deck.count}"
puts

puts '# Replacing the deck with a new one'

deck.replace(new_deck)

puts "  Cards on deck: #{deck.count}"
puts "\n  Dealing all cards:"

deck.count.times do
  puts "    Dealt: #{deck.deal}"
end

puts "\n  Cards left on deck: #{deck.count}"
puts

puts '# Reset the deck'
deck.reset

puts "  Cards on deck: #{deck.count}"
