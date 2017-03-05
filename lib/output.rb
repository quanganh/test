require_relative '../base.rb'

class Output < Base
  attr_reader :items

  def initialize(items, total_tax, total)
    @items = items
    @total_tax = total_tax
    @total = total
    @results = []
  end

  def print!
    puts "==========================="
    items.each do |item|
      @results << "#{item[:quantity]} #{item[:name]}: #{ceil_to_2(item[:total])}"
    end
    @results << "Sales Total: #{ceil_to_2(@total_tax)}"
    @results << "Total: #{ceil_to_2(@total)}"
    puts @results
  end
end
