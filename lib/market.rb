class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names #map returns a new array with just the info we want
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    item_vendors = []
    @vendors.select do |vendor|
      if vendor.inventory.keys.include?(item)
        item_vendors << item
      end
    end
  end

  def sorted_item_list
    items = []
    vendors.each do |vendor|
      vendor.inventory.each do |item, value|
        if value > 0
          items << item.name
        end
      end
    end
    items.sort.uniq
  end

  def total_inventory
    market_stock = {}
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        if market_stock[item]
          market_stock[item][:quantity] += quantity
        else
          market_stock[item] = {quantity: vendor.inventory[item],
            vendors: vendors_that_sell(item)
          }
        end
      end
    end
    market_stock
  end

  def overstocked_items
    overstock = []
    total_inventory.each do |item, info_hash|
      if info_hash[:quantity] > 50 && info_hash[:vendors].length > 1
        overstock << item
      end
    end
    overstock
  end
end
