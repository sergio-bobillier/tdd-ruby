require_relative 'product'

RSpec.describe Product do
  before :all do
    @p1 = described_class.new(id: 1, name: 'item 1', quantity: 3, price: 25)
    @p2 = described_class.new(id: 2, name: 'item 2', quantity: 5, price: 15)
    @p3 = described_class.new(id: 3, name: 'item 3', quantity: 0, price: 30)
  end

  describe 'Class methods' do
    subject { described_class }

    it { is_expected.to respond_to :all }
    it { is_expected.to respond_to :product_names }
    it { is_expected.to respond_to :sold_out_products }
    it { is_expected.to respond_to :total_inventory }
    it { is_expected.to respond_to :total_inventory_value }

    describe '::all' do
      it { expect(subject.all).to eq [@p1, @p2, @p3] }
    end

    describe '::product_names' do
      it { expect(subject.product_names).to eq [@p1.name, @p2.name, @p3.name] }
    end

    describe '::sold_out_products' do
      it { expect(subject.sold_out_products).to eq [@p3] }
    end

    describe '::total_inventory' do
      it { expect(subject.total_inventory).to eq @p1.quantity + @p2.quantity + @p3.quantity }
    end

    describe '::total_inventory_value' do
      it { expect(subject.total_inventory_value).to eq @p1.quantity * @p1.price + @p2.quantity * @p2.price + @p3.quantity * @p3.price }
    end
  end

  describe 'Instance methods' do
    subject { @p1 }

    it { is_expected.to respond_to :id }
    it { is_expected.to respond_to :name }
    it { is_expected.to respond_to :quantity }
    it { is_expected.to respond_to :price }

    describe '#id' do
      it { expect(subject.id).to eq 1 }
    end

    describe '#name' do
      it { expect(subject.name).to eq 'item 1' }
    end

    describe '#quantity' do
      it { expect(subject.quantity).to eq 3 }
    end

    describe '#price' do
      it { expect(subject.price).to eq 25 }
    end
  end
end
