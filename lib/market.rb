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
end
