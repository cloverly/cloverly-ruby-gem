require 'spec_helper'

describe Cloverly::Purchase do

  before do
    Cloverly.default = Cloverly.new(ENV['CLOVERLY_PUBLIC_KEY'])
    @purchase_slug = Cloverly.offset("shipping", {distance: {value: 35, units: "miles"}, weight: {value: 5, units: "kg"}}).slug
  end

  context "instance method" do
    it "allows me to retrieve an purchase" do
      purchase = Cloverly::Purchase.retrieve(@cloverly_instance, @purchase_slug)
      expect(purchase).to be_kind_of(Cloverly::Purchase)
    end

    it "allows me to get a list of purchases" do
      purchase = Cloverly::Purchase.list(Cloverly.new(ENV['CLOVERLY_PRIVATE_KEY']))
      expect(purchase.first).to be_kind_of(Cloverly::Purchase)
    end
  end

  context "class method" do
    it "allows me to find the purchase" do
      purchase = Cloverly::Purchase.retrieve(@purchase_slug)
      expect(purchase).to be_kind_of(Cloverly::Purchase)
    end

    it "allows a shipping purchase" do
      purchase = Cloverly::Purchase.shipping({distance: {value: 35, units: "miles"}, weight: {value: 5, units: "kg"}})
      expect(purchase).to be_kind_of(Cloverly::Purchase)
    end

    it "allows a carbon purchase" do
      purchase = Cloverly::Purchase.carbon({weight: {value: 35, units: "kg"}})
      expect(purchase).to be_kind_of(Cloverly::Purchase)
    end

    it "allows a vehicle purchase" do
      purchase = Cloverly::Purchase.vehicle({distance: {value: 35, units: "miles"}, fuel_efficiency: {value: 14, units: "mpg", of: "gasoline"}})
      expect(purchase).to be_kind_of(Cloverly::Purchase)
    end

    it "allows cancelling an purchase" do
      purchase = Cloverly::Purchase.shipping({distance: {value: 35, units: "miles"}, weight: {value: 5, units: "kg"}})
      purchase.cancel!

      expect(purchase.state).to eq("cancelled")
    end
  end
end
