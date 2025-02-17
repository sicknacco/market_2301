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

  it 'has an empty hash for starting inventory' do
    expect(@vendor.inventory).to eq({})
  end

  it 'can check its current stock of an item' do
    expect(@vendor.check_stock(@item1)).to eq(0)
  end

  it 'can stock an item' do
    @vendor.stock(@item1, 30)
    
    expect(@vendor.inventory).to eq({@item1 => 30})
    expect(@vendor.check_stock(@item1)).to eq(30)
    
    @vendor.stock(@item1, 25)
    expect(@vendor.check_stock(@item1)).to eq(55)
    
    @vendor.stock(@item2, 12)
    expect(@vendor.inventory).to eq({@item1 => 55, @item2 => 12})
  end

  it 'can sum potential revenue' do
    @vendor.stock(@item1, 35)
    @vendor.stock(@item2, 7)

    expect(@vendor.potential_revenue).to eq(29.75)
  end
end