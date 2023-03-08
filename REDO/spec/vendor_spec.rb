require 'rspec'
require './lib/item'
require './lib/vendor'

RSpec.describe Vendor do
  before(:each) do
    @vendor = Vendor.new("Rocky Mountain Fresh")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
  end

  it 'has a name and an empty beginning inventory hash' do
    expect(@vendor).to be_a(Vendor)
    expect(@vendor.name).to eq("Rocky Mountain Fresh")
    expect(@vendor.inventory).to eq({})
  end
  
  it 'can check stock and stock items' do
    expect(@vendor.check_stock(@item1)).to eq(0)
    
    @vendor.stock(@item1, 30)
    expect(@vendor.inventory).to eq({@item1 => 30})
  end
end