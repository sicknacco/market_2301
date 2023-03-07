require 'rspec'
require './lib/item'
require './lib/vendor'

RSpec.describe Vendor do
  before(:each) do
    @vendor = Vendor.new("Rocky Mountain Fresh")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
  end

  it 'exists and has a name' do
    expect(@vendor).to be_a(Vendor)
    expect(@vendor.name).to eq("Rocky Mountain Fresh")
  end

  it 'has inventory and can check stock' do
    expect(@vendor.inventory).to eq({})
    expect(@vendor.check_stock(@item1)).to eq(0)
  end

  it 'can stock items' do
    @vendor.stock(@item1, 30)
    expect(@vendor.inventory).to eq({@item1 => 30})
    expect(@vendor.check_stock(@item1)).to eq(30)
    # @vendor.stock(@item1, 30)
    # expect(@vendor.inventory).to eq({@item1 => 60})
  end
end