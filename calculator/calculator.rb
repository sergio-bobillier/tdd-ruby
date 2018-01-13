class Calculator
  def self.add(first, second)
    first + second
  end

  def self.substract(first, second)
    first - second
  end

  def self.multiply(first, second)
    first * second
  end

  def self.divide(first, second)
    first.to_f / second
  end

  def self.power(first, second)
    first ** second
  end
end
