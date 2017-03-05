require_relative '../lib/product.rb'
require_relative '../base.rb'

class Calculator < Base
  attr_reader :items, :total_tax, :total
  TAX_RATE = 0.10
  INPORT_TAX_RATE = 0.05

  def initialize(list)
    @list = list
    @items = []
    @total_tax = 0.0
    @total = 0.0
  end

  def execute
    update_items
    update_total
  end

  def update_items
    @list.each do |row|
      product = Product.new(row)
      qty = get_quantity(row)
      @items << {
        name: product.name,
        quantity: qty,
        tax: item_total_tax(qty, product),
        total: calculate_total(qty, product)
      }
    end
  end

  def get_quantity(item)
    return 0 unless item && item[0] =~ /^[0-9].*/
    item.split(/[^\d]/).first.to_i
  end

  def item_total_tax(qty, product)
    tax_per_item = cal_tax(product)
    qty * tax_per_item
  end

  def cal_tax(product)
    tax = product.exclusion ? 0 : product.price * TAX_RATE
    tax += (product.price * INPORT_TAX_RATE) if product.imported
    ceil_to_2(tax)
  end

  def calculate_total(qty, product)
    return 0 unless qty && qty > 0
    qty * (product.price + cal_tax(product))
  end

  def update_total
    @total = generate_total('total')
    @total_tax = generate_total('tax')
  end

  def generate_total(type)
    list = @items.map { |key, value| key[type.to_sym] }
    ceil_to_2(list.inject(:+))
  end
end
