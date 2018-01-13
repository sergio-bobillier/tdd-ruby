require_relative 'calculator'

RSpec.describe Calculator do
  let :first { 10 }
  let :second { 50 }

  context 'Addition' do
    it 'should return the sum of two numbers' do
      expect(Calculator.add(first, second)).to eq 60
    end
  end

  context 'Substraction' do
    it 'should return the difference of two numbers' do
      expect(Calculator.substract(first, second)).to eq(-40)
    end
  end

  context 'Multiplication' do
    it 'should return the product of two numbers' do
      expect(Calculator.multiply(first, second)).to eq 500
    end
  end

  context 'Division' do
    it 'should return the cocient of a number divided by the other' do
      expect(Calculator.divide(first, second)).to eq 0.2
    end
  end

  context 'Power' do
    it "should return the result of raising a number to the other number's power" do
      expect(Calculator.power(first, second)).to eq 100000000000000000000000000000000000000000000000000
    end
  end
end
