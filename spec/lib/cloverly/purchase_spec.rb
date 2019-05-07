require 'spec_helper'

describe Cloverly::Purchase do

  before do
    Cloverly.default = Cloverly.new(ENV['CLOVERLY_PUBLIC_KEY'])
    @purchase_slug = Cloverly.offset!("shipping", {distance: {value: 35, units: "miles"}, weight: {value: 5, units: "kg"}}).slug
  end

  it "allows me to find the estimate" do
    purchase = Cloverly::Purchase.retrieve(@purchase_slug)
    expect(purchase).to be_kind_of(Cloverly::Purchase)
  end
end
