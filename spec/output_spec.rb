require_relative '../lib/output'

describe 'Output' do
  describe '#print!' do
    let!(:item) { { quantity: 5, name: 'iphone', total: 500.05 } }
    let!(:output) { Output.new([item], 150.02, 10.30) }

    it 'should run print' do
      output.print!
    end
  end
end
