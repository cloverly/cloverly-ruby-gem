require 'spec_helper'

describe Cloverly do

  it "initializes" do
    cloverly = Cloverly.new(ENV['CLOVERLY_PUBLIC_KEY'])
    expect(cloverly.api_key).to eq(ENV['CLOVERLY_PUBLIC_KEY'])
  end

  it 'throws error with wrong api key' do
    @cloverly = Cloverly.new("wrong key")

    debugger

    expect { @cloverly.account }.to raise_error(Cloverly::Error)
  end

  context "with cloverly initialized" do
    before do
      @cloverly = Cloverly.new(ENV['CLOVERLY_PUBLIC_KEY'])
    end

    it "returns account information from cloverly" do
      expect(@cloverly.account).to eq({name: "Batman"})
    end

    it "offsets shipping" do
      expect(@cloverly.offset("shipping", {weight: {value: 34, units: "kg"}, from: {zip: "94043"}, to: {zip: "35209"}})).to eq({carbon_equivalents: 35})
    end
  end

end
