require_relative '../lib/calculator'
require_relative '../lib/product'

describe 'Calculator' do
  let!(:list) {
    [
      "1 box of chocolates at 10.00",
      "10 imported bottles of perfume at 47.51"
    ]
  }
  let(:calculate) { Calculator.new(list) }

  describe '#update_items' do
    let!(:list_names) { ['box of chocolates', 'imported bottles of perfume'] }
    before { calculate.update_items }

    specify do
      expect(calculate.items.map { |key, value| key[:name] }).to match_array(list_names)
      expect(calculate.items.map { |key, value| key[:quantity] }).to match_array([1, 10])
    end
  end

  describe '#execute' do
    let!(:total_tax1) { 0 }
    let!(:total_tax2) { 10 * (47.51 * (Calculator::TAX_RATE + Calculator::INPORT_TAX_RATE)).round(2) }
    let!(:total1) { ((1 * 10.00) + total_tax1) }
    let!(:total2) { ((10 * 47.51) + total_tax2) }
    let!(:tax_total) { total_tax1 + total_tax2 }
    let!(:total_amount) { total1 + total2 }
    before { calculate.execute }

    specify do
      expect(calculate.total_tax).to eq(total_tax2)
      expect(calculate.total).to eq(total_amount)
    end
  end

  describe '#item_total_tax' do
    let!(:product) { Product.new('2 music CD at 5.49') }
    let!(:result) { (2 * (5.49 * Calculator::TAX_RATE)).round(2) } #product is not exclusion and not imported

    specify do
      expect(calculate.item_total_tax(2, product)).to eq(result)
    end
  end

  describe '#cal_tax' do
    context 'when product is not imported' do
      context 'and exclusion' do
        let!(:product) { Product.new('1 book at 12.49') }

        specify do
          expect(calculate.cal_tax(product)).to eq(0)
        end
      end

      context 'and not exclusion' do
        let!(:product) { Product.new('1 music CD at 14.99') }

        specify do
          expect(calculate.cal_tax(product)).to eq((14.99 * Calculator::TAX_RATE).round(2))
        end
      end
    end

    context 'when product is imported' do
      context 'and exclusion' do
        let!(:product) { Product.new('1 imported box of chocolates at 10.00') }

        specify do
          expect(calculate.cal_tax(product)).to eq((10.00 * Calculator::INPORT_TAX_RATE).round(2))
        end
      end

      context 'and not exclusion' do
        let!(:product) { Product.new('1 imported music CD at 15.99') }

        specify do
          expect(calculate.cal_tax(product)).to eq((15.99 * (Calculator::TAX_RATE + Calculator::INPORT_TAX_RATE)).round(2))
        end
      end
    end
  end

  describe '#calculate_total' do
    let!(:product) { Product.new('3 music CD at 2.49') }
    let!(:result) { 3 * (2.49 + (2.49 * Calculator::TAX_RATE)).round(2) }

    specify do
      expect(calculate.calculate_total(3, product)).to eq(result)
    end
  end
end
