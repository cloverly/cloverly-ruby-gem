class Cloverly::Estimate
  include Cloverly::Base

  def purchase!
    Cloverly::Purchase.parse(@cloverly_instance, @cloverly_instance.post("/2019-03-beta/purchases", {estimate_slug: self.slug}))
  end
end
