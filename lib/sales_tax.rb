require_relative '../lib/calculator.rb'
require_relative '../lib/output.rb'

class SalesTax

  def initialize(filename)
    @filename = filename
  end

  def run!
    list = File.open(@filename).to_a
    calculate_and_output(list)
  end

  def calculate_and_output(list)
    cal = Calculator.new(list)
    cal.execute
    Output.new(cal.items, cal.total_tax, cal.total).print!
  end
end
