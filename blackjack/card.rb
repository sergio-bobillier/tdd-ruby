class Card
  SUITS = ['Spades', 'Clubs', 'Diamonds', 'Hearts'].freeze
  RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace'].freeze

  attr_accessor :suit, :rank, :show

  def initialize(suit, rank)
    raise ArgumentError.new("Unrecognized suit: '#{suit}'") unless SUITS.include?(suit)
    raise ArgumentError.new("Unrecognized rank: '#{rank}'") unless RANKS.include?(rank)

    @show = true
    @suit = suit
    @rank = rank
  end

  def to_s
    show ? "#{rank} of #{suit}" : ''
  end

  def ==(other_card)
    (suit == other_card.suit && rank == other_card.rank)
  end

  def <=>(other_card)
    RANKS.index(self.rank) <=> RANKS.index(other_card.rank)
  end

  def hide
    self.show = false
    self
  end

  def reveal
    self.show = true
    self
  end

  def face?
    ['Jack', 'Queen', 'King'].include?(rank)
  end
end
