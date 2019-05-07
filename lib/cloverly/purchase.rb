class Cloverly::Purchase
  include Cloverly::Base

  def self.retrieve(cloverly_instance = nil, slug)
    cloverly_instance ||= Cloverly.default
    Cloverly::Purchase.parse(cloverly_instance, cloverly_instance.get("/2019-03-beta/purchases/#{slug}"))
  end
end
