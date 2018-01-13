require_relative 'deck'
require_relative 'hand'

require_relative 'exceptions/invalid_state_exception'

class Blackjack
  attr_reader :players_hand, :dealers_hand, :turn, :winner, :result

  def initialize
    @deck = Deck.new.shuffle

    @players_hand = Hand.new
    @dealers_hand = Hand.new

    @playing = false
    @turn = nil
    @winner = nil
    @result = nil
  end

  def playing?
    @playing
  end

  def deal
    raise InvalidStateException if playing?

    @dealers_hand << @deck.deal.hide
    @players_hand << @deck.deal
    @dealers_hand << @deck.deal
    @players_hand << @deck.deal

    @turn = :player
    @playing = true

    if @players_hand.blackjack?
      dealers_turn
    end
  end

  def to_s
    "Dealer's hand: #{@dealers_hand}\nPlayer's hand: #{@players_hand}"
  end

  def hit
    raise InvalidStateException unless playing?

    if turn == :player
      card =  @deck.deal
      @players_hand << card

      if @players_hand.value > 21
        @dealers_hand.reveal
        @result = 'Player busted'
        @playing = false
        @winner = :dealer
      end
    else
      @dealers_hand << @deck.deal

      if @dealers_hand.value > 21
        @result = 'Dealer busted'
        @playing = false
        @winner = :player
      end
    end

    card
  end

  def stand
    raise InvalidStateException unless playing?

    if turn == :player
      @dealers_hand.reveal
      dealers_turn
    else
      finish_game
    end
  end

  private

  def dealers_turn
    @turn = :dealer

    while dealers_hand.value < 17
      hit
    end

    stand if playing?
  end

  def finish_game
    @playing = false

    if @players_hand > @dealers_hand
      @winner = :player
      @result = 'Player has the best hand'
    elsif @dealers_hand > @players_hand
      @winner = :dealer
      @result = 'Dealer has the best hand'
    else
      @result = 'Tie'
    end
  end
end
