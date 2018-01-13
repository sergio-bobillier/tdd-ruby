require_relative 'student'

RSpec.describe Student do
  describe 'Instance methods' do
    subject { described_class.new('John', 'Doe') }

    it { respond_to :first_name }
    it { respond_to :last_name }
    it { respond_to :full_name }
  end

  describe 'Class methods' do
    describe '::count' do
      context 'When creating two students' do
        it 'should return 2' do
          Student.new('John', 'Doe')
          Student.new('Jane', 'Doe')
          expect(Student.count).to eq 2
        end
      end
    end
  end
end
