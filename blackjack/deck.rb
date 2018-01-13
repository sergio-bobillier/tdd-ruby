require_relative 'card'

class Deck
  def initialize
    reset
  end

  def shuffle
    @deck.shuffle!
    self
  end

  def deal
    @deck.pop
  end

  def replace(deck)
    @deck = deck.clone
    self
  end

  def count
    @deck.count
  end

  def reset
    @deck = []
    Card::SUITS.each do |suit|
      Card::RANKS.each do |rank|
        @deck << Card.new(suit, rank)
      end
    end

    self
  end

  def ==(other_deck)
    deck == other_deck.deck
  end

  protected

  def deck
    @deck
  end
end
