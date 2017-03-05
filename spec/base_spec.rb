require_relative '../base.rb'

describe 'Base' do
  let(:base) { Base.new }

  it { expect(base.ceil_to_2(12.3456)).to eq(12.35) }
  it { expect(base.root_path).to eq(Dir.pwd) }
end
