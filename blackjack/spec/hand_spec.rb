require_relative '../hand'
require_relative '../card'

RSpec.describe Hand do
  subject { described_class.new }

  let :card { Card.new('Diamonds', '9') }
  let :cards { [card, Card.new('Spades', '2')] }
  let :hidden_card { Card.new('Clubs', 'King').hide }
  let :blackjack_with_face { [Card.new('Clubs', 'Ace'), Card.new('Hearts', 'Queen')] }
  let :blackjack_with_ten { [Card.new('Clubs', 'Ace'), Card.new('Hearts', '10')] }
  let :twenty_one { [Card.new('Diamonds', '9'), Card.new('Spades', '6'), Card.new('Hearts', '6')] }
  let :ace { Card.new('Clubs', 'Ace') }
  let :cards_and_ace { cards.clone << ace }

  it { is_expected.to respond_to :cards_count }
  it { is_expected.to respond_to :hidden_cards }
  it { is_expected.to respond_to :<< }
  it { is_expected.to respond_to :value }
  it { is_expected.to respond_to :to_s }
  it { is_expected.to respond_to :blackjack? }
  it { is_expected.to respond_to :reveal }
  it { is_expected.to respond_to :> }
  it { is_expected.to respond_to :< }

  describe 'Initializer' do
    context 'with no arguments' do
      it 'creates an empty hand' do
        expect(subject.cards_count).to eq 0
        expect(subject.value).to eq 0
      end
    end

    context 'with a single card' do
      subject { described_class.new(card) }

      it 'created a hand with the given card' do
        expect(subject.cards_count).to eq 1
        expect(subject.value).to eq 9
      end
    end

    context 'with an array of cards' do
      subject { described_class.new(cards) }

      it 'creates a hand with the given cards' do
        expect(subject.cards_count).to eq 2
        expect(subject.value).to eq 11
      end
    end
  end

  describe 'Class methods' do
    describe '#cards_count' do
      it 'returns the number of cards in the hand' do
        subject << cards
        expect(subject.cards_count).to eq 2
      end
    end

    describe '#hidden_cards' do
      it 'returns the number of hidden cards in the hand' do
        subject << [card, hidden_card]
        expect(subject.hidden_cards).to eq 1
      end
    end

    describe '#<<' do
      context 'when adding only one card' do
        it { expect(subject << card).to eq 1 }
      end

      context 'when adding multiple cards' do
        it { expect(subject << cards).to eq 2 }
      end
    end

    describe '#value' do
      context 'With no aces' do
        it 'returns the correct value' do
          subject << cards
          expect(subject.value).to eq 11
        end
      end

      context 'With aces' do
        context 'When the value goes over 21' do
          it 'returns the correct value' do
            subject << cards_and_ace
            expect(subject.value).to eq 12
          end

          it 'returns the correct value with two aces' do
            subject << [ace, ace]
            expect(subject.value).to eq 12
          end

          it 'returns the correct value with black jack' do
            subject << [ace, Card.new('Diamonds', 'Jack')]
            expect(subject.value).to eq 21
          end
        end

        context 'When the value is under 21' do
          it 'returns the correct value' do
            subject << [card, ace]
            expect(subject.value).to eq 20
          end
        end
      end

      context 'When #show is false for one or more cards' do
        it 'returns the correct value' do
          subject << [card, hidden_card]
          expect(subject.value).to eq 9
        end
      end
    end

    describe '#to_s' do
      context 'when all cards are visible' do
        it 'returns the correct output' do
          subject << cards
          expect(subject.to_s).to eq(cards.map(&:to_s).join(', ') + " Total value: 11")
        end
      end

      context 'when there is a hidden card' do
        it 'returns the correct output' do
          subject << [card, hidden_card]
          expect(subject.to_s).to eq(card.to_s + " Total value: 9")
        end
      end
    end

    describe '#blackjack?' do
      context 'when the hand is a blackjack: Face and Ace' do
        it 'returns true' do
          subject << blackjack_with_face
          expect(subject.blackjack?).to be true
        end
      end

      context 'when the hand is a blackjack: 10 and Ace' do
        it 'returns true' do
          subject << blackjack_with_ten
          expect(subject.blackjack?).to be true
        end
      end

      context 'when the hand is not a blackjack' do
        it 'returns false' do
          subject << cards
          expect(subject.blackjack?).to be false
        end
      end
    end

    describe '#reveal' do
      it 'reveals all hidden cards' do
        subject << [card, hidden_card, hidden_card]
        expect(subject.hidden_cards).to eq 2
        expect { subject.reveal }.to change { subject.hidden_cards }.to(0)
      end
    end

    describe '#>' do
      it { expect(Hand.new(cards_and_ace).value > Hand.new(cards).value).to be true }
      it { expect(Hand.new(cards) > Hand.new(cards_and_ace)).to be false }
      it { expect(Hand.new(cards) > Hand.new(cards)).to be false }
      it { expect(Hand.new(blackjack_with_face) > Hand.new(blackjack_with_ten)).to be false }
      it { expect(Hand.new(blackjack_with_face) > Hand.new(twenty_one)).to be true }
    end

    describe '#<' do
      it { expect(Hand.new(cards) < Hand.new(cards_and_ace)).to be true }
      it { expect(Hand.new(cards_and_ace) < Hand.new(cards)).to be false }
      it { expect(Hand.new(cards_and_ace) < Hand.new(cards_and_ace)).to be false }
      it { expect(Hand.new(blackjack_with_face) < Hand.new(blackjack_with_ten)).to be false }
      it { expect(Hand.new(blackjack_with_ten) < Hand.new(twenty_one)).to be false }
    end
  end
end
