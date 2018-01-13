require_relative '../card'

RSpec.describe Card do
  describe 'Initializer' do
    it { expect { described_class.new('Picks', '8') }.to raise_error ArgumentError }
    it { expect { described_class.new('Spades', 'A') }.to raise_error ArgumentError }
  end

  describe 'Class methods' do
    let :suit { 'Diamonds' }
    let :rank { '8' }

    let :equivalent_cards { [Card.new('Spades', 'Ace'),  Card.new('Spades', 'Ace')] }
    let :different_cards { [Card.new('Spades', 'Ace'), Card.new('Hearts', 'Queen')] }

    subject { described_class.new(suit, rank) }

    it { is_expected.to respond_to :suit }
    it { is_expected.to respond_to :rank }
    it { is_expected.to respond_to :show }
    it { is_expected.to respond_to :== }
    it { is_expected.to respond_to :<=> }
    it { is_expected.to respond_to :hide }
    it { is_expected.to respond_to :reveal }
    it { is_expected.to respond_to :face? }

    describe '#show' do
      it { expect(subject.show).to be true }
    end

    describe '#suit' do
      it { expect(subject.suit).to eq 'Diamonds' }
    end

    describe '#rank' do
      it { expect(subject.rank).to eq '8' }
    end

    describe '#to_s' do
      context 'When #show is true' do
        it 'returns the card name' do
          subject.show = true
          expect(subject.to_s).to eq "#{rank} of #{suit}"
        end
      end

      context 'When #show is false' do
        it 'does not return the card name' do
          subject.show = false
          expect(subject.to_s).to eq ''
        end
      end
    end

    describe '#==' do
      context 'when two cards are equal' do
        it { expect(equivalent_cards[0] == equivalent_cards[1]).to be true}
      end

      context 'when two cards are not equal' do
        it { expect(different_cards[0] == different_cards[1]).to be false}
      end
    end

    describe '#<=>' do
      context 'with two equivalent cards' do
        it { expect(equivalent_cards[0] <=> equivalent_cards[1]).to eq 0 }
      end

      context 'when a cards is greater than the other' do
        it { expect(different_cards[0] <=> different_cards[1]).to eq 1 }
      end

      context 'when a cards is smaller than the other' do
        it { expect(different_cards[1] <=> different_cards[0]).to eq(-1) }
      end
    end

    describe '#hide' do
      it 'makes #show false and return the card' do
        expect(subject.hide).to eq(subject)
        expect(subject.show).to be false
      end
    end

    describe '#reveal' do
      it 'makes #show true and return the card' do
        expect(subject.reveal).to eq(subject)
        expect(subject.show).to be true
      end
    end

    describe '#face?' do
      context 'when the card is a face card' do
        it 'returns true' do
          face_card = described_class.new('Spades', 'Jack')
          expect(face_card.face?).to be true
        end
      end

      context 'when the card is not a face card' do
        it 'return false' do
          faceless_card = described_class.new('Spades', '8')
          expect(faceless_card.face?).to be false
        end
      end
    end
  end
end
