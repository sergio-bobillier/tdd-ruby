require_relative 'quoted_string'

RSpec.describe QuotedString do
  let :placeholder {5 + 10}

  context 'When quoting with %q' do
    describe '#to_s' do
      it 'should not display interpolated test' do
        sentence = %q{The sum of 5 + 10 is: #{placeholder}}
        quoted_string = described_class.new(sentence)
        expect(quoted_string.to_s).to eq 'The sum of 5 + 10 is: #{placeholder}'
      end
    end
  end

  context 'When quoting with %Q' do
    describe '#to_s' do
      it 'should display interpolated test' do
        sentence = %Q{The sum of 5 + 10 is: #{placeholder}}
        quoted_string = described_class.new(sentence)
        expect(quoted_string.to_s).to eq 'The sum of 5 + 10 is: 15'
      end
    end
  end
end
