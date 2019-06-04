require 'spec_helper'

describe Cloverly::Estimate do

  before do
    Cloverly.default = @cloverly_instance = Cloverly.new(ENV['CLOVERLY_PUBLIC_KEY'])
    @estimate_slug = Cloverly.estimate_offset("shipping", {distance: {value: 35, units: "miles"}, weight: {value: 5, units: "kg"}}).slug
  end

  context "instance method" do
    it "allows me to retrieve an estimate" do
      estimate = Cloverly::Estimate.retrieve(@cloverly_instance, @estimate_slug)
      expect(estimate).to be_kind_of(Cloverly::Estimate)
    end

    it "allows me to get a list of estimates" do
      estimate = Cloverly::Estimate.list(Cloverly.new(ENV['CLOVERLY_PRIVATE_KEY']))
      expect(estimate.first).to be_kind_of(Cloverly::Estimate)
    end
  end

  context "class methods" do
    it "allows me to find the estimate" do
      estimate = Cloverly::Estimate.retrieve(@estimate_slug)
      expect(estimate).to be_kind_of(Cloverly::Estimate)
    end

    it "allows a shipping estimate" do
      estimate = Cloverly::Estimate.shipping({distance: {value: 35, units: "miles"}, weight: {value: 5, units: "kg"}})
      expect(estimate).to be_kind_of(Cloverly::Estimate)
    end

    it "allows a carbon estimate" do
      estimate = Cloverly::Estimate.carbon({weight: {value: 35, units: "kg"}})
      expect(estimate).to be_kind_of(Cloverly::Estimate)
    end

    it "allows a vehicle estimate" do
      estimate = Cloverly::Estimate.vehicle({distance: {value: 35, units: "miles"}, fuel_efficiency: {value: 14, units: "mpg", of: "gasoline"}})
      expect(estimate).to be_kind_of(Cloverly::Estimate)
    end

    it "allows cancelling an estimate" do
      estimate = Cloverly::Estimate.shipping({distance: {value: 35, units: "miles"}, weight: {value: 5, units: "kg"}})
      estimate.cancel!

      expect(estimate.state).to eq("cancelled")
    end
  end

end
