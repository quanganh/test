require_relative "../lib/product"

describe "Product" do
  describe 'get name and price' do
    let!(:product) { Product.new('50 iphone at 599.99') }

    specify do
      expect(product.name).to eq('iphone')
      expect(product.price).to eq(599.99)
    end
  end

  describe '#is_exclusion?' do
    context 'when product is exclusion' do
      let!(:product) { Product.new('1 chocolate at 5.99') }

      specify do
        expect(product.exclusion).to be_truthy
      end
    end

    context 'when product is not exclusion' do
      let!(:product) { Product.new('1 Music CD at 2.99') }

      specify do
        expect(product.exclusion).to be_falsey
      end
    end
  end

  describe '#is_import?' do
    context 'when product is imported' do
      let!(:product) { Product.new('1 imported iphone at 599.99') }

      specify do
        expect(product.imported).to be_truthy
      end
    end

    context 'when product is not imported' do
      let!(:product) { Product.new('1 bottle of perfume at 200.99') }

      specify do
        expect(product.imported).to be_falsey
      end
    end
  end

  describe '#exclusions' do
    let!(:product) { Product.new('1 bottle of perfume at 200.99') }
    let!(:result) { ["book", "chocolates", "chocolate", "pills"] }

    specify do
      expect(product.exclusions).to match_array(result)
    end
  end
end
