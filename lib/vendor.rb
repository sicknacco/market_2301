class Vendor
  attr_reader :name,
              :inventory,
              :stock

  def initialize(name)
    @name = name
    @inventory = {}
    @stock = 0
  end

  def check_stock(item)
    @stock
  end

  def stock(item, count)
    if @inventory.count == 0
      @inventory[item] = count
    elsif
      @inventory[item] += count
    else
      # @inventory = {}
      # @inventory[item] = count
    end
    @stock += count
  end
end
