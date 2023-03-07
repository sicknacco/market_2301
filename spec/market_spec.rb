require 'rspec'
require './lib/item'
require './lib/vendor'
require './lib/market'

RSpec.describe Market do
  before(:each) do 
    @market = Market.new("South Pearl Street Farmers Market")
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: "$0.50"})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
  end

  it 'exists and has a name' do
    expect(@market).to be_a(Market)
    expect(@market.name).to eq("South Pearl Street Farmers Market")
  end

  it 'starts with no vendors' do
    expect(@market.vendors).to eq([])
  end

  it 'can add vendors' do
    @market.add_vendor(@vendor1)
    expect(@market.vendors).to eq([@vendor1])
  end
end