require_relative 'hand'
require_relative 'deck'

deck = Deck.new.shuffle

dealers_hand = Hand.new
dealers_hand << [deck.deal, deck.deal.hide]

puts "Dealer's hand: #{dealers_hand}"

players_hand = Hand.new
players_hand << [deck.deal, deck.deal]

puts "Player's hand: #{players_hand}"
