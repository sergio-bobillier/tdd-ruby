class Hand
  VALUES = {
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9,
    '10' => 10,
    'Jack' => 10,
    'Queen' => 10,
    'King' => 10
  }

  def initialize(cards = nil)
    @cards = []
    self << cards if cards
  end

  def cards_count
    @cards.count
  end

  def hidden_cards
    @cards.count { |card| !card.show }
  end

  def <<(card)
    if card.is_a? Array
      @cards += card
    else
      @cards << card
    end

    @cards.length
  end

  def value
    sorted_cards = visible_cards.sort
    sorted_cards.reduce(0) do |total, card|
      total + (VALUES[card.rank] || (total + 11 <= 21 ? 11 : 1))
    end
  end

  def to_s
    "#{visible_cards.join(', ')} Total value: #{value}"
  end

  def blackjack?
    return false unless cards_count == 2

    ace = false; ten = false

    @cards.each do |card|
      ace = true if card.rank == 'Ace'
      ten = true if card.face? || card.rank == '10'
    end

    ace && ten
  end

  def reveal
    @cards.each(&:reveal)
  end

  def >(other_hand)
    return false if self.blackjack? && other_hand.blackjack?
    return true if blackjack?
    self.value > other_hand.value
  end

  def <(other_hand)
    return false if self.blackjack? && other_hand.blackjack?
    return false if blackjack?
    self.value < other_hand.value
  end

  private

  def visible_cards
    @cards.select { |card| card.show }
  end
end
