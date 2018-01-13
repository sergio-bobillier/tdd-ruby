require_relative 'basic_string'

RSpec.describe BasicString do
  subject { described_class.new('There is a gemstone called Ruby in existence') }

  describe '#include?' do
    it "should return true when 'Ruby' is passed" do
      expect(subject.include?('Ruby')).to be_truthy
    end

    it "should return false when 'ruby' is passed" do
      expect(subject.include?('ruby')).to be_falsey
    end
  end

  describe '#contains?' do
    it "should return true when 'Ruby' is passed" do
      expect(subject.contains?('Ruby')).to be_truthy
    end

    it "should return true when 'ruby' is passed" do
      expect(subject.contains?('ruby')).to be_truthy
    end

    it "should return false when 'garnet' is passed" do
      expect(subject.contains?('garnet')).to be_falsey
    end
  end
end
