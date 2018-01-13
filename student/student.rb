class Student
  @@count = 0

  attr_reader :first_name, :last_name

  def self.count
    @@count
  end

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @@count += 1
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
