require_relative 'blackjack'

puts '** WELCOME TO BLACKJACK **'
game = Blackjack.new

puts 'Dealing cards...'
game.deal

while game.playing? do
  puts "\n#{game}"
  puts "\nWhat would you like to do?:"
  puts "  1. Hit"
  puts "  2. Stand"
  print "\n=> "

  choice = gets.chomp

  case choice
  when '1'
    game.hit
  when '2'
    game.stand
  else
    puts "Unknown option: '#{choice}'"
  end
end

puts "\n#{game}"
puts "#{game.result}"
puts "#{game.winner.to_s.capitalize} wins!" if game.winner
