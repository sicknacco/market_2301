require 'rspec'
require './lib/item'
require './lib/vendor'
require './lib/market'

RSpec.describe Market do
  before(:each) do 
    @market = Market.new("South Pearl Street Farmers Market")
  end

  it 'exists and has a name' do
    expect(@market).to be_a(Market)
    # expect(@market.name).to eq("South Pearl Street Farmers Market")
  end
end