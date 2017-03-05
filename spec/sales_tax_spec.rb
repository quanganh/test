require_relative '../lib/sales_tax.rb'

describe "SalesTax" do
  it "should run with input1" do
    SalesTax.new('inputs/input1.txt').run!
  end
end
