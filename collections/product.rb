class Product
  @@products = []

  attr_reader :id, :name, :quantity, :price

  def initialize(data = {})
    @id = data[:id] || 0
    @name = data[:name] || 'test product'
    @quantity = data[:quantity] || 0
    @price = data[:price] || 0

    @@products << self
  end

  def self.all
    @@products
  end

  def self.product_names
    @@products.map(&:name)
  end

  def self.sold_out_products
    @@products.select(&:sold_out?)
  end

  def self.total_inventory
    @@products.sum(&:quantity)
  end

  def self.total_inventory_value
    @@products.reduce(0) { |total, product| total + product.quantity * product.price }
  end

  def sold_out?
    quantity == 0
  end
end
