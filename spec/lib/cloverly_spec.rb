require 'spec_helper'

describe Cloverly do

  it "initializes" do
    cloverly = Cloverly.new(ENV['CLOVERLY_PUBLIC_KEY'])
    expect(cloverly.api_key).to eq(ENV['CLOVERLY_PUBLIC_KEY'])
  end

  it 'throws error with wrong api key' do
    @cloverly = Cloverly.new("wrong key")
    expect { @cloverly.account }.to raise_error(Cloverly::Error)
  end

  context "with cloverly public_key initialized" do
    before do
      @cloverly = Cloverly.new(ENV['CLOVERLY_PUBLIC_KEY'])
    end

    it "returns account information from cloverly" do
      account = @cloverly.account

      expect(account).to be_kind_of(Cloverly::Account)
      expect(account.public_key_access).to eq(true)
    end

    it "estimate a shipping offset" do
      estimate = @cloverly.offset("shipping", {weight: {value: 34, units: "kg"}, from: {zip: "94043"}, to: {zip: "35209"}})

      expect(estimate).to be_kind_of(Cloverly::Estimate)
      expect(estimate.total_cost_in_usd_cents).to eq(32)
    end

    it "allows completion of estimates" do
      estimate = @cloverly.offset("shipping", {weight: {value: 2, units: "pounds"}, from: {zip: "94043"}, to: {zip: "35209"}})
      expect(estimate.total_cost_in_usd_cents).to eq(27)

      purchase = estimate.purchase!
      expect(purchase).to be_kind_of(Cloverly::Purchase)
      expect(estimate.total_cost_in_usd_cents).to eq(27)
    end
  end

  context "with Cloverly private_key initialized" do
    before do
      @cloverly = Cloverly.new(ENV['CLOVERLY_PRIVATE_KEY'])
    end

    it "returns account information from cloverly" do
      account = @cloverly.account
      expect(account.name).to eq("Cloverly")
    end

    it "offsets shipping" do
      estimate = @cloverly.offset("shipping", {weight: {value: 34, units: "kg"}, from: {zip: "94043"}, to: {zip: "35209"}})

      expect(estimate).to be_kind_of(Cloverly::Estimate)
      expect(estimate.total_cost_in_usd_cents).to eq(32)
    end
  end


end
