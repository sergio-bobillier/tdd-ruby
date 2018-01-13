require_relative '../deck'

RSpec.describe Deck do
  let :first_card { Card.new('Hearts', 'Ace') }

  subject { Deck.new }

  it { is_expected.to respond_to :shuffle }
  it { is_expected.to respond_to :deal }
  it { is_expected.to respond_to :replace }
  it { is_expected.to respond_to :reset }
  it { is_expected.to respond_to :count }
  it { is_expected.to respond_to :== }

  describe '#count' do
    it 'returns the number of cards on the deck' do
      expect(subject.count).to eq 52
    end
  end

  describe '#deal' do
    it 'should deal the card at the top of the deck' do
      expect(subject.deal).to eq first_card
      expect{ subject.deal }.to change{subject.count}.by(-1)
    end
  end

  describe '#replace' do
    it 'replaces the deck with a new one' do
      new_deck = [Card.new('Clubs', '2'), Card.new('Clubs', '3')]
      expect(subject.replace(new_deck).count).to eq 2
      expect(subject.deal).to eq new_deck[1]
    end
  end

  describe '#shuffle' do
    ordered_deck = Deck.new
    it { expect(subject.shuffle).not_to eq ordered_deck }
  end

  describe '#reset' do
    it 'resets the deck to a new ordered one' do
      ordered_deck = Deck.new
      expect(subject.shuffle).not_to eq ordered_deck
      expect(subject.reset).to eq(ordered_deck)
    end
  end

  describe '#==' do
    context 'when two decks are equal' do
      deck1 = Deck.new
      deck2 = Deck.new

      it { expect(deck1 == deck2).to be true }

      deck1.deal
      deck2.deal

      it { expect(deck1 == deck2).to be true }
    end

    context 'when two decks are different' do
      deck1 = Deck.new
      deck2 = Deck.new.shuffle

      it { expect(deck1 == deck2).to be false }
    end
  end
end
