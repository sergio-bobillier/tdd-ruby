require_relative '../blackjack'

RSpec.describe Blackjack do
  subject { described_class.new }

  it { is_expected.to respond_to :players_hand }
  it { is_expected.to respond_to :dealers_hand }
  it { is_expected.to respond_to :playing? }
  it { is_expected.to respond_to :deal }
  it { is_expected.to respond_to :hit }
  it { is_expected.to respond_to :stand }
  it { is_expected.to respond_to :turn }
  it { is_expected.to respond_to :winner }
  it { is_expected.to respond_to :result }
  it { is_expected.to respond_to :to_s }

  context 'When game begins' do
    describe '#playing?' do
      it { expect(subject.playing?).to be false }
    end

    describe '#players_hand' do
      it('is a Hand') { expect(subject.players_hand).to be_a Hand }
      it('is empty') { expect(subject.players_hand.cards_count).to eq 0 }
    end

    describe '#dealers_hand' do
      it('is a Hand') { expect(subject.players_hand).to be_a Hand }
      it('is empty') { expect(subject.dealers_hand.cards_count).to eq 0 }
    end

    describe '#turn' do
      it('is nil') { expect(subject.turn).to be_nil }
    end

    describe '#winner' do
      it('is nil') { expect(subject.winner).to be_nil }
    end

    describe '#result' do
      it('is nil') { expect(subject.result).to be_nil }
    end
  end

  describe 'Class methods' do
    describe '#deal' do
      context 'When the game is already in course' do
        it 'raises an error' do
          allow(subject.players_hand).to receive(:blackjack?).and_return(false)

          subject.deal
          expect { subject.deal }.to raise_error(InvalidStateException)
        end
      end

      it 'deals cards to the player and the dealer' do
        subject.deal

        expect(subject.players_hand.cards_count).to eq 2
        expect(subject.dealers_hand.cards_count).to eq 2
        expect(subject.dealers_hand.hidden_cards).to eq 1
      end

      context "when the player doesn't have a blackjack" do
        it 'allows the game to continue' do
          allow(subject.players_hand).to receive(:blackjack?).and_return(false)
          subject.deal

          expect(subject.playing?).to be true
        end
      end

      context 'when the player has a blackjack' do
        context "and the dealer doesn't" do
          it 'finishes the game and sets player as winner' do
            allow(subject.players_hand).to receive(:blackjack?).and_return(true)
            allow(subject.dealers_hand).to receive(:blackjack?).and_return(false)
            subject.deal

            expect(subject.playing?).to be false
            expect(subject.winner).to eq :player
          end
        end

        context "and the dealer too" do
          it 'finishes the game and sets tie' do
            allow(subject.players_hand).to receive(:blackjack?).and_return(true)
            allow(subject.dealers_hand).to receive(:blackjack?).and_return(true)
            allow(subject.dealers_hand).to receive(:value).and_return(21)
            subject.deal

            expect(subject.playing?).to be false
            expect(subject.result).to eq 'Tie'
            expect(subject.winner).to be nil
          end
        end
      end
    end

    describe '#turn' do
      it 'returns the correct symbol according to the turn' do
        allow(subject.players_hand).to receive(:blackjack?).and_return(false)

        subject.deal
        expect(subject.turn).to eq :player

        subject.stand
        expect(subject.turn).to eq :dealer
      end
    end

    describe '#hit' do
      context 'when #playing? is false' do
        it { expect { subject.hit }.to raise_error(InvalidStateException) }
      end

      context 'when #playing? is true' do
        it 'returns the dealt card' do
          allow(subject.players_hand).to receive(:blackjack?).and_return(false)
          subject.deal

          expect(subject.hit).to be_a Card
        end

        context "and is the player's turn" do
          it 'deals a card to the player' do
            allow(subject.players_hand).to receive(:blackjack?).and_return(false)
            subject.deal

            expect { subject.hit }.to change { subject.players_hand.cards_count }.by(1)
          end

          context 'and the player remains under 21 after hitting' do
            it 'allows the game to continue' do
              allow(subject.players_hand).to receive(:blackjack?).and_return(false)
              allow(subject.players_hand).to receive(:value).and_return(19)

              subject.deal
              subject.hit
              expect(subject.playing?).to be true
            end
          end

          context 'and the player goes over 21 after hitting' do
            it 'finishes the game and sets the winner' do
              allow(subject.players_hand).to receive(:blackjack?).and_return(false)
              allow(subject.players_hand).to receive(:value).and_return(23)

              subject.deal
              subject.hit

              expect(subject.dealers_hand.hidden_cards).to eq 0
              expect(subject.playing?).to be false
              expect(subject.winner).to be :dealer
            end
          end
        end

        context "and is the Dealer's turn" do
          it 'deals a card to the dealer' do
            allow(subject.players_hand).to receive(:blackjack?).and_return(false)
            allow(subject).to receive(:turn).and_return(:dealer)
            subject.deal

            expect { subject.hit }.to change { subject.dealers_hand.cards_count }.by(1)
          end

          context 'and the dealer remains under 21 after hitting' do
            it 'allows the game to continue' do
              allow(subject).to receive(:turn).and_return(:dealer)
              allow(subject.players_hand).to receive(:blackjack?).and_return(false)
              allow(subject.dealers_hand).to receive(:value).and_return(19)

              subject.deal
              subject.hit

              expect(subject.playing?).to be true
            end
          end

          context 'and the dealer goes over 21' do
            it 'finishes the game and sets the winner after hitting' do
              allow(subject).to receive(:turn).and_return(:dealer)
              allow(subject.players_hand).to receive(:blackjack?).and_return(false)
              allow(subject.dealers_hand).to receive(:value).and_return(24)

              subject.deal
              subject.hit

              expect(subject.playing?).to be false
              expect(subject.winner).to eq :player
            end
          end
        end
      end
    end

    describe '#stand' do
      context 'when #playing is false' do
        it { expect { subject.stand }.to raise_error(InvalidStateException) }
      end

      context "during the player's turn" do
        it "reveals all the dealer's cards" do
          allow(subject.players_hand).to receive(:blackjack?).and_return(false)
          subject.deal
          subject.stand

          expect(subject.dealers_hand.hidden_cards).to eq 0
        end

        it "carries out the dealer's turn and finishes the game" do
          allow(subject.players_hand).to receive(:blackjack?).and_return(false)
          subject.deal
          subject.stand

          expect(subject.playing?).to be false
          expect(subject.turn).to eq :dealer
        end

        context "When the dealer's hand is less than 17" do
          before do
            step = -1
            cards = [
              Card.new('Hearts', 'Queen'), Card.new('Diamonds', 'Ace'),
              Card.new('Clubs', '3'), Card.new('Hearts', '8'),
              Card.new('Clubs', '10'), Card.new('Spades', '10')
            ]

            allow_any_instance_of(Deck).to receive(:deal) do
              cards[step += 1]
            end
          end

          it "hits the dealer until it's hand's value reaches 17 or more" do
            subject.deal
            subject.stand

            expect(subject.playing?).to eq false
            expect(subject.dealers_hand.cards_count).to eq 3
            expect(subject.dealers_hand.value).to eq 23
          end
        end

        context "When the dealer's hand is greater than 17" do
          it 'finishes the game without dealing more cards' do
            allow(subject.players_hand).to receive(:blackjack?).and_return(false)
            allow(subject.dealers_hand).to receive(:value).and_return(17)
            subject.deal
            subject.stand

            expect(subject.playing?).to eq false
            expect(subject.dealers_hand.cards_count).to eq 2
          end
        end
      end

      context "during the dealer's turn" do
        context 'when the player has the higher hand' do
          it 'finishes the game and sets player as the winner' do
            allow(subject.players_hand).to receive(:blackjack?).and_return(false)
            allow(subject.players_hand).to receive(:value).and_return(20)
            allow(subject.dealers_hand).to receive(:value).and_return(18)
            allow(subject).to receive(:turn).and_return(:dealer)

            subject.deal
            subject.stand

            expect(subject.playing?).to be false
            expect(subject.winner).to eq :player
            expect(subject.result).to eq 'Player has the best hand'
          end
        end

        context 'when the dealer has the higher hand' do
          it 'finishes the game and sets player as the winner' do
            allow(subject.players_hand).to receive(:blackjack?).and_return(false)
            allow(subject.players_hand).to receive(:value).and_return(17)
            allow(subject.dealers_hand).to receive(:value).and_return(21)
            allow(subject).to receive(:turn).and_return(:dealer)

            subject.deal
            subject.stand

            expect(subject.playing?).to be false
            expect(subject.winner).to eq :dealer
            expect(subject.result).to eq 'Dealer has the best hand'
          end
        end

        context 'when there is a tie' do
          it 'finishes the game and sets tie' do
            allow(subject.players_hand).to receive(:blackjack?).and_return(false)
            allow(subject.dealers_hand).to receive(:blackjack?).and_return(false)
            allow(subject.players_hand).to receive(:value).and_return(18)
            allow(subject.dealers_hand).to receive(:value).and_return(18)
            allow(subject).to receive(:turn).and_return(:dealer)

            subject.deal
            subject.stand

            expect(subject.playing?).to be false
            expect(subject.winner).to be nil
            expect(subject.result).to eq 'Tie'
          end
        end
      end
    end

    describe '#winner' do
      context 'When the player wins' do
        it 'returns :player' do
          allow(subject).to receive(:turn).and_return(:dealer)
          allow(subject.players_hand).to receive(:blackjack?).and_return(false)
          allow(subject.dealers_hand).to receive(:value).and_return(24)

          subject.deal
          subject.hit

          expect(subject.winner).to eq :player
        end
      end

      context 'When the dealer wins' do
        it 'returns :dealer' do
          allow(subject.players_hand).to receive(:blackjack?).and_return(false)
          allow(subject.players_hand).to receive(:value).and_return(23)

          subject.deal
          subject.hit

          expect(subject.winner).to eq :dealer
        end
      end
    end

    describe '#result' do
      context 'When the dealer goes over 21' do
        it 'returns "Dealer busted"' do
          allow(subject).to receive(:turn).and_return(:dealer)
          allow(subject.players_hand).to receive(:blackjack?).and_return(false)
          allow(subject.dealers_hand).to receive(:value).and_return(24)

          subject.deal
          subject.hit

          expect(subject.result).to eq 'Dealer busted'
        end
      end

      context 'When the player goes over 21' do
        it 'returns "Player busted"' do
          allow(subject.players_hand).to receive(:blackjack?).and_return(false)
          allow(subject.players_hand).to receive(:value).and_return(23)

          subject.deal
          subject.hit

          expect(subject.result).to eq "Player busted"
        end
      end
    end

    describe '#to_s' do
      it "returns the Dealer and Player's hands" do
        expect(subject.to_s).to eq "Dealer's hand: #{subject.dealers_hand}\nPlayer's hand: #{subject.players_hand}"
      end
    end
  end
end
