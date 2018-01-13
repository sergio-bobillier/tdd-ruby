require_relative 'word'

RSpec.describe Word do
  context 'The test word is a palindrome' do
    it 'Should read the same forward as backwards' do
      test_word = 'Madam'
      result = Word.palindrome? test_word
      expect(result).to be_truthy
    end
  end

  context 'The test word is NOT a palindrome' do
    it 'Should NOT read the same forward as backwards' do
      test_word = 'Food'
      result = Word.palindrome? test_word
      expect(result).to be_falsey
    end
  end
end
