require 'rspec'
require './lib/item'
require './lib/vendor'
require './lib/market'

RSpec.describe Market do
  before(:each) do 
    @market = Market.new("South Pearl Street Farmers Market")
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor3 = Vendor.new("Palisade Peach Shack")
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

  it 'vendor can stock items' do
    @market.add_vendor(@vendor1)
    @vendor1.stock(@item1, 35)
    expect(@vendor1.check_stock(@item1)).to eq(35)

    @vendor1.stock(@item2, 7)
    expect(@vendor1.check_stock(@item2)).to eq(7)
    expect(@vendor1.inventory).to eq({@item1 => 35, @item2 => 7})
    
    @market.add_vendor(@vendor2)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    expect(@vendor2.inventory).to eq({@item4 => 50, @item3 => 25})
    
    @market.add_vendor(@vendor3)
    @vendor3.stock(@item1, 65)
    expect(@vendor3.inventory).to eq({@item1 => 65})
  end

  it 'can list all vendors in an array and as a string' do
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])
    expect(@market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
  end

  it 'can tell if a vendor sells a specific item' do
    @market.add_vendor(@vendor1)
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
  
    @market.add_vendor(@vendor2)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    
    @market.add_vendor(@vendor3)
    @vendor3.stock(@item1, 65)
  
    expect(@market.vendors_that_sell(@item1)).to eq([@vendor1, @vendor3])
    expect(@market.vendors_that_sell(@item4)).to eq([@vendor2])
  end

  it 'can determine potential revenue' do
    @market.add_vendor(@vendor1)
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
  
    @market.add_vendor(@vendor2)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    
    @market.add_vendor(@vendor3)
    @vendor3.stock(@item1, 65)

    expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])
    expect(@market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    expect(@market.vendors_that_sell(@item1)).to eq([@vendor1, @vendor3])
    expect(@market.vendors_that_sell(@item4)).to eq([@vendor2])

    expect(@vendor1.potential_revenue).to eq(29.75)
  end

  it 'can return a sorted list of all items' do
    @market.add_vendor(@vendor1)
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
  
    @market.add_vendor(@vendor2)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    
    @market.add_vendor(@vendor3)
    @vendor3.stock(@item1, 65)

    expect(@market.sorted_item_list).to eq(["Banana Nice Cream", 'Peach', "Peach-Raspberry Nice Cream", 'Tomato'])
  end

  it 'can return total inventories in a hash' do
    @market.add_vendor(@vendor1)
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
  
    @market.add_vendor(@vendor2)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    
    @market.add_vendor(@vendor3)
    @vendor3.stock(@item1, 65)

    expected = {
      @item1 => {quantity: 100, vendors: [@vendor1, @vendor3]},
      @item2 => {quantity: 7, vendors: [@vendor1]},
      @item3 => {quantity: 25, vendors: [@vendor2]},
      @item4 => {quantity: 50, vendors: [@vendor2]}
    }

    expect(@market.total_inventory).to eq(expected)
  end

  it 'can show if an item is overstocked' do
    @market.add_vendor(@vendor1)
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
  
    @market.add_vendor(@vendor2)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    
    @market.add_vendor(@vendor3)
    @vendor3.stock(@item1, 65)
    @vendor3.stock(@item4, 50)
    
    expect(@market.overstocked_items).to eq([@item1, @item4])
  end
end