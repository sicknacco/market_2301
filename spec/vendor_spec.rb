require 'rspec'
require './lib/item'
require './lib/vendor'

RSpec.describe Vendor do
  before(:each) do
    @vendor = Vendor.new("Rocky Mountain Fresh")
  end

  it 'exists and has a name' do
    expect(@vendor).to be_a(Vendor)
    expect(@vendor.name).to eq("Rocky Mountain Fresh")
  end

  it 'has inventory and can check stock' do
    expect(@vendor.inventory).to eq({})
  end

end