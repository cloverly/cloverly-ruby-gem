
require 'spec_helper'

describe Cloverly::Estimate do

  before do
    Cloverly.default = Cloverly.new(ENV['CLOVERLY_PUBLIC_KEY'])
  end

  it "allows listing of sources" do
    sources = Cloverly::Source.list
    sources.each do |source|
      expect(source).to be_kind_of(Cloverly::Source)
    end
  end

  it "allows showing a specific source" do
    slug = Cloverly::Source.list.first.slug

    source = Cloverly::Source.retrieve(slug)
    expect(source).to be_kind_of(Cloverly::Source)
  end

end
