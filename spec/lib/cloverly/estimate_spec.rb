require 'spec_helper'

describe Cloverly::Estimate do

  before do
    Cloverly.default = Cloverly.new(ENV['CLOVERLY_PUBLIC_KEY'])
    @estimate_slug = Cloverly.offset("shipping", {distance: {value: 35, units: "miles"}, weight: {value: 5, units: "kg"}}).slug
  end

  it "allows me to find the estimate" do
    estimate = Cloverly::Estimate.retrieve(@estimate_slug)
    expect(estimate).to be_kind_of(Cloverly::Estimate)
  end
end
